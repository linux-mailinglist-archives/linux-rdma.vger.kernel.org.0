Return-Path: <linux-rdma+bounces-6886-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C39A041A2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 15:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BFF7A29E2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B071F1F4293;
	Tue,  7 Jan 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqono/gT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2901F892C
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258554; cv=none; b=bk1AU42w7OMJ4/yNVhs1lZbEMpuwVKVTn3qojKJSFv+kgSaNiJCX1T1439+2+TBN8B0Bo3BPDdjM7EfFG4DpPcqSZgZG+gtCGDmdmxsIxBu4St52gXWYlZI53OEvUccKHVjS29W9OCesXA6HQdNUqhqPtX3g4EW5tP2LaXz8dxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258554; c=relaxed/simple;
	bh=Q3TJALiG9qSCnsn6oAxHX3sChs8fkYJg+koi62EjVGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKTLqMxK9dUhCVc/m6XUhuYN1r/PjVSCvZzsEpHTWKcmN6FgwSJdazN4GD9Qd/4yLXX6itF7WNr5uL64grm5OO3HbU1g6jDXYCeF2rGAQn+NVq1DIGgdq4oFVahBzangSuoxVtyPOvP8BGyOhqk/D/8qty6xmYFDH/RkXZZg3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqono/gT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEA0C4CED6;
	Tue,  7 Jan 2025 14:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736258554;
	bh=Q3TJALiG9qSCnsn6oAxHX3sChs8fkYJg+koi62EjVGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqono/gTSo7wDjbYdYkZd1teDnMkoV6hLmFVCA/cJhpFm3HrFMVLaOBWYz/bup+jp
	 F8YWJ1yWu+rkwIdZyCTN2TcMXSSvRtVqCbj38GX+7PDSdH/6hRAQGbYucfvUwLkUUG
	 ahjrSh7qcJxnsVFzGqIdeilsViIV+xaoPdlJwf8l6oGJAF3Mf4IeeSqiRzV7/6Yg/N
	 Bl24LqPyQFrUzIraEqbOv5mbXwJs5qr7msYKC2RyyOzMY5yD309DvFmUD+MGtOvRxR
	 vPu5TPRlIdNAICgvu+7k4vnmpK61RG5EulgQRr9o1wy2+snvAeuQewauVZdaFf9dQM
	 YZ8rmA5Xkvt7Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next v1 2/2] IB/mad: Add flow control for solicited MADs
Date: Tue,  7 Jan 2025 16:02:13 +0200
Message-ID: <da2bb4a27cfd47ec0dd23e24d82e4a364b8b5b4d.1736258116.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736258116.git.leonro@nvidia.com>
References: <cover.1736258116.git.leonro@nvidia.com>
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
requests.

Therefore, keep track of the total outstanding solicited MAD work
requests in send or wait list. The number of outstanding send WRs
will be limited by a fraction of the RQ size, and any new send WR
that exceeds that limit will be held in a backlog list.
Backlog MADs will be forwarded to agent send list only once the total
number of outstanding send WRs falls below the limit.

Unsolicited MADs, RMPP MADs and MADs which are not SA, SMP or CM are
not subject to this flow control mechanism and will not be affected by
this change.

For this purpose, a new state is introduced:
- 'IB_MAD_STATE_QUEUED': MAD is in backlog list

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c      | 173 +++++++++++++++++++++++++++--
 drivers/infiniband/core/mad_priv.h |  17 ++-
 2 files changed, 182 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 49da1d246f72a..3dc31640f53af 100644
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
@@ -1054,6 +1081,13 @@ int ib_send_mad(struct ib_mad_send_wr_private *mad_send_wr)
 	return ret;
 }
 
+static void handle_queued_state(struct ib_mad_send_wr_private *mad_send_wr,
+		       struct ib_mad_agent_private *mad_agent_priv)
+{
+	NOT_EXPECT_MAD_STATE(mad_send_wr, 0);
+	list_add_tail(&mad_send_wr->agent_list, &mad_agent_priv->backlog_list);
+}
+
 static void handle_send_state(struct ib_mad_send_wr_private *mad_send_wr,
 		       struct ib_mad_agent_private *mad_agent_priv)
 {
@@ -1061,10 +1095,17 @@ static void handle_send_state(struct ib_mad_send_wr_private *mad_send_wr,
 		list_add_tail(&mad_send_wr->agent_list,
 			      &mad_agent_priv->send_list);
 	} else {
-		EXPECT_MAD_STATE(mad_send_wr, IB_MAD_STATE_WAIT_RESP);
+		EXPECT_MAD_STATE2(mad_send_wr, IB_MAD_STATE_QUEUED,
+				  IB_MAD_STATE_WAIT_RESP);
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
@@ -1076,8 +1117,13 @@ static void handle_wait_state(struct ib_mad_send_wr_private *mad_send_wr,
 
 	EXPECT_MAD_STATE3(mad_send_wr, IB_MAD_STATE_SEND_START,
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
 
@@ -1103,17 +1149,32 @@ static void handle_early_resp_state(struct ib_mad_send_wr_private *mad_send_wr,
 			    struct ib_mad_agent_private *mad_agent_priv)
 {
 	EXPECT_MAD_STATE(mad_send_wr, IB_MAD_STATE_SEND_START);
+	mad_agent_priv->sol_fc_send_count -= mad_send_wr->is_solicited_fc;
 }
 
 static void handle_canceled_state(struct ib_mad_send_wr_private *mad_send_wr,
 			 struct ib_mad_agent_private *mad_agent_priv)
 {
 	NOT_EXPECT_MAD_STATE(mad_send_wr, IB_MAD_STATE_DONE);
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
+	NOT_EXPECT_MAD_STATE(mad_send_wr, IB_MAD_STATE_QUEUED);
+	if (mad_send_wr->is_solicited_fc) {
+		if (mad_send_wr->state == IB_MAD_STATE_SEND_START)
+			mad_agent_priv->sol_fc_send_count--;
+		else if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP)
+			mad_agent_priv->sol_fc_wait_count--;
+	}
+
 	list_del_init(&mad_send_wr->agent_list);
 }
 
@@ -1124,6 +1185,9 @@ void change_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
 		mad_send_wr->mad_agent_priv;
 
 	switch (new_state) {
+	case IB_MAD_STATE_QUEUED:
+		handle_queued_state(mad_send_wr, mad_agent_priv);
+		break;
 	case IB_MAD_STATE_SEND_START:
 		handle_send_state(mad_send_wr, mad_agent_priv);
 		break;
@@ -1146,6 +1210,43 @@ void change_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
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
@@ -1214,6 +1315,13 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
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
 
@@ -1858,6 +1966,42 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
 	return NULL;
 }
 
+static void
+process_mad_from_backlog(struct ib_mad_agent_private *mad_agent_priv)
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
+		if (!ret)
+			return;
+
+		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+		deref_mad_agent(mad_agent_priv);
+		change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+		mad_send_wc.send_buf = &mad_send_wr->send_buf;
+		mad_send_wc.status = IB_WC_LOC_QP_OP_ERR;
+		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
+						   &mad_send_wc);
+		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	}
+
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+}
+
 void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	mad_send_wr->timeout = 0;
