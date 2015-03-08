package co.working.service.impl;

import co.working.dao.ICommonDao;
import co.working.model.User;
import co.working.service.ICommonService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements ICommonService<User,Integer> {

    private ICommonDao<User, Integer> userDao;

    public ICommonDao<User, Integer> getUserDao() {
        return userDao;
    }

    @Autowired
    public void setUserDao(ICommonDao<User, Integer> userDao) {
        this.userDao = userDao;
    }

    public void save(User user) {
        this.getUserDao().merge(user);
    }

    public List<User> findAllByExample(User user){
        return this.getUserDao().findByExample(user);
    }

	public User findExampleById(int id) {
		return this.getUserDao().get(User.class, id);
	}
    public void update(User user) {
        this.getUserDao().update(user);
    }

	public List<User> findAll() {
		return userDao.findAll(User.class);
	}

	@SuppressWarnings("unchecked")
	public JSONObject findAllUser(int i, int rows) {
		SessionFactory sf=userDao.getSessionFactory();
		Session session=sf.openSession();
		Query query=session.createQuery("from User user");
		List<User> elist=query.list();
		int count=0;
		if(elist!=null&&elist.size()>0)
			count=elist.size();
		else
			count=0;
		List<User> list=query.setMaxResults(rows).setFirstResult(i).list();
		JSONObject data=new JSONObject();
		data.accumulate("total", count);
		if(list!=null&&list.size()>0){
			JSONArray arr=new JSONArray();
   			SimpleDateFormat sff=new SimpleDateFormat("yyyy-MM-dd");
			for(User user:list){
				JSONObject obj=new JSONObject();
				obj.accumulate("id", user.getId());
				obj.accumulate("name", user.getName());
				obj.accumulate("maxim", user.getMaxim()==null?"":user.getMaxim());
				obj.accumulate("checkflag", user.getCheckflag()==null?false:user.getCheckflag());
				obj.accumulate("registeremail", user.getRegisteremail()==null?false:user.getRegisteremail());
				if(user.getRegisterdate()!=null)
					obj.accumulate("registerdate", sff.format(user.getRegisterdate()));
				else
					obj.accumulate("registerdate","");
				if(user.getLastlogindate()!=null)
					obj.accumulate("lastlogindate", sff.format(user.getLastlogindate()));
				else
					obj.accumulate("lastlogindate","");
				arr.add(obj);
			}
			data.accumulate("rows", arr);
		}else{
			data.accumulate("rows", "");
		}
		session.close();
		return data;
	}

	public User get(int id) {
		return userDao.get(User.class, id);
	}

	public void merger(User u) {
		userDao.merge(u);
	}

	public void delete(int id) {
		User u=new User();
		u.setId(id);
		userDao.delete(u);
	}

	public void delete(User u) {
		userDao.delete(u);
	}

}
