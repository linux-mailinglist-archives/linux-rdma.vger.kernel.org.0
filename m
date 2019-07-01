Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1305B4BBAE
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfFSOdp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 10:33:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40619 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOdo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 10:33:44 -0400
Received: by mail-io1-f66.google.com with SMTP id n5so38608541ioc.7;
        Wed, 19 Jun 2019 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Si3jDmFx5xypB5GvR2QVYXFanK45B7dzGeDn5cZG4jI=;
        b=QZTU4qguOuWPAdM3zzKC2aI/YKVQFT2X34ImBw62X3P7SXPCbdeDhpryRgAKZMOq/U
         Gj5jBPs8q/TCork1H4rkh9YkK30+DdpKL/NL8mtQVthhjL7THxsm2UDGnFshkDApJlq7
         LKW5gjM8UkFK9YBeYxc9P+0wzwD9IqjMJ+xx0cpjwyE1VQACNtO4uJKBWz5HQ5k6pjJL
         9wSsN1zhsF5EpU7D6bIqmV9l58WNf8dOp1qBaMg+Eg4bQG4ERXFwpyHwzZ4WTuoo+WoR
         1veqhgVaCcKCl67S0fTrFm+bhOTQbe8yOUfvI7hxMEQ5nx7jjScviRnbXT0hILesfhZd
         +K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Si3jDmFx5xypB5GvR2QVYXFanK45B7dzGeDn5cZG4jI=;
        b=nRRviitBhIqdeYuX52H8NUvI1GQEZHA+UvkIhuwWNIFoDBnORrGpXPsFhFWXmwgztm
         Gs3a7hzjhx0lM5X11hE0FTKiqoXFoupweqbvj0PtZDO1/10/eNr51WnrcT08wYAP83PA
         24lUvHj99iGpRkKaR9LdnJdo4s0QNrJYNdL8GyfD8kuxAoqXBBWH3UjmbrE4IvLwUz+t
         bBimRS4IXEawpdKLs5kpvtREfBRCpBbK5b4+0zjPsnPDJqE2Nwqh+LvjSJ0jq7JTabsC
         /1hikG30DYykzwXqS5lfQsJoWBccJ5N+q16cKUvSb//xPp8Y2Jdj6euz0KVtGiU8jsuH
         RXew==
X-Gm-Message-State: APjAAAUx0xH5t+bZaxBdADkzECSp+XOvYz5xswfgsDqvfPTbcE1sXzo/
        2AvNiGS5g7b9PUCIAY1yBvpuv+qR
X-Google-Smtp-Source: APXvYqypf7s+LaIokXauEDDoC2VLDQkX6DPVudgLEBcCvKzdC3ZFKUK6LzBRkJPtS4AG3xdXoZ7RWg==
X-Received: by 2002:a05:6638:5:: with SMTP id z5mr104879jao.58.1560954823678;
        Wed, 19 Jun 2019 07:33:43 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c17sm13900839ioo.82.2019.06.19.07.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:33:43 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEXgXN004533;
        Wed, 19 Jun 2019 14:33:42 GMT
Subject: [PATCH v4 14/19] xprtrdma: Modernize ops->connect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:33:42 -0400
Message-ID: <20190619143342.3826.8310.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Adapt and apply changes that were made to the TCP socket connect
code. See the following commits for details on the purpose of
these changes:

Commit 7196dbb02ea0 ("SUNRPC: Allow changing of the TCP timeout parameters on the fly")
Commit 3851f1cdb2b8 ("SUNRPC: Limit the reconnect backoff timer to the max RPC message timeout")
Commit 02910177aede ("SUNRPC: Fix reconnection timeouts")

