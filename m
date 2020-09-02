Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544DF25A76F
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgIBILd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBILc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:11:32 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D21720826;
        Wed,  2 Sep 2020 08:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034291;
        bh=UalnntVjeTlyxh3UfhAc8Ig2azRcbzGmhQvAiOPiSQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2f1yggMJbwCP1GcJjet4KjUfJq7bvdEItcsX68nvA4l7zY3m7BPdROkzE8yfLLbW
         84LkNryNoRnwRJTl/6RVyPqB8KbNpyyeusG/qCDs1HgsP/z2g92jJv6qj8ExQzfOnb
         UiNdv09d3rL7I+pCdE17HQKMz7Fq5A3Td/IAWUcs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/8] RDMA/cma: Fix locking for the RDMA_CM_CONNECT state
Date:   Wed,  2 Sep 2020 11:11:15 +0300
Message-Id: <20200902081122.745412-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902081122.745412-1-leon@kernel.org>
References: <20200902081122.745412-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

It is currently a bit confusing, but the design is if the handler_mutex
is held, and the state is in RDMA_CM_CONNECT, then the state cannot leave
RDMA_CM_CONNECT without also serializing with the handler_mutex.

Make this clearer by adding a direct assertion, fixing the usage in
rdma_connect and generally using READ_ONCE to read the state value.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 44 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index f1c45f67e2eb..7ac9306ab5b3 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -421,6 +421,15 @@ static int cma_comp_exch(struct rdma_id_private *id_priv,
 	unsigned long flags;
 	int ret;
 
+	/*
+	 * The FSM uses a funny double locking where state is protected by both
+	 * the handler_mutex and the spinlock. State is not allowed to change
+	 * away from a handler_mutex protected value without also holding
+	 * handler_mutex.
+	 */
+	if (comp == RDMA_CM_CONNECT)
+		lockdep_assert_held(&id_priv->handler_mutex);
+
 	spin_lock_irqsave(&id_priv->lock, flags);
 	if ((ret = (id_priv->state == comp)))
 		id_priv->state = exch;
@@ -1969,13 +1978,15 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
 {
 	struct rdma_id_private *id_priv = cm_id->context;
 	struct rdma_cm_event event = {};
+	enum rdma_cm_state state;
 	int ret;
 
 	mutex_lock(&id_priv->handler_mutex);
+	state = READ_ONCE(id_priv->state);
 	if ((ib_event->event != IB_CM_TIMEWAIT_EXIT &&
-	     id_priv->state != RDMA_CM_CONNECT) ||
+	     state != RDMA_CM_CONNECT) ||
 	    (ib_event->event == IB_CM_TIMEWAIT_EXIT &&
-	     id_priv->state != RDMA_CM_DISCONNECT))
+	     state != RDMA_CM_DISCONNECT))
 		goto out;
 
 	switch (ib_event->event) {
@@ -1985,7 +1996,7 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
 		event.status = -ETIMEDOUT;
 		break;
 	case IB_CM_REP_RECEIVED:
-		if (cma_comp(id_priv, RDMA_CM_CONNECT) &&
+		if (state == RDMA_CM_CONNECT &&
 		    (id_priv->id.qp_type != IB_QPT_UD)) {
 			trace_cm_send_mra(id_priv);
 			ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
@@ -2246,8 +2257,8 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 		goto net_dev_put;
 	}
 
-	if (cma_comp(conn_id, RDMA_CM_CONNECT) &&
-	    (conn_id->id.qp_type != IB_QPT_UD)) {
+	if (READ_ONCE(conn_id->state) == RDMA_CM_CONNECT &&
+	    conn_id->id.qp_type != IB_QPT_UD) {
 		trace_cm_send_mra(cm_id->context);
 		ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
 	}
@@ -2308,7 +2319,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	struct sockaddr *raddr = (struct sockaddr *)&iw_event->remote_addr;
 
 	mutex_lock(&id_priv->handler_mutex);
-	if (id_priv->state != RDMA_CM_CONNECT)
+	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
 		goto out;
 
 	switch (iw_event->event) {
@@ -3807,7 +3818,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id *cm_id,
 	int ret;
 
 	mutex_lock(&id_priv->handler_mutex);
-	if (id_priv->state != RDMA_CM_CONNECT)
+	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
 		goto out;
 
 	switch (ib_event->event) {
@@ -4043,12 +4054,15 @@ static int cma_connect_iw(struct rdma_id_private *id_priv,
 
 int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 {
-	struct rdma_id_private *id_priv;
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
 	int ret;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
-	if (!cma_comp_exch(id_priv, RDMA_CM_ROUTE_RESOLVED, RDMA_CM_CONNECT))
-		return -EINVAL;
+	mutex_lock(&id_priv->handler_mutex);
+	if (!cma_comp_exch(id_priv, RDMA_CM_ROUTE_RESOLVED, RDMA_CM_CONNECT)) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
 
 	if (!id->qp) {
 		id_priv->qp_num = conn_param->qp_num;
@@ -4065,11 +4079,13 @@ int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 	else
 		ret = -ENOSYS;
 	if (ret)
-		goto err;
-
+		goto err_state;
+	mutex_unlock(&id_priv->handler_mutex);
 	return 0;
-err:
+err_state:
 	cma_comp_exch(id_priv, RDMA_CM_CONNECT, RDMA_CM_ROUTE_RESOLVED);
+err_unlock:
+	mutex_unlock(&id_priv->handler_mutex);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_connect);
-- 
2.26.2

