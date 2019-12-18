Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5F1125309
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 21:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLRUSN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 15:18:13 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34748 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLRUSN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Dec 2019 15:18:13 -0500
Received: by mail-yw1-f67.google.com with SMTP id b186so1298243ywc.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Dec 2019 12:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sq/hzjhd+QcFpuc8fdxLGP0FRH67ZLrQpWEBm0nJg28=;
        b=n/CgL5gwvef92UHLTMWeO0MNarHlSAe8hrEyk6a3q1Ll8b2DHLA9u84M7cwqwwBbgs
         AxBINVPimA+x0MoUwgD57b4ZHroHwR7FFzGG1H9lstuWvmgIHEjXOKtYXvVNLTysHcD0
         6gX3L9GF/BEvo6G8SmEGlNbjc921k8NYOBsko5tbRQcZNeufjeums8X4dP2PZgiGNqT1
         xWKH7iFO1sD4Ho+qKUvLg0f+iEVrKTubchYztBp5VsMKVjVVTeWv/GT//uVB18ym3f5F
         7b57/kKDmzdiT57vCKcznL88fbmtoI/bRJYlJSWsUdFhJgkGfaXXBx0UJh1GjMD31Ikx
         qCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=sq/hzjhd+QcFpuc8fdxLGP0FRH67ZLrQpWEBm0nJg28=;
        b=Pbw+ioyi/nIBAOvpYakeSk69Jpc5G8Dv2Q12My2UWGH7iDrYmXZtuX8iTvfidllOHp
         saVeVH5vbyA073TBn3UqHtCLa77brbSA/3vxAi33U74a6lHx7qfENr4FQ2chcAxY9ieJ
         dlfvRKzv0gUNgZBY3yvo8AEsmtOPl8wYXAnN0cXsiArAd9J3tJw652R/fN88EqViVMsh
         U3biCR5H9IE/XYyl8ry2a0sAnmX2LMCy0xma8IbYkIAzXRxV/CEC2RAiF5r1gwe6uefQ
         efzC0j6i6B1KDx0m74GA/XeTr1VcPBzkPyVCjoJCV5tTzZjC1/5WcqefAk4lKm89OrHo
         OsYw==
X-Gm-Message-State: APjAAAUs4OMwnaJ6ubMGHODjKH4GmItNWYLQ4TlD6VRd5oFRx7cEEahE
        48Y7uWdEjj55QKZemFG/YQs=
X-Google-Smtp-Source: APXvYqz/2BW0JanTUoYGVLyOBr9e2w799+6hSgOlUot1+ZA0gYca+DKv4LhSxXm52nclijvr0tQh4A==
X-Received: by 2002:a81:b701:: with SMTP id v1mr3783953ywh.54.1576700291580;
        Wed, 18 Dec 2019 12:18:11 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b76sm1421883ywb.77.2019.12.18.12.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 12:18:11 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBIKIATJ022497;
        Wed, 18 Dec 2019 20:18:10 GMT
Subject: [PATCH v10 1/3] RDMA/cma: Add trace points in RDMA Connection
 Manager
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dledford@redhat.com, jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 18 Dec 2019 15:18:10 -0500
Message-ID: <20191218201810.30584.3052.stgit@manet.1015granger.net>
In-Reply-To: <20191218201631.30584.53987.stgit@manet.1015granger.net>
References: <20191218201631.30584.53987.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Record state transitions as each connection is established. The IP
address of both peers and the Type of Service is reported. These
trace points are not in performance hot paths.

Also, record each cm_event_handler call to ULPs. This eliminates the
need for each ULP to add its own similar trace point in its CM event
handler function.

These new trace points appear in a new trace subsystem called
"rdma_cma".

