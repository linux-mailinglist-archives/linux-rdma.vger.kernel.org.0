Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4654F10ECFC
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2019 17:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLBQVE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 11:21:04 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40441 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBQVE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Dec 2019 11:21:04 -0500
Received: by mail-yb1-f193.google.com with SMTP id n3so178645ybm.7
        for <linux-rdma@vger.kernel.org>; Mon, 02 Dec 2019 08:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=05O/nehwqublQouCX90lv63raUCh5CR8VJ93aTwrn3c=;
        b=dlm/zvqLv3xQiKnGJgpmRdMyOQc1rPf0sFw0TYJ908gA9oD0VQGEHQTyKEObW3n2Zb
         ek5GVHdAvEJOydIoIyHV92Xfl6LpqQl5PkYO9a9llWjb60VodalmJ/t9CoXvyM0SuJN5
         7iQEVLJwhs0/K3QcYI9NtPX/GJW0YM46AWq1XdHbDrCk0eKXEHLeYJGrKLPDXujaDrZg
         g5nGNKvRwyF3tKqwIjWR3gjLD1eVvrPKnvfxdJte7KGXkS0NQjY0KUnxOottd+vipYM7
         hH6RlaaBIQg1foSH3CWRmza5QdxdDBgQYD9dpApR7XBCPgxBLUKpQTOdzFONVASbcs+V
         KYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=05O/nehwqublQouCX90lv63raUCh5CR8VJ93aTwrn3c=;
        b=C8fKuadx6Or7X2mAZPnqEgjNnrQSTrs75Nb9U7iTDqE36sf4+uIHRbwZCBRld90L0f
         ZqJr2JOn4iyqT/w9UGhkfmODDiv9gQFopUs0JUpYB3E41xvuyX9QHY1GoPEqonXAM2Dg
         AZpfR7FRx+DJzSVaA7lUY2f7xplmmq4SIQqP8OW5YQV/5CCCyCuNVRzKvMqGdDZ/w6cp
         L4cZe9r8A2SpgeP6ZFpL1rV1GKE15LvvvA5kWs+sPc6z9otp1129Bj4EYpuzC24ZEwzS
         NgY+alIuFxPudw16YBowS4LxW1mtqxSjtR8B4blAJZLN0IpQZFvK2zvsr3lsM0tDJdGg
         yLqQ==
X-Gm-Message-State: APjAAAWCYL1HUUZw4bGyS2tURnBpxLzp03huplR1GTpDs/Nl86ApIZS9
        cwPJR+zfmbw9GTt/NOwSBmofqWtP
X-Google-Smtp-Source: APXvYqwFH1ZrsZx2Fnjcoqqg0jfQiSYevvLo+d5wDJhbORAGQRAXCZVT2qgSeMhKgBH4N/7KewbKQw==
X-Received: by 2002:a25:2787:: with SMTP id n129mr202659ybn.50.1575303661952;
        Mon, 02 Dec 2019 08:21:01 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a74sm34025ywe.42.2019.12.02.08.21.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 08:21:01 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xB2GL0GO014245
        for <linux-rdma@vger.kernel.org>; Mon, 2 Dec 2019 16:21:00 GMT
Subject: [PATCH v8 1/3] RDMA/cma: Add trace points in RDMA Connection Manager
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 02 Dec 2019 11:21:00 -0500
Message-ID: <20191202162059.3950.33654.stgit@manet.1015granger.net>
In-Reply-To: <20191202161518.3950.61082.stgit@manet.1015granger.net>
References: <20191202161518.3950.61082.stgit@manet.1015granger.net>
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

   kworker/u24:2-2127  [011]   696.746254: cm_event_handler:     cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0 ADDR_RESOLVED (0/0)
   kworker/u24:2-2127  [011]   696.746880: cm_event_handler:     cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0 ROUTE_RESOLVED (2/0)
   kworker/u28:2-2214  [001]   696.776316: cm_send_req:          cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0 qp_num=526
     kworker/1:3-972   [001]   696.777603: cm_send_mra:          cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0
     kworker/1:3-972   [001]   696.778062: cm_send_rtu:          cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0
     kworker/1:3-972   [001]   696.778198: cm_event_handler:     cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0 ESTABLISHED (9/0)
     kworker/1:3-972   [001]   700.621750: cm_disconnect:        cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0
     kworker/1:3-972   [001]   700.621881: cm_sent_dreq:         cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0
     kworker/3:2-512   [003]   700.622354: cm_event_handler:     cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0 DISCONNECTED (10/0)

