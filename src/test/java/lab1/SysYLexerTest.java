package lab1;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class SysYLexerTest {
  PrintStream systemErr = System.err;
  ByteArrayOutputStream buf = null;

  @BeforeEach
  public void setErr() {
    buf = new ByteArrayOutputStream();
    System.setErr(new PrintStream(buf));
  }

  private void testNormal(String inputPath, String outputPath) {
    try (Stream<String> stream = Files.lines(Path.of(outputPath));) {
      String[] args = {inputPath};
      SysYLexerHelper.lexicalAnalysis(args);
      List<String> expected = stream.collect(Collectors.toList());
      List<String> actual = buf.toString().lines().collect(Collectors.toList());
      Assertions.assertIterableEquals(expected, actual);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  private void testError(String inputPath, String outputPath) {
    try (Stream<String> stream = Files.lines(Path.of(outputPath))) {
      String[] args = {inputPath};
      SysYLexerHelper.lexicalAnalysis(args);

      List<String> expected =
          stream
          .map(this::prefixBeforeColon)
          .collect(Collectors.toList());
      List<String> actual =
          buf.toString().lines()
          .map(this::prefixBeforeColon)
          .collect(Collectors.toList());
      Assertions.assertIterableEquals(expected, actual);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  private String prefixBeforeColon(String str) {
    int index = str.indexOf(':');
    Assertions.assertTrue(index >= 0, "Missing ':': " + str);
    return str.substring(0, index);
  }

  @Test
  public void testIfElse() {
    testNormal("./src/test/test-sets/lab1/if-else-test.sy",
        "./src/test/test-sets/lab1/if-else-test.out");
  }

  @Test
  public void test1() {
    testNormal("./src/test/test-sets/lab1/test1.sy",
        "./src/test/test-sets/lab1/test1.out");
  }

  @Test
  public void test2() {
    testError("./src/test/test-sets/lab1/test2.sy",
        "./src/test/test-sets/lab1/test2.out");
  }

  @Test
  public void test3() {
    testNormal("./src/test/test-sets/lab1/test3.sy",
        "./src/test/test-sets/lab1/test3.out");
  }

  @Test
  public void test4() {
    testNormal("./src/test/test-sets/lab1/test4.sy",
        "./src/test/test-sets/lab1/test4.out");
  }

  @Test
  public void test5() {
    testError("./src/test/test-sets/lab1/test5.sy",
        "./src/test/test-sets/lab1/test5.out");
  }

  @AfterEach
  public void restoreErr() {
    System.setErr(systemErr);
    buf = null;
  }
}
