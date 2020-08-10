package com.maskkk.dao;
 
import java.sql.ResultSet;
 
import java.sql.SQLException;
 
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;
 
import org.springframework.beans.factory.annotation.Autowired;
 
import org.springframework.jdbc.core.JdbcTemplate;
 
import org.springframework.jdbc.core.RowMapper;
 
import com.maskkk.model.Login;
 
import com.maskkk.model.User;
 
public class UserDaoImpl implements UserDao {
 
  @Autowired
 
  DataSource datasource;
 
  @Autowired
 
  JdbcTemplate jdbcTemplate;
 
  public void register(User user) {
    //注册用户信息
    String sql = "insert into users values(?,?,?,?,?,?,?,?)";
 
    jdbcTemplate.update(sql, new Object[] { user.getUsername(), user.getPassword(), user.getFirstname(),
     		
    user.getLastname(), user.getEmail(), user.getAddress(), user.getPhone(), 0 });
    //注册用户主目录信息，用户主目录就是用户名，它的fatherid是0
    String sql2 = "insert into directory (dirname, fatherid, username) values(?,?,?)";
    
    jdbcTemplate.update (sql2, new Object[]{user.getUsername(), 0, user.getUsername()});
    
    //建立这个主目录
    
    //update User表的curdirid
    String sql3 = "select id from directory where dirname='"+user.getUsername()+"'";
    Map result3 = (Map)jdbcTemplate.queryForMap(sql3);
    Integer id= (Integer)result3.get("id");
    String sql4 = "update users set curdirid = ? where username = ?";
    jdbcTemplate.update(sql4, new Object[]{id, user.getUsername()});
    user.setCurdirid(id);
    }
 
    public User validateUser(Login login) {
 
    String sql = "select * from users where username='" + login.getUsername() + "' and password='" + login.getPassword()
 
    + "'";
 
    List<User> users = jdbcTemplate.query(sql, new UserMapper());
 
    return users.size() > 0 ? users.get(0) : null;
 
    }

	public void makeNewDir(String dir, String fatherid, String username) {
		 String sql1 = "insert into directory (dirname, fatherid, username) values(?,?,?)";
		    
		 jdbcTemplate.update (sql1, new Object[]{dir, fatherid, username});
	}

	public void deleteDir(User user) {
		// TODO Auto-generated method stub
		
	}

	public void renameDir(User user) {
		// TODO Auto-generated method stub
		
	}

	public String getCurDirName(String dirid) {
		String sql1 = "select dirname from directory where id='"+dirid+"'";
	    Map result1 = (Map)jdbcTemplate.queryForMap(sql1);
	    String dirname= (String)result1.get("dirname");
	    return dirname;
	}

	public String getCurDirName(User user) {
		// TODO Auto-generated method stub
		return null;
	}

	public String getCurDirIdByUsername(String username) {
		String sql1 = "select curdirid from users where username='"+username+"'";
	    Map result1 = (Map)jdbcTemplate.queryForMap(sql1);
	    String dirid= result1.get("curdirid").toString();
	    return dirid;
	}
	public String getCurDirIdByDirname(String dirname) {
		String sql1 = "select id from directory where dirname='"+dirname+"'";
	    Map result1 = (Map)jdbcTemplate.queryForMap(sql1);
	    String dirid= result1.get("id").toString();
	    return dirid;
	}
	
	public String getCurDirIdByDirname(String dirname, String curdirid) {
		String sql1 = "select id from directory where dirname='"+dirname+"' and fatherid='"+curdirid+"'";
	    Map result1 = (Map)jdbcTemplate.queryForMap(sql1);
	    String dirid= result1.get("id").toString();
	    return dirid;
	}
	
	public Integer getFatherId(String curdirid) {
		String sql1 = "select fatherid from directory where id="+Integer.valueOf(curdirid);
	    Map result1 = (Map)jdbcTemplate.queryForMap(sql1);
	    Integer fatherid= (Integer) result1.get("fatherid");
	    return fatherid;
	}

	
	public String getCurDirId(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	
 
  }
 
  class UserMapper implements RowMapper<User> {
 
  public User mapRow(ResultSet rs, int arg1) throws SQLException {
 
    User user = new User();
 
    user.setUsername(rs.getString("username"));
 
    user.setPassword(rs.getString("password"));
 
    user.setFirstname(rs.getString("firstname"));
 
    user.setLastname(rs.getString("lastname"));
 
    user.setEmail(rs.getString("email"));
 
    user.setAddress(rs.getString("address"));
 
    user.setPhone(rs.getInt("phone"));
 
    return user;
 
  }
 
}
