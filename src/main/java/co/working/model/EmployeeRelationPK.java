package co.working.model;

import javax.persistence.Embeddable;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;

@Embeddable
public class EmployeeRelationPK implements Serializable{
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="resumeId")
	private Resume  resume;//简历信息

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="hireinfoId")
	private HireInfo hireinfo;//职位信息
	
    
	public Resume getResume() {
		return resume;
	}
	public void setResume(Resume resume) {
		this.resume = resume;
	}
	public HireInfo getHireinfo() {
		return hireinfo;
	}
	public void setHireinfo(HireInfo hireinfo) {
		this.hireinfo = hireinfo;
	}

	public EmployeeRelationPK() {
		super();
	}

	@Override
	public int hashCode() {
		return super.hashCode();
	}
	@Override
	public boolean equals(Object obj) {
		return super.equals(obj);
	}
	public EmployeeRelationPK(Resume resume, HireInfo hireinfo) {
		super();
		this.resume = resume;
		this.hireinfo = hireinfo;
	}
	
	
}
