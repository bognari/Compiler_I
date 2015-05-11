package ex2;

import java.io.FileReader;
import java.io.IOException;

import beaver.*;
import beaver.Parser.Exception;


public class Main {

	public static void main(String[] args) {
		String inputFileName;		
		   if(args.length != 1) {
		      System.out.println("EX2: missing file command line argument");
		      //System.exit(1);
		      inputFileName = "tests/example.txt";
		    }
		   else {
		      System.out.println("EX2: starting on file " + args[0]);
		      System.out.flush();
		      inputFileName = args[0];
		    }
		   try {
			Scanner lexer  = new EX2Scanner(new FileReader(inputFileName));
			Parser parser = new EX2Parser();

			double result = (double) parser.parse(lexer);
			   System.out.println("Ausgabe");
			   System.out.println(String.format("%.2f", result).replace(',', '.'));
		} catch (IOException | Exception e) {
			e.printStackTrace();
		}

	}

}