@@ -2318,11 +2462,14 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 	adjust_timeout(mad_agent_priv);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
-	if (ret == IB_RMPP_RESULT_INTERNAL)
+	if (ret == IB_RMPP_RESULT_INTERNAL) {
 		ib_rmpp_send_handler(mad_send_wc);
-	else
+	} else {
+		if (mad_send_wr->is_solicited_fc)
+			process_mad_from_backlog(mad_agent_priv);
 		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
 						   mad_send_wc);
+	}
 
 	/* Release reference on agent taken when sending */
 	deref_mad_agent(mad_agent_priv);
@@ -2480,6 +2627,8 @@ static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv)
 
 	/* Empty wait list to prevent receives from finding a request */
 	list_splice_init(&mad_agent_priv->wait_list, &cancel_list);
+	mad_agent_priv->sol_fc_wait_count = 0;
+	list_splice_tail_init(&mad_agent_priv->backlog_list, &cancel_list);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 	/* Report all cancelled requests */
@@ -2515,6 +2664,13 @@ find_send_wr(struct ib_mad_agent_private *mad_agent_priv,
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
 
@@ -2537,8 +2693,9 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 		return -EINVAL;
 	}
 
-	active = (mad_send_wr->state == IB_MAD_STATE_SEND_START ||
-		  mad_send_wr->state == IB_MAD_STATE_EARLY_RESP);
+	active = ((mad_send_wr->state == IB_MAD_STATE_SEND_START) ||
+		  (mad_send_wr->state == IB_MAD_STATE_EARLY_RESP) ||
+		  (mad_send_wr->state == IB_MAD_STATE_QUEUED && timeout_ms));
 	if (!timeout_ms)
 		change_mad_state(mad_send_wr, IB_MAD_STATE_CANCELED);
 
@@ -2687,6 +2844,8 @@ static void clear_mad_error_list(struct list_head *list,
 
 	list_for_each_entry_safe(mad_send_wr, n, list, agent_list) {
 		mad_send_wc.send_buf = &mad_send_wr->send_buf;
+		if (mad_send_wr->is_solicited_fc)
+			process_mad_from_backlog(mad_agent_priv);
 		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
 						   &mad_send_wc);
 		deref_mad_agent(mad_agent_priv);
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index bfcf0a62fdd65..52655f24e16d4 100644
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
@@ -118,11 +122,13 @@ struct ib_mad_snoop_private {
 };
 
 enum ib_mad_state {
+	/* MAD is in backlog list */
+	IB_MAD_STATE_QUEUED = 1,
 	/*
 	 * MAD was sent to the QP and is waiting for completion
 	 * notification in send list.
 	 */
-	IB_MAD_STATE_SEND_START = 1,
+	IB_MAD_STATE_SEND_START,
 	/*
 	 * MAD send completed successfully, waiting for a response
 	 * in wait list.
@@ -144,6 +150,12 @@ enum ib_mad_state {
 		if (IS_ENABLED(CONFIG_LOCKDEP))                        \
 			WARN_ON(mad_send_wr->state != expected_state); \
 	}
+#define EXPECT_MAD_STATE2(mad_send_wr, expected_state1, expected_state2) \
+	{                                                                \
+		if (IS_ENABLED(CONFIG_LOCKDEP))                          \
+			WARN_ON(mad_send_wr->state != expected_state1 && \
+				mad_send_wr->state != expected_state2);  \
+	}
 #define EXPECT_MAD_STATE3(mad_send_wr, expected_state1, expected_state2, \
 			  expected_state3)                               \
 	{                                                                \
@@ -183,6 +195,9 @@ struct ib_mad_send_wr_private {
 	int pad;
 
 	enum ib_mad_state state;
+
+	/* Solicited MAD flow control */
+	bool is_solicited_fc;
 };
 
 struct ib_mad_local_private {
-- 
2.47.1


