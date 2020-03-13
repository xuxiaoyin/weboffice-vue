package DBstep;

import java.io.*;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

public class iFileUpLoad2000
{
  public iFileUpLoad2000(HttpServletRequest request)
  {
      int totalRead = 0;
      int readBytes = 0;
      int mSingCur = 0;
      try
      {
          FBufLen = request.getContentLength();
          FBuffer = new byte[FBufLen];
          for(; totalRead < FBufLen; totalRead += readBytes)
          {
              request.getInputStream();
              readBytes = request.getInputStream().read(FBuffer, totalRead, FBufLen - totalRead);
          }

      }
      catch(Exception e)
      {
          System.out.println(e.toString());
      }
      for(FSingLen = 0; FBuffer[FSingLen] != 13; FSingLen = FSingLen + 1);
      FSingBuf = new byte[FSingLen];
      for(mSingCur = 0; mSingCur < FSingLen; mSingCur++)
          FSingBuf[mSingCur] = FBuffer[mSingCur];

      FFilePath = "";
      FFileName = "";
      FCopyright = "[\u6570\u636E\u9A7F\u7AD9\uFF0C\u7248\u6743\u6240\u6709]";
  }

  public int FindSing(int Start)
  {
      int result = -1;
      int s = Start;
      do
      {
          if(s >= FBufLen - FSingLen)
          {
              result = -1;
              break;
          }
          int DjfOk = 1;
          int i = 0;
          do
          {
              if(i >= FSingLen)
                  break;
              if(FSingBuf[i] != FBuffer[s + i])
              {
                  DjfOk = 0;
                  break;
              }
              i++;
          } while(true);
          if(DjfOk == 1)
          {
              result = s;
              break;
          }
          s++;
      } while(true);
      return result;
  }

  public int FindItem(String TagName)
  {
      int result;
label0:
      {
          result = -1;
          int s = 0;
          do
          {
              s = FindSing(s);
              if(s == -1)
                  break;
              s = s + FSingLen + 40;
              int e = s;
              if(e + 1 >= FBufLen)
              {
                  result = -1;
                  break label0;
              }
              for(; FBuffer[e + 1] != 34; e++);
              String strName = new String(FBuffer, s, (e - s) + 1);
              if(TagName.equalsIgnoreCase(strName))
              {
                  result = e + 1;
                  break label0;
              }
          } while(true);
          result = -1;
      }
      return result;
  }

  public String ItemValue(String TagName)
  {
      String strTmp = "";
      String result = "";
      int s = FindItem(TagName);
      if(s == -1)
          return result;
      int e;
      if(FBuffer[s + 1] == 59)
      {
          s += 13;
          for(e = s; FBuffer[e + 1] != 34; e++);
      } else
      {
          s += 5;
          e = FindSing(s) - 3;
      }
      if(e - s < 0)
      {
          return result;
      } else
      {
          strTmp = new String(FBuffer, s, (e - s) + 1);
          result = strTmp;
          return result;
      }
  }

  public String ExtName(String TagName)
  {
      String mFileName = "";
      String mExtName = "";
      mExtName = "";
      mFileName = ItemValue(TagName);
      if(mFileName != "")
          mExtName = mFileName.substring(mFileName.lastIndexOf("."));
      return mExtName;
  }

  public byte[] FileBody(String TagName)
  {
      byte mBody[] = null;
      int s = FindItem(TagName);
      if(s == -1)
          return mBody;
      s += 13;
      int i;
      for(i = s; FBuffer[i] != 34; i++);
      int e = i - 1;
      if(e - s < 0)
          return mBody;
      i = e;
      do
      {
          if(FBuffer[i - 4] == 13 && FBuffer[i - 3] == 10 && FBuffer[i - 2] == 13 && FBuffer[i - 1] == 10)
          {
              s = i;
              break;
          }
          i++;
      } while(true);
      e = FindSing(s) - 3;
      if(e - s >= 0)
      {
          mBody = new byte[(e - s) + 1];
          int j = 0;
          for(i = s; i <= e; i++)
          {
              mBody[j] = FBuffer[i];
              j++;
          }

      }
      return mBody;
  }

