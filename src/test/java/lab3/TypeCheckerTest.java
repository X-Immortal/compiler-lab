package lab3;

import com.google.common.collect.HashMultiset;
import com.google.common.collect.Multiset;
import com.google.common.collect.Multisets;
import org.antlr.v4.runtime.misc.Pair;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TypeCheckerTest {
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
      TypeChecker.check(args);
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
      TypeChecker.check(args);

      Map<Integer, List<Pair<Integer, Integer>>> expected = stream
          .map(this::prefixBeforeColon)
          .map(this::extract)
          .collect(Collectors.groupingBy(pair -> pair.b));
      Multiset<Pair<Integer, Integer>> expectedSameSet = HashMultiset.create();
      Set<Integer> anySetLines = new HashSet<>();
      Multiset<Pair<Integer, Integer>> expectedAnySet = HashMultiset.create();
      expected.forEach((lineNo, list) -> {
        Map<Integer, List<Pair<Integer, Integer>>> types =
            list.stream()
                .collect(Collectors.groupingBy(pair -> pair.a));
        if (types.size() > 1) {
          anySetLines.add(lineNo);
          expectedAnySet.addAll(list);
        } else {
          expectedSameSet.addAll(list);
        }
      });

      Map<Integer, List<Pair<Integer, Integer>>> actual = buf.toString().lines()
          .map(this::prefixBeforeColon)
          .map(this::extract)
          .collect(Collectors.groupingBy(pair -> pair.b));
      Multiset<Pair<Integer, Integer>> actualSameSet = HashMultiset.create();
      Multiset<Pair<Integer, Integer>> actualAnySet = HashMultiset.create();
      actual.forEach((lineNo, list) -> {
        if (anySetLines.contains(lineNo)) {
          actualAnySet.addAll(list);
        } else {
          actualSameSet.addAll(list);
        }
      });

      Assertions.assertIterableEquals(expectedSameSet, actualSameSet);
      Assertions.assertTrue(Multisets.containsOccurrences(expectedAnySet, actualAnySet));
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  private String prefixBeforeColon(String str) {
    int index = str.indexOf(':');
    index = index >= 0 ? index : str.length();
    return str.substring(0, index);
  }

  private Pair<Integer, Integer> extract(String str) {
    Pattern pattern = Pattern.compile("Error type (\\d+) at Line (\\d+)");
    Matcher matcher = pattern.matcher(str);
    Assertions.assertTrue(matcher.matches(), "Output format error: " + str);
    return new Pair<>(
        Integer.parseInt(matcher.group(1)),
        Integer.parseInt(matcher.group(2)));
  }

  @Test
  public void test1() {
    testError("./src/test/test-sets/lab3/test1.sy",
        "./src/test/test-sets/lab3/test1.out");
  }

  @Test
  public void test2() {
    testError("./src/test/test-sets/lab3/test2.sy",
        "./src/test/test-sets/lab3/test2.out");
  }

  @Test
  public void test3() {
    testNormal("./src/test/test-sets/lab3/test3.sy",
        "./src/test/test-sets/lab3/test3.out");
  }

  @Test
  public void test4() {
    testError("./src/test/test-sets/lab3/test4.sy",
        "./src/test/test-sets/lab3/test4.out");
  }

  @Test
  public void test5() {
    testNormal("./src/test/test-sets/lab3/test5.sy",
        "./src/test/test-sets/lab3/test5.out");
  }

  @Test
  public void test6() {
    testError("./src/test/test-sets/lab3/test6.sy",
        "./src/test/test-sets/lab3/test6.out");
  }

  @Test
  public void test7() {
    testNormal("./src/test/test-sets/lab3/test7.sy",
        "./src/test/test-sets/lab3/test7.out");
  }

  @Test
  public void test8() {
    testError("./src/test/test-sets/lab3/test8.sy",
        "./src/test/test-sets/lab3/test8.out");
  }

  @Test
  public void test9() {
    testError("./src/test/test-sets/lab3/test9.sy",
        "./src/test/test-sets/lab3/test9.out");
  }

  @Test
  public void test10() {
    testError("./src/test/test-sets/lab3/test10.sy",
        "./src/test/test-sets/lab3/test10.out");
  }

  @Test
  public void test11() {
    testNormal("./src/test/test-sets/lab3/test11.sy",
        "./src/test/test-sets/lab3/test11.out");
  }

  @Test
  public void test12() {
    testNormal("./src/test/test-sets/lab3/test12.sy",
        "./src/test/test-sets/lab3/test12.out");
  }


  @AfterEach
  public void restoreErr() {
    System.setErr(systemErr);
    buf = null;
  }
}
