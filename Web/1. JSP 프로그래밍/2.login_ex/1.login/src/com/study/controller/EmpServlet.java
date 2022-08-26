package com.study.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.study.dto.EmpDTO;
import com.study.dto.LoginDTO;
import com.study.service.EmpServiceImpl;
import com.study.service.LoginService;
import com.study.service.LoginServiceImpl;

@WebServlet("/emp")
public class EmpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        process(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        process(request, response);
    }

    private void process(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "insertemp":
                doInsert(request, response);
                break;
            case "listemp":
                doList(request, response);
                break;
            case "updateemp":
                doUpdate(request, response);
                break;
            case "deleteemp":
                doDelete(request, response);
                break;
        }
    }
    
    //추가하기--------------------------------------------------------------------------
	protected void doInsert(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		EmpDTO emp=new EmpDTO();
		emp.setEname(request.getParameter("ename"));
		emp.setPhone(request.getParameter("phone"));
		emp.setDept(request.getParameter("dept"));
		
		int n=EmpServiceImpl.getEmpService().insertEmp(emp);
		if(n > 0) {
			doList(request, response);
			//response.sendRedirect("/log/list");
		}else {
			System.out.println("error");
		}
	}
	//전체보기--------------------------------------------------------------------------
	protected void doList(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		List<EmpDTO> list=EmpServiceImpl.getEmpService().listEmp();
		if(list != null) {
			//System.out.println("OK List");
			
			/* request 객체 */
			RequestDispatcher rd=request.getRequestDispatcher("emptest/empList.jsp");
			request.setAttribute("emp",list);  // 리케스트명: emp
			rd.forward(request, response);     // empList.jsp에게 권한을 위임
		}
	}
	//수정하기--------------------------------------------------------------------------
	protected void doUpdate(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		EmpDTO dto=new EmpDTO();
		dto.setEno(Integer.parseInt(request.getParameter("eno")));
		dto.setPhone(request.getParameter("phone"));
		dto.setDept(request.getParameter("dept"));
		
		int n=EmpServiceImpl.getEmpService().updateEmp(dto);		
		if(n>0) {
			doList(request, response);
			//response.sendRedirect("/log/list");
		}else {
			System.out.println("error");
		}		
	}
	//삭제하기--------------------------------------------------------------------------
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		EmpDTO dto=new EmpDTO();
		dto.setEno(Integer.parseInt(request.getParameter("eno")));
		
		int n=EmpServiceImpl.getEmpService().deleteEmp(dto);		
		if(n > 0){
			doList(request, response);
			//response.sendRedirect("/log/list");
		}else{
			System.out.println("error");
		}		
	}
}









