package co.working.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;

@Entity(name="t_hireinfo_resume")
public class EmployeeRelation implements Serializable{
	@Id
	private EmployeeRelationPK pk;
	
    @Column(name="sendDate")
	private  Date sendDate;//投递日期
    
    @Column(name="isViewFlag")
	private  int viewFlag;//1.在审阅2.未录取3.录取
    
	public EmployeeRelationPK getPk() {
		return pk;
	}

	public void setPk(EmployeeRelationPK pk) {
		this.pk = pk;
	}

	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}

	public int getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(int viewFlag) {
		this.viewFlag = viewFlag;
	}
	
}
