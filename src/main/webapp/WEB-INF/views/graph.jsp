<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://d3js.org/d3.v7.min.js"></script>
</head>
<body><script>
// svg 박스를 설정하기 위한 높이 넓이 마진 설정 값
const width = 600;
const height = 300;
const margin = {top: 40, left: 40, bottom: 40, right: 40};

// svg 에 위에 설정한 값들을 넣고 body태그에 삽입
const svg = d3.select('body').append('svg').style('width', width).style('height', height);

// data를 db에서 뽑아와야함
const data = [
    {name: 'a', value: 10},
    {name: 'b', value: 29},
    {name: 'c', value: 32},
    {name: 'd', value: 25},
    {name: 'e', value: 23},
    {name: 'f', value: 15}
  ];
 
/* data = [1, 2, 3, 4, 5] 값을 가지는 데이터가 있고

출력하고자 하는 차트 SVG 너비가 100px이라고 하면,

    .domain([1,5])

    .range([1,100]) 이 된다. */

//시각화할 데이터의 값 domain 
// 반영할 값 range

// scaleband = x축 , scaleLinear = y축
const x = d3.scaleBand()
//.domain(data.map(function(d){return d.name}); 
  .domain(data.map(d => d.name))
  // marin left와 margin right을 뺀 길이
  .range([margin.left, width - margin.right])
  .padding(0.2);
 
 //d3.scale.linear - 정량적 선형 스케일(축척)을 생성한다
const y = d3.scaleLinear()
// nice() 반올림을 통해 축을 이쁘게
  .domain([0, d3.max(data, d => d.value)]).nice()
    .range([height - margin.bottom, margin.top]);
 //g 문서요소 
 /* 그룹을 뜻
    다른 문서 요소를 담는 역할
    트랜스폼 요소 적용가능 
    */
 /* call 
 	선택된 변수의 내용을 불러옴
 */   
 
 
 //axis 단위값
const xAxis = g => g
  .attr('transform', `translate(0, ${height - margin.bottom})`)
  // bottom x축을 아래
  .call(d3.axisBottom(x)
    .tickSizeOuter(0));
 
const yAxis = g => g
  .attr('transform', `translate(${margin.left}, 0)`)
  // left y축을 왼쪽에
  .call(d3.axisLeft(y))
  .call(g => g.select('.domain').remove());
 

 
svg.append('g').call(xAxis);
svg.append('g').call(yAxis);
svg.append('g')
  .attr('fill', 'steelblue')
  .selectAll('rect').data(data).enter().append('rect')
  .attr('x', d => x(d.name))
  .attr('y', d => y(d.value))
  .attr('height', d => y(0) - y(d.value))
  .attr('width', x.bandwidth());

svg.node();
</script>
</body>
</html>