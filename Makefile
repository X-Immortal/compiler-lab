include Makefile.git

export CLASSPATH=/usr/local/lib/antlr-*-complete.jar

DOMAINNAME = oj.compilers.cpl.icu
ANTLR = java -jar /usr/local/lib/antlr-*-complete.jar -listener -visitor -long-messages
JAVAC = javac -g
JAVA = java
FILEPATH = /home/ubuntu/BY_LAB/Lab/tests/test1.sysy

PFILE = $(shell find . -name "SysYParser.g4")
LFILE = $(shell find . -name "SysYLexer.g4")
JAVAFILE = $(shell find ./src/main -name "*.java")
ANTLRPATH = $(shell find /usr/local/lib -name "antlr-*-complete.jar")
 

compile: antlr
	$(call git_commit,"make")
	mkdir -p classes
	$(JAVAC) -classpath $(ANTLRPATH) $(JAVAFILE) -d classes

run: compile
	java -classpath ./classes:$(ANTLRPATH) Main $(FILEPATH)


antlr: $(LFILE) $(PFILE) 
	$(ANTLR) $(PFILE) $(LFILE)


test: compile
	$(call git_commit, "test")
	nohup java -classpath ./classes:$(ANTLRPATH) Main ./tests/test1.sysy &


clean:
	find src/main/antlr -type f \( -name "*.tokens" -o -name "*.interp" -o -name "*Lexer.java" -o -name "*Parser.java" -o -name "*BaseListener.java" -o -name "*Listener.java" -o -name "*BaseVisitor.java" -o -name "*Visitor.java" \) -delete
	rm -rf classes
	rm -rf out
	rm -rf src/main/antlr/.antlr


submit: clean
	git gc
	bash submit.sh


.PHONY: compile antlr test run clean submit
