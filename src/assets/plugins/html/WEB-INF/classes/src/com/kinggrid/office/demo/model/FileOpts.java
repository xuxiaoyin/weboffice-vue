package com.kinggrid.office.demo.model;

public class FileOpts {

	/** 文件名 **/
	private String fileName;

	/** 文件id */
	private String baseid;

	/** 扩展字段 */
	private String opt;

	/** 文件后缀 **/
	private String ext;

	public FileOpts(String fileName, String ext) {
		this.fileName = fileName;
		this.ext = ext;
	}

	public FileOpts(String fileName, String ext, String baseid) {
		this.fileName = fileName;
		this.ext = ext;
		this.baseid = baseid;
	}

	public FileOpts(String fileName) {
		this.fileName = fileName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOpt() {
		return opt;
	}

	public void setOpt(String opt) {
		this.opt = opt;
	}

	public String getExt() {
		return ext;
	}

	public void setExt(String ext) {
		this.ext = ext;
	}

	public String getBaseid() {
		return baseid;
	}

	public void setBaseid(String baseid) {
		this.baseid = baseid;
	}

}
