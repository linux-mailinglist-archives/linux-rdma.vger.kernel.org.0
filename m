Return-Path: <linux-rdma+bounces-12695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9F3B24719
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B89173ADC
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 10:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37202EBDEC;
	Wed, 13 Aug 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNi+iQjB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C12D9EDC;
	Wed, 13 Aug 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080539; cv=none; b=gd0DgOW/z9Lk39keGhPWX/hvLhGjFe9PK1YpcefM8u97wcNb7a4hK4T1t31lUQvrCIF2Uiw/1Y1aJh5ENiGtD5Ep7+H0oYCecVc/s6MT8pgky2kdPm7hcyaHCzmVQeTAR82aiOhf8GiDlnPDHYLfH/cJRdYHnAL9ds0r5/KdRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080539; c=relaxed/simple;
	bh=/Jd0bfDJ7l3BpOXiVzLYeQaWfngBKNKjbgKJx7dFa5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lOq2LOCmFi81YeT161gseYSCYbpSREhLrsQyoCPi1mKRRPmHcpO/dXDU8byhg+te9JFxwvM7NE0b80dROgdJMmTcRMyt+ufgFR7haLAZDH240V00lSeK9g9jG2NR8kzK+oV/MiouDpe7hvF0+nH1ysp0B+VfRhwXEgb4u4utOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNi+iQjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBBBC4CEF6;
	Wed, 13 Aug 2025 10:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755080539;
	bh=/Jd0bfDJ7l3BpOXiVzLYeQaWfngBKNKjbgKJx7dFa5E=;
	h=Date:From:To:Cc:Subject:From;
	b=PNi+iQjBbKSC0mx4W6rJeptKV09iQH4X6bl4tIhea1FYORX4TqJiBgt4dQ0pHastW
	 dOWmOXFILQrjzIDLIQgBKGSR4FWjIYIl3dceDPUylcAR0meWgp36rh6cH2ZRdz1A3i
	 dt7HKCqL9U7g/5bKDGMlRUEfNTrF6CddfezyIuD9MIcwfiOT5qvzR2BEzTVO7RTdCB
	 KCYargVPpMRFEUnDXWYl5tNqdZ+f40ZD/5QepW/6NOsjvXtd3mqtF8yrWRxJ2B23+J
	 QEgMBJMn/Oeq65mWZgStjRuD3Uk0XOzI9iOW/EX1Tks4mB11bx9TFGAyYiC4GANbbt
	 qHiCuSoSqYRlQ==
Date: Wed, 13 Aug 2025 19:22:14 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] RDMA/cm: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <aJxnVjItIEW4iYAv@kspp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

We have a flexible `struct cm_work` in the top of `struct
cm_timewait_info`, but this struct don't even need the flexible
part.

So, we add `struct cm_work_hdr`, that will contain everything
except the flexible array and use this one as the type for member
`work` in `struct cm_timewait_info`, and refactor the rest of the
code accordingly.

Also, add a static_assert() to ensure no member is ever added
outside `struct cm_work_hdr` in `struct cm_work`.

So, with these changes, fix the following warning:
drivers/infiniband/core/cm.c:196:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use new `struct cm_work_hdr` instead of struct_group_tagged()

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZgHdZ15cQ7MIHsGL@neat/

 drivers/infiniband/core/cm.c | 236 ++++++++++++++++++-----------------
 1 file changed, 121 insertions(+), 115 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 92678e438ff4..a0f3dfd03c74 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -184,7 +184,7 @@ struct cm_av {
 	u8 timeout;
 };
 
