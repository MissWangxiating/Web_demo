package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import db.Db_connect;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class AddServlet
 */
@WebServlet("/AddServlet")
public class AddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("==========AddServlet START=============");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		String json = "";
		if(request.getParameter("addJson")!=null){
			json = request.getParameter("addJson");
			//System.out.println("==get==jsonstr:"+json);			
		}
		JSONObject jsonobj = JSONObject.fromObject(json);
		String name = jsonobj.getString("name");
		String sex = "";
				if(jsonobj.getString("sex").equals("男")){
					sex="1";
				}else{
					sex="0";
				}
		String intro = jsonobj.getString("intro");
		String birth = jsonobj.getString("birth");
		String place = jsonobj.getString("place");
		//String file = jsonobj.getString("file");
		int flag = Db_connect.executeUpdate("insert student(name,sex,intro,birth,place) values ('"+name+"','"+sex+"','"+intro+"','"+birth+"','"+place+"')");
		if(flag!=0){
			System.out.println("=========INSERT SUCCESS========");
		}else{
			System.out.println("=====failed,please check sql===");
		}
		Db_connect.close();		
	}

}
