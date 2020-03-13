package DBstep;

import java.io.File;  
import java.io.FileInputStream;  
import java.io.IOException;  
import java.io.InputStream;  
import java.security.MessageDigest;  
import java.security.NoSuchAlgorithmException;  
  
/** 
 * �ṩһϵ�л�ȡ��У��MD5�ķ��� 
 * 
 */  
public class MD5Util {  
  
    /** 
     * ��ȡ����������MD5ֵ 
     *  
     * @param is 
     * @return 
     * @throws NoSuchAlgorithmException 
     * @throws IOException 
     */  
    public static String getMD5(InputStream is) throws NoSuchAlgorithmException, IOException {  
        StringBuffer md5 = new StringBuffer();  
        MessageDigest md = MessageDigest.getInstance("MD5");  
        byte[] dataBytes = new byte[1024];  
          
        int nread = 0;   
        while ((nread = is.read(dataBytes)) != -1) {  
            md.update(dataBytes, 0, nread);  
        };  
        byte[] mdbytes = md.digest();  
          
        // convert the byte to hex format  
        for (int i = 0; i < mdbytes.length; i++) {  
            md5.append(Integer.toString((mdbytes[i] & 0xff) + 0x100, 16).substring(1));  
        }  
        return md5.toString();  
    }  
    //��FileBody���MD5
    public static String getBodyMD5(byte[] dataBytes) throws NoSuchAlgorithmException, IOException {  
        StringBuffer md5 = new StringBuffer();  
        MessageDigest md = MessageDigest.getInstance("MD5");  
        int nlength=dataBytes.length;
        md.update(dataBytes, 0, nlength);
        
//        byte[] dataBytes = new byte[1024];  
          
//        int nread = 0;   
//        while ((nread = is.read(dataBytes)) != -1) {  
//            md.update(dataBytes, 0, nread);  
//        };
        
        byte[] mdbytes = md.digest();  
          
        // convert the byte to hex format  
        for (int i = 0; i < mdbytes.length; i++) {  
            md5.append(Integer.toString((mdbytes[i] & 0xff) + 0x100, 16).substring(1));  
        }  
        return md5.toString();  
    }
    
    /** 
     * ��ȡ���ļ���MD5ֵ 
     *  
     * @param file 
     * @return 
     * @throws NoSuchAlgorithmException 
     * @throws IOException 
     */  
    public static String getMD5(File file) throws NoSuchAlgorithmException, IOException {  
        FileInputStream fis = new FileInputStream(file);  
        return getMD5(fis);  
    }  
      
    /** 
     * ��ȡָ��·���ļ���MD5ֵ 
     *  
     * @param path 
     * @return 
     * @throws NoSuchAlgorithmException 
     * @throws IOException 
     */  
    public static String getMD5(String path) throws NoSuchAlgorithmException, IOException {  
        FileInputStream fis = new FileInputStream(path);  
        return getMD5(fis);  
    }  
  
    /** 
     * У�����������MD5ֵ 
     *  
     * @param is 
     * @param toBeCheckSum 
     * @return 
     * @throws NoSuchAlgorithmException 
     * @throws IOException 
     */  
    public static boolean md5CheckSum(InputStream is, String toBeCheckSum) throws NoSuchAlgorithmException, IOException {  
        return getMD5(is).equals(toBeCheckSum);  
    }  
      
    /** 
     * У����ļ���MD5ֵ 
     *  
     * @param file 
     * @param toBeCheckSum 
     * @return 
     * @throws NoSuchAlgorithmException 
     * @throws IOException 
     */  
    public static boolean md5CheckSum(File file, String toBeCheckSum) throws NoSuchAlgorithmException, IOException {  
        return getMD5(file).equals(toBeCheckSum);  
    }  
      
    /** 
     * У��ָ��·���ļ���MD5ֵ 
     *  
     * @param path 
     * @param toBeCheckSum 
     * @return 
     * @throws NoSuchAlgorithmException 
     * @throws IOException 
     */  
    public static boolean md5CheckSum(String path, String toBeCheckSum) throws NoSuchAlgorithmException, IOException {  
        return getMD5(path).equals(toBeCheckSum);  
    }  
      
    /* MD5 TEST 
    public static void main(String[] args) { 
        try { 
            System.out.println(getMD5("D:/work/BJ/ESB_CSS_CSS_ImportCustCompFormRejectInfoSrv.xml")); 
        } catch (NoSuchAlgorithmException e) { 
            e.printStackTrace(); 
        } catch (IOException e) { 
            e.printStackTrace(); 
        } 
    } 
    */  
}  