-struct cm_work {
+struct cm_work_hdr {
 	struct delayed_work work;
 	struct list_head list;
 	struct cm_port *port;
@@ -192,11 +192,17 @@ struct cm_work {
 	__be32 local_id;			/* Established / timewait */
 	__be32 remote_id;
 	struct ib_cm_event cm_event;
+};
+
+struct cm_work {
+	struct cm_work_hdr hdr;
 	struct sa_path_rec path[];
 };
+static_assert(offsetof(struct cm_work, path) == sizeof(struct cm_work_hdr),
+	      "struct member likely outside of struct cm_work_hdr");
 
 struct cm_timewait_info {
-	struct cm_work work;
+	struct cm_work_hdr work;
 	struct list_head list;
 	struct rb_node remote_qp_node;
 	struct rb_node remote_id_node;
@@ -891,15 +897,15 @@ static struct cm_work *cm_dequeue_work(struct cm_id_private *cm_id_priv)
 	if (list_empty(&cm_id_priv->work_list))
 		return NULL;
 
-	work = list_entry(cm_id_priv->work_list.next, struct cm_work, list);
-	list_del(&work->list);
+	work = list_entry(cm_id_priv->work_list.next, struct cm_work, hdr.list);
+	list_del(&work->hdr.list);
 	return work;
 }
 
 static void cm_free_work(struct cm_work *work)
 {
-	if (work->mad_recv_wc)
-		ib_free_recv_mad(work->mad_recv_wc);
+	if (work->hdr.mad_recv_wc)
+		ib_free_recv_mad(work->hdr.mad_recv_wc);
 	kfree(work);
 }
 
@@ -918,7 +924,7 @@ static void cm_queue_work_unlock(struct cm_id_private *cm_id_priv,
 	 */
 	immediate = atomic_inc_and_test(&cm_id_priv->work_count);
 	if (!immediate) {
-		list_add_tail(&work->list, &cm_id_priv->work_list);
+		list_add_tail(&work->hdr.list, &cm_id_priv->work_list);
 		/*
 		 * This routine always consumes incoming reference. Once queued
 		 * to the work_list then a reference is held by the thread
@@ -1771,9 +1777,9 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 
 static u16 cm_get_bth_pkey(struct cm_work *work)
 {
-	struct ib_device *ib_dev = work->port->cm_dev->ib_device;
-	u32 port_num = work->port->port_num;
-	u16 pkey_index = work->mad_recv_wc->wc->pkey_index;
+	struct ib_device *ib_dev = work->hdr.port->cm_dev->ib_device;
+	u32 port_num = work->hdr.port->port_num;
+	u16 pkey_index = work->hdr.mad_recv_wc->wc->pkey_index;
 	u16 pkey;
 	int ret;
 
@@ -1799,8 +1805,8 @@ static u16 cm_get_bth_pkey(struct cm_work *work)
 static void cm_opa_to_ib_sgid(struct cm_work *work,
 			      struct sa_path_rec *path)
 {
-	struct ib_device *dev = work->port->cm_dev->ib_device;
-	u32 port_num = work->port->port_num;
+	struct ib_device *dev = work->hdr.port->cm_dev->ib_device;
+	u32 port_num = work->hdr.port->port_num;
 
 	if (rdma_cap_opa_ah(dev, port_num) &&
 	    (ib_is_opa_gid(&path->sgid))) {
@@ -1823,8 +1829,8 @@ static void cm_format_req_event(struct cm_work *work,
 	struct cm_req_msg *req_msg;
 	struct ib_cm_req_event_param *param;
 
-	req_msg = (struct cm_req_msg *)work->mad_recv_wc->recv_buf.mad;
-	param = &work->cm_event.param.req_rcvd;
+	req_msg = (struct cm_req_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
+	param = &work->hdr.cm_event.param.req_rcvd;
 	param->listen_id = listen_id;
 	param->bth_pkey = cm_get_bth_pkey(work);
 	param->port = cm_id_priv->av.port->port_num;
@@ -1856,7 +1862,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->ece.vendor_id = IBA_GET(CM_REQ_VENDOR_ID, req_msg);
 	param->ece.attr_mod = be32_to_cpu(req_msg->hdr.attr_mod);
 
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_REQ_PRIVATE_DATA, req_msg);
 }
 
@@ -1866,7 +1872,7 @@ static void cm_process_work(struct cm_id_private *cm_id_priv,
 	int ret;
 
 	/* We will typically only have the current event to report. */
-	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, &work->cm_event);
+	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, &work->hdr.cm_event);
 	cm_free_work(work);
 
 	while (!ret && !atomic_add_negative(-1, &cm_id_priv->work_count)) {
@@ -1877,7 +1883,7 @@ static void cm_process_work(struct cm_id_private *cm_id_priv,
 			return;
 
 		ret = cm_id_priv->id.cm_handler(&cm_id_priv->id,
-						&work->cm_event);
+						&work->hdr.cm_event);
 		cm_free_work(work);
 	}
 	cm_deref_id(cm_id_priv);
@@ -1957,7 +1963,7 @@ static void cm_dup_req_handler(struct cm_work *work,
 	int ret;
 
 	atomic_long_inc(
-		&work->port->counters[CM_RECV_DUPLICATES][CM_REQ_COUNTER]);
+		&work->hdr.port->counters[CM_RECV_DUPLICATES][CM_REQ_COUNTER]);
 
 	/* Quick state check to discard duplicate REQs. */
 	spin_lock_irq(&cm_id_priv->lock);
@@ -1967,7 +1973,7 @@ static void cm_dup_req_handler(struct cm_work *work,
 	}
 	spin_unlock_irq(&cm_id_priv->lock);
 
-	ret = cm_alloc_response_msg(work->port, work->mad_recv_wc, true, &msg);
+	ret = cm_alloc_response_msg(work->hdr.port, work->hdr.mad_recv_wc, true, &msg);
 	if (ret)
 		return;
 
@@ -2006,7 +2012,7 @@ static struct cm_id_private *cm_match_req(struct cm_work *work,
 	struct cm_timewait_info *timewait_info;
 	struct cm_req_msg *req_msg;
 
-	req_msg = (struct cm_req_msg *)work->mad_recv_wc->recv_buf.mad;
+	req_msg = (struct cm_req_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
 
 	/* Check for possible duplicate REQ. */
 	spin_lock_irq(&cm.lock);
@@ -2030,7 +2036,7 @@ static struct cm_id_private *cm_match_req(struct cm_work *work,
 					   timewait_info->work.remote_id);
 
 		spin_unlock_irq(&cm.lock);
-		cm_issue_rej(work->port, work->mad_recv_wc,
+		cm_issue_rej(work->hdr.port, work->hdr.mad_recv_wc,
 			     IB_CM_REJ_STALE_CONN, CM_MSG_RESPONSE_REQ,
 			     NULL, 0);
 		if (cur_cm_id_priv) {
@@ -2047,7 +2053,7 @@ static struct cm_id_private *cm_match_req(struct cm_work *work,
 	if (!listen_cm_id_priv) {
 		cm_remove_remote(cm_id_priv);
 		spin_unlock_irq(&cm.lock);
-		cm_issue_rej(work->port, work->mad_recv_wc,
+		cm_issue_rej(work->hdr.port, work->hdr.mad_recv_wc,
 			     IB_CM_REJ_INVALID_SERVICE_ID, CM_MSG_RESPONSE_REQ,
 			     NULL, 0);
 		return NULL;
@@ -2100,10 +2106,10 @@ static int cm_req_handler(struct cm_work *work)
 	const struct ib_gid_attr *gid_attr;
 	int ret;
 
-	req_msg = (struct cm_req_msg *)work->mad_recv_wc->recv_buf.mad;
+	req_msg = (struct cm_req_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
 
 	cm_id_priv =
-		cm_alloc_id_priv(work->port->cm_dev->ib_device, NULL, NULL);
+		cm_alloc_id_priv(work->hdr.port->cm_dev->ib_device, NULL, NULL);
 	if (IS_ERR(cm_id_priv))
 		return PTR_ERR(cm_id_priv);
 
@@ -2128,8 +2134,8 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
 	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
 
-	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
-				      work->mad_recv_wc->recv_buf.grh,
+	ret = cm_init_av_for_response(work->hdr.port, work->hdr.mad_recv_wc->wc,
+				      work->hdr.mad_recv_wc->recv_buf.grh,
 				      &cm_id_priv->av);
 	if (ret)
 		goto destroy;
@@ -2169,9 +2175,9 @@ static int cm_req_handler(struct cm_work *work)
 		work->path[0].rec_type =
 			sa_conv_gid_to_pathrec_type(gid_attr->gid_type);
 	} else {
-		cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
+		cm_process_routed_req(req_msg, work->hdr.mad_recv_wc->wc);
 		cm_path_set_rec_type(
-			work->port->cm_dev->ib_device, work->port->port_num,
+			work->hdr.port->cm_dev->ib_device, work->hdr.port->port_num,
 			&work->path[0],
 			IBA_GET_MEM_PTR(CM_REQ_PRIMARY_LOCAL_PORT_GID,
 					req_msg));
@@ -2179,7 +2185,7 @@ static int cm_req_handler(struct cm_work *work)
 	if (cm_req_has_alt_path(req_msg))
 		work->path[1].rec_type = work->path[0].rec_type;
 	cm_format_paths_from_req(req_msg, &work->path[0],
-				 &work->path[1], work->mad_recv_wc->wc);
+				 &work->path[1], work->hdr.mad_recv_wc->wc);
 	if (cm_id_priv->av.ah_attr.type == RDMA_AH_ATTR_TYPE_ROCE)
 		sa_path_set_dmac(&work->path[0],
 				 cm_id_priv->av.ah_attr.roce.dmac);
@@ -2191,8 +2197,8 @@ static int cm_req_handler(struct cm_work *work)
 	if (ret) {
 		int err;
 
-		err = rdma_query_gid(work->port->cm_dev->ib_device,
-				     work->port->port_num, 0,
+		err = rdma_query_gid(work->hdr.port->cm_dev->ib_device,
+				     work->hdr.port->port_num, 0,
 				     &work->path[0].sgid);
 		if (err)
 			ib_send_cm_rej(&cm_id_priv->id, IB_CM_REJ_INVALID_GID,
@@ -2419,8 +2425,8 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	struct cm_rep_msg *rep_msg;
 	struct ib_cm_rep_event_param *param;
 
-	rep_msg = (struct cm_rep_msg *)work->mad_recv_wc->recv_buf.mad;
-	param = &work->cm_event.param.rep_rcvd;
+	rep_msg = (struct cm_rep_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
+	param = &work->hdr.cm_event.param.rep_rcvd;
 	param->remote_ca_guid =
 		cpu_to_be64(IBA_GET(CM_REP_LOCAL_CA_GUID, rep_msg));
 	param->remote_qkey = IBA_GET(CM_REP_LOCAL_Q_KEY, rep_msg);
@@ -2438,7 +2444,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->ece.vendor_id |= IBA_GET(CM_REP_VENDOR_ID_L, rep_msg);
 	param->ece.attr_mod = be32_to_cpu(rep_msg->hdr.attr_mod);
 
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_REP_PRIVATE_DATA, rep_msg);
 }
 
@@ -2449,7 +2455,7 @@ static void cm_dup_rep_handler(struct cm_work *work)
 	struct ib_mad_send_buf *msg = NULL;
 	int ret;
 
-	rep_msg = (struct cm_rep_msg *) work->mad_recv_wc->recv_buf.mad;
+	rep_msg = (struct cm_rep_msg *) work->hdr.mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
 		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)),
 		cpu_to_be32(IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg)));
@@ -2457,8 +2463,8 @@ static void cm_dup_rep_handler(struct cm_work *work)
 		return;
 
 	atomic_long_inc(
-		&work->port->counters[CM_RECV_DUPLICATES][CM_REP_COUNTER]);
-	ret = cm_alloc_response_msg(work->port, work->mad_recv_wc, true, &msg);
+		&work->hdr.port->counters[CM_RECV_DUPLICATES][CM_REP_COUNTER]);
+	ret = cm_alloc_response_msg(work->hdr.port, work->hdr.mad_recv_wc, true, &msg);
 	if (ret)
 		goto deref;
 
@@ -2495,7 +2501,7 @@ static int cm_rep_handler(struct cm_work *work)
 	struct cm_id_private *cur_cm_id_priv;
 	struct cm_timewait_info *timewait_info;
 
-	rep_msg = (struct cm_rep_msg *)work->mad_recv_wc->recv_buf.mad;
+	rep_msg = (struct cm_rep_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
 		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)), 0);
 	if (!cm_id_priv) {
@@ -2547,7 +2553,7 @@ static int cm_rep_handler(struct cm_work *work)
 
 		spin_unlock(&cm.lock);
 		spin_unlock_irq(&cm_id_priv->lock);
-		cm_issue_rej(work->port, work->mad_recv_wc,
+		cm_issue_rej(work->hdr.port, work->hdr.mad_recv_wc,
 			     IB_CM_REJ_STALE_CONN, CM_MSG_RESPONSE_REP,
 			     NULL, 0);
 		ret = -EINVAL;
@@ -2597,7 +2603,7 @@ static int cm_establish_handler(struct cm_work *work)
 	struct cm_id_private *cm_id_priv;
 
 	/* See comment in cm_establish about lookup. */
-	cm_id_priv = cm_acquire_id(work->local_id, work->remote_id);
+	cm_id_priv = cm_acquire_id(work->hdr.local_id, work->hdr.remote_id);
 	if (!cm_id_priv)
 		return -EINVAL;
 
@@ -2620,21 +2626,21 @@ static int cm_rtu_handler(struct cm_work *work)
 	struct cm_id_private *cm_id_priv;
 	struct cm_rtu_msg *rtu_msg;
 
-	rtu_msg = (struct cm_rtu_msg *)work->mad_recv_wc->recv_buf.mad;
+	rtu_msg = (struct cm_rtu_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
 		cpu_to_be32(IBA_GET(CM_RTU_REMOTE_COMM_ID, rtu_msg)),
 		cpu_to_be32(IBA_GET(CM_RTU_LOCAL_COMM_ID, rtu_msg)));
 	if (!cm_id_priv)
 		return -EINVAL;
 
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_RTU_PRIVATE_DATA, rtu_msg);
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_REP_SENT &&
 	    cm_id_priv->id.state != IB_CM_MRA_REP_RCVD) {
 		spin_unlock_irq(&cm_id_priv->lock);
-		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+		atomic_long_inc(&work->hdr.port->counters[CM_RECV_DUPLICATES]
 						     [CM_RTU_COUNTER]);
 		goto out;
 	}
@@ -2843,21 +2849,21 @@ static int cm_dreq_handler(struct cm_work *work)
 	struct cm_dreq_msg *dreq_msg;
 	struct ib_mad_send_buf *msg = NULL;
 
-	dreq_msg = (struct cm_dreq_msg *)work->mad_recv_wc->recv_buf.mad;
+	dreq_msg = (struct cm_dreq_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
 		cpu_to_be32(IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg)),
 		cpu_to_be32(IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg)));
 	if (!cm_id_priv) {
-		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+		atomic_long_inc(&work->hdr.port->counters[CM_RECV_DUPLICATES]
 						     [CM_DREQ_COUNTER]);
-		cm_issue_drep(work->port, work->mad_recv_wc);
+		cm_issue_drep(work->hdr.port, work->hdr.mad_recv_wc);
 		trace_icm_no_priv_err(
 			IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg),
 			IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg));
 		return -EINVAL;
 	}
 
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_DREQ_PRIVATE_DATA, dreq_msg);
 
 	spin_lock_irq(&cm_id_priv->lock);
