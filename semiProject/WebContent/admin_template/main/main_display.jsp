<%@page import="java.text.DecimalFormat"%>
<%@page import="semiProject.dto.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="semiProject.dao.BoardDAO"%>
<%@page import="semiProject.dao.OrderDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/shop/security/admin_check.jspf" %>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  
    
 <%
	String today= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	String[] period={new SimpleDateFormat("yyyy-MM-dd").format(new Date().getTime()-((long)(60*60*24*1000)*6)), new SimpleDateFormat("yyyy-MM-dd").format(new Date().getTime()-((long)(60*60*24*1000)*30)) };
	int[] category={1,2,3,4,5,6,10,20,30,2,3,4};
	int[] dayNewCount=new int[12];
	for (int i=0;i<category.length;i++){
		if (i<10){
	 		dayNewCount[i]=OrderDAO.getDAO().dayOrderCount(today, category[i]);
		} else {
	 		dayNewCount[i]=BoardDAO.getDAO().dayBoardCount(today, category[i]);
		}
	}
    
    String[] days= new String[30];
    for(int i=0; i<days.length; i++) {
       days[i]=new SimpleDateFormat("yyyy-MM-dd").format(new Date().getTime()-((long)(60*60*24*1000)*i));
    }
    
    int allSales=0;     
    int cancelSales=0;  
    int realSales=0;    
 %>
   <div id="left" style="display: inline-block; width: 25%; position: relative; z-index: 4;">
      <p class="title">주문현황</p>
      <div class="beforeD">
         <button class="left_b" id="btn1" type="button">입금대기<span class="left_s"><br><%=dayNewCount[0] %></span></button>
         <button class="left_b" id="btn2" type="button">입금완료<span class="left_s"><br><%=dayNewCount[1] %></span></button>
         <button class="left_b" id="btn3" type="button">배송준비<span class="left_s"><br><%=dayNewCount[2] %></span></button>
      </div>
      <div class="afterD">
         <button class="left_b" id="btn4" type="button">배송중<span class="left_s"><br><%=dayNewCount[3] %></span></button>
         <button class="left_b" id="btn5" type="button">배송완료<span class="left_s"><br><%=dayNewCount[4] %></span></button>
         <button class="left_b" id="btn6" type="button">구매확정<span class="left_s" style="color: blue;"><br><%=dayNewCount[5] %></span></button>
      </div>
      <div class="cancle">
         <button class="left_b" id="btn10" type="button">취소요청<span class="left_s"><br><%=dayNewCount[6] %></span></button>
         <button class="left_b" id="btn20" type="button">교환요청<span class="left_s"><br><%=dayNewCount[7] %></span></button>
         <button class="left_b" id="btn30" type="button">환불요청<span class="left_s"><br><%=dayNewCount[8] %></span></button>
      </div>
      <p class="title">문의현황</p>
      <div class="cs">
         <button class="left_b" id="qna" type="button">상품 문의<span class="left_s"><br><%=dayNewCount[11] %>&nbsp;</span>/<span>&nbsp;<%=BoardDAO.getDAO().selectBoardCount(4) %></span></button>
         <button class="left_b" id="review" type="button">상품 후기<span class="left_s"><br><%=dayNewCount[10] %>&nbsp;</span>/<span>&nbsp;<%=BoardDAO.getDAO().selectBoardCount(3) %></span></button>
         <button class="left_b" id="free" type="button">자유게시판<span class="left_s"><br><%=dayNewCount[9] %>&nbsp;</span>/<span>&nbsp;<%=BoardDAO.getDAO().selectBoardCount(2) %></span></button>
      </div>
      <div class="cs">
         <button class="left_b" id="notice" type="button" style="width: 460px; height: 50px;">공지사항 관리</button>
      </div>
   </div>
   
   
   
