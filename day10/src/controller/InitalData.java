package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import model.JDBCUtil;
import model.melonDAO;
import model.melonVO;


@WebListener
public class InitalData implements ServletContextListener {
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		melonDAO.delete();
	}
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		melonDAO.insert();
	}
}
