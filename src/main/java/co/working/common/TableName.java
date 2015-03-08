package co.working.common;
/*
 *定义基础Reference的表名
 * */
public enum TableName {
		SEX("Sex"),
		JOBSTATUS("JobStatus"),
		POLITICTYPE("PoliticType"),
		DOCUMENTTYPE("DocumentType"),
		CURRENTSALERY("CurrentSalery"),
		COMPANYSIZE("CompanySize"),
		COMPANYTYPE("CompanyType"),
		INDUSTRYTYPE("IndustryType"),
		LANGUAGE("Language"),
		WORKYEAR("WorkYear"),
		MARRIAGESTATUS("MarriageStatus"),
		WORKTYPE("WorkType"),
		POSITIONTYPE("PositionType");
		private String name;
		private  TableName(String name){
				this.setName(name);
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}

}
