package com.kinggrid.office.demo.utils;

import java.io.UnsupportedEncodingException;
import java.util.Date;

import org.apache.commons.codec.binary.Base64;

/**
 * base64编码解码工具
 * 
 * @author meisc
 *
 */
public class Base64Util {

	/**
	 * 编码
	 * 
	 * @param str
	 * @return
	 */
	public static String encode(String str) {
		try {
			byte[] textByte = str.getBytes("UTF-8");
			// 编码
			String encodedText =Base64.encodeBase64URLSafeString(textByte);
			return encodedText;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 解码
	 * 
	 * @param str
	 * @return
	 */
	public static String deco(String str) {
		try {
			String r = new String(Base64.decodeBase64(str), "UTF-8");
			return r;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String[] args) throws UnsupportedEncodingException {
		String text = "C:\\Users\\meisc\\Desktop\\10iAppOffice手写批注.doc";
		long s=new Date().getTime();
		String en=Base64Util.encode(text);
		System.out.println(en);
		System.out.println(Base64Util.deco(en));
		long e=new Date().getTime();
		System.out.println(e-s);
	}

}