Some common transport code is moved to xprt.c to satisfy the code
duplication police.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xprt.h     |    3 ++
 include/trace/events/rpcrdma.h  |   31 ++++++++++++++++++
 net/sunrpc/sched.c              |    1 +
 net/sunrpc/xprt.c               |   32 +++++++++++++++++++
 net/sunrpc/xprtrdma/transport.c |   66 ++++++++++++++++++++++++++++++---------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 net/sunrpc/xprtsock.c           |   23 +-------------
 7 files changed, 121 insertions(+), 36 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index a6d9fce..cc78fd3 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -334,6 +334,9 @@ struct xprt_class {
  */
 struct rpc_xprt		*xprt_create_transport(struct xprt_create *args);
 void			xprt_connect(struct rpc_task *task);
+unsigned long		xprt_reconnect_delay(const struct rpc_xprt *xprt);
+void			xprt_reconnect_backoff(struct rpc_xprt *xprt,
+					       unsigned long init_to);
 void			xprt_reserve(struct rpc_task *task);
 void			xprt_retry_reserve(struct rpc_task *task);
 int			xprt_reserve_xprt(struct rpc_xprt *xprt, struct rpc_task *task);
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 98023d9..f6a4eaa 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -375,6 +375,37 @@
 DEFINE_RXPRT_EVENT(xprtrdma_op_close);
 DEFINE_RXPRT_EVENT(xprtrdma_op_connect);
 
+TRACE_EVENT(xprtrdma_op_set_cto,
+	TP_PROTO(
+		const struct rpcrdma_xprt *r_xprt,
+		unsigned long connect,
+		unsigned long reconnect
+	),
+
+	TP_ARGS(r_xprt, connect, reconnect),
+
+	TP_STRUCT__entry(
+		__field(const void *, r_xprt)
+		__field(unsigned long, connect)
+		__field(unsigned long, reconnect)
+		__string(addr, rpcrdma_addrstr(r_xprt))
+		__string(port, rpcrdma_portstr(r_xprt))
+	),
+
+	TP_fast_assign(
+		__entry->r_xprt = r_xprt;
+		__entry->connect = connect;
+		__entry->reconnect = reconnect;
+		__assign_str(addr, rpcrdma_addrstr(r_xprt));
+		__assign_str(port, rpcrdma_portstr(r_xprt));
+	),
+
+	TP_printk("peer=[%s]:%s r_xprt=%p: connect=%lu reconnect=%lu",
+		__get_str(addr), __get_str(port), __entry->r_xprt,
+		__entry->connect / HZ, __entry->reconnect / HZ
+	)
+);
+
 TRACE_EVENT(xprtrdma_qp_event,
 	TP_PROTO(
 		const struct rpcrdma_xprt *r_xprt,
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index bb04ae5..5ad5dea 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -58,6 +58,7 @@
  */
 struct workqueue_struct *rpciod_workqueue __read_mostly;
 struct workqueue_struct *xprtiod_workqueue __read_mostly;
+EXPORT_SYMBOL_GPL(xprtiod_workqueue);
 
 unsigned long
 rpc_task_timeout(const struct rpc_task *task)
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index ad21880..b1f54b7 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -850,6 +850,38 @@ void xprt_connect(struct rpc_task *task)
 	xprt_release_write(xprt, task);
 }
 
+/**
+ * xprt_reconnect_delay - compute the wait before scheduling a connect
+ * @xprt: transport instance
+ *
+ */
+unsigned long xprt_reconnect_delay(const struct rpc_xprt *xprt)
+{
+	unsigned long start, now = jiffies;
+
+	start = xprt->stat.connect_start + xprt->reestablish_timeout;
+	if (time_after(start, now))
+		return start - now;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xprt_reconnect_delay);
+
+/**
+ * xprt_reconnect_backoff - compute the new re-establish timeout
+ * @xprt: transport instance
+ * @init_to: initial reestablish timeout
+ *
+ */
+void xprt_reconnect_backoff(struct rpc_xprt *xprt, unsigned long init_to)
+{
+	xprt->reestablish_timeout <<= 1;
+	if (xprt->reestablish_timeout > xprt->max_reconnect_timeout)
+		xprt->reestablish_timeout = xprt->max_reconnect_timeout;
+	if (xprt->reestablish_timeout < init_to)
+		xprt->reestablish_timeout = init_to;
+}
+EXPORT_SYMBOL_GPL(xprt_reconnect_backoff);
+
 enum xprt_xid_rb_cmp {
 	XID_RB_EQUAL,
 	XID_RB_LEFT,
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 3688e078..4993aa4 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -298,6 +298,7 @@
 	module_put(THIS_MODULE);
 }
 
+/* 60 second timeout, no retries */
 static const struct rpc_timeout xprt_rdma_default_timeout = {
 	.to_initval = 60 * HZ,
 	.to_maxval = 60 * HZ,
@@ -323,8 +324,9 @@
 	if (!xprt)
 		return ERR_PTR(-ENOMEM);
 
-	/* 60 second timeout, no retries */
 	xprt->timeout = &xprt_rdma_default_timeout;
+	xprt->connect_timeout = xprt->timeout->to_initval;
+	xprt->max_reconnect_timeout = xprt->timeout->to_maxval;
 	xprt->bind_timeout = RPCRDMA_BIND_TO;
 	xprt->reestablish_timeout = RPCRDMA_INIT_REEST_TO;
 	xprt->idle_timeout = RPCRDMA_IDLE_DISC_TO;
@@ -487,31 +489,64 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 }
 
 /**
- * xprt_rdma_connect - try to establish a transport connection
+ * xprt_rdma_set_connect_timeout - set timeouts for establishing a connection
+ * @xprt: controlling transport instance
+ * @connect_timeout: reconnect timeout after client disconnects
+ * @reconnect_timeout: reconnect timeout after server disconnects
+ *
+ */
+static void xprt_rdma_tcp_set_connect_timeout(struct rpc_xprt *xprt,
+					      unsigned long connect_timeout,
+					      unsigned long reconnect_timeout)
+{
+	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
+
+	trace_xprtrdma_op_set_cto(r_xprt, connect_timeout, reconnect_timeout);
+
+	spin_lock(&xprt->transport_lock);
+
+	if (connect_timeout < xprt->connect_timeout) {
+		struct rpc_timeout to;
+		unsigned long initval;
+
+		to = *xprt->timeout;
+		initval = connect_timeout;
+		if (initval < RPCRDMA_INIT_REEST_TO << 1)
+			initval = RPCRDMA_INIT_REEST_TO << 1;
+		to.to_initval = initval;
+		to.to_maxval = initval;
+		r_xprt->rx_timeout = to;
+		xprt->timeout = &r_xprt->rx_timeout;
+		xprt->connect_timeout = connect_timeout;
+	}
+
+	if (reconnect_timeout < xprt->max_reconnect_timeout)
+		xprt->max_reconnect_timeout = reconnect_timeout;
+
+	spin_unlock(&xprt->transport_lock);
+}
+
+/**
+ * xprt_rdma_connect - schedule an attempt to reconnect
  * @xprt: transport state
- * @task: RPC scheduler context
+ * @task: RPC scheduler context (unused)
  *
  */
 static void
 xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 {
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
+	unsigned long delay;
 
 	trace_xprtrdma_op_connect(r_xprt);
+
+	delay = 0;
 	if (r_xprt->rx_ep.rep_connected != 0) {
-		/* Reconnect */
-		schedule_delayed_work(&r_xprt->rx_connect_worker,
-				      xprt->reestablish_timeout);
-		xprt->reestablish_timeout <<= 1;
-		if (xprt->reestablish_timeout > RPCRDMA_MAX_REEST_TO)
-			xprt->reestablish_timeout = RPCRDMA_MAX_REEST_TO;
-		else if (xprt->reestablish_timeout < RPCRDMA_INIT_REEST_TO)
-			xprt->reestablish_timeout = RPCRDMA_INIT_REEST_TO;
-	} else {
-		schedule_delayed_work(&r_xprt->rx_connect_worker, 0);
-		if (!RPC_IS_ASYNC(task))
-			flush_delayed_work(&r_xprt->rx_connect_worker);
+		delay = xprt_reconnect_delay(xprt);
+		xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
 	}
+	queue_delayed_work(xprtiod_workqueue, &r_xprt->rx_connect_worker,
+			   delay);
 }
 
 /**
@@ -769,6 +804,7 @@ void xprt_rdma_print_stats(struct rpc_xprt *xprt, struct seq_file *seq)
 	.send_request		= xprt_rdma_send_request,
 	.close			= xprt_rdma_close,
 	.destroy		= xprt_rdma_destroy,
+	.set_connect_timeout	= xprt_rdma_tcp_set_connect_timeout,
 	.print_stats		= xprt_rdma_print_stats,
 	.enable_swap		= xprt_rdma_enable_swap,
 	.disable_swap		= xprt_rdma_disable_swap,
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 117e328..8378f45 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -432,6 +432,7 @@ struct rpcrdma_xprt {
 	struct rpcrdma_ep	rx_ep;
 	struct rpcrdma_buffer	rx_buf;
 	struct delayed_work	rx_connect_worker;
+	struct rpc_timeout	rx_timeout;
 	struct rpcrdma_stats	rx_stats;
 };
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c69951e..b154600 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2402,25 +2402,6 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	xprt_wake_pending_tasks(xprt, status);
 }
 
-static unsigned long xs_reconnect_delay(const struct rpc_xprt *xprt)
-{
-	unsigned long start, now = jiffies;
-
-	start = xprt->stat.connect_start + xprt->reestablish_timeout;
-	if (time_after(start, now))
-		return start - now;
-	return 0;
-}
-
-static void xs_reconnect_backoff(struct rpc_xprt *xprt)
-{
-	xprt->reestablish_timeout <<= 1;
-	if (xprt->reestablish_timeout > xprt->max_reconnect_timeout)
-		xprt->reestablish_timeout = xprt->max_reconnect_timeout;
-	if (xprt->reestablish_timeout < XS_TCP_INIT_REEST_TO)
-		xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
-}
-
 /**
  * xs_connect - connect a socket to a remote endpoint
  * @xprt: pointer to transport structure
@@ -2450,8 +2431,8 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 		/* Start by resetting any existing state */
 		xs_reset_transport(transport);
 
-		delay = xs_reconnect_delay(xprt);
-		xs_reconnect_backoff(xprt);
+		delay = xprt_reconnect_delay(xprt);
+		xprt_reconnect_backoff(xprt, XS_TCP_INIT_REEST_TO);
 
 	} else
 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);

