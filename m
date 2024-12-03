Return-Path: <linux-rdma+bounces-6199-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67DB9E205A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 15:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E768B44728
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95E1F12F7;
	Tue,  3 Dec 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOnRevO4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B4E1EE006
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233963; cv=none; b=fX2MNgEqWzq502dluK+jEs+kLKrHstTcIGGQTsFhpI0NBMpN5YGlWwJUNGJFNTkcShc6Z62DKkbZ1KvufVLIVlqvWP9Rkl6Zh6NjHoHJvOv9FuvVw4Z3UZVm+CkIZAkVPEEffQ8e51Ni6cry89ayAWDUp7abKaSsxvhl7+D2zPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233963; c=relaxed/simple;
	bh=Ri2rvFH3uGX2uhGXx0iN9W2u8dudF6PqldI5cSMI3uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USUms6PbRuV5WEz8a2Dmaz8sE0u/jOpZuNaQtni3PvjaMzVLZHG/LdTfyjdIAyZWjg/nO4m+L2fHhNUws1CotqAOQv1MCOLcwkcQcQJcBVyNhj1eJRIPWL7zRSpXojhQgkhU+rkfexEnhDRtUXe9N2fiNrbn4Q6sTlv9okOPaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOnRevO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E72C4CECF;
	Tue,  3 Dec 2024 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733233960;
	bh=Ri2rvFH3uGX2uhGXx0iN9W2u8dudF6PqldI5cSMI3uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOnRevO4JlO7043QV41+350gG5Q08TuOD7aZU3GbJVGpZKLnlBoSMRXhQKIjZD3Ia
	 eCx4z/I3kjuYUkLTvYPkbc1zz5W0JUwcDSie/OaXQ4o5SrTBaBAiBYS+tmIHktAcjN
	 subj8y8dSrxOp4bK8HrqOi7EF6DHQlzVcTOMczeW1GMlhpj+xFp5QTloPYl8+ArSey
	 3zC5up4zhOiRazzc4hUjw60TbPsvBF9mCQRLcXApRfZtUGkp3tSNIDwgH3Vqk7wJJw
	 BJlTSlZlIA3oowmP4mTt59IHBgPHye41nO6m4dsJkeFi/8oevbHiVxKuKnkV3Lq++t
	 i2QrD2M9yJsEQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next 3/3] IB/mad: Add flow control for solicited MADs
Date: Tue,  3 Dec 2024 15:52:23 +0200
Message-ID: <edea14a9da803479b986ba3a27058390891de21e.1733233636.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733233636.git.leonro@nvidia.com>
References: <cover.1733233636.git.leonro@nvidia.com>
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
requests (MADs that are on agent send list or wait list). The number of
outstanding send WRs will be limited by a fraction of the RQ size, and
any new send WR that exceeds that limit will be held in a backlog list.
Backlog MADs will be forwarded to agent send list only once the total
number of outstanding send WRs falls below the limit.

For this purpose, a new state is introduced:
 * IB_MAD_STATE_QUEUED - MAD is in backlog list

Unsolicited MADs, RMPP MADs and MADs which are not SA, SMP or CM are
not subject to this flow control mechanism and will not be affected by
this change.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/infiniband/core/mad.c      | 171 +++++++++++++++++++++++++++--
 drivers/infiniband/core/mad_priv.h |   8 ++
 2 files changed, 171 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index e16bc396f6bc..86e846b12e2f 100644
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
@@ -392,12 +415,15 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 	INIT_LIST_HEAD(&mad_agent_priv->send_list);
 	INIT_LIST_HEAD(&mad_agent_priv->wait_list);
 	INIT_LIST_HEAD(&mad_agent_priv->rmpp_list);
+	INIT_LIST_HEAD(&mad_agent_priv->backlog_list);
 	INIT_DELAYED_WORK(&mad_agent_priv->timed_work, timeout_sends);
 	INIT_LIST_HEAD(&mad_agent_priv->local_list);
 	INIT_WORK(&mad_agent_priv->local_work, local_completions);
 	refcount_set(&mad_agent_priv->refcount, 1);
 	init_completion(&mad_agent_priv->comp);
 