@@ -2877,9 +2883,9 @@ static int cm_dreq_handler(struct cm_work *work)
 			ib_cancel_mad(cm_id_priv->msg);
 		break;
 	case IB_CM_TIMEWAIT:
-		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+		atomic_long_inc(&work->hdr.port->counters[CM_RECV_DUPLICATES]
 						     [CM_DREQ_COUNTER]);
-		msg = cm_alloc_response_msg_no_ah(work->port, work->mad_recv_wc,
+		msg = cm_alloc_response_msg_no_ah(work->hdr.port, work->hdr.mad_recv_wc,
 						  true);
 		if (IS_ERR(msg))
 			goto unlock;
@@ -2889,12 +2895,12 @@ static int cm_dreq_handler(struct cm_work *work)
 			       cm_id_priv->private_data_len);
 		spin_unlock_irq(&cm_id_priv->lock);
 
-		if (cm_create_response_msg_ah(work->port, work->mad_recv_wc, msg) ||
+		if (cm_create_response_msg_ah(work->hdr.port, work->hdr.mad_recv_wc, msg) ||
 		    ib_post_send_mad(msg, NULL))
 			cm_free_msg(msg);
 		goto deref;
 	case IB_CM_DREQ_RCVD:
-		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+		atomic_long_inc(&work->hdr.port->counters[CM_RECV_DUPLICATES]
 						     [CM_DREQ_COUNTER]);
 		goto unlock;
 	default:
@@ -2916,14 +2922,14 @@ static int cm_drep_handler(struct cm_work *work)
 	struct cm_id_private *cm_id_priv;
 	struct cm_drep_msg *drep_msg;
 
-	drep_msg = (struct cm_drep_msg *)work->mad_recv_wc->recv_buf.mad;
+	drep_msg = (struct cm_drep_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
 		cpu_to_be32(IBA_GET(CM_DREP_REMOTE_COMM_ID, drep_msg)),
 		cpu_to_be32(IBA_GET(CM_DREP_LOCAL_COMM_ID, drep_msg)));
 	if (!cm_id_priv)
 		return -EINVAL;
 
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_DREP_PRIVATE_DATA, drep_msg);
 
 	spin_lock_irq(&cm_id_priv->lock);
