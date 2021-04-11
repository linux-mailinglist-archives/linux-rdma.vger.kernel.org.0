Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43135B419
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Apr 2021 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhDKMWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Apr 2021 08:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKMWa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 11 Apr 2021 08:22:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94730610C8;
        Sun, 11 Apr 2021 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618143734;
        bh=dkCEfOlKpwZKTEEbQTW0J7M0DerJwdnZIFtUUAVNEtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1G5ZvniBdd2e0u/6A5aHpwsRsLQdF3agqBmEa4Cu3cuu0rCTv/euauG+KQG7kG4q
         pZePM05LIRcONL+uLogA0OTcJTRib2avH7LR1ZeBlUF5+l6MPGEXsRJx0c2sDagGn3
         d82yU9A7YWdhML0OM6NbEWeuE8m+2rdIjqezv4+qBwQGYbT6FZPiFUOn/Z+pDNFkGT
         Xxu5Ka9HFf35VkbqiKfhQsRLjMRVXf6vd8O5sOB5U2BKpv4yMGyWnkJveLe4wSbw68
         1pXrEFVru/CxQ+pF2yAj51GinvGrQmZ3tLvPZjpBW8LgI+wm+DL923F1nu3c00rRh6
         DkLxv4eLXZYQA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 4/5] IB/cm: Add lock protection when access av/alt_av's port of a cm_id