+	mad_agent_priv->sol_fc_max =
+		get_sol_fc_max_outstanding(mad_reg_req);
 	ret2 = ib_mad_agent_security_setup(&mad_agent_priv->agent, qp_type);
 	if (ret2) {
 		ret = ERR_PTR(ret2);
@@ -1054,6 +1080,43 @@ int ib_send_mad(struct ib_mad_send_wr_private *mad_send_wr)
 	return ret;
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
@@ -1117,14 +1180,26 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		mad_send_wr->max_retries = send_buf->retries;
 		mad_send_wr->retries_left = send_buf->retries;
 		send_buf->retries = 0;
-		mad_send_wr->state = IB_MAD_STATE_SEND_START;
 		mad_send_wr->status = IB_WC_SUCCESS;
 
 		/* Reference MAD agent until send completes */
 		refcount_inc(&mad_agent_priv->refcount);
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+
+		mad_send_wr->is_solicited_fc = is_solicited_fc_mad(mad_send_wr);
+		if (mad_is_for_backlog(mad_send_wr)) {
+			list_add_tail(&mad_send_wr->agent_list,
+				      &mad_agent_priv->backlog_list);
+			mad_send_wr->state = IB_MAD_STATE_QUEUED;
+			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+			return 0;
+		}
+
 		list_add_tail(&mad_send_wr->agent_list,
 			      &mad_agent_priv->send_list);
+		mad_send_wr->state = IB_MAD_STATE_SEND_START;
+		mad_agent_priv->sol_fc_send_count +=
+			mad_send_wr->is_solicited_fc;
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 		if (ib_mad_kernel_rmpp_agent(&mad_agent_priv->agent)) {
@@ -1136,6 +1211,8 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		if (ret < 0) {
 			/* Fail send request */
 			spin_lock_irqsave(&mad_agent_priv->lock, flags);
+			mad_agent_priv->sol_fc_send_count -=
+				mad_send_wr->is_solicited_fc;
 			list_del(&mad_send_wr->agent_list);
 			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 			deref_mad_agent(mad_agent_priv);
@@ -1768,14 +1845,59 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
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
+		list_move_tail(&mad_send_wr->agent_list,
+			       &mad_agent_priv->send_list);
+		mad_agent_priv->sol_fc_send_count++;
+		mad_send_wr->state = IB_MAD_STATE_SEND_START;
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+		ret = ib_send_mad(mad_send_wr);
+		if (!ret)
+			return;
+
+		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+		deref_mad_agent(mad_agent_priv);
+		mad_agent_priv->sol_fc_send_count--;
+		list_del(&mad_send_wr->agent_list);
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
 	list_del(&mad_send_wr->agent_list);
-	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP)
+	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP) {
+		mad_send_wr->mad_agent_priv->sol_fc_wait_count -=
+			mad_send_wr->is_solicited_fc;
 		mad_send_wr->state = IB_MAD_STATE_DONE;
-	else
+	} else {
+		mad_send_wr->mad_agent_priv->sol_fc_send_count -=
+			mad_send_wr->is_solicited_fc;
 		mad_send_wr->state = IB_MAD_STATE_EARLY_RESP;
+	}
 }
 
 static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
@@ -2177,7 +2299,7 @@ static void wait_for_response(struct ib_mad_send_wr_private *mad_send_wr)
 	unsigned long delay;
 
 	mad_agent_priv = mad_send_wr->mad_agent_priv;
-	list_del(&mad_send_wr->agent_list);
+	list_del_init(&mad_send_wr->agent_list);
 
 	delay = mad_send_wr->timeout;
 	mad_send_wr->timeout += jiffies;
@@ -2195,6 +2317,16 @@ static void wait_for_response(struct ib_mad_send_wr_private *mad_send_wr)
 		list_item = &mad_agent_priv->wait_list;
 	}
 