@@ -3020,12 +3026,12 @@ static void cm_format_rej_event(struct cm_work *work)
 	struct cm_rej_msg *rej_msg;
 	struct ib_cm_rej_event_param *param;
 
-	rej_msg = (struct cm_rej_msg *)work->mad_recv_wc->recv_buf.mad;
-	param = &work->cm_event.param.rej_rcvd;
+	rej_msg = (struct cm_rej_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
+	param = &work->hdr.cm_event.param.rej_rcvd;
 	param->ari = IBA_GET_MEM_PTR(CM_REJ_ARI, rej_msg);
 	param->ari_length = IBA_GET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg);
 	param->reason = IBA_GET(CM_REJ_REASON, rej_msg);
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_REJ_PRIVATE_DATA, rej_msg);
 }
 
@@ -3058,7 +3064,7 @@ static int cm_rej_handler(struct cm_work *work)
 	struct cm_id_private *cm_id_priv;
 	struct cm_rej_msg *rej_msg;
 
-	rej_msg = (struct cm_rej_msg *)work->mad_recv_wc->recv_buf.mad;
+	rej_msg = (struct cm_rej_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_rejected_id(rej_msg);
 	if (!cm_id_priv)
 		return -EINVAL;
@@ -3175,14 +3181,14 @@ static int cm_mra_handler(struct cm_work *work)
 	struct cm_mra_msg *mra_msg;
 	int timeout;
 
-	mra_msg = (struct cm_mra_msg *)work->mad_recv_wc->recv_buf.mad;
+	mra_msg = (struct cm_mra_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_mraed_id(mra_msg);
 	if (!cm_id_priv)
 		return -EINVAL;
 
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_MRA_PRIVATE_DATA, mra_msg);
-	work->cm_event.param.mra_rcvd.service_timeout =
+	work->hdr.cm_event.param.mra_rcvd.service_timeout =
 		IBA_GET(CM_MRA_SERVICE_TIMEOUT, mra_msg);
 	timeout = cm_convert_to_ms(IBA_GET(CM_MRA_SERVICE_TIMEOUT, mra_msg)) +
 		  cm_convert_to_ms(cm_id_priv->av.timeout);
@@ -3210,7 +3216,7 @@ static int cm_mra_handler(struct cm_work *work)
 		    ib_modify_mad(cm_id_priv->msg, timeout)) {
 			if (cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
 				atomic_long_inc(
-					&work->port->counters[CM_RECV_DUPLICATES]
+					&work->hdr.port->counters[CM_RECV_DUPLICATES]
 							     [CM_MRA_COUNTER]);
 			goto out;
 		}
@@ -3218,7 +3224,7 @@ static int cm_mra_handler(struct cm_work *work)
 		break;
 	case IB_CM_MRA_REQ_RCVD:
 	case IB_CM_MRA_REP_RCVD:
-		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+		atomic_long_inc(&work->hdr.port->counters[CM_RECV_DUPLICATES]
 						     [CM_MRA_COUNTER]);
 		fallthrough;
 	default:
@@ -3295,33 +3301,33 @@ static int cm_lap_handler(struct cm_work *work)
 	/* Currently Alternate path messages are not supported for
 	 * RoCE link layer.
 	 */
-	if (rdma_protocol_roce(work->port->cm_dev->ib_device,
-			       work->port->port_num))
+	if (rdma_protocol_roce(work->hdr.port->cm_dev->ib_device,
+			       work->hdr.port->port_num))
 		return -EINVAL;
 
 	/* todo: verify LAP request and send reject APR if invalid. */
-	lap_msg = (struct cm_lap_msg *)work->mad_recv_wc->recv_buf.mad;
+	lap_msg = (struct cm_lap_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
 		cpu_to_be32(IBA_GET(CM_LAP_REMOTE_COMM_ID, lap_msg)),
 		cpu_to_be32(IBA_GET(CM_LAP_LOCAL_COMM_ID, lap_msg)));
 	if (!cm_id_priv)
 		return -EINVAL;
 
-	param = &work->cm_event.param.lap_rcvd;
+	param = &work->hdr.cm_event.param.lap_rcvd;
 	memset(&work->path[0], 0, sizeof(work->path[1]));
-	cm_path_set_rec_type(work->port->cm_dev->ib_device,
-			     work->port->port_num, &work->path[0],
+	cm_path_set_rec_type(work->hdr.port->cm_dev->ib_device,
+			     work->hdr.port->port_num, &work->path[0],
 			     IBA_GET_MEM_PTR(CM_LAP_ALTERNATE_LOCAL_PORT_GID,
 					     lap_msg));
 	param->alternate_path = &work->path[0];
 	cm_format_path_from_lap(cm_id_priv, param->alternate_path, lap_msg);
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_LAP_PRIVATE_DATA, lap_msg);
 
-	ret = ib_init_ah_attr_from_wc(work->port->cm_dev->ib_device,
-				      work->port->port_num,
-				      work->mad_recv_wc->wc,
-				      work->mad_recv_wc->recv_buf.grh,
+	ret = ib_init_ah_attr_from_wc(work->hdr.port->cm_dev->ib_device,
+				      work->hdr.port->port_num,
+				      work->hdr.mad_recv_wc->wc,
+				      work->hdr.mad_recv_wc->recv_buf.grh,
 				      &ah_attr);
 	if (ret)
 		goto deref;
@@ -3333,7 +3339,7 @@ static int cm_lap_handler(struct cm_work *work)
 	}
 
 	spin_lock_irq(&cm_id_priv->lock);
-	cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
+	cm_init_av_for_lap(work->hdr.port, work->hdr.mad_recv_wc->wc,
 			   &ah_attr, &cm_id_priv->av);
 	cm_move_av_from_path(&cm_id_priv->alt_av, &alt_av);
 
@@ -3345,9 +3351,9 @@ static int cm_lap_handler(struct cm_work *work)
 	case IB_CM_LAP_IDLE:
 		break;
 	case IB_CM_MRA_LAP_SENT:
-		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+		atomic_long_inc(&work->hdr.port->counters[CM_RECV_DUPLICATES]
 						     [CM_LAP_COUNTER]);
-		msg = cm_alloc_response_msg_no_ah(work->port, work->mad_recv_wc,
+		msg = cm_alloc_response_msg_no_ah(work->hdr.port, work->hdr.mad_recv_wc,
 						  true);
 		if (IS_ERR(msg))
 			goto unlock;
@@ -3358,12 +3364,12 @@ static int cm_lap_handler(struct cm_work *work)
 			      cm_id_priv->private_data_len);
 		spin_unlock_irq(&cm_id_priv->lock);
 
-		if (cm_create_response_msg_ah(work->port, work->mad_recv_wc, msg) ||
+		if (cm_create_response_msg_ah(work->hdr.port, work->hdr.mad_recv_wc, msg) ||
 		    ib_post_send_mad(msg, NULL))
 			cm_free_msg(msg);
 		goto deref;
 	case IB_CM_LAP_RCVD:
-		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+		atomic_long_inc(&work->hdr.port->counters[CM_RECV_DUPLICATES]
 						     [CM_LAP_COUNTER]);
 		goto unlock;
 	default:
@@ -3388,24 +3394,24 @@ static int cm_apr_handler(struct cm_work *work)
 	/* Currently Alternate path messages are not supported for
 	 * RoCE link layer.
 	 */
-	if (rdma_protocol_roce(work->port->cm_dev->ib_device,
-			       work->port->port_num))
+	if (rdma_protocol_roce(work->hdr.port->cm_dev->ib_device,
+			       work->hdr.port->port_num))
 		return -EINVAL;
 
-	apr_msg = (struct cm_apr_msg *)work->mad_recv_wc->recv_buf.mad;
+	apr_msg = (struct cm_apr_msg *)work->hdr.mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
 		cpu_to_be32(IBA_GET(CM_APR_REMOTE_COMM_ID, apr_msg)),
 		cpu_to_be32(IBA_GET(CM_APR_LOCAL_COMM_ID, apr_msg)));
 	if (!cm_id_priv)
 		return -EINVAL; /* Unmatched reply. */
 
-	work->cm_event.param.apr_rcvd.ap_status =
+	work->hdr.cm_event.param.apr_rcvd.ap_status =
 		IBA_GET(CM_APR_AR_STATUS, apr_msg);
-	work->cm_event.param.apr_rcvd.apr_info =
+	work->hdr.cm_event.param.apr_rcvd.apr_info =
 		IBA_GET_MEM_PTR(CM_APR_ADDITIONAL_INFORMATION, apr_msg);
-	work->cm_event.param.apr_rcvd.info_len =
+	work->hdr.cm_event.param.apr_rcvd.info_len =
 		IBA_GET(CM_APR_ADDITIONAL_INFORMATION_LENGTH, apr_msg);
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_APR_PRIVATE_DATA, apr_msg);
 
 	spin_lock_irq(&cm_id_priv->lock);
