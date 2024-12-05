Return-Path: <linux-rdma+bounces-6306-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A835E9E57D7
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898601883B35
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE1219A74;
	Thu,  5 Dec 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWnc9Q2j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB52218EA1
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406660; cv=none; b=I5ESN3bsSK8p6V60NGY2PnE4JWEmhJqrhf5Wat3T9EWGEppzEV0I74Be3bJo4mQ9vUy0UNJJzA9g9SBsN4jMZfPYdLHkZszR1jkbNRc5IPwSzX7iIGaZpCOIT8lj1+zTReRhLwTw3lnlMshnxw6e3Div3ZZ9t1ZitZ4SvY24YAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406660; c=relaxed/simple;
	bh=dEL/2sq4ht9b5bEGXDI/G7/t5bb4jTSEvkntFOdpnHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHj+HsDmtFIDegd4zr2bTQ/glTdKMgyOprl5BH8ckFANKpwrtqkBG9KXnfSOOyddyaHGd9jKZ0ieL13ZDnaCJZLBMbG3xD0KImPTPpdIka1mH5rzpJVLSxcC3r1ADNfZetxnFU4Fm/Wdcx1m3wWYaYwGifttITXEwOP6tVRPs9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWnc9Q2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5277CC4CED1;
	Thu,  5 Dec 2024 13:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406659;
	bh=dEL/2sq4ht9b5bEGXDI/G7/t5bb4jTSEvkntFOdpnHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OWnc9Q2j1p0/nW4yNHXuGCXhvNG+y7Euj91tivZxBm12MdRvxr7ajcB7hoQ9bTjuq
	 G4dB8CniUdioJhGL7CELxa431Oz1nTHjixphp3+zqpZwOKgA29Qrs00o3EGM/Unqwa
	 r97gjlsNdDHpiCSwR0RZ9d/7dvmyOrDOp+b8RZwhQKOSq3vJebEGS4ZSLJX4zKmkpG
	 zs+BLhFYgAFZMLxAas7r0NaluEKOo5xu/JsNvIz+VvtVC3krmZ6yukDn7c6x7YTNul
	 sKnyKOxBWargqnrYsWqjM41qdWP+8AylUiGdkRDM02qVj7Zw8Tt9a1YEzadlUQYPSv
	 aug/Z7YjoKe5w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next 7/9] IB/mad: Exponential backoff when retrying sends
Date: Thu,  5 Dec 2024 15:49:37 +0200
Message-ID: <af348c70c47485235d7d6811b56ccf23e105bdad.1733405453.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733405453.git.leon@kernel.org>
References: <cover.1733405453.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

When a receiver is overloaded, MAD requests time out and get retried in
a linear fashion.  This could worsen congestion and reduce goodput.  To
help reduce the load over time, use exponential backoff after a preset
number of retries.  Cap delays between retries at 60s, even when in
exponential mode.

MRA message from recipient could request an even higher timeout, so
continue to respect that for the next retry.  However, reset the backoff
algorithm to the beginning when and MRA is received.

Exclude RMPP and OPA from exponential backoff.

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c      | 53 ++++++++++++++++++++++++++++--
 drivers/infiniband/core/mad_priv.h |  3 ++
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 5c255ee3db38..a3a8cf4bbc20 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -54,7 +54,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ib_mad.h>
 
-#define IB_MAD_MAX_DEADLINE (jiffies + msecs_to_jiffies(5 * 60 * 1000))
+#define IB_MAD_LINEAR_TIMEOUTS_DEFAULT	4
+#define IB_MAD_MAX_TIMEOUT_MS		(60 * MSEC_PER_SEC)
+#define IB_MAD_MAX_DEADLINE		(jiffies + msecs_to_jiffies(5 * 60 * 1000))
 
 #ifdef CONFIG_TRACEPOINTS
 static void create_mad_addr_info(struct ib_mad_send_wr_private *mad_send_wr,
@@ -1210,10 +1212,12 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		}
 
 		mad_send_wr->tid = ((struct ib_mad_hdr *) send_buf->mad)->tid;
+		mad_send_wr->var_timeout_ms = send_buf->timeout_ms;
 		/* Timeout will be updated after send completes */
 		mad_send_wr->timeout = msecs_to_jiffies(send_buf->timeout_ms);
 		mad_send_wr->max_retries = send_buf->retries;
 		mad_send_wr->retries_left = send_buf->retries;
+		mad_send_wr->backoff_retries = 0;
 		send_buf->retries = 0;
 		mad_send_wr->status = IB_WC_SUCCESS;
 
