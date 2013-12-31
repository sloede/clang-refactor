set(LLVM_LINK_COMPONENTS
  Support
  )

add_clang_executable(clang-refac
  ClangRefac.cpp
  )

target_link_libraries(clang-refac
  clangAST
  clangASTMatchers
  clangBasic
  clangFrontend
  clangLex
  clangTooling
  )
