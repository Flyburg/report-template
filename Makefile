# LaTeX编译器设置
LATEX = xelatex
LATEX_FLAGS = -shell-escape -interaction=nonstopmode

# 主文档名称
TARGET = report

# 构建目标
all: $(TARGET).pdf

# 编译PDF（需要多次编译以生成交叉引用）
$(TARGET).pdf: $(TARGET).tex preamble.tex
	$(LATEX) $(LATEX_FLAGS) $(TARGET)
	$(LATEX) $(LATEX_FLAGS) $(TARGET)
	rm -f $(TARGET).aux $(TARGET).log
	rm -rf _minted-*

# 清理临时文件
clean:
	rm -f *.aux *.log *.out *.toc *.synctex.gz *.fls *.fdb_latexmk
	rm -f *.bbl *.blg *.bcf *.run.xml
	rm -rf _minted-*

# 完全清理（包括PDF）
cleanall: clean
	rm -f $(TARGET).pdf

# 重新构建
rebuild: cleanall all

.PHONY: all clean cleanall rebuild