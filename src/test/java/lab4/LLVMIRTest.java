package lab4;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class LLVMIRTest extends LLVMIRBaseTest {
  @BeforeEach
  public void buildOutputDir() throws IOException {
    Files.createDirectories(Path.of("src/test/output/lab4/"));
  }

  @Test
  public void sample1() {
    test("src/test/test-sets/lab4/sample1.sy",
        "src/test/output/lab4/sample1.ll",
        "src/test/test-sets/lab4/sample1.ll");
  }

  @Test
  public void sample2() {
    test("src/test/test-sets/lab4/sample2.sy",
        "src/test/output/lab4/sample2.ll",
        "src/test/test-sets/lab4/sample2.ll");
  }

  @Test
  public void test1() {
    test("src/test/test-sets/lab4/test1.sy",
        "src/test/output/lab4/test1.ll",
        "src/test/test-sets/lab4/test1.ll");
  }

  @Test
  public void test2() {
    test("src/test/test-sets/lab4/test2.sy",
        "src/test/output/lab4/test2.ll",
        "src/test/test-sets/lab4/test2.ll");
  }

  @Test
  public void test3() {
    test("src/test/test-sets/lab4/test3.sy",
        "src/test/output/lab4/test3.ll",
        "src/test/test-sets/lab4/test3.ll");
  }

  @Test
  public void test4() {
    test("src/test/test-sets/lab4/test4.sy",
        "src/test/output/lab4/test4.ll",
        "src/test/test-sets/lab4/test4.ll");
  }

  @Test
  public void test5() {
    test("src/test/test-sets/lab4/test5.sy",
        "src/test/output/lab4/test5.ll",
        "src/test/test-sets/lab4/test5.ll");
  }

  @Test
  public void test6() {
    test("src/test/test-sets/lab4/test6.sy",
        "src/test/output/lab4/test6.ll",
        "src/test/test-sets/lab4/test6.ll");
  }

  @Test
  public void test7() {
    test("src/test/test-sets/lab4/test7.sy",
        "src/test/output/lab4/test7.ll",
        "src/test/test-sets/lab4/test7.ll");
  }

  @Test
  public void test8() {
    test("src/test/test-sets/lab4/test8.sy",
        "src/test/output/lab4/test8.ll",
        "src/test/test-sets/lab4/test8.ll");
  }

  @Test
  public void test9() {
    test("src/test/test-sets/lab4/test9.sy",
        "src/test/output/lab4/test9.ll",
        "src/test/test-sets/lab4/test9.ll");
  }

  @Test
  public void test10() {
    test("src/test/test-sets/lab4/test10.sy",
        "src/test/output/lab4/test10.ll",
        "src/test/test-sets/lab4/test10.ll");
  }

  @Test
  public void test11() {
    test("src/test/test-sets/lab4/test11.sy",
        "src/test/output/lab4/test11.ll",
        "src/test/test-sets/lab4/test11.ll");
  }

  @Test
  public void test12() {
    test("src/test/test-sets/lab4/test12.sy",
        "src/test/output/lab4/test12.ll",
        "src/test/test-sets/lab4/test12.ll");
  }

  @Test
  public void test13() {
    test("src/test/test-sets/lab4/test13.sy",
        "src/test/output/lab4/test13.ll",
        "src/test/test-sets/lab4/test13.ll");
  }

  @Test
  public void test14() {
    test("src/test/test-sets/lab4/test14.sy",
        "src/test/output/lab4/test14.ll",
        "src/test/test-sets/lab4/test14.ll");
  }

  @Test
  public void test15() {
    test("src/test/test-sets/lab4/test15.sy",
        "src/test/output/lab4/test15.ll",
        "src/test/test-sets/lab4/test15.ll");
  }
}