<div id="right" style="display: inline-block; width: 70%;">

	<p class="title" style="position: relative; z-index: 2;">주요현황</p>

	<div id="Line_Controls_Chart" style="position: relative; z-index: 1;  margin-left: -90px; width: 900px; height: 900px; display: inline-block; " >
		<div id="lineChartArea" style="padding:0px 20px 0px 0px; "></div>
		<div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
	</div>
        
        
	<div class="tableSection" style="text-align: center; display: inline-block; z-index: 3; width: 500px; height: 900px;">
		<table class="section_t" style="width: 480px; margin: 0 auto; margin-top: 60px; margin-left: -20px;">
			<thead>
				<tr><th colspan="4">매출전표</th></tr>
				<tr>
                  <th>날짜</th><th>매출액</th><th>판매금액</th><th>환불금액</th>
				</tr>
			<thead>
            <tbody>
            	<%for(int i=6; i>=0; i--) { %> 
            		<% String day=days[i]; %>
            		<% allSales=0; %>
                    <% cancelSales=0; %>
                    <% realSales=0; %>
            	    <% for (int s=0; s<3;s++) { %>     
            	    	<% List<OrderDTO> salesOrder=OrderDAO.getDAO().salesAccount(day, day, s); %>
            	    	<% for (OrderDTO sales:salesOrder){ %>
            	    		<% if (s==0){ %>
            	    			<% realSales+=sales.getOrderTotal(); %>
            	    		<% } else if (s==1){ %>
            	    			<% cancelSales+=sales.getOrderTotal(); %>
            	    		<% } else if (s==2){ %>
            	    			<% allSales+=sales.getOrderTotal(); %>
            	    		<%} %>
            	    	<%} %>
            	    <%} %>
           	    	<tr>
           	    		<td style="font-weight: bold;"><%=day %></td><td><%=DecimalFormat.getCurrencyInstance().format(realSales) %></td><td><%=DecimalFormat.getCurrencyInstance().format(allSales) %></td><td><%=DecimalFormat.getCurrencyInstance().format(cancelSales) %></td>
           	    	</tr>
              <%} %>
            </tbody>
            <tfoot>
            	<%for(int i=0; i<2; i++) { %> 
            		<% String day=period[i]; %>
            		<% allSales=0; %>
                    <% cancelSales=0; %>
                    <% realSales=0; %>
            	    <% for (int s=0; s<3;s++) { %>     
            	    	<% List<OrderDTO> salesOrder=OrderDAO.getDAO().salesAccount(day, today, s); %>
            	    	<% for (OrderDTO sales:salesOrder){ %>
            	    		<% if (s==0){ %>
            	    			<% realSales+=sales.getOrderTotal(); %>
            	    		<% } else if (s==1){ %>
            	    			<% cancelSales+=sales.getOrderTotal(); %>
            	    		<% } else if (s==2){ %>
            	    			<% allSales+=sales.getOrderTotal(); %>
            	    		<%} %>
            	    	<%} %>
            	    <%} %>
           	    	<tr>
           	    		<td style="font-weight: bold;"><%if(i==0){ %>7일 총계<%} else { %>30일 총계<%} %></td><td style="font-weight: bold;"><%=DecimalFormat.getCurrencyInstance().format(realSales) %></td><td><%=DecimalFormat.getCurrencyInstance().format(allSales) %></td><td><%=DecimalFormat.getCurrencyInstance().format(cancelSales) %></td>
           	    	</tr>
              <%} %>
            </tfoot>
         </table>
      </div>

	
	
	
	</div>
   
   
<script type="text/javascript">


$("#btn1").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=1";
});
$("#btn2").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=2";
});
$("#btn3").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=3";
});
$("#btn4").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=4";
});
$("#btn5").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=5";
});
$("#btn6").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=6";
});
$("#btn10").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=10";
});
$("#btn20").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=20";
});
$("#btn30").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=order&work=list&orderStatus=30";
});
$("#free").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=1&pageSize=10&category=2";
});
$("#review").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=1&pageSize=10&category=3";
});
$("#qna").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=1&pageSize=10&category=4";
});
$("#notice").click(function() {
	location.href="<%=request.getContextPath()%>/admin_template/index.jsp?part=board&work=list&pageNum=1&pageSize=10&category=1";
});



