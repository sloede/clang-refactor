# CLANG_LEVEL := ../../..
CLANG_LEVEL := /home/mic/.pool/.src/llvm/tools/clang

TOOLNAME = clang-refac
NO_INSTALL = 1

# No plugins, optimize startup time.
TOOL_NO_EXPORTS = 1

include $(CLANG_LEVEL)/../../Makefile.config
LINK_COMPONENTS := $(TARGETS_TO_BUILD) asmparser bitreader support mc option
USEDLIBS = clangTooling.a clangFrontend.a clangSerialization.a clangDriver.a \
					 clangRewriteFrontend.a clangRewriteCore.a \
					 clangParse.a clangSema.a clangAnalysis.a \
					 clangAST.a clangASTMatchers.a clangEdit.a clangLex.a clangBasic.a

include $(CLANG_LEVEL)/Makefile

