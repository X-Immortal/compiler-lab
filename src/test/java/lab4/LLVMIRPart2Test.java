package lab4;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class LLVMIRPart2Test extends LLVMIRBaseTest {
  @BeforeEach
  public void buildOutputDir() throws IOException {
    Files.createDirectories(Path.of("src/test/output/lab4/part2/"));
  }

  @Test
  public void sample1() {
    test("src/test/test-sets/lab4/part2/sample1.sy",
        "src/test/output/lab4/part2/sample1.ll",
        "src/test/test-sets/lab4/part2/sample1.ll");
  }

  @Test
  public void sample2() {
    test("src/test/test-sets/lab4/part2/sample2.sy",
        "src/test/output/lab4/part2/sample2.ll",
        "src/test/test-sets/lab4/part2/sample2.ll");
  }

  @Test
  public void sample3() {
    test("src/test/test-sets/lab4/part2/sample3.sy",
        "src/test/output/lab4/part2/sample3.ll",
        "src/test/test-sets/lab4/part2/sample3.ll");
  }

  @Test
  public void sample4() {
    test("src/test/test-sets/lab4/part2/sample4.sy",
        "src/test/output/lab4/part2/sample4.ll",
        "src/test/test-sets/lab4/part2/sample4.ll");
  }

  @Test
  public void sample5() {
    test("src/test/test-sets/lab4/part2/sample5.sy",
        "src/test/output/lab4/part2/sample5.ll",
        "src/test/test-sets/lab4/part2/sample5.ll");
  }
}
