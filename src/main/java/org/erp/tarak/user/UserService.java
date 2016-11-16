package org.erp.tarak.user;

import java.util.List;


public interface UserService {
	public void addUser(User user);

	public List<User> listUsers();

	public User getUser(String userId);

	public void deleteUser(User user);
}
