package co.working.service.impl;

import co.working.dao.ICommonDao;
import co.working.model.RootUser;
import co.working.service.ICommonService;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("rootUserService")
public class RootUserServiceImpl implements ICommonService<RootUser, Integer> {
	private ICommonDao<RootUser, Integer> rootUserDao;
	@Autowired
	public void setRootUserDao(@Qualifier("rootUserDao")ICommonDao<RootUser, Integer> rootUserDao) {
		this.rootUserDao = rootUserDao;
	}
	public List<RootUser> findExampleByCriteria(String paramName,Object obj){
        DetachedCriteria criteria=DetachedCriteria.forClass(RootUser.class);
        criteria.add(Property.forName(paramName).eq(obj));
        return rootUserDao.findByCriteria(criteria);	
	}
	public void update(RootUser root) {
		rootUserDao.update(root);
	}
	public void save(RootUser rootUser) {
		rootUserDao.save(rootUser);
	}
	public List<RootUser> findAllExample() {
		return rootUserDao.findAll(RootUser.class);
	}
	public void delete(int id) {
		RootUser rootUser=new RootUser();
		rootUser.setId(id);
		rootUserDao.delete(rootUser);
	}
	public RootUser get(int id) {
		return rootUserDao.get(RootUser.class, id);
	}
	public void merge(RootUser rootUser) {
		rootUserDao.merge(rootUser);
	}
}
