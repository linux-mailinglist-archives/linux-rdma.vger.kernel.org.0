Return-Path: <linux-rdma+bounces-11752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BD1AED991
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F3177678
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8536F25A2DA;
	Mon, 30 Jun 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx7VLRVw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D924466E
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278620; cv=none; b=J9IMUnmJTBJP7DZ3jzjgDM2IyUuliS0jOgJnXhQEx4gM1IU8XzZfc8KRSBudkSaKIbntNXCTZVCRJJ7pr0+iEnnDXNZ7pDwh8KRAsLZ/rsKxU66IbtwxhPswxMIqqQKJ2y467iamN23GC9atF7Co18HFhwGL1ihFoiB3RdZFfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278620; c=relaxed/simple;
	bh=DuNy/Ue2iSS09mIveexditpJ5C10v4W4v6FgDQCFGew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8aDkOyrV0xicP9+yYl5voasILZEJ/XebQMQxCz/VOpTH4sVZNsHtHVh/bk9NNDJLlxsGliuDJwKL3AtecngQ0ylj7OnHHZqsAzRUd/ltqZb3gflNo4Nu+4QU1Ffm6flO3kt8oxk++Rpyh+1PU3z3EFIsSmO7QmQDuHt55EcK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx7VLRVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A96C4CEEF;
	Mon, 30 Jun 2025 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751278619;
	bh=DuNy/Ue2iSS09mIveexditpJ5C10v4W4v6FgDQCFGew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kx7VLRVwJ3ecI+ESGQZBWfWn5yitj98i5VcbiYzMXPiqAY+CEJLj7TXju7ZfISBBG
	 Hj47dEF+2HZMU8q73p+9bkMEhK9Z1Db5ji/tX5egE32Kyy1quTRdM014UwfIznbh9w
	 df/G3BnmtMIc4Wu00G/ZL0vJ+Xwjhz12vBAbbb8uiHsuLXpq3hQDITck8iN5wXjJar
	 XwIpY0gx6ahsn+SNXG4FRDlyol/f5WyDL3iBxHe7iy/6HZe3s1joQ7I/N3sqzish8O
	 J0URu69B0LZ0bklQDz1bjbTUuTZ+m8R1bV8lNM65IQK7W1gMJ7EjWHqAGQzvRP22VL
	 u2wqVtClH17zA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next v2 2/3] IB/mad: Add flow control for solicited MADs
Date: Mon, 30 Jun 2025 13:16:43 +0300
Message-ID: <c0ecaa1821badee124cd13f3bf860f67ce453beb.1751278420.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751278420.git.leon@kernel.org>
References: <cover.1751278420.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

Currently, MADs sent via an agent are being forwarded directly to the
corresponding MAD QP layer.

MADs with a timeout value set and requiring a response (solicited MADs)
will be resent if the timeout expires without receiving a response.
In a congested subnet, flooding MAD QP layer with more solicited send
requests from the agent will only worsen the situation by triggering
more timeouts and therefore more retries.

Thus, add flow control for non-user solicited MADs to block agents from
issuing new solicited MAD requests to the MAD QP until outstanding
requests are completed and the MAD QP is ready to process additional
requests. While at it, keep track of the total outstanding solicited
MAD work requests in send or wait list. The number of outstanding send
WRs will be limited by a fraction of the RQ size, and any new send WR
that exceeds that limit will be held in a backlog list.
Backlog MADs will be forwarded to agent send list only once the total
number of outstanding send WRs falls below the limit.

Unsolicited MADs, RMPP MADs and MADs which are not SA, SMP or CM are
not subject to this flow control mechanism and will not be affected by
this change.

For this purpose, a new state is introduced:
- 'IB_MAD_STATE_QUEUED': MAD is in backlog list

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c      | 206 +++++++++++++++++++++++++++--
 drivers/infiniband/core/mad_priv.h |  18 +++
 2 files changed, 214 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index eb2d63dff638..183667038cf2 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -210,6 +210,29 @@ int ib_response_mad(const struct ib_mad_hdr *hdr)
 }
 EXPORT_SYMBOL(ib_response_mad);
 