@@ -3429,7 +3435,7 @@ static int cm_timewait_handler(struct cm_work *work)
 	struct cm_timewait_info *timewait_info;
 	struct cm_id_private *cm_id_priv;
 
-	timewait_info = container_of(work, struct cm_timewait_info, work);
+	timewait_info = container_of(&work->hdr, struct cm_timewait_info, work);
 	spin_lock_irq(&cm.lock);
 	list_del(&timewait_info->list);
 	spin_unlock_irq(&cm.lock);
@@ -3531,16 +3537,16 @@ static void cm_format_sidr_req_event(struct cm_work *work,
 	struct ib_cm_sidr_req_event_param *param;
 
 	sidr_req_msg = (struct cm_sidr_req_msg *)
-				work->mad_recv_wc->recv_buf.mad;
-	param = &work->cm_event.param.sidr_req_rcvd;
+				work->hdr.mad_recv_wc->recv_buf.mad;
+	param = &work->hdr.cm_event.param.sidr_req_rcvd;
 	param->pkey = IBA_GET(CM_SIDR_REQ_PARTITION_KEY, sidr_req_msg);
 	param->listen_id = listen_id;
 	param->service_id =
 		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg));
 	param->bth_pkey = cm_get_bth_pkey(work);
-	param->port = work->port->port_num;
+	param->port = work->hdr.port->port_num;
 	param->sgid_attr = rx_cm_id->av.ah_attr.grh.sgid_attr;
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_SIDR_REQ_PRIVATE_DATA, sidr_req_msg);
 }
 