Sample events:

           <...>-220   [004]   121.430733: cm_id_create:         cm.id=0
           <...>-472   [003]   121.430991: cm_event_handler:     cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 ADDR_RESOLVED (0/0)
           <...>-472   [003]   121.430995: cm_event_done:        cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 result=0
           <...>-472   [003]   121.431172: cm_event_handler:     cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 ROUTE_RESOLVED (2/0)
           <...>-472   [003]   121.431174: cm_event_done:        cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 result=0
           <...>-220   [004]   121.433480: cm_qp_create:         cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 pd.id=2 qp_type=RC send_wr=4091 recv_wr=256 qp_num=521 rc=0
           <...>-220   [004]   121.433577: cm_send_req:          cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 qp_num=521
     kworker/1:2-973   [001]   121.436190: cm_send_mra:          cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0
     kworker/1:2-973   [001]   121.436340: cm_send_rtu:          cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0
     kworker/1:2-973   [001]   121.436359: cm_event_handler:     cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 ESTABLISHED (9/0)
     kworker/1:2-973   [001]   121.436365: cm_event_done:        cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 result=0
           <...>-1975  [005]   123.161954: cm_disconnect:        cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0
           <...>-1975  [005]   123.161974: cm_sent_dreq:         cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0
           <...>-220   [004]   123.162102: cm_disconnect:        cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0
     kworker/0:1-13    [000]   123.162391: cm_event_handler:     cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 DISCONNECTED (10/0)
     kworker/0:1-13    [000]   123.162393: cm_event_done:        cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 result=0
           <...>-220   [004]   123.164456: cm_qp_destroy:        cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0 qp_num=521
           <...>-220   [004]   123.165290: cm_id_destroy:        cm.id=0 src=192.168.2.51:35090 dst=192.168.2.55:20049 tos=0

Some features to note:
- restracker ID of the rdma_cm_id is tagged on each trace event
- The source and destination IP addresses and TOS are reported
- CM event upcalls are shown with decoded event and status
- CM state transitions are reported
- rdma_cm_id lifetime events are captured
- The latency of ULP CM event handlers is reported
- Lifetime events of associated QPs are reported
- Device removal and insertion is reported

This patch is based on previous work by:

Saeed Mahameed <saeedm@mellanox.com>
Mukesh Kacker <mukesh.kacker@oracle.com>
Ajaykumar Hotchandani <ajaykumar.hotchandani@oracle.com>
Aron Silverton <aron.silverton@oracle.com>
Avinash Repaka <avinash.repaka@oracle.com>
Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/Makefile    |    3 
 drivers/infiniband/core/cma.c       |   88 ++++++--
 drivers/infiniband/core/cma_trace.c |   16 +
 drivers/infiniband/core/cma_trace.h |  391 +++++++++++++++++++++++++++++++++++
 4 files changed, 475 insertions(+), 23 deletions(-)
 create mode 100644 drivers/infiniband/core/cma_trace.c
 create mode 100644 drivers/infiniband/core/cma_trace.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 9a8871e21545..f22555f982e2 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -20,7 +20,8 @@ ib_cm-y :=			cm.o
 
 iw_cm-y :=			iwcm.o iwpm_util.o iwpm_msg.o
 
-rdma_cm-y :=			cma.o
+CFLAGS_cma_trace.o +=		-I$(src)
+rdma_cm-y :=			cma.o cma_trace.o
 
 rdma_cm-$(CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS) += cma_configfs.o
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 43a6f07e0afe..55a9afacfedd 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -36,6 +36,7 @@
 
 #include "core_priv.h"
 #include "cma_priv.h"
+#include "cma_trace.h"
 
 MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("Generic RDMA CM Agent");
@@ -877,6 +878,7 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
 	id_priv->seq_num &= 0x00ffffff;
 
+	trace_cm_id_create(id_priv);
 	return &id_priv->id;
 }
 EXPORT_SYMBOL(__rdma_create_id);
@@ -928,27 +930,34 @@ int rdma_create_qp(struct rdma_cm_id *id, struct ib_pd *pd,
 	int ret;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
-	if (id->device != pd->device)
-		return -EINVAL;
+	if (id->device != pd->device) {
+		ret = -EINVAL;
+		goto out_err;
+	}
 
 	qp_init_attr->port_num = id->port_num;
 	qp = ib_create_qp(pd, qp_init_attr);
-	if (IS_ERR(qp))
-		return PTR_ERR(qp);
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
+		goto out_err;
+	}
 
 	if (id->qp_type == IB_QPT_UD)
 		ret = cma_init_ud_qp(id_priv, qp);
 	else
 		ret = cma_init_conn_qp(id_priv, qp);
 	if (ret)
