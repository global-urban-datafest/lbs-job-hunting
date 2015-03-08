package co.working.util;

import org.apache.commons.codec.binary.Base64;
import org.apache.logging.log4j.core.helpers.Assert;
import org.springframework.stereotype.Component;

import javax.crypto.KeyGenerator;
import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.math.BigInteger;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * desciption 加密工具类
 */
@Component("encryptUtil")
public class EncryptUtil {
    /*
    * @author tonyli
    * @param password
    * desciption 密码加密方法
    * */
    public String Encrypt(String pass) throws NoSuchAlgorithmException {
        Assert.isNotNull(pass, "pass can not be null here");
        return new BigInteger(encryptMD5(pass.getBytes())).toString(32);
    }

    public static final String KEY_SHA = "SHA";
    public static final String KEY_MD5 = "MD5";
    public static final String KEY_MAC = "HmacMD5";


// sun不推荐使用它们自己的base64,用apache的挺好

    /**
     * BASE64解密
     */
    public static byte[] decryptBASE64(byte[] dest) {
        if (dest == null) {
            return null;
        }
        return Base64.decodeBase64(dest);
    }

    /**
     * BASE64加密
     */
    public static byte[] encryptBASE64(byte[] origin) {
        if (origin == null) {
            return null;
        }
        return Base64.encodeBase64(origin);
    }

    /**
     * MD5加密
     *
     * @throws java.security.NoSuchAlgorithmException
     */
    public static byte[] encryptMD5(byte[] data)
            throws NoSuchAlgorithmException {
        if (data == null) {
            return null;
        }
        MessageDigest md5 = MessageDigest.getInstance(KEY_MD5);
        md5.update(data);
        return new Base64().encode(md5.digest());
    }

    /**
     * SHA加密
     *
     * @throws java.security.NoSuchAlgorithmException
     */
    public static byte[] encryptSHA(byte[] data)
            throws NoSuchAlgorithmException {
        if (data == null) {
            return null;
        }
        MessageDigest sha = MessageDigest.getInstance(KEY_SHA);
        sha.update(data);
        return sha.digest();
    }

    /**
     * 初始化HMAC密钥
     *
     * @throws java.security.NoSuchAlgorithmException
     */
    public static String initMacKey() throws NoSuchAlgorithmException {
        KeyGenerator keyGenerator = KeyGenerator.getInstance(KEY_MAC);
        SecretKey secretKey = keyGenerator.generateKey();
        return new String(encryptBASE64(secretKey.getEncoded()));
    }

    /**
     * HMAC加密
     *
     * @throws java.security.NoSuchAlgorithmException
     * @throws java.security.InvalidKeyException
     */
    public static byte[] encryptHMAC(byte[] data, String key)
            throws NoSuchAlgorithmException, InvalidKeyException {
        SecretKey secretKey = new SecretKeySpec(decryptBASE64(key.getBytes()),
                KEY_MAC);
        Mac mac = Mac.getInstance(secretKey.getAlgorithm());
        mac.init(secretKey);
        return mac.doFinal(data);

    }

    public static void main(String[] args) throws Exception {
        System.out.print(new EncryptUtil().Encrypt(null));
    }

}