+#define SOL_FC_MAX_DEFAULT_FRAC 4
+#define SOL_FC_MAX_SA_FRAC 32
+
+static int get_sol_fc_max_outstanding(struct ib_mad_reg_req *mad_reg_req)
+{
+	if (!mad_reg_req)
+		/* Send only agent */
+		return mad_recvq_size / SOL_FC_MAX_DEFAULT_FRAC;
+
+	switch (mad_reg_req->mgmt_class) {
+	case IB_MGMT_CLASS_CM:
+		return mad_recvq_size / SOL_FC_MAX_DEFAULT_FRAC;
+	case IB_MGMT_CLASS_SUBN_ADM:
+		return mad_recvq_size / SOL_FC_MAX_SA_FRAC;
+	case IB_MGMT_CLASS_SUBN_LID_ROUTED:
+	case IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE:
+		return min(mad_recvq_size, IB_MAD_QP_RECV_SIZE) /
+		       SOL_FC_MAX_DEFAULT_FRAC;
+	default:
+		return 0;
+	}
+}
+
 /*
  * ib_register_mad_agent - Register to send/receive MADs
  *
@@ -392,12 +415,16 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 	INIT_LIST_HEAD(&mad_agent_priv->send_list);
 	INIT_LIST_HEAD(&mad_agent_priv->wait_list);
 	INIT_LIST_HEAD(&mad_agent_priv->rmpp_list);
+	INIT_LIST_HEAD(&mad_agent_priv->backlog_list);
 	INIT_DELAYED_WORK(&mad_agent_priv->timed_work, timeout_sends);
 	INIT_LIST_HEAD(&mad_agent_priv->local_list);
 	INIT_WORK(&mad_agent_priv->local_work, local_completions);
 	refcount_set(&mad_agent_priv->refcount, 1);
 	init_completion(&mad_agent_priv->comp);
-
+	mad_agent_priv->sol_fc_send_count = 0;
+	mad_agent_priv->sol_fc_wait_count = 0;
+	mad_agent_priv->sol_fc_max =
+		get_sol_fc_max_outstanding(mad_reg_req);
 	ret2 = ib_mad_agent_security_setup(&mad_agent_priv->agent, qp_type);
 	if (ret2) {
 		ret = ERR_PTR(ret2);
@@ -1054,6 +1081,20 @@ int ib_send_mad(struct ib_mad_send_wr_private *mad_send_wr)
 	return ret;
 }
 
+static void handle_queued_state(struct ib_mad_send_wr_private *mad_send_wr,
+		       struct ib_mad_agent_private *mad_agent_priv)
+{
+	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP) {
+		mad_agent_priv->sol_fc_wait_count--;
+		list_move_tail(&mad_send_wr->agent_list,
+			       &mad_agent_priv->backlog_list);
+	} else {
+		expect_mad_state(mad_send_wr, IB_MAD_STATE_INIT);
+		list_add_tail(&mad_send_wr->agent_list,
+			      &mad_agent_priv->backlog_list);
+	}
+}
+
 static void handle_send_state(struct ib_mad_send_wr_private *mad_send_wr,
 		       struct ib_mad_agent_private *mad_agent_priv)
 {
@@ -1061,10 +1102,17 @@ static void handle_send_state(struct ib_mad_send_wr_private *mad_send_wr,
 		list_add_tail(&mad_send_wr->agent_list,
 			      &mad_agent_priv->send_list);
 	} else {
-		expect_mad_state(mad_send_wr, IB_MAD_STATE_WAIT_RESP);
+		expect_mad_state2(mad_send_wr, IB_MAD_STATE_WAIT_RESP,
+				  IB_MAD_STATE_QUEUED);
 		list_move_tail(&mad_send_wr->agent_list,
 			       &mad_agent_priv->send_list);
 	}
+
+	if (mad_send_wr->is_solicited_fc) {
+		if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP)
+			mad_agent_priv->sol_fc_wait_count--;
+		mad_agent_priv->sol_fc_send_count++;
+	}
 }
 
 static void handle_wait_state(struct ib_mad_send_wr_private *mad_send_wr,
@@ -1076,8 +1124,13 @@ static void handle_wait_state(struct ib_mad_send_wr_private *mad_send_wr,
 
 	expect_mad_state3(mad_send_wr, IB_MAD_STATE_SEND_START,
 			  IB_MAD_STATE_WAIT_RESP, IB_MAD_STATE_CANCELED);
-	list_del_init(&mad_send_wr->agent_list);
+	if (mad_send_wr->state == IB_MAD_STATE_SEND_START &&
+	    mad_send_wr->is_solicited_fc) {
+		mad_agent_priv->sol_fc_send_count--;
+		mad_agent_priv->sol_fc_wait_count++;
+	}
 
+	list_del_init(&mad_send_wr->agent_list);
 	delay = mad_send_wr->timeout;
 	mad_send_wr->timeout += jiffies;
 
@@ -1103,17 +1156,31 @@ static void handle_early_resp_state(struct ib_mad_send_wr_private *mad_send_wr,
 			    struct ib_mad_agent_private *mad_agent_priv)
 {
 	expect_mad_state(mad_send_wr, IB_MAD_STATE_SEND_START);
+	mad_agent_priv->sol_fc_send_count -= mad_send_wr->is_solicited_fc;
 }
 
 static void handle_canceled_state(struct ib_mad_send_wr_private *mad_send_wr,
 			 struct ib_mad_agent_private *mad_agent_priv)
 {
 	not_expect_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
+	if (mad_send_wr->is_solicited_fc) {
+		if (mad_send_wr->state == IB_MAD_STATE_SEND_START)
+			mad_agent_priv->sol_fc_send_count--;
+		else if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP)
+			mad_agent_priv->sol_fc_wait_count--;
+	}
 }
 
 static void handle_done_state(struct ib_mad_send_wr_private *mad_send_wr,
 		       struct ib_mad_agent_private *mad_agent_priv)
 {
+	if (mad_send_wr->is_solicited_fc) {
+		if (mad_send_wr->state == IB_MAD_STATE_SEND_START)
+			mad_agent_priv->sol_fc_send_count--;
+		else if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP)
+			mad_agent_priv->sol_fc_wait_count--;
+	}
+
 	list_del_init(&mad_send_wr->agent_list);
 }
 
@@ -1126,6 +1193,9 @@ void change_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
 	switch (new_state) {
 	case IB_MAD_STATE_INIT:
 		break;
+	case IB_MAD_STATE_QUEUED:
+		handle_queued_state(mad_send_wr, mad_agent_priv);
+		break;
 	case IB_MAD_STATE_SEND_START:
 		handle_send_state(mad_send_wr, mad_agent_priv);
 		break;
@@ -1148,6 +1218,43 @@ void change_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
 	mad_send_wr->state = new_state;
 }
 
+static bool is_solicited_fc_mad(struct ib_mad_send_wr_private *mad_send_wr)
+{
+	struct ib_rmpp_mad *rmpp_mad;
+	u8 mgmt_class;
+
+	if (!mad_send_wr->timeout)
+		return 0;
+
+	rmpp_mad = mad_send_wr->send_buf.mad;
+	if (mad_send_wr->mad_agent_priv->agent.rmpp_version &&
+	    (ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) & IB_MGMT_RMPP_FLAG_ACTIVE))
+		return 0;
+
+	mgmt_class =
+		((struct ib_mad_hdr *)mad_send_wr->send_buf.mad)->mgmt_class;
+	return mgmt_class == IB_MGMT_CLASS_CM ||
+	       mgmt_class == IB_MGMT_CLASS_SUBN_ADM ||
+	       mgmt_class == IB_MGMT_CLASS_SUBN_LID_ROUTED ||
+	       mgmt_class == IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE;
+}
+
+static bool mad_is_for_backlog(struct ib_mad_send_wr_private *mad_send_wr)
+{
+	struct ib_mad_agent_private *mad_agent_priv =
+		mad_send_wr->mad_agent_priv;
+
+	if (!mad_send_wr->is_solicited_fc || !mad_agent_priv->sol_fc_max)
+		return false;
+
+	if (!list_empty(&mad_agent_priv->backlog_list))
+		return true;
+
+	return mad_agent_priv->sol_fc_send_count +
+		       mad_agent_priv->sol_fc_wait_count >=
+	       mad_agent_priv->sol_fc_max;
+}
+
 /*
  * ib_post_send_mad - Posts MAD(s) to the send queue of the QP associated
  *  with the registered client
@@ -1216,6 +1323,13 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		/* Reference MAD agent until send completes */
 		refcount_inc(&mad_agent_priv->refcount);
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+		mad_send_wr->is_solicited_fc = is_solicited_fc_mad(mad_send_wr);
+		if (mad_is_for_backlog(mad_send_wr)) {
+			change_mad_state(mad_send_wr, IB_MAD_STATE_QUEUED);
+			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+			return 0;
+		}
+
 		change_mad_state(mad_send_wr, IB_MAD_STATE_SEND_START);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
