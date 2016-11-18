package com.absurd;

import com.absurd.generator.util.StringUtils;
import org.junit.Assert;
import org.junit.Test;

/**
 * Created by wangwenwei on 16/11/19.
 */
public class StringUtilsTest {
    @Test
    public void converTest()throws Exception{
        String str = "T_ADM_MODULES";

        Assert.assertEquals(StringUtils.toLowerCase(str),"admModules");
        Assert.assertEquals(StringUtils.toClassCase(str),"AdmModules");
    }
}
