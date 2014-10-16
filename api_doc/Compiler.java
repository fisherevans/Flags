package apidocker;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class Compiler {
  private File _src, _out;

  public Compiler(File src, File out) {
    _src = src;
    _out = out;
  }

  public void digest() {
    if (_src == null || !_src.exists())
      return;
    List<File> files = new ArrayList<File>();
    if (_src.isDirectory()) {
      for (File child : _src.listFiles())
        files.add(child);
    } else {
      files.add(_src);
    }
    for (int fileId = 0; fileId < files.size(); fileId++) {
      File file = files.get(fileId);
      if (file.isDirectory()) {
        for (File child : file.listFiles())
          files.add(child);
      } else {
        parseFile(file);
      }
    }
  }

  private void parseFile(File file) {
    if (file == null || !file.exists() || !file.isFile())
      return;
    try {
      System.out.println("Reading: " + file.getCanonicalPath());
    } catch (Exception e) {
      e.printStackTrace();
      System.exit(1);
    }
  }

  public void vomit() {

  }

  public static void main(String[] args) {
    Compiler compiler = new Compiler(new File(args[0]), new File(args[1]));
    compiler.digest();
    compiler.vomit();
  }
}