Some features to note:
- restracker ID of the rdma_cm_id is tagged on each trace event
- The source and destination IP addresses and TOS are reported
- CM event upcalls are shown with decoded event and status
- CM state transitions are reported
- rdma_cm_id lifetime events are captured
- The latency of ULP CM event handlers is reported
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
 drivers/infiniband/core/Makefile    |    2 
 drivers/infiniband/core/cma.c       |   68 ++++++--
 drivers/infiniband/core/cma_trace.c |   16 ++
 drivers/infiniband/core/cma_trace.h |  302 +++++++++++++++++++++++++++++++++++
 4 files changed, 371 insertions(+), 17 deletions(-)
 create mode 100644 drivers/infiniband/core/cma_trace.c
 create mode 100644 drivers/infiniband/core/cma_trace.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 09881bd5f12d..c8f89f0a3e8f 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -20,7 +20,7 @@ ib_cm-y :=			cm.o
 
 iw_cm-y :=			iwcm.o iwpm_util.o iwpm_msg.o
 
-rdma_cm-y :=			cma.o
+rdma_cm-y :=			cma.o cma_trace.o
 
 rdma_cm-$(CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS) += cma_configfs.o
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index d78f67623f24..9f68d716efd5 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -63,6 +63,7 @@
 
 #include "core_priv.h"
 #include "cma_priv.h"
+#include "cma_trace.h"
 
 MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("Generic RDMA CM Agent");
@@ -904,6 +905,7 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
 	id_priv->seq_num &= 0x00ffffff;
 
+	trace_cm_create(id_priv);
 	return &id_priv->id;
 }
 EXPORT_SYMBOL(__rdma_create_id);
@@ -1838,6 +1840,7 @@ void rdma_destroy_id(struct rdma_cm_id *id)
 	enum rdma_cm_state state;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
+	trace_cm_destroy(id_priv);
 	state = cma_exch(id_priv, RDMA_CM_DESTROYING);
 	cma_cancel_operation(id_priv, state);
 
@@ -1890,6 +1893,7 @@ static int cma_rep_recv(struct rdma_id_private *id_priv)
 	if (ret)
 		goto reject;
 
+	trace_cm_send_rtu(id_priv);
 	ret = ib_send_cm_rtu(id_priv->cm_id.ib, NULL, 0);
 	if (ret)
 		goto reject;
@@ -1898,6 +1902,7 @@ static int cma_rep_recv(struct rdma_id_private *id_priv)
 reject:
 	pr_debug_ratelimited("RDMA CM: CONNECT_ERROR: failed to handle reply. status %d\n", ret);
 	cma_modify_qp_err(id_priv);
+	trace_cm_send_rej(id_priv);
 	ib_send_cm_rej(id_priv->cm_id.ib, IB_CM_REJ_CONSUMER_DEFINED,
 		       NULL, 0, NULL, 0);
 	return ret;
@@ -1917,6 +1922,17 @@ static void cma_set_rep_event_data(struct rdma_cm_event *event,
 	event->param.conn.qp_num = rep_data->remote_qpn;
 }
 
+static int cma_cm_event_handler(struct rdma_id_private *id_priv,
+				struct rdma_cm_event *event)
+{
+	int ret;
+
+	trace_cm_event_handler(id_priv, event);
+	ret = id_priv->id.event_handler(&id_priv->id, event);
+	trace_cm_event_done(id_priv, ret);
+	return ret;
+}
+
 static int cma_ib_handler(struct ib_cm_id *cm_id,
 			  const struct ib_cm_event *ib_event)
 {
@@ -1939,8 +1955,10 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
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
@@ -1985,7 +2003,7 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
 		goto out;
 	}
 
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.ib = NULL;
@@ -2146,6 +2164,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	if (IS_ERR(listen_id))
 		return PTR_ERR(listen_id);
 