Date:   Sun, 11 Apr 2021 15:21:51 +0300
Message-Id: <20210411122152.59274-5-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210411122152.59274-1-leon@kernel.org>
References: <20210411122152.59274-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Add a rwlock protection when access the av/alt_av's port pointer.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 131 +++++++++++++++++++++++++++--------
 1 file changed, 104 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index b4f4a569c0b9..d8368d71ac7c 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -261,6 +261,7 @@ struct cm_id_private {
 	/* todo: use alternate port on send failure */
 	struct cm_av av;
 	struct cm_av alt_av;
+	rwlock_t av_rwlock;	/* Do not acquire inside cm.lock */
 
 	void *private_data;
 	__be64 tid;
@@ -303,17 +304,33 @@ static int cm_alloc_msg(struct cm_id_private *cm_id_priv,
 	struct ib_mad_agent *mad_agent;
 	struct ib_mad_send_buf *m;
 	struct ib_ah *ah;
+	int ret;
+
+	read_lock(&cm_id_priv->av_rwlock);
+	if (!cm_id_priv->av.port) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	mad_agent = cm_id_priv->av.port->mad_agent;
+	if (!mad_agent) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ah = rdma_create_ah(mad_agent->qp->pd, &cm_id_priv->av.ah_attr, 0);
-	if (IS_ERR(ah))
-		return PTR_ERR(ah);
+	if (IS_ERR(ah)) {
+		ret = PTR_ERR(ah);
+		goto out;
+	}
 
 	m = ib_create_send_mad(mad_agent, cm_id_priv->id.remote_cm_qpn,
 			       cm_id_priv->av.pkey_index,
 			       0, IB_MGMT_MAD_HDR, IB_MGMT_MAD_DATA,
 			       GFP_ATOMIC,
 			       IB_MGMT_BASE_VERSION);
+
+	read_unlock(&cm_id_priv->av_rwlock);
 	if (IS_ERR(m)) {
 		rdma_destroy_ah(ah, 0);
 		return PTR_ERR(m);
@@ -327,6 +344,10 @@ static int cm_alloc_msg(struct cm_id_private *cm_id_priv,
 	m->context[0] = cm_id_priv;
 	*msg = m;
 	return 0;
+
+out:
+	read_unlock(&cm_id_priv->av_rwlock);
+	return ret;
 }
 
 static struct ib_mad_send_buf *cm_alloc_response_msg_no_ah(struct cm_port *port,
@@ -420,7 +441,6 @@ static void add_cm_id_to_cm_dev_list(struct cm_id_private *cm_id_priv,
 	if (!list_empty(&cm_id_priv->cm_dev_list))
 		list_del(&cm_id_priv->cm_dev_list);
 	list_add_tail(&cm_id_priv->cm_dev_list, &cm_dev->cm_id_priv_list);
-
 out:
 	spin_unlock_irqrestore(&cm.lock, flags);
 }
@@ -433,8 +453,8 @@ static int cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
 	struct rdma_ah_attr new_ah_attr;
 	int ret;
 
-	av->port = port;
-	av->pkey_index = wc->pkey_index;
+	if (!port)
+		return -EINVAL;
 
 	/*
 	 * av->ah_attr might be initialized based on past wc during incoming
@@ -449,7 +469,11 @@ static int cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
 	if (ret)
 		return ret;
 
+	write_lock(&cm_id_priv->av_rwlock);
+	av->port = port;
+	av->pkey_index = wc->pkey_index;
 	add_cm_id_to_cm_dev_list(cm_id_priv, port->cm_dev);
+	write_unlock(&cm_id_priv->av_rwlock);
 
 	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
 	return 0;
@@ -461,8 +485,10 @@ static int cm_init_av_for_response(struct cm_port *port, struct ib_wc *wc,
 {
 	struct cm_av *av = &cm_id_priv->av;
 
+	write_lock(&cm_id_priv->av_rwlock);
 	av->port = port;
 	add_cm_id_to_cm_dev_list(cm_id_priv, port->cm_dev);
+	write_unlock(&cm_id_priv->av_rwlock);
 	av->pkey_index = wc->pkey_index;
 	return ib_init_ah_attr_from_wc(port->cm_dev->ib_device,
 				       port->port_num, wc,
@@ -519,15 +545,21 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 	struct cm_device *cm_dev;
 	struct cm_port *port;
 	struct cm_av *av;
-	int ret;
+	int ret = 0;
 
 	port = get_cm_port_from_path(path, sgid_attr);
 	if (!port)
 		return -EINVAL;
 	cm_dev = port->cm_dev;
 
-	if (!is_priv_av && cm_dev != cm_id_priv->av.port->cm_dev)
-		return -EINVAL;
+	read_lock(&cm_id_priv->av_rwlock);
+	if (!is_priv_av &&
+	    (!cm_id_priv->av.port || cm_dev != cm_id_priv->av.port->cm_dev))
+		ret = -EINVAL;
+
+	read_unlock(&cm_id_priv->av_rwlock);
+	if (ret)
+		return ret;
 
 	av = is_priv_av ? &cm_id_priv->av : &cm_id_priv->alt_av;
 
@@ -536,8 +568,6 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 	if (ret)
 		return ret;
 
-	av->port = port;
-
 	/*
 	 * av->ah_attr might be initialized based on wc or during
 	 * request processing time which might have reference to sgid_attr.
@@ -552,11 +582,15 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 	if (ret)
 		return ret;
 
+	write_lock(&cm_id_priv->av_rwlock);
+	av->port = port;
 	av->timeout = path->packet_life_time + 1;
-	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
 	if (is_priv_av)
 		add_cm_id_to_cm_dev_list(cm_id_priv, cm_dev);
 
+	write_unlock(&cm_id_priv->av_rwlock);
+
+	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
 	return 0;
 }
 
@@ -838,6 +872,7 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
 	INIT_LIST_HEAD(&cm_id_priv->cm_dev_list);
 	atomic_set(&cm_id_priv->work_count, -1);
 	refcount_set(&cm_id_priv->refcount, 1);
+	rwlock_init(&cm_id_priv->av_rwlock);
 
 	ret = xa_alloc_cyclic(&cm.local_id_table, &id, NULL, xa_limit_32b,
 			      &cm.local_id_next, GFP_KERNEL);
@@ -951,6 +986,26 @@ static u8 cm_ack_timeout(u8 ca_ack_delay, u8 packet_life_time)
 	return min(31, ack_timeout);
 }
 
+static u8 cm_ack_timeout_req(struct cm_id_private *cm_id_priv,
+			     u8 packet_life_time)
+{
+	u8 ack_delay = 0;
+
+	read_lock(&cm_id_priv->av_rwlock);
+	if (cm_id_priv->av.port && cm_id_priv->av.port->cm_dev)
+		ack_delay = cm_id_priv->av.port->cm_dev->ack_delay;
+	read_unlock(&cm_id_priv->av_rwlock);
+
+	return cm_ack_timeout(ack_delay, packet_life_time);
+}
+
+static u8 cm_ack_timeout_rep(struct cm_id_private *cm_id_priv,
+			     u8 packet_life_time)
+{
+	return cm_ack_timeout(cm_id_priv->target_ack_delay,
+			      packet_life_time);
+}
+
 static void cm_remove_remote(struct cm_id_private *cm_id_priv)
 {
 	struct cm_timewait_info *timewait_info = cm_id_priv->timewait_info;
@@ -1285,9 +1340,13 @@ EXPORT_SYMBOL(ib_cm_insert_listen);
 
 static __be64 cm_form_tid(struct cm_id_private *cm_id_priv)
 {
-	u64 hi_tid, low_tid;
+	u64 hi_tid = 0, low_tid;
+
+	read_lock(&cm_id_priv->av_rwlock);
+	if (cm_id_priv->av.port && cm_id_priv->av.port->mad_agent)
+		hi_tid = ((u64) cm_id_priv->av.port->mad_agent->hi_tid) << 32;
+	read_unlock(&cm_id_priv->av_rwlock);
 
-	hi_tid   = ((u64) cm_id_priv->av.port->mad_agent->hi_tid) << 32;
 	low_tid  = (u64)cm_id_priv->id.local_id;
 	return cpu_to_be64(hi_tid | low_tid);
 }
@@ -1391,8 +1450,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	IBA_SET(CM_REQ_PRIMARY_SUBNET_LOCAL, req_msg,
 		(pri_path->hop_limit <= 1));
 	IBA_SET(CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT, req_msg,
-		cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
-			       pri_path->packet_life_time));
+		cm_ack_timeout_req(cm_id_priv, pri_path->packet_life_time));
 
 	if (alt_path) {
 		bool alt_ext = false;
@@ -1443,8 +1501,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		IBA_SET(CM_REQ_ALTERNATE_SUBNET_LOCAL, req_msg,
 			(alt_path->hop_limit <= 1));
 		IBA_SET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, req_msg,
-			cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
-				       alt_path->packet_life_time));
+			cm_ack_timeout_req(cm_id_priv,
+					   alt_path->packet_life_time));
 	}
 	IBA_SET(CM_REQ_VENDOR_ID, req_msg, param->ece.vendor_id);
 
@@ -1785,7 +1843,12 @@ static void cm_format_req_event(struct cm_work *work,
 	param = &work->cm_event.param.req_rcvd;
 	param->listen_id = listen_id;
 	param->bth_pkey = cm_get_bth_pkey(work);
-	param->port = cm_id_priv->av.port->port_num;
+	read_lock(&cm_id_priv->av_rwlock);
+	if (cm_id_priv->av.port)
+		param->port = cm_id_priv->av.port->port_num;
+	else
+		param->port = 0;
+	read_unlock(&cm_id_priv->av_rwlock);
 	param->primary_path = &work->path[0];
 	cm_opa_to_ib_sgid(work, param->primary_path);
 	if (cm_req_has_alt_path(req_msg)) {
@@ -2216,8 +2279,13 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	IBA_SET(CM_REP_STARTING_PSN, rep_msg, param->starting_psn);
 	IBA_SET(CM_REP_RESPONDER_RESOURCES, rep_msg,
 		param->responder_resources);
-	IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg,
-		cm_id_priv->av.port->cm_dev->ack_delay);
+	read_lock(&cm_id_priv->av_rwlock);
+	if (cm_id_priv->av.port && cm_id_priv->av.port->cm_dev)
+		IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg,
+			cm_id_priv->av.port->cm_dev->ack_delay);
+	else
+		IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg, 0);
+	read_unlock(&cm_id_priv->av_rwlock);
 	IBA_SET(CM_REP_FAILOVER_ACCEPTED, rep_msg, param->failover_accepted);
 	IBA_SET(CM_REP_RNR_RETRY_COUNT, rep_msg, param->rnr_retry_count);
 	IBA_SET(CM_REP_LOCAL_CA_GUID, rep_msg,
@@ -2530,11 +2598,9 @@ static int cm_rep_handler(struct cm_work *work)
 	cm_id_priv->target_ack_delay =
 		IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
 	cm_id_priv->av.timeout =
-			cm_ack_timeout(cm_id_priv->target_ack_delay,
-				       cm_id_priv->av.timeout - 1);
+		cm_ack_timeout_rep(cm_id_priv, cm_id_priv->av.timeout - 1);
 	cm_id_priv->alt_av.timeout =
-			cm_ack_timeout(cm_id_priv->target_ack_delay,
-				       cm_id_priv->alt_av.timeout - 1);
+		cm_ack_timeout_rep(cm_id_priv, cm_id_priv->alt_av.timeout - 1);
 
 	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
@@ -4113,7 +4179,10 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
 			qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ |
 						    IB_ACCESS_REMOTE_ATOMIC;
 		qp_attr->pkey_index = cm_id_priv->av.pkey_index;
-		qp_attr->port_num = cm_id_priv->av.port->port_num;
+		read_lock(&cm_id_priv->av_rwlock);
+		qp_attr->port_num = cm_id_priv->av.port ?
+			cm_id_priv->av.port->port_num : 0;
+		read_unlock(&cm_id_priv->av_rwlock);
 		ret = 0;
 		break;
 	default:
@@ -4157,7 +4226,10 @@ static int cm_init_qp_rtr_attr(struct cm_id_private *cm_id_priv,
 		}
 		if (rdma_ah_get_dlid(&cm_id_priv->alt_av.ah_attr)) {
 			*qp_attr_mask |= IB_QP_ALT_PATH;
-			qp_attr->alt_port_num = cm_id_priv->alt_av.port->port_num;
+			read_lock(&cm_id_priv->av_rwlock);
+			qp_attr->alt_port_num = cm_id_priv->alt_av.port ?
+				cm_id_priv->alt_av.port->port_num : 0;
+			read_unlock(&cm_id_priv->av_rwlock);
 			qp_attr->alt_pkey_index = cm_id_priv->alt_av.pkey_index;
 			qp_attr->alt_timeout = cm_id_priv->alt_av.timeout;
 			qp_attr->alt_ah_attr = cm_id_priv->alt_av.ah_attr;
@@ -4216,7 +4288,10 @@ static int cm_init_qp_rts_attr(struct cm_id_private *cm_id_priv,
 			}
 		} else {
 			*qp_attr_mask = IB_QP_ALT_PATH | IB_QP_PATH_MIG_STATE;
-			qp_attr->alt_port_num = cm_id_priv->alt_av.port->port_num;
+			read_lock(&cm_id_priv->av_rwlock);
+			qp_attr->alt_port_num = cm_id_priv->alt_av.port ?
+				cm_id_priv->alt_av.port->port_num : 0;
+			read_unlock(&cm_id_priv->av_rwlock);
 			qp_attr->alt_pkey_index = cm_id_priv->alt_av.pkey_index;
 			qp_attr->alt_timeout = cm_id_priv->alt_av.timeout;
 			qp_attr->alt_ah_attr = cm_id_priv->alt_av.ah_attr;
@@ -4434,10 +4509,12 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 
 	list_for_each_entry_safe(cm_id_priv, tmp,
 				 &cm_dev->cm_id_priv_list, cm_dev_list) {
+		write_lock(&cm_id_priv->av_rwlock);
 		if (!list_empty(&cm_id_priv->cm_dev_list))
 			list_del(&cm_id_priv->cm_dev_list);
 		cm_id_priv->av.port = NULL;
 		cm_id_priv->alt_av.port = NULL;
+		write_unlock(&cm_id_priv->av_rwlock);
 	}
 
 	rdma_for_each_port (ib_device, i) {
-- 
2.30.2