@@ -3552,13 +3558,13 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	int ret;
 
 	cm_id_priv =
-		cm_alloc_id_priv(work->port->cm_dev->ib_device, NULL, NULL);
+		cm_alloc_id_priv(work->hdr.port->cm_dev->ib_device, NULL, NULL);
 	if (IS_ERR(cm_id_priv))
 		return PTR_ERR(cm_id_priv);
 
 	/* Record SGID/SLID and request ID for lookup. */
 	sidr_req_msg = (struct cm_sidr_req_msg *)
-				work->mad_recv_wc->recv_buf.mad;
+				work->hdr.mad_recv_wc->recv_buf.mad;
 
 	cm_id_priv->id.remote_id =
 		cpu_to_be32(IBA_GET(CM_SIDR_REQ_REQUESTID, sidr_req_msg));
@@ -3566,10 +3572,10 @@ static int cm_sidr_req_handler(struct cm_work *work)
 		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg));
 	cm_id_priv->tid = sidr_req_msg->hdr.tid;
 
-	wc = work->mad_recv_wc->wc;
+	wc = work->hdr.mad_recv_wc->wc;
 	cm_id_priv->sidr_slid = wc->slid;
-	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
-				      work->mad_recv_wc->recv_buf.grh,
+	ret = cm_init_av_for_response(work->hdr.port, work->hdr.mad_recv_wc->wc,
+				      work->hdr.mad_recv_wc->recv_buf.grh,
 				      &cm_id_priv->av);
 	if (ret)
 		goto out;
