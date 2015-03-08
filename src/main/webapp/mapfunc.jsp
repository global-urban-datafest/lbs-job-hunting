<%@ page language="java" pageEncoding="UTF-8" %>
<script type="text/javascript">
    jQuery.ajaxSetup({ scriptCharset: "utf-8", contentType: "application/json; charset=utf-8" });
    var pageNo = 1;
    var pageSize = 10;
    var initSearch = true;
    var arrayMark = new Array();
    var arrayWin = new Array();
    var map;
    $(document).ready(function () {
        map = new BMap.Map("hotmap");
        //map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);
        map.addControl(new BMap.NavigationControl());
        map.addControl(new BMap.ScaleControl());

        map.centerAndZoom(new BMap.Point(120.2 ,30.3),13);

        window.map = map;
        map.enableDragging();
        map.enableScrollWheelZoom();
        map.enableDoubleClickZoom();
        map.enableKeyboard();
        map.addEventListener("dragend", function (e) {
            initSearch = true;
            selfDataCount = 0;
            selfPageNum = 0;
            baiduDataCount = 0;
            initDataMap(1);
        });
        initDataMap(1);

        //左边菜单切换
        $(".hotmapl .menu").each(function (index, element) {
            $(this).click(function () {
                var data = $(this).attr("data");
                var value = $("#" + data + "Check").val();
                map.clearOverlays();
                if (typeof currentWindow != "undefined") {
                    currentWindow.close();
                }
                if (value == 0) {
                    $("#" + data + "Check").attr("value", 1);
                    $(this).addClass('active');
                } else {
                    $("#" + data + "Check").attr("value", 0);
                    if ($(this).hasClass('active')) {
                        $(this).removeClass('active');
                    }
                }
                baiduDataCount = 0;
                selfDataCount = 0;
                selfPageNum = 0;
                initSearch = true;
                currentIndex = 0;
                currentPageNo = 0;
                keyword = [];
                //initDataMap(1);
            });
        });
    });
    var ls = null;
    var firstPage = true;
    var initSearch = true;
    var keyword = [];
    var keyWordResultNum = [];
    var baiduDataCount = 0;
    var selfDataCount = 0;
    var selfPageNum = 0;
    var badNum = 0;
    function initDataMap(pn) {
        if (pn < pageNo) {
            var totalResultCount = pn * pageSize; //
            if (totalResultCount <= selfDataCount) {
                currentPageNo = 1;
                currentIndex = 0;
            }
            else {
                var sub = totalResultCount - selfDataCount;
                var tempIndex = 0;
                for (var i = 1; i <= currentPageNo; i++) {
                    var pageResultCount = 0;
                    var cNum = pageSize * i;
                    for (var j = 0; j < keyWordResultNum.length; j++) {
                        var size = 0;
                        if (keyWordResultNum[j] - cNum > 0) {
                            size = pageSize;
                        }
                        else {
                            if (keyWordResultNum[j] + pageSize - cNum > 0) {
                                size = keyWordResultNum[j] + pageSize - cNum;
                            }
                        }

                        if (sub <= size) {
                            tempIndex += sub;
                        }
                        else {
                            tempIndex += size;
                        }
                        sub -= size;
                        if (sub <= 0) {
                            currentPageNo = i;
                            currentIndex = tempIndex;
                        }

                    }
                }
            }
            pageNo = pn;
        }
        pageNo = pn;
        var bound = map.getBounds();            //获取可视区域
        var southWest = bound.getSouthWest();   //可视区域左下角
        var northEast = bound.getNorthEast();   //可视区域右上角
        //清空选项数据

        $("#hotmapRightBar").html("");
        var userCheck = $("#userCheck").val();
        var compCheck = $("#compCheck").val();

        for (var i = 0; i < arrayMark.length; i++) {
            map.removeControl(arrayMark[i]);
            arrayWin[i].close();
        }
        arrayMark.splice(0, arrayMark.length);
        arrayWin.splice(0, arrayWin.length);

        if (initSearch || selfPageNum >= pn) {
//            if (userCheck == "1" || compCheck == "1") {
//                $.ajax({
//                    url: 'http://web.wzta.gov.cn/api/place/list.jspx?leftBottomLng=' + southWest.lng + '&leftBottomLat=' + southWest.lat + '&topRightLng=' + northEast.lng + '&topRightLat=' + northEast.lat + '&jingdianCheck=' + jingdianCheck + '&jiudianCheck=' + jiudianCheck + '&pageNo=' + pn + '&jsoncallback=?',
//                    dataType: 'jsonp',
//                    success: function (sd) {
//                        if (typeof currentmarker != "undefined") {
//                            map.addOverlay(currentmarker);
//                            // currentWindow.open(currentmarker);
//                        }
//                        if (sd.status == 0) {
//                            var results = sd.results;
//                            selfPageNum = parseInt((sd.pager.totalCount + pageSize - 1) / pageSize);
//                            selfDataCount = sd.pager.totalCount;
//                            if (selfPageNum > pn || (meishiCheck != "1" && jiaotongCheck != "1" && xiuxianyuleCheck != "1" && shenghuofuwuCheck != "1")) {
//                                RenderResult(results, pageNo, selfPageNum);
//                            }
//                            else {
//                                SearchBaiduData(results);
//                            }
//                        }
//                    }
//                });
//            }
            var sd = ({
                "status":0,
                "message":"ok",
                "pager" : {
                    "totalCount": 387,
                    "pageSize": 26,
                    "pageNo": 1 ,
                    "totalPage": 15
                },
                "results":[

                    {
                        "name":"杭州黄龙饭店有限公司 ",
                        "label":"A",
                        "logo":"http://web.wzta.gov.cn/u/cms/www/201501/191500308ci0_w.jpg",
                        "category":1,
                        "location":{
                            "lat":30.272851,
                            "lng":120.149285
                        },
                        "address":"杭州市西湖区曙光路120号（杭大路口）",
                        "street_id":"杭州市西湖区曙光路120号（杭大路口）",
                        "telephone":"0577—88381585",
                        "uid":"101177",
                        "star":"",
                        "audio":"",
                        "detailUrl":"/jingqu/101177.htm"
                    }
                    ,
                    {
                        "name":"杭州九洲大药房连锁有限公司",
                        "label":"B",
                        "logo":"http://web.wzta.gov.cn/u/cms/www/201501/20100550heme_w.jpg",
                        "category":2,
                        "location":{
                            "lat":30.320926,
                            "lng":120.265849
                        },
                        "address":"杭州市九州路19-12",
                        "street_id":"杭州市九州路19-12",
                        "telephone":"",
                        "uid":"101283",
                        "star":"",
                        "audio":"",
                        "detailUrl":"/jiudian/101283.htm"
                    }
                    ,
                    {
                        "name":"天津天越国际影城",
                        "label":"C",
                        "logo":"http://web.wzta.gov.cn/u/cms/www/201501/17144952m9c2_w.jpg",
                        "category":1,
                        "location":{
                            "lat":39.126486,
                            "lng":117.202568
                        },
                        "address":"天津市和平区滨江道300号858欧乐时尚广场6－7层(乐宾百货北侧)",
                        "street_id":"天津市和平区滨江道300号858欧乐时尚广场6－7层(乐宾百货北侧)",
                        "telephone":" 0577—88517668",
                        "uid":"101156",
                        "star":"",
                        "audio":"",
                        "detailUrl":"/jingqu/101156.htm"
                    }
                    ,
                    {
                        "name":"沃尔玛浙江百货有限公司",
                        "label":"D",
                        "logo":"",
                        "category":2,
                        "location":{
                            "lat":30.313733,
                            "lng":120.185272
                        },
                        "address":"杭州香积寺东路58号天驰大厦沃尔玛购物中心/余杭临平沃尔玛",
                        "street_id":"杭州香积寺东路58号天驰大厦沃尔玛购物中心/余杭临平沃尔玛",
                        "telephone":"",
                        "uid":"108b1cea3326b6d13586f40d",
                        "star":"",
                        "audio":"",
                        "detailUrl":""
                    }
                        ,
                    {
                        "name":"友融投资管理(上海)有限公司杭州分公司",
                        "label":"D",
                        "logo":"",
                        "category":2,
                        "location":{
                            "lat":30.276235,
                            "lng":120.107667
                        },
                        "address":"杭州市西湖区古墩路83号浙商财富中心4号楼西门11楼",
                        "street_id":"杭州市西湖区古墩路83号浙商财富中心4号楼西门11楼",
                        "telephone":"",
                        "uid":"108b1cea3326b6d13586f40d",
                        "star":"",
                        "audio":"",
                        "detailUrl":""
                    }
                ]
            });
            var results = sd.results;
            var selfPageNum = parseInt((sd.pager.totalCount + pageSize - 1) / pageSize);
            var selfDataCount = sd.pager.totalCount;
            if (selfPageNum > pn) {
                RenderResult(results, pageNo, selfPageNum);
            }

        }
    }
    var currentPageNo = 1;
    var currentIndex = 0;
    var currentData = [];

    function RenderResult(results, pageNo, totalPage) {
        var rightBar = "<ul>";
        var num = 0;
        var continueNum = 0;
        for (i in results) {
            if (results[i].label != null && results[i].label != "") {
                rightBar += "<li><a href='javascript:void(0)' onClick='clickRightItem(" + num + ")'>" + results[i].label + "." + results[i].name + "</a></li>";
                num++;
            }
        }
        rightBar += "</ul>";

        var prevFun = "initDataMap(" + (pageNo - 1) + ")";
        var nextFun = "initDataMap(" + (pageNo + 1) + ")";
        if (totalPage > 1) {
            if (pageNo > 1) {
                var prevBtnClass = "nextBtn";
                if (pageNo < totalPage)
                    prevBtnClass = "prevBtn";

                rightBar += "<div class='" + prevBtnClass + "' style='clear:both;'><a href='javascript:void(0)' onClick='" + prevFun + "'>上一页</a></div>";
            }
            if (pageNo < totalPage) {
                rightBar += "<div class='nextBtn' style='clear:both;'><a href='javascript:void(0)' onClick='" + nextFun + "'>下一页</a></div>";
            }
        }
        $("#hotmapRightBar").html(rightBar);
        addMarker(results);
    }
