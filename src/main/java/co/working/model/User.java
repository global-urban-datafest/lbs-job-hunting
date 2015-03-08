package co.working.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name="t_user")
public class User implements Serializable{
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private int id;//自增长位
    @Column(name="name", unique=true)
    private String name;//登录名
    @Column(name="password")
    private String password;//登录密码
    @Column(name="headImage")
    private String headImage;//头像
    @Column(name="maxim")
    private String maxim;//格言
    @Column(name="checkflag")
    private Boolean checkflag;//资料完成标志位
    @Column(name="registeremail", unique=true)
    private String registeremail;//注册email
    @Column(name="registerdate")
    private Date registerdate;//注册日期
    @Column(name="lastlogindate")
    private Date lastlogindate;//上次登录日期
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
    private Set<Resume> resumes= new HashSet<Resume>();
    
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getHeadImage() {
        return headImage;
    }

    public void setHeadImage(String headImage) {
        this.headImage = headImage;
    }

    public String getMaxim() {
        return maxim;
    }

    public void setMaxim(String maxim) {
        this.maxim = maxim;
    }

    public Boolean getCheckflag() {
        return checkflag;
    }

    public void setCheckflag(Boolean checkflag) {
        this.checkflag = checkflag;
    }

    public String getRegisteremail() {
        return registeremail;
    }

    public void setRegisteremail(String registeremail) {
        this.registeremail = registeremail;
    }

    public Date getRegisterdate() {
        return registerdate;
    }

    public void setRegisterdate(Date registerdate) {
        this.registerdate = registerdate;
    }

    public Date getLastlogindate() {
        return lastlogindate;
    }

    public void setLastlogindate(Date lastlogindate) {
        this.lastlogindate = lastlogindate;
    }

	public Set<Resume> getResumes() {
		return resumes;
	}

	public void setResumes(Set<Resume> resumes) {
		this.resumes = resumes;
	}
    
}

