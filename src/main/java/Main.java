import lab3.TypeChecker;

import java.io.IOException;

public class Main {

  public static void main(String[] args) throws IOException {
//    SysYLexerHelper.lexicalAnalysis(args);
//    SysYParserHelper.handle(args);
    TypeChecker.check(args);
  }
}
