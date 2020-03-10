Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF12C17F378
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCJJ0K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJ0K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:10 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387AB24681;
        Tue, 10 Mar 2020 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832368;
        bh=TfA8oUHOL0UvwaN88p52gDy17KrrfkQ3t7XTUSmBpts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lD7PKcQp9wVdP7vqanLSTzThg8yf/VMJ6Jm+MRLv2XL+vsO4fQV7qEKF6gktD3xHe
         Polmda6uT2yzBI/pQgLA0N4tPU26cGmqPlkPVlhKrU0agRlW56nbKqHO0Kqm+tLPL1
         V16tc5Y94rIurqniNkFTfWwJNwff2kRSPwn2AigU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 07/15] RDMA/cm: Make it clear that there is no concurrency in cm_sidr_req_handler()
Date:   Tue, 10 Mar 2020 11:25:37 +0200
Message-Id: <20200310092545.251365-8-leon@kernel.org>
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

ib_create_cm_id() immediately places the id in the xarray, so it is visible
to network traffic.

The state is initially set to IB_CM_IDLE and all the MAD handlers will
test this state under lock and refuse to advance from IDLE, so adding to
the xarray is harmless.

Further, the set to IB_CM_SIDR_REQ_RCVD also excludes all MAD handlers.

However, the local_id isn't even used for SIDR mode, and there will be no
input MADs related to the newly created ID.

So, make the whole flow simpler so it can be understood:
 - Do not put the SIDR cm_id in the xarray. This directly shows that there
   is no concurrency
 - Delete the confusing work_count and pending_list manipulations. This
   mechanism is only used by MAD handlers and timewait, neither of which
   apply to SIDR.
 - Add a few comments and rename 'cur_cm_id_priv' to 'listen_cm_id_priv'
 - Move other loose sets up to immediately after cm_id creation so that
   the cm_id is fully configured right away. This fixes an oversight where
   the service_id will not be returned back on a IB_SIDR_UNSUPPORTED
   reject.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 64 +++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index f50b56302500..2eb6ece9b783 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3562,20 +3562,27 @@ static void cm_format_sidr_req_event(struct cm_work *work,
 
 static int cm_sidr_req_handler(struct cm_work *work)
 {
-	struct ib_cm_id *cm_id;
-	struct cm_id_private *cm_id_priv, *cur_cm_id_priv;
+	struct cm_id_private *cm_id_priv, *listen_cm_id_priv;
 	struct cm_sidr_req_msg *sidr_req_msg;
 	struct ib_wc *wc;
 	int ret;
 
-	cm_id = ib_create_cm_id(work->port->cm_dev->ib_device, NULL, NULL);
-	if (IS_ERR(cm_id))
-		return PTR_ERR(cm_id);
-	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
+	cm_id_priv =
+		cm_alloc_id_priv(work->port->cm_dev->ib_device, NULL, NULL);
+	if (IS_ERR(cm_id_priv))
+		return PTR_ERR(cm_id_priv);
 
 	/* Record SGID/SLID and request ID for lookup. */
 	sidr_req_msg = (struct cm_sidr_req_msg *)
 				work->mad_recv_wc->recv_buf.mad;
+
+	cm_id_priv->id.remote_id =
+		cpu_to_be32(IBA_GET(CM_SIDR_REQ_REQUESTID, sidr_req_msg));
+	cm_id_priv->id.service_id =
+		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg));
+	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
+	cm_id_priv->tid = sidr_req_msg->hdr.tid;
+
 	wc = work->mad_recv_wc->wc;
 	cm_id_priv->av.dgid.global.subnet_prefix = cpu_to_be64(wc->slid);
 	cm_id_priv->av.dgid.global.interface_id = 0;
@@ -3585,41 +3592,44 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	if (ret)
 		goto out;
 
-	cm_id_priv->id.remote_id =
-		cpu_to_be32(IBA_GET(CM_SIDR_REQ_REQUESTID, sidr_req_msg));
-	cm_id_priv->tid = sidr_req_msg->hdr.tid;
-	atomic_inc(&cm_id_priv->work_count);
-
 	spin_lock_irq(&cm.lock);
-	cur_cm_id_priv = cm_insert_remote_sidr(cm_id_priv);
-	if (cur_cm_id_priv) {
+	listen_cm_id_priv = cm_insert_remote_sidr(cm_id_priv);
+	if (listen_cm_id_priv) {
 		spin_unlock_irq(&cm.lock);
 		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
 				counter[CM_SIDR_REQ_COUNTER]);
 		goto out; /* Duplicate message. */
 	}
 	cm_id_priv->id.state = IB_CM_SIDR_REQ_RCVD;
-	cur_cm_id_priv = cm_find_listen(
-		cm_id->device,
-		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg)));
-	if (!cur_cm_id_priv) {
+	listen_cm_id_priv = cm_find_listen(cm_id_priv->id.device,
+					   cm_id_priv->id.service_id);
+	if (!listen_cm_id_priv) {
 		spin_unlock_irq(&cm.lock);
 		cm_reject_sidr_req(cm_id_priv, IB_SIDR_UNSUPPORTED);
 		goto out; /* No match. */
 	}
-	refcount_inc(&cur_cm_id_priv->refcount);
-	refcount_inc(&cm_id_priv->refcount);
+	refcount_inc(&listen_cm_id_priv->refcount);
 	spin_unlock_irq(&cm.lock);
 
-	cm_id_priv->id.cm_handler = cur_cm_id_priv->id.cm_handler;
-	cm_id_priv->id.context = cur_cm_id_priv->id.context;
-	cm_id_priv->id.service_id =
-		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg));
-	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
+	cm_id_priv->id.cm_handler = listen_cm_id_priv->id.cm_handler;
+	cm_id_priv->id.context = listen_cm_id_priv->id.context;
 
-	cm_format_sidr_req_event(work, cm_id_priv, &cur_cm_id_priv->id);
-	cm_process_work(cm_id_priv, work);
-	cm_deref_id(cur_cm_id_priv);
+	/*
+	 * A SIDR ID does not need to be in the xarray since it does not receive
+	 * mads, is not placed in the remote_id or remote_qpn rbtree, and does
+	 * not enter timewait.
+	 */
+
+	cm_format_sidr_req_event(work, cm_id_priv, &listen_cm_id_priv->id);
+	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, &work->cm_event);
+	cm_free_work(work);
+	/*
+	 * A pointer to the listen_cm_id is held in the event, so this deref
+	 * must be after the event is delivered above.
+	 */
+	cm_deref_id(listen_cm_id_priv);
+	if (ret)
+		cm_destroy_id(&cm_id_priv->id, ret);
 	return 0;
 out:
 	ib_destroy_cm_id(&cm_id_priv->id);
-- 
2.24.1

