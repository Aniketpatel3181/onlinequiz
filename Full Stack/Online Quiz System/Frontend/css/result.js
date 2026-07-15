const result = JSON.parse(localStorage.getItem("result"));

if (!result) {
    alert("No Result Found");
    window.location = "login.html";
}

document.getElementById("totalQuestions").innerHTML =
    result.totalQuestions;

document.getElementById("correctAnswers").innerHTML =
    result.correctAnswers;

document.getElementById("wrongAnswers").innerHTML =
    result.wrongAnswers;

document.getElementById("score").innerHTML =
    result.score;

document.getElementById("percentage").innerHTML =
    result.percentage;








    document.getElementById("restartBtn").onclick = () => {

    window.location = "quiz.html";

};

document.getElementById("logoutBtn").onclick = () => {

    localStorage.removeItem("token");

    localStorage.removeItem("result");

    window.location = "login.html";

};