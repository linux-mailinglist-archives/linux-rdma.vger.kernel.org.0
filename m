Return-Path: <linux-rdma+bounces-6302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34579E57D2
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817AA28657A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D471D21A42B;
	Thu,  5 Dec 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOY5umB5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536421A425
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406645; cv=none; b=eMsg+QTkv1x7OgoN3jRxTyJ37l+E4tzZU6Y5/3IqzY6GATGjwI4DCKDerkEe+rKEavMziFuu2lQ5XZW7J5yRQ3uzpKaPdI5ffprnFDkpabKVrzYTnWZgblbRDEqXurJnjUfOxKJohx4g5HV8PypkPMZwt+U01bBMe9/GL1+MKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406645; c=relaxed/simple;
	bh=5417LrkO6HhyB5HJCUBG8hZZpVa7sCLNnP+7bBCRhWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgybBugY6qnG6SvvtltvIseUJ+2/yPJ+WuyZTZ36g/alLFkgVJifcI8rf06LjfRA+KP89uHEIrt7Kl+0hcoVKtS7Rm7niNyrUPT02ap7MREVKp9mdG2m7MHjsECsQDVlfxPKlEEP3NAK9sdn9JNOF+Ps93Xslv5JlZ/lfXoIvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOY5umB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7B1C4CED1;
	Thu,  5 Dec 2024 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406645;
	bh=5417LrkO6HhyB5HJCUBG8hZZpVa7sCLNnP+7bBCRhWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOY5umB5IyyvvfmnjJ09OR3Il4dTxgbindeqNrsJK4/MIcVy5iR401LyfuaFrx+8O
	 RRqiBNKjUQhH/tClTASkw/GhR0sXC8d6EnwICW+oI0gan0OvNOUZg/X5IhCgJFnlDR
	 cj0OoZ1HkGAB3RdDlX+qZ9wGJze1BlTy7xnSJivr5jPUv+E3bW6FYYZV/m5BuTOcM8
	 5S0wTtdbco7iq475ML/esgQv2dSt5hFPI+zFnPtLuKDRcr7m8bp00WUOKiG4yksZEt
	 d/Z6S8HNbJjtC3x0/4kqJT7SDzat13HliJARbP3R12/d7Md5GURihOFKPedd2QQDDg
	 dbln7chUZEAmg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next 2/9] IB/mad: Add deadline for send MADs
Date: Thu,  5 Dec 2024 15:49:32 +0200
Message-ID: <3e9add3109a36c3238465b9ce11363084b9ddb14.1733405453.git.leon@kernel.org>
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

The MAD layer does not currently provide a way to enforce a deadline.
Callers which need that, like rdma_resolve_route / SA, make assumptions
about the MAD layer's retry algorithm and set the retries and timeout_ms
fields struct ib_mad_send_buf accordingly.  For example, given today's
retry algorithm - linear, with no significant scheduling or queueing
delays - callers expect the final timeout to trigger roughly after
(retries + 1) * timeout_ms.

Add helper to set internal deadline based on relative timeout from
current time.  Callers can configure the deadline at any time, but
should account for delays themselves introduce before calling
ib_post_send_mad.  Otherwise, if the deadline has passed, post fails.

When a deadline is not set or it's too high, clamp to 5 minutes after
post time.  Probably not a good idea to accept arbitrary timeouts.

After a series of callers will be converted to use this new parameter,
the MAD layer can evolve its retry algorithm (e.g., to prevent
congestion) without affecting those callers.

Note that existing fields still need to be exposed:
  - timeout_ms will be needed to reset the retry algorithm after a
    temporary delay requested by remote via CM MRA [1], and
  - retries is needed to implement CM REQ:Max CM Retries [2].

In case of CM MRA (ib_modify_mad is called with non-zero timeout),
increase the deadline as the sender can't plan for MRA-requested delays.

Ignore RMPP for now - it uses a different per-window retry algorithm.

[1] IBTA v1.7 - Section 12.6.6 - MRA - Message Receipt Acknowledgment
[2] IBTA v1.7 - Section 12.7.27 - Max CM Retries

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c      | 54 +++++++++++++++++++++++++++---
 drivers/infiniband/core/mad_priv.h |  1 +
 include/rdma/ib_mad.h              | 29 ++++++++++++++++
 3 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index bcfbb2a5c02b..5c255ee3db38 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -54,6 +54,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ib_mad.h>
 
+#define IB_MAD_MAX_DEADLINE (jiffies + msecs_to_jiffies(5 * 60 * 1000))
+
 #ifdef CONFIG_TRACEPOINTS
 static void create_mad_addr_info(struct ib_mad_send_wr_private *mad_send_wr,
 			  struct ib_mad_qp_info *qp_info,
@@ -855,6 +857,26 @@ int ib_mad_kernel_rmpp_agent(const struct ib_mad_agent *agent)
 }
 EXPORT_SYMBOL(ib_mad_kernel_rmpp_agent);
 
+int ib_set_mad_deadline(struct ib_mad_send_buf *send_buf, u32 total_timeout_ms)
+{
+	struct ib_mad_send_wr_private *mad_send_wr =
+		container_of(send_buf, struct ib_mad_send_wr_private, send_buf);
+
+	if (WARN_ON_ONCE(!total_timeout_ms))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(mad_send_wr->deadline))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(ib_mad_kernel_rmpp_agent(
+		    &mad_send_wr->mad_agent_priv->agent)))
+		return -EINVAL;
+
+	mad_send_wr->deadline = jiffies + msecs_to_jiffies(total_timeout_ms);
+	return 0;
+}
+EXPORT_SYMBOL(ib_set_mad_deadline);
+
 struct ib_mad_send_buf *ib_create_send_mad(struct ib_mad_agent *mad_agent,
 					   u32 remote_qpn, u16 pkey_index,
 					   int rmpp_active, int hdr_len,
@@ -1174,6 +1196,19 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 				continue;
 		}
 