  public String FileName(String TagName)
  {
      String result = "";
      int s = FindItem(TagName);
      if(s == -1)
          return result;
      s += 13;
      int i;
      for(i = s; FBuffer[i] != 34; i++);
      int e = i - 1;
      if(e - s < 0)
          return result;
      i = e;
      do
      {
          if(i < s)
              break;
          if((char)FBuffer[i - 1] == '\\')
          {
              s = i;
              break;
          }
          i--;
      } while(true);
      result = new String(FBuffer, s, (e - s) + 1);
      return result;
  }

  public int FileSize(String TagName)
  {
      int result = 0;
      int s = FindItem(TagName);
      if(s == -1)
          return result;
      s += 13;
      int i;
      for(i = s; FBuffer[i] != 34; i++);
      int e = i - 1;
      if(e - s < 0)
          return result;
      i = e;
      do
      {
          if(FBuffer[i - 4] == 13 && FBuffer[i - 3] == 10 && FBuffer[i - 2] == 13 && FBuffer[i - 1] == 10)
          {
              s = i;
              break;
          }
          i++;
      } while(true);
      e = FindSing(s) - 3;
      result = (e - s) + 1;
      return result;
  }

  public String CopyRight()
  {
      return FCopyright;
  }

  public String getFilePath()
  {
      return FFilePath;
  }

  public String Request(String TagName)
  {
      return ItemValue(TagName);
  }

  public boolean SaveAll(String FileName)
  {
      boolean result = false;
      try
      {
          FileOutputStream mFile = new FileOutputStream(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(FFilePath)))).append('\\').append(FileName))));
          for(int i = 0; i < FBufLen; i++)
              mFile.write(FBuffer[i]);

          mFile.close();
          result = true;
      }
      catch(Exception ex)
      {
          System.out.println(ex.toString());
          result = false;
      }
      return result;
  }

  public boolean SaveFile(String TagName, String FileName)
  {
      String mFileName = "";
      boolean result = false;
      mFileName = FileName;
      int s = FindItem(TagName);
      if(s == -1)
      {
          result = false;
          return result;
      }
      s += 13;
      int i;
      for(i = s; FBuffer[i] != 34; i++);
      int e = i - 1;
      if(e - s < 0)
      {
          result = false;
          return result;
      }
      i = e;
      do
      {
          if(i < s)
              break;
          if((char)FBuffer[i - 1] == '\\')
          {
              s = i;
              break;
          }
          i--;
      } while(true);
      FFileName = new String(FBuffer, s, (e - s) + 1);
      if(mFileName.trim() != "")
          FFileName = mFileName;
      i = e;
      do
      {
          if(FBuffer[i - 4] == 13 && FBuffer[i - 3] == 10 && FBuffer[i - 2] == 13 && FBuffer[i - 1] == 10)
          {
              s = i;
              break;
          }
          i++;
      } while(true);
      e = FindSing(s) - 3;
      try
      {
          FileOutputStream mFile = new FileOutputStream(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(FFilePath)))).append('\\').append(FFileName))));
          if(mFile != null)
          {
              if(e - s >= 0)
              {
                  for(i = s; i <= e; i++)
                      mFile.write(FBuffer[i]);

                  result = true;
              }
          } else
          {
              result = false;
          }
          mFile.close();
      }
      catch(Exception ex)
      {
          System.out.println(ex.toString());
          result = false;
      }
      return result;
  }

  public boolean setFilePath(String Value)
  {
      FFilePath = Value;
      File mFile = new File(FFilePath);
      mFile.mkdirs();
      return mFile.isDirectory();
  }

  public String FFilePath;
  public String FFileName;
  public byte FBuffer[];
  public int FBufLen;
  public int FBinLen;
  public byte FSingBuf[];
  public int FSingLen;
  public String FCopyright;
}