-		goto err;
+		goto out_destroy;
 
 	id->qp = qp;
 	id_priv->qp_num = qp->qp_num;
 	id_priv->srq = (qp->srq != NULL);
+	trace_cm_qp_create(id_priv, pd, qp_init_attr, 0);
 	return 0;
-err:
+out_destroy:
 	ib_destroy_qp(qp);
+out_err:
+	trace_cm_qp_create(id_priv, pd, qp_init_attr, ret);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_create_qp);
@@ -958,6 +967,7 @@ void rdma_destroy_qp(struct rdma_cm_id *id)
 	struct rdma_id_private *id_priv;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
+	trace_cm_qp_destroy(id_priv);
 	mutex_lock(&id_priv->qp_mutex);
 	ib_destroy_qp(id_priv->id.qp);
 	id_priv->id.qp = NULL;
@@ -1811,6 +1821,7 @@ void rdma_destroy_id(struct rdma_cm_id *id)
 	enum rdma_cm_state state;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
+	trace_cm_id_destroy(id_priv);
 	state = cma_exch(id_priv, RDMA_CM_DESTROYING);
 	cma_cancel_operation(id_priv, state);
 
@@ -1863,6 +1874,7 @@ static int cma_rep_recv(struct rdma_id_private *id_priv)
 	if (ret)
 		goto reject;
 
+	trace_cm_send_rtu(id_priv);
 	ret = ib_send_cm_rtu(id_priv->cm_id.ib, NULL, 0);
 	if (ret)
 		goto reject;
@@ -1871,6 +1883,7 @@ static int cma_rep_recv(struct rdma_id_private *id_priv)
 reject:
 	pr_debug_ratelimited("RDMA CM: CONNECT_ERROR: failed to handle reply. status %d\n", ret);
 	cma_modify_qp_err(id_priv);
+	trace_cm_send_rej(id_priv);
 	ib_send_cm_rej(id_priv->cm_id.ib, IB_CM_REJ_CONSUMER_DEFINED,
 		       NULL, 0, NULL, 0);
 	return ret;
@@ -1890,6 +1903,17 @@ static void cma_set_rep_event_data(struct rdma_cm_event *event,
 	event->param.conn.qp_num = rep_data->remote_qpn;
 }
 
+static int cma_cm_event_handler(struct rdma_id_private *id_priv,
+				struct rdma_cm_event *event)
+{
+	int ret;
+
+	trace_cm_event_handler(id_priv, event);
+	ret = id_priv->id.event_handler(&id_priv->id, event);
+	trace_cm_event_done(id_priv, event, ret);
+	return ret;
+}
+
 static int cma_ib_handler(struct ib_cm_id *cm_id,
 			  const struct ib_cm_event *ib_event)
 {
@@ -1912,8 +1936,10 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
 		break;
 	case IB_CM_REP_RECEIVED:
 		if (cma_comp(id_priv, RDMA_CM_CONNECT) &&
-		    (id_priv->id.qp_type != IB_QPT_UD))
+		    (id_priv->id.qp_type != IB_QPT_UD)) {
+			trace_cm_send_mra(id_priv);
 			ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
+		}
 		if (id_priv->id.qp) {
 			event.status = cma_rep_recv(id_priv);
 			event.event = event.status ? RDMA_CM_EVENT_CONNECT_ERROR :
@@ -1958,7 +1984,7 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
 		goto out;
 	}
 
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.ib = NULL;
@@ -2119,6 +2145,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	if (IS_ERR(listen_id))
 		return PTR_ERR(listen_id);
 
