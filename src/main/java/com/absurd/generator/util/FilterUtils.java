package com.absurd.generator.util;

import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * Created by wangwenwei on 16/11/19.
 */
public class FilterUtils {
    public static List<Map<String, Object>> filterTableName(List<Map<String, Object>> tableNames, String pre){
        Pattern p=Pattern.compile("^"+pre+"([\\w\\W\\s]*?)");
        return   tableNames.stream()
             .filter(e->
                    p.matcher ((String) e.get("TABLE_NAME")).find()
        ).collect(Collectors.toList());

    }

}
