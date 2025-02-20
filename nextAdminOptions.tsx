import type { NextAdminOptions } from "@premieroctet/next-admin";
import SendPostsToSubscribersDialog from "./components/SendPostToSubscribersDialog";

const options: NextAdminOptions = {
  title: "My awesome admin",

  model: {
    Post: {
      actions: [
        {
          type: "dialog",
          icon: "EnvelopeIcon",
          id: "post-send",
          title: "Send posts to subscribers",
          component: <SendPostsToSubscribersDialog />,
          depth: 3,
        },
      ],
    },
  },
};

export default options;
