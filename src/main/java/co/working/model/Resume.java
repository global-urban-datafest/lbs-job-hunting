package co.working.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name="t_resume")
public class Resume implements Serializable{
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private int id;//自增长位
    @Column(name="name")
    private String name;//简历名称
    @Column(name="publicFlag")
    private Boolean public_flag;//是否可见
    @Column(name="compeletepercent")
    private Double compeletepercent;//完整百分比
    @Column(name="compeleteflag")
    private Boolean compeleteflag;//完整标志位
    @Column(name="creationdate")
    private Date creationdate;//创建日期
    @Column(name="updatedate")
    private Date updatedate;//更新日期
    @Column(name="defaultResumeFlag")
    private boolean defaultResumeFlag;///默认简历
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="userId")
    private User user;//拥有者
    @OneToOne(cascade=CascadeType.ALL)
    @PrimaryKeyJoinColumn//这个注解只能写在主(生成ID)的一端
    private ResumeDetail resumeDetail;//基本详情

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY,mappedBy="pk.resume")
	private Set<EmployeeRelation>  employeerelations=new HashSet<EmployeeRelation>();
    
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getPublic_flag() {
		return public_flag;
	}

	public void setPublic_flag(Boolean public_flag) {
		this.public_flag = public_flag;
	}

	public Double getCompeletepercent() {
		return compeletepercent;
	}

	public void setCompeletepercent(Double compeletepercent) {
		this.compeletepercent = compeletepercent;
	}

	public Boolean getCompeleteflag() {
		return compeleteflag;
	}

	public void setCompeleteflag(Boolean compeleteflag) {
		this.compeleteflag = compeleteflag;
	}

	public Date getCreationdate() {
		return creationdate;
	}

	public void setCreationdate(Date creationdate) {
		this.creationdate = creationdate;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
	

	public boolean isDefaultResumeFlag() {
		return defaultResumeFlag;
	}

	public void setDefaultResumeFlag(boolean defaultResumeFlag) {
		this.defaultResumeFlag = defaultResumeFlag;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public ResumeDetail getResumeDetail() {
		return resumeDetail;
	}

	public void setResumeDetail(ResumeDetail resumeDetail) {
		this.resumeDetail = resumeDetail;
	}

	public Set<EmployeeRelation> getEmployeerelations() {
		return employeerelations;
	}

	public void setEmployeerelations(Set<EmployeeRelation> employeerelations) {
		this.employeerelations = employeerelations;
	}
   
	
}
