package lab4;

import org.antlr.v4.runtime.misc.Pair;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class LLVMIRBaseTest {
  protected void test(String input, String output, String refer) {
    String[] args = {input, output};
    try {
      LLVMIRHelper.handle(args);
      Assertions.assertTrue(Files.exists(Path.of(output)), "Failed to generate llvm-ir output file.");
      Pair<Integer, String> expected = runLLVM(refer);
      Pair<Integer, String> actual = runLLVM(output);
      Assertions.assertTrue(expected.b.isEmpty(),
          "There is something wrong with the reference output:\n" + expected.b);
      Assertions.assertTrue(actual.b.isEmpty(), actual.b);
      Assertions.assertEquals(expected.a, actual.a);
    } catch (IOException | InterruptedException e) {
      throw new RuntimeException(e);
    }
  }

  private Pair<Integer, String> runLLVM(String path) throws IOException, InterruptedException {
    Process process = new ProcessBuilder("lli", path).start();
    return new Pair<>(process.waitFor(), new String(process.getInputStream().readAllBytes()));
  }

  @BeforeEach
  public void checkLli() throws IOException, InterruptedException {
    Process process = new ProcessBuilder("which", "lli").start();
    Assertions.assertEquals(0, process.waitFor(),
        "Could not find lli. Use \"sudo apt update; sudo apt install llvm\" to install lli and try again.");
  }
}