@@ -1839,6 +1953,18 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
 			return (wr->state != IB_MAD_STATE_CANCELED) ? wr : NULL;
 	}
 
+	list_for_each_entry(wr, &mad_agent_priv->backlog_list, agent_list) {
+		if ((wr->tid == mad_hdr->tid) &&
+		    rcv_has_same_class(wr, wc) &&
+		    /*
+		     * Don't check GID for direct routed MADs.
+		     * These might have permissive LIDs.
+		     */
+		    (is_direct(mad_hdr->mgmt_class) ||
+		     rcv_has_same_gid(mad_agent_priv, wr, wc)))
+			return (wr->state != IB_MAD_STATE_CANCELED) ? wr : NULL;
+	}
+
 	/*
 	 * It's possible to receive the response before we've
 	 * been notified that the send has completed
@@ -1860,10 +1986,47 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
 	return NULL;
 }
 
+static void
+process_backlog_mads(struct ib_mad_agent_private *mad_agent_priv)
+{
+	struct ib_mad_send_wr_private *mad_send_wr;
+	struct ib_mad_send_wc mad_send_wc = {};
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	while (!list_empty(&mad_agent_priv->backlog_list) &&
+	       (mad_agent_priv->sol_fc_send_count +
+			mad_agent_priv->sol_fc_wait_count <
+		mad_agent_priv->sol_fc_max)) {
+		mad_send_wr = list_entry(mad_agent_priv->backlog_list.next,
+					 struct ib_mad_send_wr_private,
+					 agent_list);
+		change_mad_state(mad_send_wr, IB_MAD_STATE_SEND_START);
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+		ret = ib_send_mad(mad_send_wr);
+		if (ret) {
+			spin_lock_irqsave(&mad_agent_priv->lock, flags);
+			deref_mad_agent(mad_agent_priv);
+			change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
+			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+			mad_send_wc.send_buf = &mad_send_wr->send_buf;
+			mad_send_wc.status = IB_WC_LOC_QP_OP_ERR;
+			mad_agent_priv->agent.send_handler(
+				&mad_agent_priv->agent, &mad_send_wc);
+		}
+
+		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	}
+
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+}
+
 void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	mad_send_wr->timeout = 0;
-	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP)
+	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP ||
+	    mad_send_wr->state == IB_MAD_STATE_QUEUED)
 		change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
 	else
 		change_mad_state(mad_send_wr, IB_MAD_STATE_EARLY_RESP);
@@ -2320,11 +2483,14 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 	adjust_timeout(mad_agent_priv);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
-	if (ret == IB_RMPP_RESULT_INTERNAL)
+	if (ret == IB_RMPP_RESULT_INTERNAL) {
 		ib_rmpp_send_handler(mad_send_wc);
-	else
+	} else {
+		if (mad_send_wr->is_solicited_fc)
+			process_backlog_mads(mad_agent_priv);
 		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
 						   mad_send_wc);
+	}
 
 	/* Release reference on agent taken when sending */
 	deref_mad_agent(mad_agent_priv);