@@ -2662,18 +2666,34 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 		return -EINVAL;
 	}
 
-	if (!timeout_ms)
+	if (!timeout_ms) {
 		mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
+		goto apply;
+	}
+
+	/* CM MRA requesting a lower timeout than ours.  Could be a delayed MRA
+	 * (variable backoff increased in the meantime) or remote using a const.
+	 */
+	if (timeout_ms < mad_send_wr->var_timeout_ms)
+		goto ignore;
+
+	/* Assume remote will no longer be overloaded after MRA Service Timeout
+	 * passes and restart variable backoff algorithm.
+	 */
+	mad_send_wr->var_timeout_ms = mad_send_wr->send_buf.timeout_ms;
+	mad_send_wr->backoff_retries = 0;
 
 	if (mad_send_wr->deadline)
 		mad_send_wr->deadline += msecs_to_jiffies(timeout_ms);
 
+apply:
 	if (mad_send_wr->state == IB_MAD_STATE_SEND_START ||
 	    (mad_send_wr->state == IB_MAD_STATE_QUEUED && timeout_ms))
 		mad_send_wr->timeout = msecs_to_jiffies(timeout_ms);
 	else
 		ib_reset_mad_timeout(mad_send_wr, timeout_ms);
 
+ignore:
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 	return 0;
 }
@@ -2767,6 +2787,30 @@ static void local_completions(struct work_struct *work)
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 }
 
+/*
+ * Applies a variable backoff to certain send MADs.
+ *
+ * Exists to scope down the initial variable backoff implementation.
+ */
+static void set_next_timeout(struct ib_mad_send_wr_private *mad_send_wr)
+{
+	const struct ib_mad_agent_private *agent = mad_send_wr->mad_agent_priv;
+	const struct ib_mad_port_private *port = agent->qp_info->port_priv;
+	const struct ib_mad_hdr *hdr = mad_send_wr->send_buf.mad;
+
+	if (ib_mad_kernel_rmpp_agent(&agent->agent))
+		return;
+
+	if (hdr->base_version != IB_MGMT_BASE_VERSION)
+		return;
+
+	if (++mad_send_wr->backoff_retries < READ_ONCE(port->linear_timeouts))
+		return;
+
+	mad_send_wr->var_timeout_ms =
+		min(mad_send_wr->var_timeout_ms << 1, IB_MAD_MAX_TIMEOUT_MS);
+}
+
 static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	int ret;
@@ -2778,7 +2822,8 @@ static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
 	mad_send_wr->retries_left--;
 	mad_send_wr->send_buf.retries++;
 
-	mad_send_wr->timeout = msecs_to_jiffies(mad_send_wr->send_buf.timeout_ms);
+	set_next_timeout(mad_send_wr);
+	mad_send_wr->timeout = msecs_to_jiffies(mad_send_wr->var_timeout_ms);
 
 	if (ib_mad_kernel_rmpp_agent(&mad_send_wr->mad_agent_priv->agent)) {
 		ret = ib_retry_rmpp(mad_send_wr);
@@ -3195,6 +3240,8 @@ static int ib_mad_port_open(struct ib_device *device,
 		goto error8;
 	}
 
+	port_priv->linear_timeouts = IB_MAD_LINEAR_TIMEOUTS_DEFAULT;
+
 	spin_lock_irqsave(&ib_mad_port_list_lock, flags);
 	list_add_tail(&port_priv->port_list, &ib_mad_port_list);
 	spin_unlock_irqrestore(&ib_mad_port_list_lock, flags);
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 24580ad2d428..076ebcea27b4 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -139,10 +139,12 @@ struct ib_mad_send_wr_private {
 	struct ib_ud_wr send_wr;
 	struct ib_sge sg_list[IB_MAD_SEND_REQ_MAX_SG];
 	__be64 tid;
+	unsigned int var_timeout_ms;
 	unsigned long timeout;
 	unsigned long deadline;
 	int max_retries;
 	int retries_left;
+	int backoff_retries;
 	int retry;
 	enum ib_wc_status status;
 
@@ -222,6 +224,7 @@ struct ib_mad_port_private {
 	struct ib_mad_mgmt_version_table version[MAX_MGMT_VERSION];
 	struct workqueue_struct *wq;
 	struct ib_mad_qp_info qp_info[IB_MAD_QPS_CORE];
+	u8 linear_timeouts;
 };
 
 int ib_send_mad(struct ib_mad_send_wr_private *mad_send_wr);
-- 
2.47.0