@@ -3578,7 +3584,7 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	listen_cm_id_priv = cm_insert_remote_sidr(cm_id_priv);
 	if (listen_cm_id_priv) {
 		spin_unlock_irq(&cm.lock);
-		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
+		atomic_long_inc(&work->hdr.port->counters[CM_RECV_DUPLICATES]
 						     [CM_SIDR_REQ_COUNTER]);
 		goto out; /* Duplicate message. */
 	}
@@ -3604,7 +3610,7 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	 */
 
 	cm_format_sidr_req_event(work, cm_id_priv, &listen_cm_id_priv->id);
-	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, &work->cm_event);
+	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, &work->hdr.cm_event);
 	cm_free_work(work);
 	/*
 	 * A pointer to the listen_cm_id is held in the event, so this deref
@@ -3707,8 +3713,8 @@ static void cm_format_sidr_rep_event(struct cm_work *work,
 	struct ib_cm_sidr_rep_event_param *param;
 
 	sidr_rep_msg = (struct cm_sidr_rep_msg *)
-				work->mad_recv_wc->recv_buf.mad;
-	param = &work->cm_event.param.sidr_rep_rcvd;
+				work->hdr.mad_recv_wc->recv_buf.mad;
+	param = &work->hdr.cm_event.param.sidr_rep_rcvd;
 	param->status = IBA_GET(CM_SIDR_REP_STATUS, sidr_rep_msg);
 	param->qkey = IBA_GET(CM_SIDR_REP_Q_KEY, sidr_rep_msg);
 	param->qpn = IBA_GET(CM_SIDR_REP_QPN, sidr_rep_msg);
@@ -3717,7 +3723,7 @@ static void cm_format_sidr_rep_event(struct cm_work *work,
 	param->info_len = IBA_GET(CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH,
 				  sidr_rep_msg);
 	param->sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
-	work->cm_event.private_data =
+	work->hdr.cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_SIDR_REP_PRIVATE_DATA, sidr_rep_msg);
 }
 
@@ -3727,7 +3733,7 @@ static int cm_sidr_rep_handler(struct cm_work *work)
 	struct cm_id_private *cm_id_priv;
 
 	sidr_rep_msg = (struct cm_sidr_rep_msg *)
-				work->mad_recv_wc->recv_buf.mad;
+				work->hdr.mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
 		cpu_to_be32(IBA_GET(CM_SIDR_REP_REQUESTID, sidr_rep_msg)), 0);
 	if (!cm_id_priv)
@@ -3839,10 +3845,10 @@ static void cm_send_handler(struct ib_mad_agent *mad_agent,
 
 static void cm_work_handler(struct work_struct *_work)
 {
-	struct cm_work *work = container_of(_work, struct cm_work, work.work);
+	struct cm_work *work = container_of(_work, struct cm_work, hdr.work.work);
 	int ret;
 
-	switch (work->cm_event.event) {
+	switch (work->hdr.cm_event.event) {
 	case IB_CM_REQ_RECEIVED:
 		ret = cm_req_handler(work);
 		break;
@@ -3883,7 +3889,7 @@ static void cm_work_handler(struct work_struct *_work)
 		ret = cm_timewait_handler(work);
 		break;
 	default:
-		trace_icm_handler_err(work->cm_event.event);
+		trace_icm_handler_err(work->hdr.cm_event.event);
 		ret = -EINVAL;
 		break;
 	}
@@ -3935,16 +3941,16 @@ static int cm_establish(struct ib_cm_id *cm_id)
 	 * we need to find the cm_id once we're in the context of the
 	 * worker thread, rather than holding a reference on it.
 	 */