@@ -2497,14 +2663,20 @@ static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv)
 				 &mad_agent_priv->send_list, agent_list)
 		change_mad_state(mad_send_wr, IB_MAD_STATE_CANCELED);
 
-	/* Empty wait list to prevent receives from finding a request */
+	/* Empty wait & backlog list to prevent receives from finding request */
 	list_for_each_entry_safe(mad_send_wr, temp_mad_send_wr,
 				 &mad_agent_priv->wait_list, agent_list) {
 		change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
 		list_add_tail(&mad_send_wr->agent_list, &cancel_list);
 	}
-	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
+	list_for_each_entry_safe(mad_send_wr, temp_mad_send_wr,
+				 &mad_agent_priv->backlog_list, agent_list) {
+		change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
+		list_add_tail(&mad_send_wr->agent_list, &cancel_list);
+	}
+
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 	/* Report all cancelled requests */
 	clear_mad_error_list(&cancel_list, IB_WC_WR_FLUSH_ERR, mad_agent_priv);
 }
@@ -2528,6 +2700,13 @@ find_send_wr(struct ib_mad_agent_private *mad_agent_priv,
 		    &mad_send_wr->send_buf == send_buf)
 			return mad_send_wr;
 	}
+
+	list_for_each_entry(mad_send_wr, &mad_agent_priv->backlog_list,
+			    agent_list) {
+		if (&mad_send_wr->send_buf == send_buf)
+			return mad_send_wr;
+	}
+
 	return NULL;
 }
 