+	if (mad_send_wr->state == IB_MAD_STATE_SEND_START) {
+		if (mad_send_wr->is_solicited_fc) {
+			mad_agent_priv->sol_fc_send_count--;
+			mad_agent_priv->sol_fc_wait_count++;
+		}
+	} else if (mad_send_wr->state == IB_MAD_STATE_QUEUED) {
+		mad_agent_priv->sol_fc_wait_count +=
+			mad_send_wr->is_solicited_fc;
+	}
+
 	mad_send_wr->state = IB_MAD_STATE_WAIT_RESP;
 	list_add(&mad_send_wr->agent_list, list_item);
 
@@ -2246,19 +2378,25 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 	}
 
 	/* Remove send from MAD agent and notify client of completion */
-	if (mad_send_wr->state == IB_MAD_STATE_SEND_START)
+	if (mad_send_wr->state == IB_MAD_STATE_SEND_START) {
 		list_del(&mad_send_wr->agent_list);
+		mad_agent_priv->sol_fc_send_count -=
+			mad_send_wr->is_solicited_fc;
+	}
 
 	adjust_timeout(mad_agent_priv);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 	if (mad_send_wr->status != IB_WC_SUCCESS)
 		mad_send_wc->status = mad_send_wr->status;
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
@@ -2417,6 +2555,8 @@ static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv)
 
 	/* Empty wait list to prevent receives from finding a request */
 	list_splice_init(&mad_agent_priv->wait_list, &cancel_list);
+	mad_agent_priv->sol_fc_wait_count = 0;
+	list_splice_tail_init(&mad_agent_priv->backlog_list, &cancel_list);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 	/* Report all cancelled requests */
@@ -2452,6 +2592,13 @@ find_send_wr(struct ib_mad_agent_private *mad_agent_priv,
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
 
@@ -2477,7 +2624,8 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 		mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
 
 	mad_send_wr->send_buf.timeout_ms = timeout_ms;
-	if (mad_send_wr->state == IB_MAD_STATE_SEND_START)
+	if (mad_send_wr->state == IB_MAD_STATE_SEND_START ||
+	    (mad_send_wr->state == IB_MAD_STATE_QUEUED && timeout_ms))
 		mad_send_wr->timeout = msecs_to_jiffies(timeout_ms);
 	else
 		ib_reset_mad_timeout(mad_send_wr, timeout_ms);
@@ -2607,7 +2755,10 @@ static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
 		mad_send_wr->state = IB_MAD_STATE_SEND_START;
 		list_add_tail(&mad_send_wr->agent_list,
 			      &mad_send_wr->mad_agent_priv->send_list);
+		mad_send_wr->mad_agent_priv->sol_fc_send_count +=
+			mad_send_wr->is_solicited_fc;
 	}
+
 	return ret;
 }
 
@@ -2641,6 +2792,8 @@ static void timeout_sends(struct work_struct *work)
 		}
 
 		list_del_init(&mad_send_wr->agent_list);
+		mad_agent_priv->sol_fc_wait_count -=
+			mad_send_wr->is_solicited_fc;
 		if (mad_send_wr->status == IB_WC_SUCCESS &&
 		    !retry_send(mad_send_wr))
 			continue;
@@ -2655,6 +2808,8 @@ static void timeout_sends(struct work_struct *work)
 		else
 			mad_send_wc.status = mad_send_wr->status;
 		mad_send_wc.send_buf = &mad_send_wr->send_buf;
+		if (mad_send_wr->is_solicited_fc)
+			process_mad_from_backlog(mad_agent_priv);
 		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
 						   &mad_send_wc);
 		deref_mad_agent(mad_agent_priv);
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 4af63c1664c2..b2a12a82a62d 100644
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
@@ -118,6 +122,7 @@ struct ib_mad_snoop_private {
 };
 
 enum ib_mad_state {
+	IB_MAD_STATE_QUEUED,
 	IB_MAD_STATE_SEND_START,
 	IB_MAD_STATE_WAIT_RESP,
 	IB_MAD_STATE_EARLY_RESP,
@@ -150,6 +155,9 @@ struct ib_mad_send_wr_private {
 	int pad;
 
 	enum ib_mad_state state;
+
+	/* Solicited MAD flow control */
+	bool is_solicited_fc;
 };
 
 struct ib_mad_local_private {
-- 
2.47.0


