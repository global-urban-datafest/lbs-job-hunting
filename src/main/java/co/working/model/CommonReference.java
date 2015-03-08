package co.working.model;

import javax.persistence.*;
import java.io.Serializable;

/*
 * 公用reference实体类
 * */
@Entity
@Table(name="t_commonRef")
public class CommonReference implements Serializable {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
    @Column(name="ref_tableName")
	private String tableName;
    @Column(name="ref_tableDesc")
	private String tableDesc;
    @Column(name="ref_tableMemo")
	private String tableMemo;
    @Column(name="ref_tableOrderNum")
	private String tableOrderNum;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTableDesc() {
		return tableDesc;
	}
	public void setTableDesc(String tableDesc) {
		this.tableDesc = tableDesc;
	}
	public String getTableMemo() {
		return tableMemo;
	}
	public void setTableMemo(String tableMemo) {
		this.tableMemo = tableMemo;
	}
	public String getTableOrderNum() {
		return tableOrderNum;
	}
	public void setTableOrderNum(String tableOrderNum) {
		this.tableOrderNum = tableOrderNum;
	}
	
}