</script>
<script type="text/javascript">
    //创建marker
    function addMarker(results) {
        for (var i = 0; i < results.length; i++) {
            var json = results[i];

            var point = new BMap.Point(json.location.lng, json.location.lat);
            var iconImg;
            var imageurl = "${static}/images/map/jindian.png";
            if (json.label == null || json.label == "") {
                iconImg = createIcon({ w: 23, h: 31, l: 46, t: 21, x: 9, lb: 12 }, imageurl);
            } else {
                if (json.category == 1) {
                    imageurl = "${static}/images/map/jindian.png";
                    iconImg = createIcon({ w: 23, h: 31, l: 46, t: 21, x: 9, lb: 12 }, imageurl);
                } else if (json.category == 2) {
                    imageurl = "${static}/images/map/jiudian.png";
                    iconImg = createIcon({ w: 23, h: 31, l: 46, t: 21, x: 9, lb: 12 }, imageurl);
                }
            }
            var marker = new BMap.Marker(point, { icon: iconImg });
            //var marker = new BMap.Marker(point);
            if (json.label == null || json.label == "") {
                json.label = "";
            }
            var label = new BMap.Label(json.label, { "offset": new BMap.Size(12 - 9 + 10, -20) });
            label.setStyle({
                border: "none",
                background: "none",
                fontSize: '14px',
                color: '#fff',
                marginTop: '22px',
                marginLeft: '-9px'
            });
            marker.setLabel(label);
            map.addOverlay(marker);

        }
    }

    //创建一个Icon
    function createIcon(json, url) {
        var icon = new BMap.Icon( "http://localhost:8080" + url, new BMap.Size(json.w, json.h), { imageOffset: new BMap.Size(0, 0), infoWindowOffset: new BMap.Size(json.lb + 5, 1), offset: new BMap.Size(json.x, json.h) })
        return icon;
    }

</script>