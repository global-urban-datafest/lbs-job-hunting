package co.working.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * description 公司实体类
 */
@Entity
@Table(name="t_company")
public class Company implements Serializable{
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private int id;
    @Column(name="loginName")
    private String cpy_loginName;//登录名
    @Column(name="loginPass")
    private String cpy_loginPass;//登录密码
    @Column(name="companyName")
    private String companyName;//公司名
    @Column(name="companySize")
    private Integer companySize;//公司规模
    @Column(name="companyType")
    private Integer companyType;//公司性质
    @Lob
    @Column(name="companyDesc")
    private String companyDesc;//公司描述
    @Column(name="legalPerson")
    private String legalPerson;//法人代表
    @Column(name="companyURL")
    private String companyURL;//公司网址
    @Column(name="companyTel")
    private String companyTel;//公司电话
    @Column(name="companyEmail")
    private String companyEmail;//公司email
    @Column(name="hotFlag")
    private boolean cpy_hot_flag;//是否为热门公司
    @Column(name="companyAddress")
    private String companyAddress;//公司地址
    @Column(name="lastLoginDate")
    private Date lastLoginDate;//上次登录信息
    @Column(name="creationDate")
    private Date creationDate;//创建时间
    @Column(name="companyLogo")
    private String companyLogo;//公司Logo
    @OneToMany(cascade=CascadeType.ALL,fetch=FetchType.LAZY,mappedBy="company")
    private Set<HireInfo> hireinfoes=new HashSet<HireInfo>();
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCpy_loginName() {
        return cpy_loginName;
    }

    public void setCpy_loginName(String cpy_loginName) {
        this.cpy_loginName = cpy_loginName;
    }

    public String getCpy_loginPass() {
        return cpy_loginPass;
    }

    public void setCpy_loginPass(String cpy_loginPass) {
        this.cpy_loginPass = cpy_loginPass;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public Integer getCompanySize() {
        return companySize;
    }

    public void setCompanySize(Integer companySize) {
        this.companySize = companySize;
    }

    public Integer getCompanyType() {
        return companyType;
    }

    public void setCompanyType(Integer companyType) {
        this.companyType = companyType;
    }

    public String getCompanyDesc() {
        return companyDesc;
    }

    public void setCompanyDesc(String companyDesc) {
        this.companyDesc = companyDesc;
    }

    public String getLegalPerson() {
        return legalPerson;
    }

    public void setLegalPerson(String legalPerson) {
        this.legalPerson = legalPerson;
    }

    public String getCompanyURL() {
        return companyURL;
    }

    public void setCompanyURL(String companyURL) {
        this.companyURL = companyURL;
    }

    public String getCompanyTel() {
        return companyTel;
    }

    public void setCompanyTel(String companyTel) {
        this.companyTel = companyTel;
    }

    public String getCompanyEmail() {
        return companyEmail;
    }

    public void setCompanyEmail(String companyEmail) {
        this.companyEmail = companyEmail;
    }

    public boolean isCpy_hot_flag() {
        return cpy_hot_flag;
    }

    public void setCpy_hot_flag(boolean cpy_hot_flag) {
        this.cpy_hot_flag = cpy_hot_flag;
    }

    public String getCompanyAddress() {
        return companyAddress;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress;
    }

	public Date getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public String getCompanyLogo() {
		return companyLogo;
	}

	public void setCompanyLogo(String companyLogo) {
		this.companyLogo = companyLogo;
	}

	public Set<HireInfo> getHireinfoes() {
		return hireinfoes;
	}

	public void setHireinfoes(Set<HireInfo> hireinfoes) {
		this.hireinfoes = hireinfoes;
	}
    
}
