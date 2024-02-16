package kr.co.jhta.restaurants_service.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Getter
@Setter
@NoArgsConstructor
@Slf4j
public class Pagination {

	private int rows = 10;
	private int pages = 5;
	private int page;
	private int totalRows;
	private int totalPages;
	private int totalBlocks;
	private int currentBlock;
	private int beginPage;
	private int endPage;
	private boolean isFirst;
	private boolean isLast;
	private int prePage;
	private int nextPage;
	private int begin;
	private int end;
	
	public Pagination(int page, int totalRows) {
		this.page = page;
		this.totalRows = totalRows;
		
		init();
	}
	
	public Pagination(int rows,int page, int totalRows) {
		this.page = page;
		this.rows = rows;
		this.totalRows = totalRows;
		
		init();
	}
	
	private void init() {
		totalPages = (int) Math.ceil((double) totalRows/rows);
		if(totalRows==0) {
			totalPages++;
		}
		totalBlocks = (int) Math.ceil((double) totalPages/pages);
		currentBlock = (int) Math.ceil((double) page/pages);
		beginPage = (currentBlock - 1)*pages + 1;
		endPage = currentBlock*pages;
		
		log.info("totalRows, rows: '{}', '{}'",totalRows,rows);

		
		if (currentBlock >= totalBlocks) {
			endPage = totalPages;
		}
		isFirst = page == 1;
		isLast = page == totalPages;
		prePage = page - 1;
		nextPage = page + 1;
		begin = (page - 1)*rows + 1;
		end = page*rows;
		
		log.info("currentBlock, totalBlocks, page : '{}', '{}','{}'",currentBlock,totalBlocks,page);
		log.info("beginPage, endPage, totalPages : '{}', '{}', '{}'",beginPage,endPage,totalPages);
	}
}
