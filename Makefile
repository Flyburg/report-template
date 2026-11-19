# macOS 上 TeX Live 默认安装路径（PATH 中找不到 xelatex 时回退为绝对路径）
ifeq (,$(shell command -v xelatex 2>/dev/null))
TEXBIN = /Library/TeX/texbin/
endif

# LaTeX编译器设置
LATEX = $(TEXBIN)xelatex
BIBER = $(TEXBIN)biber
LATEX_FLAGS = -shell-escape -interaction=nonstopmode -halt-on-error

# 主文档名称
TARGET = report

# 依赖文件
SECTIONS = $(wildcard sections/*.tex)
BIB = refs.bib
FIGURES = zjulogo.png

# 构建目标
all: $(TARGET).pdf

# 编译PDF（xelatex -> biber -> xelatex x2，以生成参考文献与交叉引用）
$(TARGET).pdf: $(TARGET).tex preamble.tex $(SECTIONS) $(BIB) $(FIGURES)
	$(LATEX) $(LATEX_FLAGS) $(TARGET)
	$(BIBER) $(TARGET)
	$(LATEX) $(LATEX_FLAGS) $(TARGET)
	$(LATEX) $(LATEX_FLAGS) $(TARGET)

# 清理临时文件
clean:
	rm -f *.aux *.log *.out *.toc *.synctex.gz *.fls *.fdb_latexmk
	rm -f *.bbl *.blg *.bcf *.run.xml missfont.log
	rm -rf _minted-*

# 完全清理（包括PDF）
cleanall: clean
	rm -f $(TARGET).pdf

# 重新构建
rebuild: cleanall all

.PHONY: all clean cleanall rebuild