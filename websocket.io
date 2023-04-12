#include <libwebsockets.h>

static int callback_http(struct lws *wsi, enum lws_callback_reasons reason, void *user_data, void *in, size_t len)
{
    // Handle HTTP-related callbacks here
    return 0;
}

static int callback_websocket(struct lws *wsi, enum lws_callback_reasons reason, void *user_data, void *in, size_t len)
{
    switch (reason)
    {
        case LWS_CALLBACK_ESTABLISHED:
            // WebSocket connection established, do any setup here
            break;
        case LWS_CALLBACK_RECEIVE:
            // WebSocket message received, process it here
            break;
        case LWS_CALLBACK_CLOSED:
            // WebSocket connection closed, do cleanup here
            break;
        default:
            break;
    }
    return 0;
}

int main()
{
    struct lws_context_creation_info info;
    memset(&info, 0, sizeof(info));

    info.port = 7681; // Port for WebSocket server
    info.protocols = (const struct lws_protocols[]) {
        {
            "http-only",
            callback_http,
            0,
            0,
        },
        {
            "websocket",
            callback_websocket,
            0,
            0,
        },
        { NULL, NULL, 0, 0 }
    };

    struct lws_context *context = lws_create_context(&info);
    if (!context)
    {
        fprintf(stderr, "Failed to create libwebsocket context\n");
        return 1;
    }

    // Main event loop for handling WebSocket connections
    while (1)
    {
        lws_service(context, 50); // 50ms timeout
    }

    lws_context_destroy(context);

    return 0;
}

