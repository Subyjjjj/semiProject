<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<!-- 콘텐츠 시작 { -->
	<div id="container">
		<!--  -->
		<div id="wrapper_title">갤러리</div>

		<!-- 게시판 목록 시작 { -->
		<div id="bo_gall" style="width: 100%">



			<!-- 게시판 페이지 정보 및 버튼 시작 { -->
			<div id="bo_btn_top">
				<div id="bo_list_total">
					<span>Total 5건</span> 1 페이지
				</div>

			</div>
			<!-- } 게시판 페이지 정보 및 버튼 끝 -->

			<form name="fboardlist" id="fboardlist"
				action="./board_list_update.php"
				onsubmit="return fboardlist_submit(this);" method="post">
				<input type="hidden" name="bo_table" value="gallery"> <input
					type="hidden" name="sfl" value=""> <input type="hidden"
					name="stx" value=""> <input type="hidden" name="spt"
					value=""> <input type="hidden" name="sst"
					value="wr_num, wr_reply"> <input type="hidden" name="sod"
					value=""> <input type="hidden" name="page" value="1">
				<input type="hidden" name="sw" value="">


				<ul id="gall_ul" class="gall_row">
					<li class="gall_li col-gn-4">
						<div class="gall_box">
							<div class="gall_chk">
								<span class="sound_only"> 5 </span>
							</div>
							<div class="gall_con">
								<div class="gall_img">
									<a
										href="https://www.empery.kr/bbs/board.php?bo_table=gallery&amp;wr_id=12">
										<img
										src="https://www.empery.kr/data/file/gallery/thumb-2009788699_LKjHRFEX_b4ce2469601db59b5422aef312cffa75405fe7ed_283x283.jpg"
										alt="">
									</a>
								</div>
								<div class="gall_text_href">
									<a
										href="https://www.empery.kr/bbs/board.php?bo_table=gallery&amp;wr_id=12"
										class="bo_tit"> 'Denis Gastin'씨의 방문 <i class="fa fa-heart"
										aria-hidden="true"></i>
									</a>
								</div>
								<div class="gall_name">
									<span class="sound_only">작성자 </span><span class="profile_img"></span><span
										class="sv_member">최고관리자</span>
								</div>
								<div class="gall_info">
									<span class="sound_only">조회 </span><i class="fa fa-eye"
										aria-hidden="true"></i> 124 <span class="gall_date"><span
										class="sound_only">작성일 </span><i class="fa fa-clock-o"
										aria-hidden="true"></i> 02-21</span>
								</div>
							</div>
						</div>
					</li>
					<li class="gall_li col-gn-4">
						<div class="gall_box">
							<div class="gall_chk">
								<span class="sound_only"> 4 </span>
							</div>
							<div class="gall_con">
								<div class="gall_img">
									<a
										href="https://www.empery.kr/bbs/board.php?bo_table=gallery&amp;wr_id=11">
										<img
										src="https://www.empery.kr/data/file/gallery/thumb-1850085332_G8WqV3fw_9dd2d34a2fb261a2a85314a517fe8f6adbc5d03a_283x283.jpg"
										alt="">
									</a>
								</div>
								<div class="gall_text_href">
									<a
										href="https://www.empery.kr/bbs/board.php?bo_table=gallery&amp;wr_id=11"
										class="bo_tit"> 와인셀러 </a>
								</div>
								<div class="gall_name">
									<span class="sound_only">작성자 </span><span class="profile_img"></span><span
										class="sv_member">최고관리자</span>
								</div>
								<div class="gall_info">
									<span class="sound_only">조회 </span><i class="fa fa-eye"
										aria-hidden="true"></i> 89 <span class="gall_date"><span
										class="sound_only">작성일 </span><i class="fa fa-clock-o"
										aria-hidden="true"></i> 02-14</span>
								</div>
							</div>
						</div>
					</li>
					<li class="gall_li col-gn-4">
						<div class="gall_box">
							<div class="gall_chk">
								<span class="sound_only"> 3 </span>
							</div>
							<div class="gall_con">
								<div class="gall_img">
									<a
										href="https://www.empery.kr/bbs/board.php?bo_table=gallery&amp;wr_id=10">
										<img
										src="https://www.empery.kr/data/file/gallery/thumb-1850085332_CGZBtqrU_5c34ec3ba28a92c15d1bdd5f61d91ef7f8b6fcbc_283x283.jpg"
										alt="">
									</a>
								</div>
								<div class="gall_text_href">
									<a
										href="https://www.empery.kr/bbs/board.php?bo_table=gallery&amp;wr_id=10"
										class="bo_tit"> 숙성실 </a>
								</div>
								<div class="gall_name">
									<span class="sound_only">작성자 </span><span class="profile_img"></span><span
										class="sv_member">최고관리자</span>
								</div>
								<div class="gall_info">
									<span class="sound_only">조회 </span><i class="fa fa-eye"
										aria-hidden="true"></i> 91 <span class="gall_date"><span
										class="sound_only">작성일 </span><i class="fa fa-clock-o"
										aria-hidden="true"></i> 02-14</span>
								</div>
							</div>
						</div>
					</li>
					<li class="gall_li col-gn-4">
						<div class="gall_box">
							<div class="gall_chk">
								<span class="sound_only"> 2 </span>
							</div>
							<div class="gall_con">
								<div class="gall_img">
									<a
										href="https://www.empery.kr/bbs/board.php?bo_table=gallery&amp;wr_id=6">
										<img
										src="https://www.empery.kr/data/file/gallery/thumb-2949232220_8EBb6Ync_cfb0cfefb05bad80ee4abee920580294cd80c9c5_283x283.jpg"
										alt="">
									</a>
								</div>
								<div class="gall_text_href">
									<a
										href="https://www.empery.kr/bbs/board.php?bo_table=gallery&amp;wr_id=6"
										class="bo_tit"> 공장 정문 </a>
								</div>
								<div class="gall_name">
									<span class="sound_only">작성자 </span><span class="profile_img"></span><span
										class="sv_member">최고관리자</span>
								</div>
								<div class="gall_info">
									<span class="sound_only">조회 </span><i class="fa fa-eye"
										aria-hidden="true"></i> 96 <span class="gall_date"><span
										class="sound_only">작성일 </span><i class="fa fa-clock-o"
										aria-hidden="true"></i> 01-10</span>
								</div>
							</div>
						</div>
					</li>
					<li class="gall_li col-gn-4 box_clear">
						<div class="gall_box">
							<div class="gall_chk">
								<span class="sound_only"> 1 </span>
							</div>
							<div class="gall_con">
								<div class="gall_img">
									<a
										href="https://www.empery.kr/bbs/board.php?bo_table=gallery&amp;wr_id=5">
										<img
										src="https://www.empery.kr/data/file/gallery/thumb-2949232220_7w93rSfZ_7e7ea3633f4ce1663e396084205768ae0266d1c0_283x283.jpg"
										alt="">
									</a>
								</div>
								<div class="gall_text_href">
									<a
										href="https://www.empery.kr/bbs/board.php?bo_table=gallery&amp;wr_id=5"
										class="bo_tit"> 겨울 머루 밭 <i class="fa fa-heart"
										aria-hidden="true"></i>
									</a>
								</div>
								<div class="gall_name">
									<span class="sound_only">작성자 </span><span class="profile_img"></span><span
										class="sv_member">최고관리자</span>
								</div>
								<div class="gall_info">
									<span class="sound_only">조회 </span><i class="fa fa-eye"
										aria-hidden="true"></i> 103 <span class="gall_date"><span
										class="sound_only">작성일 </span><i class="fa fa-clock-o"
										aria-hidden="true"></i> 01-10</span>
								</div>
							</div>
						</div>
					</li>
				</ul>

			</form>

			<!-- 게시판 검색 시작 { -->
			<fieldset id="bo_sch">
				<legend>게시물 검색</legend>

				<form name="fsearch" method="get">
					<input type="hidden" name="bo_table" value="gallery"> 
					<input type="hidden" name="sca" value="">
					<input type="hidden" name="sop" value="and">
					<label for="sfl" class="sound_only">검색대상</label>
					<select name="sfl" id="sfl">
						<option value="wr_subject||wr_content">제목+내용</option>
						<option value="mb_id,1">회원아이디</option>
						<option value="wr_name,1">글쓴이</option>
					</select> <label for="stx" class="sound_only">검색어<strong class="sound_only"> 필수</strong></label>
					<input type="text" name="stx" value="" required id="stx" class="sch_input" size="25" maxlength="20" placeholder="검색어를 입력해주세요">
					<input type="submit" value="검색" class="sch_btn">
				</form>
			</fieldset>
			<!-- } 게시판 검색 끝 -->
		</div>




		<!-- 페이지 -->
		<!-- } 게시판 목록 끝 -->

	</div>
	<!-- } 콘텐츠 끝 -->