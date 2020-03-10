Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF56E17F379
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCJJ0N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJ0N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:13 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51AE02051A;
        Tue, 10 Mar 2020 09:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832371;
        bh=mS3EE+qm+O6o5WqGfVItVPOl0i3siUFWkF7eWyAfxzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ag0el5dWNcJG61Yae2/cryBw4urkDehvjgHZlRaZdmlCk8X7IPygRoOQV5IXru494
         tI5Epbc1etkaO2dsjvMsITyAZMv9ct38F2DNQfzta15E6uAg9d/vL/xFwYjmU8mPmt
         e3IQP2tN8It3foQSl6TtcUBHVRQG59Gzv2Rztwhc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 08/15] RDMA/cm: Make it clearer how concurrency works in cm_req_handler()
Date:   Tue, 10 Mar 2020 11:25:38 +0200
Message-Id: <20200310092545.251365-9-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310092545.251365-1-leon@kernel.org>
References: <20200310092545.251365-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

ib_crate_cm_id() immediately places the id in the xarray, and publishes it
into the remote_id and remote_qpn rbtrees. This makes it visible to other
threads before it is fully set up.

It appears the thinking here was that the states IB_CM_IDLE and
IB_CM_REQ_RCVD do not allow any MAD handler or lookup in the remote_id and
remote_qpn rbtrees to advance.

However, cm_rej_handler() does take an action on IB_CM_REQ_RCVD, which is
not really expected by the design.

Make the whole thing clearer:
 - Keep the new cm_id out of the xarray until it is completely set up.
   This directly prevents MAD handlers and all rbtree lookups from seeing
   the pointer.
 - Move all the trivial setup right to the top so it is obviously done
   before any concurrency begins
 - Move the mutation of the cm_id_priv out of cm_match_id() and into the
   caller so the state transition is obvious
 - Place the manipulation of the work_list at the end, under lock, after
   the cm_id is placed in the xarray. The work_count cannot change on an
   ID outside the xarray.
 - Add some comments

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 99 +++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 2eb6ece9b783..d00eb4751ae5 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1973,14 +1973,10 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 		cm_issue_rej(work->port, work->mad_recv_wc,
 			     IB_CM_REJ_INVALID_SERVICE_ID, CM_MSG_RESPONSE_REQ,
 			     NULL, 0);
-		goto out;
+		return NULL;
 	}
 	refcount_inc(&listen_cm_id_priv->refcount);
-	refcount_inc(&cm_id_priv->refcount);
-	cm_id_priv->id.state = IB_CM_REQ_RCVD;
-	atomic_inc(&cm_id_priv->work_count);
 	spin_unlock_irq(&cm.lock);
-out:
 	return listen_cm_id_priv;
 }
 
@@ -2022,7 +2018,6 @@ static void cm_process_routed_req(struct cm_req_msg *req_msg, struct ib_wc *wc)
 
 static int cm_req_handler(struct cm_work *work)
 {
-	struct ib_cm_id *cm_id;
 	struct cm_id_private *cm_id_priv, *listen_cm_id_priv;
 	struct cm_req_msg *req_msg;
 	const struct ib_global_route *grh;
@@ -2031,13 +2026,33 @@ static int cm_req_handler(struct cm_work *work)
 
 	req_msg = (struct cm_req_msg *)work->mad_recv_wc->recv_buf.mad;
 
-	cm_id = ib_create_cm_id(work->port->cm_dev->ib_device, NULL, NULL);
-	if (IS_ERR(cm_id))
-		return PTR_ERR(cm_id);
+	cm_id_priv =
+		cm_alloc_id_priv(work->port->cm_dev->ib_device, NULL, NULL);
+	if (IS_ERR(cm_id_priv))
+		return PTR_ERR(cm_id_priv);
 
-	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	cm_id_priv->id.remote_id =
 		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_COMM_ID, req_msg));
+	cm_id_priv->id.service_id =
+		cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg));
+	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
+	cm_id_priv->tid = req_msg->hdr.tid;
+	cm_id_priv->timeout_ms = cm_convert_to_ms(
+		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg));
+	cm_id_priv->max_cm_retries = IBA_GET(CM_REQ_MAX_CM_RETRIES, req_msg);
+	cm_id_priv->remote_qpn =
+		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_QPN, req_msg));
+	cm_id_priv->initiator_depth =
+		IBA_GET(CM_REQ_RESPONDER_RESOURCES, req_msg);
+	cm_id_priv->responder_resources =
+		IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
+	cm_id_priv->path_mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
+	cm_id_priv->pkey = cpu_to_be16(IBA_GET(CM_REQ_PARTITION_KEY, req_msg));
+	cm_id_priv->sq_psn = cpu_to_be32(IBA_GET(CM_REQ_STARTING_PSN, req_msg));
+	cm_id_priv->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
+	cm_id_priv->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
+	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
+
 	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
 				      work->mad_recv_wc->recv_buf.grh,
 				      &cm_id_priv->av);
@@ -2049,27 +2064,26 @@ static int cm_req_handler(struct cm_work *work)
 		ret = PTR_ERR(cm_id_priv->timewait_info);
 		goto destroy;
 	}