var chartDrowFun = {
	    chartDrow : function(){
	        var chartData = '';
	        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
	        var chartDateformat     = 'yyyy-MM-dd';
	        //라인차트의 라인 수
	        var chartLineCount    = 10;
	        //컨트롤러 바 차트의 라인 수
	        var controlLineCount    = 10;
	 
	        function drawDashboard() {
	 
	          var data = new google.visualization.DataTable();
	          //그래프에 표시할 컬럼 추가
	          data.addColumn('datetime' , '날짜');
	          data.addColumn('number'   , '총계');
	          data.addColumn('number'   , '취소액');   
	          data.addColumn('number'   , '판매금액');     
	 
	          //그래프에 표시할 데이터
	          var dataRow = [];
	 		 
	 		  
	          <%for(int count=29; count>=0; count--) { %>
				var currentDate = new Date();   
	            currentDate.setDate(currentDate.getDate() - <%=count%>);
	            var year = currentDate.getFullYear(); // 년도
	            var month = currentDate.getMonth()+1;  // 월
	            var date = currentDate.getDate();  // 날짜
	            var day = currentDate.getDay();  // 요일
	        	var now=new Date(year, month-1, date , '10');
	            
	        	<% String j=days[count]; %>
	        	<% allSales=0; %>
	            <% cancelSales=0; %>
	            <% realSales=0; %>
	        	    <% for (int s=0; s<3; s++) { %>     
	        	    	<% List<OrderDTO> salesOrder=OrderDAO.getDAO().salesAccount(j, j, s); %>
	        	    	<% for (OrderDTO sales:salesOrder){ %>
	        	    		<% if (s==0){ %>
	        	    			<% realSales+=sales.getOrderTotal(); %>
	        	    		<% } else if (s==1){ %>
	        	    			<% cancelSales+=sales.getOrderTotal(); %>
	        	    		<% } else if (s==2){ %>
	        	    			<% allSales+=sales.getOrderTotal(); %>
	        	    		<%} %>
	        	    	<%} %>
	        	    <%} %>
	            var total=<%=allSales%>;
	            var income=<%=realSales%>;
	            var outcome=<%=cancelSales%>;
	        
	 
	            dataRow = [now, income, outcome , total];
	            data.addRow(dataRow);
	            <%} %>
	 
	 
	            var chart = new google.visualization.ChartWrapper({
	              chartType   : 'LineChart',
	              containerId : 'lineChartArea', //라인 차트 생성할 영역
	              options     : {
	                              isStacked   : 'percent',
	                              focusTarget : 'category',
	                              height          : 400,
	                              width              : '1100px',
	                              legend          : { position: "top", textStyle: {fontSize: 13}},
	                              pointSize        : 5,
	                              tooltip          : {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},
	                              hAxis              : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
	                                                                  years : {format: ['yyyy년']},
	                                                                  months: {format: ['MM월']},
	                                                                  days  : {format: ['dd일']},
	                                                                  hours : {format: ['HH시']}}
	                                                                },textStyle: {fontSize:12}},
	                vAxis              : {minValue: 100,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}},
	                animation        : {startup: true,duration: 1000,easing: 'in' },
	                annotations    : {pattern: chartDateformat,
	                                textStyle: {
	                                fontSize: 15,
	                                bold: true,
	                                italic: true,
	                                color: '#871b47',
	                                auraColor: '#d799ae',
	                                opacity: 0.8,
	                                pattern: chartDateformat
	                              }
	                            }
	              }
	            });
	 
	            var control = new google.visualization.ControlWrapper({
	              controlType: 'ChartRangeFilter',
	              containerId: 'controlsArea',  //control bar를 생성할 영역
	              options: {
	                  ui:{
	                        chartType: 'LineChart',
	                        chartOptions: {
	                        chartArea: {'width': '60%','height' : 80},
	                          hAxis: {'baselineColor': 'none', format: chartDateformat, textStyle: {fontSize:12},
	                            gridlines:{count:controlLineCount,units: {
	                                  years : {format: ['yyyy년']},
	                                  months: {format: ['MM월']},
	                                  days  : {format: ['dd일']},
	                                  hours : {format: ['HH시']}}
	                            }}
	                        }
	                  },
	                    filterColumnIndex: 0
	                }
	            });
	 
	            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
	            date_formatter.format(data, 0);
	 
	            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
	            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
	            dashboard.bind([control], [chart]);
	            dashboard.draw(data);
	 
	        }
	          google.charts.setOnLoadCallback(drawDashboard);
	 
	      }
	    }
	 
	$(document).ready(function(){
	  google.charts.load('current', {'packages':['line','controls']});
	  chartDrowFun.chartDrow(); //chartDrow() 실행
	});
</script>