+	trace_cm_req_handler(listen_id, ib_event->event);
 	if (!cma_ib_check_req_qp_type(&listen_id->id, ib_event)) {
 		ret = -EINVAL;
 		goto net_dev_put;
@@ -2161,7 +2188,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	 * until we're done accessing it.
 	 */
 	atomic_inc(&conn_id->refcount);
-	ret = conn_id->id.event_handler(&conn_id->id, &event);
+	ret = cma_cm_event_handler(conn_id, &event);
 	if (ret)
 		goto err3;
 	/*
@@ -2170,8 +2197,10 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	 */
 	mutex_lock(&lock);
 	if (cma_comp(conn_id, RDMA_CM_CONNECT) &&
-	    (conn_id->id.qp_type != IB_QPT_UD))
+	    (conn_id->id.qp_type != IB_QPT_UD)) {
+		trace_cm_send_mra(cm_id->context);
 		ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
+	}
 	mutex_unlock(&lock);
 	mutex_unlock(&conn_id->handler_mutex);
 	mutex_unlock(&listen_id->handler_mutex);
@@ -2286,7 +2315,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	event.status = iw_event->status;
 	event.param.conn.private_data = iw_event->private_data;
 	event.param.conn.private_data_len = iw_event->private_data_len;
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.iw = NULL;
@@ -2363,7 +2392,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 	 * until we're done accessing it.
 	 */
 	atomic_inc(&conn_id->refcount);