-	cm_id_priv->timewait_info->work.remote_id =
-		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_COMM_ID, req_msg));
+	cm_id_priv->timewait_info->work.remote_id = cm_id_priv->id.remote_id;
 	cm_id_priv->timewait_info->remote_ca_guid =
 		cpu_to_be64(IBA_GET(CM_REQ_LOCAL_CA_GUID, req_msg));
-	cm_id_priv->timewait_info->remote_qpn =
-		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_QPN, req_msg));
+	cm_id_priv->timewait_info->remote_qpn = cm_id_priv->remote_qpn;
+
+	/*
+	 * Note that the ID pointer is not in the xarray at this point,
+	 * so this set is only visible to the local thread.
+	 */
+	cm_id_priv->id.state = IB_CM_REQ_RCVD;
 
 	listen_cm_id_priv = cm_match_req(work, cm_id_priv);
 	if (!listen_cm_id_priv) {
 		pr_debug("%s: local_id %d, no listen_cm_id_priv\n", __func__,
-			 be32_to_cpu(cm_id->local_id));
+			 be32_to_cpu(cm_id_priv->id.local_id));
+		cm_id_priv->id.state = IB_CM_IDLE;
 		ret = -EINVAL;
 		goto destroy;
 	}
 
-	cm_id_priv->id.cm_handler = listen_cm_id_priv->id.cm_handler;
-	cm_id_priv->id.context = listen_cm_id_priv->id.context;
-	cm_id_priv->id.service_id =
-		cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg));
-	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
-
 	cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
 
 	memset(&work->path[0], 0, sizeof(work->path[0]));
@@ -2107,10 +2121,10 @@ static int cm_req_handler(struct cm_work *work)
 				     work->port->port_num, 0,
 				     &work->path[0].sgid);
 		if (err)
-			ib_send_cm_rej(cm_id, IB_CM_REJ_INVALID_GID,
+			ib_send_cm_rej(&cm_id_priv->id, IB_CM_REJ_INVALID_GID,
 				       NULL, 0, NULL, 0);
 		else
-			ib_send_cm_rej(cm_id, IB_CM_REJ_INVALID_GID,
+			ib_send_cm_rej(&cm_id_priv->id, IB_CM_REJ_INVALID_GID,
 				       &work->path[0].sgid,
 				       sizeof(work->path[0].sgid),
 				       NULL, 0);
@@ -2120,39 +2134,40 @@ static int cm_req_handler(struct cm_work *work)
 		ret = cm_init_av_by_path(&work->path[1], NULL,
 					 &cm_id_priv->alt_av, cm_id_priv);
 		if (ret) {
-			ib_send_cm_rej(cm_id, IB_CM_REJ_INVALID_ALT_GID,
+			ib_send_cm_rej(&cm_id_priv->id,
+				       IB_CM_REJ_INVALID_ALT_GID,
 				       &work->path[0].sgid,
 				       sizeof(work->path[0].sgid), NULL, 0);
 			goto rejected;
 		}
 	}
-	cm_id_priv->tid = req_msg->hdr.tid;
-	cm_id_priv->timeout_ms = cm_convert_to_ms(
-		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg));
-	cm_id_priv->max_cm_retries = IBA_GET(CM_REQ_MAX_CM_RETRIES, req_msg);
-	cm_id_priv->remote_qpn =
-		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_QPN, req_msg));
-	cm_id_priv->initiator_depth =
-		IBA_GET(CM_REQ_RESPONDER_RESOURCES, req_msg);
-	cm_id_priv->responder_resources =
-		IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
-	cm_id_priv->path_mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
-	cm_id_priv->pkey = cpu_to_be16(IBA_GET(CM_REQ_PARTITION_KEY, req_msg));
-	cm_id_priv->sq_psn = cpu_to_be32(IBA_GET(CM_REQ_STARTING_PSN, req_msg));
-	cm_id_priv->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
-	cm_id_priv->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
-	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
 
+	cm_id_priv->id.cm_handler = listen_cm_id_priv->id.cm_handler;
+	cm_id_priv->id.context = listen_cm_id_priv->id.context;
 	cm_format_req_event(work, cm_id_priv, &listen_cm_id_priv->id);
+
+	/* Now MAD handlers can see the new ID */
+	spin_lock_irq(&cm_id_priv->lock);
+	cm_finalize_id(cm_id_priv);
+
+	/* Refcount belongs to the event, pairs with cm_process_work() */
+	refcount_inc(&cm_id_priv->refcount);
+	atomic_inc(&cm_id_priv->work_count);
+	spin_unlock_irq(&cm_id_priv->lock);
 	cm_process_work(cm_id_priv, work);
+	/*
+	 * Since this ID was just created and was not made visible to other MAD
+	 * handlers until the cm_finalize_id() above we know that the
+	 * cm_process_work() will deliver the event and the listen_cm_id
+	 * embedded in the event can be derefed here.
+	 */
 	cm_deref_id(listen_cm_id_priv);
 	return 0;
 
 rejected:
-	refcount_dec(&cm_id_priv->refcount);
 	cm_deref_id(listen_cm_id_priv);
 destroy:
-	ib_destroy_cm_id(cm_id);
+	ib_destroy_cm_id(&cm_id_priv->id);
 	return ret;
 }
 
-- 
2.24.1

