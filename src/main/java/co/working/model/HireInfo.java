package co.working.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "t_hireInfo")
public class HireInfo implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	@Lob
	@Column(name = "hireDesc")
	private String hireDesc;// 职位描述
	@Column(name = "positionName")
	private String positionName;// 职位名称
	@Column(name = "workplace")
	private String workplace;//工作地点
	@Column(name = "jobpeopleNum")
	private int jobpeopleNum;//招聘人数
	@Column(name = "worktype")
	private Integer worktype;// 工作类型
	@Column(name = "salary")
	private String salary;// 薪资待遇
	@Lob
	@Column(name = "jobRequried")
	private String jobRequried;// 职位需求
	@Lob
	@Column(name = "jobTreatment")
	private String jobTreatment;// 职位待遇
	@Column(name="disabled_flag")
	private boolean disabledFlag;//职位过期标志
	@Column(name="disabledDate")
	private Date disabledDate;//职位过期日期
	@Column(name="hotflag")
	private boolean hotflag;//是否为热门
	
	@Column(name = "workyear")
	private Integer workyear;// 工作年限

	@ManyToOne( fetch = FetchType.EAGER)
	@JoinColumn(name = "companyId", referencedColumnName = "id")
	private Company company;
	
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY,mappedBy="pk.hireinfo")
	private Set<EmployeeRelation>  employeerelations=new HashSet<EmployeeRelation>();
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getHireDesc() {
		return hireDesc;
	}

	public void setHireDesc(String hireDesc) {
		this.hireDesc = hireDesc;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public String getWorkplace() {
		return workplace;
	}

	public void setWorkplace(String workplace) {
		this.workplace = workplace;
	}

	public int getJobpeopleNum() {
		return jobpeopleNum;
	}

	public void setJobpeopleNum(int jobpeopleNum) {
		this.jobpeopleNum = jobpeopleNum;
	}

	public Integer getWorktype() {
		return worktype;
	}

	public void setWorktype(Integer worktype) {
		this.worktype = worktype;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getJobRequried() {
		return jobRequried;
	}

	public void setJobRequried(String jobRequried) {
		this.jobRequried = jobRequried;
	}

	public String getJobTreatment() {
		return jobTreatment;
	}

	public void setJobTreatment(String jobTreatment) {
		this.jobTreatment = jobTreatment;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}


	public boolean isDisabledFlag() {
		return disabledFlag;
	}

	public void setDisabledFlag(boolean disabledFlag) {
		this.disabledFlag = disabledFlag;
	}

	public Date getDisabledDate() {
		return disabledDate;
	}

	public void setDisabledDate(Date disabledDate) {
		this.disabledDate = disabledDate;
	}

	public boolean isHotflag() {
		return hotflag;
	}

	public void setHotflag(boolean hotflag) {
		this.hotflag = hotflag;
	}

	public Integer getWorkyear() {
		return workyear;
	}

	public void setWorkyear(Integer workyear) {
		this.workyear = workyear;
	}

	public Set<EmployeeRelation> getEmployeerelations() {
		return employeerelations;
	}

	public void setEmployeerelations(Set<EmployeeRelation> employeerelations) {
		this.employeerelations = employeerelations;
	}
}