@@ -2550,8 +2729,9 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 		return -EINVAL;
 	}
 
-	active = (mad_send_wr->state == IB_MAD_STATE_SEND_START ||
-		  mad_send_wr->state == IB_MAD_STATE_EARLY_RESP);
+	active = ((mad_send_wr->state == IB_MAD_STATE_SEND_START) ||
+		  (mad_send_wr->state == IB_MAD_STATE_EARLY_RESP) ||
+		  (mad_send_wr->state == IB_MAD_STATE_QUEUED && timeout_ms));
 	if (!timeout_ms)
 		change_mad_state(mad_send_wr, IB_MAD_STATE_CANCELED);
 
@@ -2665,6 +2845,11 @@ static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
 	mad_send_wr->send_buf.retries++;
 
 	mad_send_wr->timeout = msecs_to_jiffies(mad_send_wr->send_buf.timeout_ms);
+	if (mad_send_wr->is_solicited_fc &&
+	    !list_empty(&mad_send_wr->mad_agent_priv->backlog_list)) {
+		change_mad_state(mad_send_wr, IB_MAD_STATE_QUEUED);
+		return 0;
+	}
 
 	if (ib_mad_kernel_rmpp_agent(&mad_send_wr->mad_agent_priv->agent)) {
 		ret = ib_retry_rmpp(mad_send_wr);
@@ -2730,6 +2915,7 @@ static void timeout_sends(struct work_struct *work)
 	}
 
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+	process_backlog_mads(mad_agent_priv);
 	clear_mad_error_list(&timeout_list, IB_WC_RESP_TIMEOUT_ERR,
 			     mad_agent_priv);
 	clear_mad_error_list(&cancel_list, IB_WC_WR_FLUSH_ERR, mad_agent_priv);
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 3534be20496d..f444357d33f4 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -95,12 +95,16 @@ struct ib_mad_agent_private {
 
 	spinlock_t lock;
 	struct list_head send_list;
+	unsigned int sol_fc_send_count;
 	struct list_head wait_list;
+	unsigned int sol_fc_wait_count;
 	struct delayed_work timed_work;
 	unsigned long timeout;
 	struct list_head local_list;
 	struct work_struct local_work;
 	struct list_head rmpp_list;
+	unsigned int sol_fc_max;
+	struct list_head backlog_list;
 
 	refcount_t refcount;
 	union {
@@ -120,6 +124,8 @@ struct ib_mad_snoop_private {
 enum ib_mad_state {
 	/* MAD is in the making and is not yet in any list */
 	IB_MAD_STATE_INIT,
+	/* MAD is in backlog list */
+	IB_MAD_STATE_QUEUED,
 	/*
 	 * MAD was sent to the QP and is waiting for completion
 	 * notification in send list.
@@ -166,6 +172,9 @@ struct ib_mad_send_wr_private {
 	int pad;
 
 	enum ib_mad_state state;
+
+	/* Solicited MAD flow control */
+	bool is_solicited_fc;
 };
 
 static inline void expect_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
@@ -175,6 +184,15 @@ static inline void expect_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
 		WARN_ON(mad_send_wr->state != expected_state);
 }
 
+static inline void expect_mad_state2(struct ib_mad_send_wr_private *mad_send_wr,
+				     enum ib_mad_state expected_state1,
+				     enum ib_mad_state expected_state2)
+{
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		WARN_ON(mad_send_wr->state != expected_state1 &&
+			mad_send_wr->state != expected_state2);
+}
+
 static inline void expect_mad_state3(struct ib_mad_send_wr_private *mad_send_wr,
 				     enum ib_mad_state expected_state1,
 				     enum ib_mad_state expected_state2,
-- 
2.50.0


