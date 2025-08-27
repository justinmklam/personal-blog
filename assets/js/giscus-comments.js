// Giscus Comment Count Manager
// Uses PostMessage API to get comment counts from Giscus iframes

class GiscusCommentManager {
  constructor() {
    this.setupMessageListener();
  }

  setupMessageListener() {
    window.addEventListener("message", (event) => {
      if (event.origin !== "https://giscus.app") return;
      if (!(typeof event.data === "object" && event.data.giscus)) return;

      const giscusData = event.data.giscus;

      // Check if this contains discussion data with comment count
      if ("discussion" in giscusData) {
        const discussion = giscusData.discussion;
        const currentPath = window.location.pathname;

        if (discussion && typeof discussion.totalCommentCount === "number") {
          // Update comment count displays on current page
          this.updateCommentCountDisplays(
            currentPath,
            discussion.totalCommentCount
          );

          console.log(
            `Giscus: Page ${currentPath} has ${discussion.totalCommentCount} comments`
          );
        }
      }
    });
  }

  updateCommentCountDisplays(url, count) {
    // Update comment count elements for this URL on the current page
    const elements = document.querySelectorAll(`[data-url="${url}"]`);
    elements.forEach((element) => {
      const link = element.querySelector("a") || element;
      if (count === 0) {
        link.innerHTML = "0 comments";
      } else if (count === 1) {
        link.innerHTML = "1 comment";
      } else {
        link.innerHTML = `${count} comments`;
      }
    });
  }

  // Initialize comment count manager
  initialize() {
    // The PostMessage listener will automatically update counts when Giscus loads
    // No need for stored counts - fresh data every time
  }
}

// Initialize the comment manager when DOM is loaded
document.addEventListener("DOMContentLoaded", function () {
  window.giscusCommentManager = new GiscusCommentManager();
  window.giscusCommentManager.initialize();
});
