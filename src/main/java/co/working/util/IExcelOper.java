package co.working.util;

import java.util.List;

public interface IExcelOper {
    public void CreateExcel(String outputFile, List list);

    public Object ReadExcel(String fileToBeRead);
}