+	trace_cm_req_handler(listen_id, ib_event->event);
 	if (!cma_ib_check_req_qp_type(&listen_id->id, ib_event)) {
 		ret = -EINVAL;
 		goto net_dev_put;
@@ -2188,7 +2207,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	 * until we're done accessing it.
 	 */
 	atomic_inc(&conn_id->refcount);
-	ret = conn_id->id.event_handler(&conn_id->id, &event);
+	ret = cma_cm_event_handler(conn_id, &event);
 	if (ret)
 		goto err3;
 	/*
@@ -2197,8 +2216,10 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
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
@@ -2313,7 +2334,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	event.status = iw_event->status;
 	event.param.conn.private_data = iw_event->private_data;
 	event.param.conn.private_data_len = iw_event->private_data_len;
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.iw = NULL;
@@ -2390,7 +2411,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 	 * until we're done accessing it.
 	 */
 	atomic_inc(&conn_id->refcount);
-	ret = conn_id->id.event_handler(&conn_id->id, &event);
+	ret = cma_cm_event_handler(conn_id, &event);
 	if (ret) {
 		/* User wants to destroy the CM ID */
 		conn_id->cm_id.iw = NULL;
@@ -2462,6 +2483,7 @@ static int cma_listen_handler(struct rdma_cm_id *id,
 
 	id->context = id_priv->id.context;
 	id->event_handler = id_priv->id.event_handler;
+	trace_cm_event_handler(id_priv, event);
 	return id_priv->id.event_handler(id, event);
 }
 
@@ -2636,7 +2658,7 @@ static void cma_work_handler(struct work_struct *_work)
 	if (!cma_comp_exch(id_priv, work->old_state, work->new_state))
 		goto out;
 
-	if (id_priv->id.event_handler(&id_priv->id, &work->event)) {
+	if (cma_cm_event_handler(id_priv, &work->event)) {
 		cma_exch(id_priv, RDMA_CM_DESTROYING);
 		destroy = 1;
 	}
@@ -2659,7 +2681,7 @@ static void cma_ndev_work_handler(struct work_struct *_work)
 	    id_priv->state == RDMA_CM_DEVICE_REMOVAL)
 		goto out;
 
-	if (id_priv->id.event_handler(&id_priv->id, &work->event)) {
+	if (cma_cm_event_handler(id_priv, &work->event)) {
 		cma_exch(id_priv, RDMA_CM_DESTROYING);
 		destroy = 1;
 	}
@@ -3062,7 +3084,7 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 	} else
 		event.event = RDMA_CM_EVENT_ADDR_RESOLVED;
 
-	if (id_priv->id.event_handler(&id_priv->id, &event)) {
+	if (cma_cm_event_handler(id_priv, &event)) {
 		cma_exch(id_priv, RDMA_CM_DESTROYING);
 		mutex_unlock(&id_priv->handler_mutex);
 		rdma_destroy_id(&id_priv->id);
@@ -3709,7 +3731,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id *cm_id,
 		goto out;
 	}
 
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 
 	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
 	if (ret) {
@@ -3773,6 +3795,7 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
 	req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
 	req.max_cm_retries = CMA_MAX_CM_RETRIES;
 
+	trace_cm_send_sidr_req(id_priv);
 	ret = ib_send_cm_sidr_req(id_priv->cm_id.ib, &req);
 	if (ret) {
 		ib_destroy_cm_id(id_priv->cm_id.ib);
@@ -3846,6 +3869,7 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	req.max_cm_retries = CMA_MAX_CM_RETRIES;
 	req.srq = id_priv->srq ? 1 : 0;
 
+	trace_cm_send_req(id_priv);
 	ret = ib_send_cm_req(id_priv->cm_id.ib, &req);
 out:
 	if (ret && !IS_ERR(id)) {
@@ -3959,6 +3983,7 @@ static int cma_accept_ib(struct rdma_id_private *id_priv,
 	rep.rnr_retry_count = min_t(u8, 7, conn_param->rnr_retry_count);
 	rep.srq = id_priv->srq ? 1 : 0;
 
+	trace_cm_send_rep(id_priv);
 	ret = ib_send_cm_rep(id_priv->cm_id.ib, &rep);
 out:
 	return ret;
@@ -4008,6 +4033,7 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
 	rep.private_data = private_data;
 	rep.private_data_len = private_data_len;
 
+	trace_cm_send_sidr_rep(id_priv);
 	return ib_send_cm_sidr_rep(id_priv->cm_id.ib, &rep);
 }
 
@@ -4093,13 +4119,15 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,
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
@@ -4124,8 +4152,13 @@ int rdma_disconnect(struct rdma_cm_id *id)
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
@@ -4191,7 +4224,7 @@ static int cma_ib_mc_handler(int status, struct ib_sa_multicast *multicast)
 	} else
 		event.event = RDMA_CM_EVENT_MULTICAST_ERROR;
 
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 
 	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
 	if (ret) {
@@ -4596,6 +4629,7 @@ static void cma_add_one(struct ib_device *device)
 		cma_listen_on_dev(id_priv, cma_dev);
 	mutex_unlock(&lock);
 
+	trace_cm_add_one(device);
 	return;
 
 free_gid_type:
@@ -4626,7 +4660,7 @@ static int cma_remove_id_dev(struct rdma_id_private *id_priv)
 		goto out;
 
 	event.event = RDMA_CM_EVENT_DEVICE_REMOVAL;
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 out:
 	mutex_unlock(&id_priv->handler_mutex);
 	return ret;
@@ -4664,6 +4698,8 @@ static void cma_remove_one(struct ib_device *device, void *client_data)
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
index 000000000000..2ca45622f215
--- /dev/null
+++ b/drivers/infiniband/core/cma_trace.h
@@ -0,0 +1,302 @@
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
+		__field(u32, id)
+		__field(u32, tos)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->id = id_priv->res.id;
+		__entry->tos = id_priv->tos;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm_id.id=%u src: %pISpc dst: %pISpc tos=%u",
+		__entry->id, __entry->srcaddr, __entry->dstaddr, __entry->tos
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
+DEFINE_CMA_FSM_EVENT(destroy);
+
+TRACE_EVENT(cm_create,
+	TP_PROTO(
+		const struct rdma_id_private *id_priv
+	),
+
+	TP_ARGS(id_priv),
+
+	TP_STRUCT__entry(
+		__field(u32, id)
+	),
+
+	TP_fast_assign(
+		__entry->id = id_priv->res.id;
+	),
+
+	TP_printk("cm_id.id=%u",
+		__entry->id
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
+		__field(u32, id)
+		__field(u32, tos)
+		__field(u32, qp_num)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->id = id_priv->res.id;
+		__entry->tos = id_priv->tos;
+		__entry->qp_num = id_priv->qp_num;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm_id.id=%u src: %pISpc dst: %pISpc tos=%u qp_num=%u",
+		__entry->id, __entry->srcaddr, __entry->dstaddr, __entry->tos,
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
+		__field(u32, id)
+		__field(u32, tos)
+		__field(unsigned long, event)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->id = id_priv->res.id;
+		__entry->tos = id_priv->tos;
+		__entry->event = event;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm_id.id=%u src: %pISpc dst: %pISpc tos=%u %s (%lu)",
+		__entry->id, __entry->srcaddr, __entry->dstaddr, __entry->tos,
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
+		__field(u32, id)
+		__field(u32, tos)
+		__field(unsigned long, event)
+		__field(int, status)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->id = id_priv->res.id;
+		__entry->tos = id_priv->tos;
+		__entry->event = event->event;
+		__entry->status = event->status;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm_id.id=%u src: %pISpc dst: %pISpc tos=%u %s (%lu/%d)",
+		__entry->id, __entry->srcaddr, __entry->dstaddr, __entry->tos,
+		rdma_show_cm_event(__entry->event), __entry->event,
+		__entry->status
+	)
+);
+
+TRACE_EVENT(cm_event_done,
+	TP_PROTO(
+		const struct rdma_id_private *id_priv,
+		int result
+	),
+
+	TP_ARGS(id_priv, result),
+
+	TP_STRUCT__entry(
+		__field(u32, id)
+		__field(u32, tos)
+		__field(int, result)
+		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->id = id_priv->res.id;
+		__entry->tos = id_priv->tos;
+		__entry->result = result;
+		memcpy(__entry->srcaddr, &id_priv->id.route.addr.src_addr,
+		       sizeof(struct sockaddr_in6));
+		memcpy(__entry->dstaddr, &id_priv->id.route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("cm_id.id=%u src: %pISpc dst: %pISpc tos=%u result=%d",
+		__entry->id, __entry->srcaddr, __entry->dstaddr, __entry->tos,
+		__entry->result
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

