package net.kbssm.koloud.HomeDeco;

public class Home {

	public int visitCnt; 	//방문 카운트, 로그인 한 횟수로 카운트
	public int serverCnt; 	//서버 카운트, 생성 및 요청 들어왔을 때 카운트
	public int pageCnt; 		//도메인 카운트, 페이지 방문 횟수 카운트... 메뉴 탭마다 있어야 함.
	public int resourceCnt;	//리소스 카운트, 리소스 변경 및 요청 카운트

	public Home() {
	}
	
	public Home(int visitCnt, int serverCnt, int pageCnt, int resourceCnt) {
		super();
		this.visitCnt = visitCnt;
		this.serverCnt = serverCnt;
		this.pageCnt = pageCnt;
		this.resourceCnt = resourceCnt;
	}

	public int getVisitCnt() {
		return visitCnt;
	}

	public void setVisitCnt(int visitCnt) {
		this.visitCnt = visitCnt;
	}

	public int getServerCnt() {
		return serverCnt;
	}

	public void setServerCnt(int serverCnt) {
		this.serverCnt = serverCnt;
	}

	public int getPageCnt() {
		return pageCnt;
	}

	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}

	public int getResourceCnt() {
		return resourceCnt;
	}

	public void setResourceCnt(int resourceCnt) {
		this.resourceCnt = resourceCnt;
	}
	
	
	
}
