async function loadQuizzes(){

const response = await fetch(API+"/quizzes",{

headers:{
Authorization:"Bearer "+token
}

});

const quizzes = await response.json();

let html="";

quizzes.forEach((quiz)=>{

html+=`

<tr>

<td>${quiz.id}</td>

<td>${quiz.title}</td>

<td>${quiz.duration}</td>

<td>

<button
class="edit"
onclick="editQuiz(${quiz.id})">

Edit

</button>

<button
class="delete"
onclick="deleteQuiz(${quiz.id})">

Delete

</button>

</td>

</tr>

`;

});

document.getElementById("quizTable").innerHTML=html;

}

loadQuizzes();