-	INIT_DELAYED_WORK(&work->work, cm_work_handler);
-	work->local_id = cm_id->local_id;
-	work->remote_id = cm_id->remote_id;
-	work->mad_recv_wc = NULL;
-	work->cm_event.event = IB_CM_USER_ESTABLISHED;
+	INIT_DELAYED_WORK(&work->hdr.work, cm_work_handler);
+	work->hdr.local_id = cm_id->local_id;
+	work->hdr.remote_id = cm_id->remote_id;
+	work->hdr.mad_recv_wc = NULL;
+	work->hdr.cm_event.event = IB_CM_USER_ESTABLISHED;
 
 	/* Check if the device started its remove_one */
 	spin_lock_irqsave(&cm.lock, flags);
 	if (!cm_dev->going_down) {
-		queue_delayed_work(cm.wq, &work->work, 0);
+		queue_delayed_work(cm.wq, &work->hdr.work, 0);
 	} else {
 		kfree(work);
 		ret = -ENODEV;
@@ -4057,15 +4063,15 @@ static void cm_recv_handler(struct ib_mad_agent *mad_agent,
 		return;
 	}
 
-	INIT_DELAYED_WORK(&work->work, cm_work_handler);
-	work->cm_event.event = event;
-	work->mad_recv_wc = mad_recv_wc;
-	work->port = port;
+	INIT_DELAYED_WORK(&work->hdr.work, cm_work_handler);
+	work->hdr.cm_event.event = event;
+	work->hdr.mad_recv_wc = mad_recv_wc;
+	work->hdr.port = port;
 
 	/* Check if the device started its remove_one */
 	spin_lock_irq(&cm.lock);
 	if (!port->cm_dev->going_down)
-		queue_delayed_work(cm.wq, &work->work, 0);
+		queue_delayed_work(cm.wq, &work->hdr.work, 0);
 	else
 		going_down = 1;
 	spin_unlock_irq(&cm.lock);
-- 
2.43.0


