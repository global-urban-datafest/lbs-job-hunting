package co.working.service.impl;

import co.working.dao.ICommonDao;
import co.working.model.Resume;
import co.working.model.ResumeDetail;
import co.working.service.ICommonService;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("resumeDetailService")
public class ResumeDetailServiceImpl implements ICommonService<ResumeDetail ,Integer> {

	private ICommonDao<ResumeDetail, Integer> resumeDetailDao;

	public ICommonDao<ResumeDetail, Integer> getResumeDetailDao() {
		return resumeDetailDao;
	}
	@Autowired
	public void setResumeDetailDao(ICommonDao<ResumeDetail, Integer> resumeDetailDao) {
		this.resumeDetailDao = resumeDetailDao;
	}

	public List<ResumeDetail> findAllByResumer(Resume resume){
        DetachedCriteria criteria=DetachedCriteria.forClass(ResumeDetail.class);
        criteria.add(Property.forName("resume").eq(resume) );
		List<ResumeDetail> list=this.getResumeDetailDao().findByCriteria(criteria);
		criteria=null;
		return list;
	}

    public ResumeDetail save(ResumeDetail resumeDetail){
       return  this.getResumeDetailDao().save(resumeDetail);
    }
    
    public void update(ResumeDetail resumeDetail){
    	this.getResumeDetailDao().update(resumeDetail);
    }	
    
    public ResumeDetail findExampleById(Integer id){
    	return this.getResumeDetailDao().get(ResumeDetail.class, id);
    }
	public void detele(Integer id) {
    	ResumeDetail rd=new ResumeDetail();
    	rd.setId(id);
		this.getResumeDetailDao().delete(rd);
	}
	public ResumeDetail get(int id) {
		// TODO Auto-generated method stub
		return null;
	}
	public void deleteAll(List<ResumeDetail> rds) {
		resumeDetailDao.deleteAll(rds);
	}
	public void merge(ResumeDetail resumeDetail) {
		resumeDetailDao.merge(resumeDetail);
	}
}
