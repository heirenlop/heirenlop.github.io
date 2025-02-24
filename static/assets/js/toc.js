// toc.js
// Create a table of contents from the h2 elements on the page

document.addEventListener("DOMContentLoaded", function() {
    const toc = document.getElementById("toc");
    const headings = document.querySelectorAll("h2");

    if (headings.length === 0) {
        toc.style.display = "none";  // 隐藏目录部分
    } else {
        headings.forEach((heading, index) => {
            const id = `section-${index + 1}`;
            heading.id = id;

            const link = document.createElement("a");
            link.href = `#${id}`;
            link.textContent = heading.textContent;

            const listItem = document.createElement("li");
            listItem.appendChild(link);
            toc.appendChild(listItem);
        });
    }
});
