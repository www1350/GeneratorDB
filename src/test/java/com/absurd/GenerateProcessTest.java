package com.absurd;

import com.absurd.generator.GenerateProcess;
import com.absurd.generator.config.Application;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;

/**
 * Created by wangwenwei on 16/11/20.
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class GenerateProcessTest {

    @Autowired
    private GenerateProcess generateProcess;
    @Test
    public void processTest() throws Exception {
        generateProcess.process();
    }
}
