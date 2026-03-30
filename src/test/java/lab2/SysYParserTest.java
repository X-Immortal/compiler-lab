package lab2;

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

public class SysYParserTest {
  PrintStream systemOut = System.out;
  ByteArrayOutputStream buf = null;

  @BeforeEach
  public void setOut() {
    buf = new ByteArrayOutputStream();
    System.setOut(new PrintStream(buf));
  }

  private void testNormal(String inputPath, String outputPath) {
    try (Stream<String> stream = Files.lines(Path.of(outputPath));) {
      String[] args = {inputPath};
      SysYParserHelper.handle(args);
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
      SysYParserHelper.handle(args);

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
  public void testSample2() {
    testNormal("./src/test/test-sets/lab2/sample2.sy",
        "./src/test/test-sets/lab2/sample2.out");
  }

  @Test
  public void hardtest2() {
    testNormal("./src/test/test-sets/lab2/hardtest2.sy",
        "./src/test/test-sets/lab2/hardtest2.out");
  }

  @Test
  public void testSample3() {
    testNormal("./src/test/test-sets/lab2/sample3.sy",
        "./src/test/test-sets/lab2/sample3.out");
  }

  @Test
  public void test1() {
    testError("./src/test/test-sets/lab2/test1.sy",
        "./src/test/test-sets/lab2/test1.out");
  }

  @Test
  public void test2() {
    testNormal("./src/test/test-sets/lab2/test2.sy",
        "./src/test/test-sets/lab2/test2.out");
  }

  @Test
  public void test3() {
    testNormal("./src/test/test-sets/lab2/test3.sy",
        "./src/test/test-sets/lab2/test3.out");
  }

  @Test
  public void test4() {
    testNormal("./src/test/test-sets/lab2/test4.sy",
        "./src/test/test-sets/lab2/test4.out");
  }

  @Test
  public void test5() {
    testNormal("./src/test/test-sets/lab2/test5.sy",
        "./src/test/test-sets/lab2/test5.out");
  }

  @Test
  public void test6() {
    testNormal("./src/test/test-sets/lab2/test6.sy",
        "./src/test/test-sets/lab2/test6.out");
  }

  @Test
  public void test7() {
    testNormal("./src/test/test-sets/lab2/test7.sy",
        "./src/test/test-sets/lab2/test7.out");
  }

  @Test
  public void testBlock() {
    testNormal("./src/test/test-sets/lab2/test_block.sy",
        "./src/test/test-sets/lab2/test_block.out");
  }

  @Test
  public void testElif() {
    testNormal("./src/test/test-sets/lab2/test_elif.sy",
        "./src/test/test-sets/lab2/test_elif.out");
  }

  @Test
  public void testIfs() {
    testNormal("./src/test/test-sets/lab2/test_ifs.sy",
        "./src/test/test-sets/lab2/test_ifs.out");
  }

  @Test
  public void testSingleIfWhile() {
    testNormal("./src/test/test-sets/lab2/test_single_if_while.sy",
        "./src/test/test-sets/lab2/test_single_if_while.out");
  }

  @AfterEach
  public void restoreOut() {
    System.setOut(systemOut);
    buf = null;
  }
}
