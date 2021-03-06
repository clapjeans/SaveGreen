<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7a41e2e2fe078d964dd06a6ada8cd641"></script>
<script src="../../../../resources/static/assets/js/jquery-3.6.0.min.js"></script>
<script>

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 9 // 지도의 확대 레벨
        };
    var map = new kakao.maps.Map(mapContainer, mapOption),
        customOverlay = new kakao.maps.CustomOverlay({}),
        infowindow = new kakao.maps.InfoWindow({removable: true});
    //줌확대축소막기
    map.setZoomable(false);

    // 지도에 폴리곤으로 표시할 영역데이터 배열입니다
    $.getJSON("${path}/JSON/Seoul.geojson", function (geojson) {

        var data = geojson.features;
        var coordinates = []; ///좌표를 저장할 배열
        var name = ''; //행정구역명

        $.each(data, function (index, val) {
            coordinates = val.geometry.coordinates;  //좌표
            name = val.properties.SIG_KOR_NM; //행정구이름

            displayArea(coordinates, name); //폴리건 함수로 이동
        })


    })

    var polygons = [];


    // 다각형을 생상하고 이벤트를 등록하는 함수입니다
    function displayArea(coordinates, name) { //좌표 행정구역명
        var path = [];  //폴리곤을 그려줄 path
        var points = []; //중심좌표를 구하기위한 지역구 좌표들
        var polygons = []; //function 안에 변수 넣기위해


        $.each(coordinates[0], function (index, coordinate) {
            var point = new Object();
            point.x = coordinate[1];
            point.y = coordinate[0];
            points.push(point);
            path.push(new kakao.maps.LatLng(coordinate[1], coordinate[0]));
        })

        // 다각형을 생성합니다
        var polygon = new kakao.maps.Polygon({
            map: map, // 다각형을 표시할 지도 객체
            path: path,  //그려질 다각형의 좌표 배열
            strokeWeight: 2, //선의 두께
            strokeColor: '#004c80', //선의 스타일
            strokeOpacity: 0.8, //선의 투명도
            fillColor: '#fff', //채우기색깔
            fillOpacity: 0.7 //채우기붙투명도
        });
        polygons.push(polygon);  //폴리건 실행


        // 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다
        // 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
        kakao.maps.event.addListener(polygon, 'mouseover', function (mouseEvent) {
            polygon.setOptions({fillColor: '#09f'});

            customOverlay.setContent('<div class="area">' + name + '</div>');

            customOverlay.setPosition(mouseEvent.latLng);
            customOverlay.setMap(map);
        });

        // 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다
        kakao.maps.event.addListener(polygon, 'mousemove', function (mouseEvent) {

            customOverlay.setPosition(mouseEvent.latLng);
        });

        // 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
        // 커스텀 오버레이를 지도에서 제거합니다
        kakao.maps.event.addListener(polygon, 'mouseout', function () {
            polygon.setOptions({fillColor: '#fff'});
            customOverlay.setMap(null);
        });

        // 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 다각형의 이름과 면적을 인포윈도우에 표시합니다
        kakao.maps.event.addListener(polygon, 'click', function (mouseEvent) {
            var content = '<div class="info">' +
                '   <div class="title">' + name + '</div>' +
                '  <div class="info">' + '<a href="/mapListInfo?gu=' + name + '">' + name + '재활용배출방법</a>' + '</div>'
            '</div>';

            infowindow.setContent(content);
            infowindow.setPosition(mouseEvent.latLng);
            infowindow.setMap(map);
        });

    }
</script>