-	ret = conn_id->id.event_handler(&conn_id->id, &event);
+	ret = cma_cm_event_handler(conn_id, &event);
 	if (ret) {
 		/* User wants to destroy the CM ID */
 		conn_id->cm_id.iw = NULL;
@@ -2435,6 +2464,7 @@ static int cma_listen_handler(struct rdma_cm_id *id,
 
 	id->context = id_priv->id.context;
 	id->event_handler = id_priv->id.event_handler;
+	trace_cm_event_handler(id_priv, event);
 	return id_priv->id.event_handler(id, event);
 }
 
@@ -2611,7 +2641,7 @@ static void cma_work_handler(struct work_struct *_work)
 	if (!cma_comp_exch(id_priv, work->old_state, work->new_state))
 		goto out;
 
-	if (id_priv->id.event_handler(&id_priv->id, &work->event)) {
+	if (cma_cm_event_handler(id_priv, &work->event)) {
 		cma_exch(id_priv, RDMA_CM_DESTROYING);
 		destroy = 1;
 	}
@@ -2634,7 +2664,7 @@ static void cma_ndev_work_handler(struct work_struct *_work)
 	    id_priv->state == RDMA_CM_DEVICE_REMOVAL)
 		goto out;
 
-	if (id_priv->id.event_handler(&id_priv->id, &work->event)) {
+	if (cma_cm_event_handler(id_priv, &work->event)) {
 		cma_exch(id_priv, RDMA_CM_DESTROYING);
 		destroy = 1;
 	}
@@ -3089,7 +3119,7 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 	} else
 		event.event = RDMA_CM_EVENT_ADDR_RESOLVED;
 
-	if (id_priv->id.event_handler(&id_priv->id, &event)) {
+	if (cma_cm_event_handler(id_priv, &event)) {
 		cma_exch(id_priv, RDMA_CM_DESTROYING);
 		mutex_unlock(&id_priv->handler_mutex);
 		rdma_destroy_id(&id_priv->id);
@@ -3736,7 +3766,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id *cm_id,
 		goto out;
 	}
 
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 
 	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
 	if (ret) {
@@ -3800,6 +3830,7 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
 	req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
 	req.max_cm_retries = CMA_MAX_CM_RETRIES;
 
+	trace_cm_send_sidr_req(id_priv);
 	ret = ib_send_cm_sidr_req(id_priv->cm_id.ib, &req);
 	if (ret) {
 		ib_destroy_cm_id(id_priv->cm_id.ib);
@@ -3873,6 +3904,7 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	req.max_cm_retries = CMA_MAX_CM_RETRIES;
 	req.srq = id_priv->srq ? 1 : 0;
 
+	trace_cm_send_req(id_priv);
 	ret = ib_send_cm_req(id_priv->cm_id.ib, &req);
 out:
 	if (ret && !IS_ERR(id)) {
@@ -3986,6 +4018,7 @@ static int cma_accept_ib(struct rdma_id_private *id_priv,
 	rep.rnr_retry_count = min_t(u8, 7, conn_param->rnr_retry_count);
 	rep.srq = id_priv->srq ? 1 : 0;
 
+	trace_cm_send_rep(id_priv);
 	ret = ib_send_cm_rep(id_priv->cm_id.ib, &rep);
 out:
 	return ret;
@@ -4035,6 +4068,7 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
 	rep.private_data = private_data;
 	rep.private_data_len = private_data_len;
 
+	trace_cm_send_sidr_rep(id_priv);
 	return ib_send_cm_sidr_rep(id_priv->cm_id.ib, &rep);
 }
 
@@ -4120,13 +4154,15 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,
 		return -EINVAL;
 
 	if (rdma_cap_ib_cm(id->device, id->port_num)) {
-		if (id->qp_type == IB_QPT_UD)
+		if (id->qp_type == IB_QPT_UD) {
 			ret = cma_send_sidr_rep(id_priv, IB_SIDR_REJECT, 0,
 						private_data, private_data_len);
-		else
+		} else {
+			trace_cm_send_rej(id_priv);
 			ret = ib_send_cm_rej(id_priv->cm_id.ib,
 					     IB_CM_REJ_CONSUMER_DEFINED, NULL,
 					     0, private_data, private_data_len);
+		}
 	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
 		ret = iw_cm_reject(id_priv->cm_id.iw,
 				   private_data, private_data_len);
@@ -4151,8 +4187,13 @@ int rdma_disconnect(struct rdma_cm_id *id)
 		if (ret)
 			goto out;
 		/* Initiate or respond to a disconnect. */
-		if (ib_send_cm_dreq(id_priv->cm_id.ib, NULL, 0))
-			ib_send_cm_drep(id_priv->cm_id.ib, NULL, 0);
+		trace_cm_disconnect(id_priv);
+		if (ib_send_cm_dreq(id_priv->cm_id.ib, NULL, 0)) {
+			if (!ib_send_cm_drep(id_priv->cm_id.ib, NULL, 0))
+				trace_cm_sent_drep(id_priv);
+		} else {
+			trace_cm_sent_dreq(id_priv);
+		}
 	} else if (rdma_cap_iw_cm(id->device, id->port_num)) {
 		ret = iw_cm_disconnect(id_priv->cm_id.iw, 0);
 	} else
@@ -4218,7 +4259,7 @@ static int cma_ib_mc_handler(int status, struct ib_sa_multicast *multicast)
 	} else
 		event.event = RDMA_CM_EVENT_MULTICAST_ERROR;
 
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 
 	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
 	if (ret) {
@@ -4623,6 +4664,7 @@ static void cma_add_one(struct ib_device *device)
 		cma_listen_on_dev(id_priv, cma_dev);
 	mutex_unlock(&lock);
 
+	trace_cm_add_one(device);
 	return;
 
 free_gid_type:
@@ -4653,7 +4695,7 @@ static int cma_remove_id_dev(struct rdma_id_private *id_priv)
 		goto out;
 
 	event.event = RDMA_CM_EVENT_DEVICE_REMOVAL;
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 out:
 	mutex_unlock(&id_priv->handler_mutex);
 	return ret;
@@ -4691,6 +4733,8 @@ static void cma_remove_one(struct ib_device *device, void *client_data)
 {
 	struct cma_device *cma_dev = client_data;
 
+	trace_cm_remove_one(device);
+
 	if (!cma_dev)
 		return;
 
diff --git a/drivers/infiniband/core/cma_trace.c b/drivers/infiniband/core/cma_trace.c
new file mode 100644
index 000000000000..b314a281e10e
--- /dev/null
+++ b/drivers/infiniband/core/cma_trace.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Trace points for the RDMA Connection Manager.
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
+ */
+
+#define CREATE_TRACE_POINTS
+
+#include <rdma/rdma_cm.h>
+#include <rdma/ib_cm.h>
+#include "cma_priv.h"
+
+#include "cma_trace.h"
diff --git a/drivers/infiniband/core/cma_trace.h b/drivers/infiniband/core/cma_trace.h
new file mode 100644
index 000000000000..81e36bf13159
--- /dev/null
+++ b/drivers/infiniband/core/cma_trace.h
@@ -0,0 +1,391 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Trace point definitions for the RDMA Connect Manager.
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2019, Oracle and/or its affiliates. All rights reserved.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rdma_cma
+
+#if !defined(_TRACE_RDMA_CMA_H) || defined(TRACE_HEADER_MULTI_READ)
+
+#define _TRACE_RDMA_CMA_H
+
+#include <linux/tracepoint.h>
+#include <trace/events/rdma.h>
+
+/*
+ * enum ib_cm_event_type, from include/rdma/ib_cm.h
+ */
+#define IB_CM_EVENT_LIST			\
+	ib_cm_event(REQ_ERROR)			\
+	ib_cm_event(REQ_RECEIVED)		\
+	ib_cm_event(REP_ERROR)			\
+	ib_cm_event(REP_RECEIVED)		\
+	ib_cm_event(RTU_RECEIVED)		\
+	ib_cm_event(USER_ESTABLISHED)		\
+	ib_cm_event(DREQ_ERROR)			\
+	ib_cm_event(DREQ_RECEIVED)		\
+	ib_cm_event(DREP_RECEIVED)		\
+	ib_cm_event(TIMEWAIT_EXIT)		\
+	ib_cm_event(MRA_RECEIVED)		\
+	ib_cm_event(REJ_RECEIVED)		\
+	ib_cm_event(LAP_ERROR)			\
+	ib_cm_event(LAP_RECEIVED)		\
+	ib_cm_event(APR_RECEIVED)		\
+	ib_cm_event(SIDR_REQ_ERROR)		\
+	ib_cm_event(SIDR_REQ_RECEIVED)		\
+	ib_cm_event_end(SIDR_REP_RECEIVED)
+
+#undef ib_cm_event
+#undef ib_cm_event_end
+
+#define ib_cm_event(x)		TRACE_DEFINE_ENUM(IB_CM_##x);
+#define ib_cm_event_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
+
+IB_CM_EVENT_LIST
+
+#undef ib_cm_event
+#undef ib_cm_event_end
+
+#define ib_cm_event(x)		{ IB_CM_##x, #x },
+#define ib_cm_event_end(x)	{ IB_CM_##x, #x }
+
+#define rdma_show_ib_cm_event(x) \
+		__print_symbolic(x, IB_CM_EVENT_LIST)
+
+
+DECLARE_EVENT_CLASS(cma_fsm_class,
+	TP_PROTO(
+		const struct rdma_id_private *id_priv
+	),
+
+	TP_ARGS(id_priv),
+
+	TP_STRUCT__entry(
+		__field(u32, cm_id)
+		__field(u32, tos)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->cm_id = id_priv->res.id;
+		__entry->tos = id_priv->tos;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm.id=%u src=%pISpc dst=%pISpc tos=%u",
+		__entry->cm_id, __entry->srcaddr, __entry->dstaddr, __entry->tos
+	)
+);
+
+#define DEFINE_CMA_FSM_EVENT(name)						\
+		DEFINE_EVENT(cma_fsm_class, cm_##name,				\
+				TP_PROTO(					\
+					const struct rdma_id_private *id_priv	\
+				),						\
+				TP_ARGS(id_priv))
+
+DEFINE_CMA_FSM_EVENT(send_rtu);
+DEFINE_CMA_FSM_EVENT(send_rej);
+DEFINE_CMA_FSM_EVENT(send_mra);
+DEFINE_CMA_FSM_EVENT(send_sidr_req);
+DEFINE_CMA_FSM_EVENT(send_sidr_rep);
+DEFINE_CMA_FSM_EVENT(disconnect);
+DEFINE_CMA_FSM_EVENT(sent_drep);
+DEFINE_CMA_FSM_EVENT(sent_dreq);
+DEFINE_CMA_FSM_EVENT(id_destroy);
+
+TRACE_EVENT(cm_id_create,
+	TP_PROTO(
+		const struct rdma_id_private *id_priv
+	),
+
+	TP_ARGS(id_priv),
+
+	TP_STRUCT__entry(
+		__field(u32, cm_id)
+	),
+
+	TP_fast_assign(
+		__entry->cm_id = id_priv->res.id;
+	),
+
+	TP_printk("cm.id=%u",
+		__entry->cm_id
+	)
+);
+
+DECLARE_EVENT_CLASS(cma_qp_class,
+	TP_PROTO(
+		const struct rdma_id_private *id_priv
+	),
+
+	TP_ARGS(id_priv),
+
+	TP_STRUCT__entry(
+		__field(u32, cm_id)
+		__field(u32, tos)
+		__field(u32, qp_num)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->cm_id = id_priv->res.id;
+		__entry->tos = id_priv->tos;
+		__entry->qp_num = id_priv->qp_num;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm.id=%u src=%pISpc dst=%pISpc tos=%u qp_num=%u",
+		__entry->cm_id, __entry->srcaddr, __entry->dstaddr, __entry->tos,
+		__entry->qp_num
+	)
+);
+
+#define DEFINE_CMA_QP_EVENT(name)						\
+		DEFINE_EVENT(cma_qp_class, cm_##name,				\
+				TP_PROTO(					\
+					const struct rdma_id_private *id_priv	\
+				),						\
+				TP_ARGS(id_priv))
+
+DEFINE_CMA_QP_EVENT(send_req);
+DEFINE_CMA_QP_EVENT(send_rep);
+DEFINE_CMA_QP_EVENT(qp_destroy);
+
+/*
+ * enum ib_wp_type, from include/rdma/ib_verbs.h
+ */
+#define IB_QP_TYPE_LIST				\
+	ib_qp_type(SMI)				\
+	ib_qp_type(GSI)				\
+	ib_qp_type(RC)				\
+	ib_qp_type(UC)				\
+	ib_qp_type(UD)				\
+	ib_qp_type(RAW_IPV6)			\
+	ib_qp_type(RAW_ETHERTYPE)		\
+	ib_qp_type(RAW_PACKET)			\
+	ib_qp_type(XRC_INI)			\
+	ib_qp_type_end(XRC_TGT)
+
+#undef ib_qp_type
+#undef ib_qp_type_end
+
+#define ib_qp_type(x)		TRACE_DEFINE_ENUM(IB_QPT_##x);
+#define ib_qp_type_end(x)	TRACE_DEFINE_ENUM(IB_QPT_##x);
+
+IB_QP_TYPE_LIST
+
+#undef ib_qp_type
+#undef ib_qp_type_end
+
+#define ib_qp_type(x)		{ IB_QPT_##x, #x },
+#define ib_qp_type_end(x)	{ IB_QPT_##x, #x }
+
+#define rdma_show_qp_type(x) \
+		__print_symbolic(x, IB_QP_TYPE_LIST)
+
+
+TRACE_EVENT(cm_qp_create,
+	TP_PROTO(
+		const struct rdma_id_private *id_priv,
+		const struct ib_pd *pd,
+		const struct ib_qp_init_attr *qp_init_attr,
+		int rc
+	),
+
+	TP_ARGS(id_priv, pd, qp_init_attr, rc),
+
+	TP_STRUCT__entry(
+		__field(u32, cm_id)
+		__field(u32, pd_id)
+		__field(u32, tos)
+		__field(u32, qp_num)
+		__field(u32, send_wr)
+		__field(u32, recv_wr)
+		__field(int, rc)
+		__field(unsigned long, qp_type)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->cm_id = id_priv->res.id;
+		__entry->pd_id = pd->res.id;
+		__entry->tos = id_priv->tos;
+		__entry->send_wr = qp_init_attr->cap.max_send_wr;
+		__entry->recv_wr = qp_init_attr->cap.max_recv_wr;
+		__entry->rc = rc;
+		if (!rc) {
+			__entry->qp_num = id_priv->qp_num;
+			__entry->qp_type = id_priv->id.qp_type;
+		} else {
+			__entry->qp_num = 0;
+			__entry->qp_type = 0;
+		}
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm.id=%u src=%pISpc dst=%pISpc tos=%u pd.id=%u qp_type=%s"
+		" send_wr=%u recv_wr=%u qp_num=%u rc=%d",
+		__entry->cm_id, __entry->srcaddr, __entry->dstaddr,
+		__entry->tos, __entry->pd_id,
+		rdma_show_qp_type(__entry->qp_type), __entry->send_wr,
+		__entry->recv_wr, __entry->qp_num, __entry->rc
+	)
+);
+
+TRACE_EVENT(cm_req_handler,
+	TP_PROTO(
+		const struct rdma_id_private *id_priv,
+		int event
+	),
+
+	TP_ARGS(id_priv, event),
+
+	TP_STRUCT__entry(
+		__field(u32, cm_id)
+		__field(u32, tos)
+		__field(unsigned long, event)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->cm_id = id_priv->res.id;
+		__entry->tos = id_priv->tos;
+		__entry->event = event;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm.id=%u src=%pISpc dst=%pISpc tos=%u %s (%lu)",
+		__entry->cm_id, __entry->srcaddr, __entry->dstaddr, __entry->tos,
+		rdma_show_ib_cm_event(__entry->event), __entry->event
+	)
+);
+
+TRACE_EVENT(cm_event_handler,
+	TP_PROTO(
+		const struct rdma_id_private *id_priv,
+		const struct rdma_cm_event *event
+	),
+
+	TP_ARGS(id_priv, event),
+
+	TP_STRUCT__entry(
+		__field(u32, cm_id)
+		__field(u32, tos)
+		__field(unsigned long, event)
+		__field(int, status)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->cm_id = id_priv->res.id;
+		__entry->tos = id_priv->tos;
+		__entry->event = event->event;
+		__entry->status = event->status;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm.id=%u src=%pISpc dst=%pISpc tos=%u %s (%lu/%d)",
+		__entry->cm_id, __entry->srcaddr, __entry->dstaddr, __entry->tos,
+		rdma_show_cm_event(__entry->event), __entry->event,
+		__entry->status
+	)
+);
+
+TRACE_EVENT(cm_event_done,
+	TP_PROTO(
+		const struct rdma_id_private *id_priv,
+		const struct rdma_cm_event *event,
+		int result
+	),
+
+	TP_ARGS(id_priv, event, result),
+
+	TP_STRUCT__entry(
+		__field(u32, cm_id)
+		__field(u32, tos)
+		__field(unsigned long, event)
+		__field(int, result)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->cm_id = id_priv->res.id;
+		__entry->tos = id_priv->tos;
+		__entry->event = event->event;
+		__entry->result = result;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm.id=%u src=%pISpc dst=%pISpc tos=%u %s consumer returns %d",
+		__entry->cm_id, __entry->srcaddr, __entry->dstaddr, __entry->tos,
+		rdma_show_cm_event(__entry->event), __entry->result
+	)
+);
+
+DECLARE_EVENT_CLASS(cma_client_class,
+	TP_PROTO(
+		const struct ib_device *device
+	),
+
+	TP_ARGS(device),
+
+	TP_STRUCT__entry(
+		__string(name, device->name)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, device->name);
+	),
+
+	TP_printk("device name=%s",
+		__get_str(name)
+	)
+);
+
+#define DEFINE_CMA_CLIENT_EVENT(name)						\
+		DEFINE_EVENT(cma_client_class, cm_##name,			\
+				TP_PROTO(					\
+					const struct ib_device *device		\
+				),						\
+				TP_ARGS(device))
+
+DEFINE_CMA_CLIENT_EVENT(add_one);
+DEFINE_CMA_CLIENT_EVENT(remove_one);
+
+#endif /* _TRACE_RDMA_CMA_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE cma_trace
+
+#include <trace/define_trace.h>