+		if (!ib_mad_kernel_rmpp_agent(&mad_agent_priv->agent) &&
+		    send_buf->timeout_ms) {
+			if (!mad_send_wr->deadline ||
+			    time_after(mad_send_wr->deadline,
+				       IB_MAD_MAX_DEADLINE)) {
+				mad_send_wr->deadline = IB_MAD_MAX_DEADLINE;
+			} else if (time_after_eq(jiffies,
+						 mad_send_wr->deadline)) {
+				ret = -ETIMEDOUT;
+				goto error;
+			}
+		}
+
 		mad_send_wr->tid = ((struct ib_mad_hdr *) send_buf->mad)->tid;
 		/* Timeout will be updated after send completes */
 		mad_send_wr->timeout = msecs_to_jiffies(send_buf->timeout_ms);
@@ -2293,16 +2328,23 @@ static void adjust_timeout(struct ib_mad_agent_private *mad_agent_priv)
 
 static void wait_for_response(struct ib_mad_send_wr_private *mad_send_wr)
 {
-	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wr_private *temp_mad_send_wr;
+	struct ib_mad_agent_private *mad_agent_priv;
+	const unsigned long now = jiffies;
 	struct list_head *list_item;
 	unsigned long delay;
 
 	mad_agent_priv = mad_send_wr->mad_agent_priv;
 	list_del_init(&mad_send_wr->agent_list);
 
-	delay = mad_send_wr->timeout;
-	mad_send_wr->timeout += jiffies;
+	/* Caller must ensure mad_send_wr->timeout is relative */
+	if (!mad_send_wr->deadline)
+		delay = mad_send_wr->timeout;
+	else if (time_after_eq(now, mad_send_wr->deadline))
+		delay = 0; /* schedule ASAP */
+	else
+		delay = min(mad_send_wr->deadline - now, mad_send_wr->timeout);
+	mad_send_wr->timeout = now + delay;
 
 	if (delay) {
 		list_for_each_prev(list_item, &mad_agent_priv->wait_list) {
@@ -2623,6 +2665,9 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 	if (!timeout_ms)
 		mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
 
+	if (mad_send_wr->deadline)
+		mad_send_wr->deadline += msecs_to_jiffies(timeout_ms);
+
 	if (mad_send_wr->state == IB_MAD_STATE_SEND_START ||
 	    (mad_send_wr->state == IB_MAD_STATE_QUEUED && timeout_ms))
 		mad_send_wr->timeout = msecs_to_jiffies(timeout_ms);
@@ -2726,7 +2771,8 @@ static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	int ret;
 
-	if (!mad_send_wr->retries_left)
+	if (time_after_eq(jiffies, mad_send_wr->deadline) ||
+	    !mad_send_wr->retries_left)
 		return -ETIMEDOUT;
 
 	mad_send_wr->retries_left--;
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index b2a12a82a62d..24580ad2d428 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -140,6 +140,7 @@ struct ib_mad_send_wr_private {
 	struct ib_sge sg_list[IB_MAD_SEND_REQ_MAX_SG];
 	__be64 tid;
 	unsigned long timeout;
+	unsigned long deadline;
 	int max_retries;
 	int retries_left;
 	int retry;
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index 3f1b58d8b4bf..69708170a0d6 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -727,6 +727,9 @@ void ib_free_recv_mad(struct ib_mad_recv_wc *mad_recv_wc);
  *
  * This call will reset the timeout value for a sent MAD to the specified
  * value.
+ *
+ * If called with a non-zero value and ib_set_mad_deadline was used, the
+ * deadline will be extended by the @timeout_ms.
  */
 int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms);
 
@@ -818,4 +821,30 @@ void ib_free_send_mad(struct ib_mad_send_buf *send_buf);
  */
 int ib_mad_kernel_rmpp_agent(const struct ib_mad_agent *agent);
 
+/**
+ * ib_set_mad_deadline - Sets send MAD's deadline based on current time.
+ * @send_buf: Previously allocated send data buffer.
+ * @total_timeout_ms: Time to wait before stopping retries.
+ *
+ * The deadline will start being enforced once ib_post_send_mad is called.
+ * It is NOT guaranteed that at least one send will be performed.  Only valid
+ * for MADs waiting for response (ib_mad_send_buf.timeout_ms must also be set).
+ *
+ * This option allows callers to bound the time a MAD is owned by the MAD layer.
+ * This takes precedence over ib_mad_send_buf.{retries, timeout_ms} and is
+ * independent from the MAD layer's internal retry algorithm.
+ *
+ * Once the this deadline expires, the MAD data buffer will be returned to the
+ * caller via the send_handler configured at agent registration time.
+ * Invocation of the send_handler might happen slightly later due to scheduling
+ * delays.
+ *
+ * The deadline will be extended if ib_modify_mad is called.
+ *
+ * Can only be called once.
+ *
+ * Might return errors for MADs which do not support deadline.
+ */
+int ib_set_mad_deadline(struct ib_mad_send_buf *send_buf, u32 total_timeout_ms);
+
 #endif /* IB_MAD_H */
-- 
2.47.0


