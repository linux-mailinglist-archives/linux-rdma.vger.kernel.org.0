Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC0100E37
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 22:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKRVtS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 16:49:18 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35209 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKRVtS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 16:49:18 -0500
Received: by mail-yw1-f66.google.com with SMTP id r131so6499234ywh.2
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 13:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jftxE3WHMLu52rZG9IffXIH9L9QprkKmZgy2qZAgk2g=;
        b=vZFNWd/B2LYQKdmUGqYZ+fH7saBO8JCh6y6OqLNLliZXbRdXE3Fp8mAmheGOHbK9UZ
         wSKny6H6J+pv/vHW26Dg8z8uEnH5OFUX+ESso4nqmLTk6y+LIADGO9ThPovNBnmzKYAP
         Isdl7jk2h6OR20Z+iakLjIJItYfxCMdPYPMjBLEAf9LyQQgug4TIuC+07Y/VVgz3bdLy
         r1hiklH7bJFtKQv1koLKJZ5ax0Cie0dT8XNO0b8ywnBao9qnK1zeCdetKUV7rS74VATV
         QidLuDc5WqJo8RiES42NXzOv5NfuX43cYN2zfLLkr+ij9BnYVLUoBHTBE0+hn/STIc1v
         94XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jftxE3WHMLu52rZG9IffXIH9L9QprkKmZgy2qZAgk2g=;
        b=Rqrw/UDplnsx1j4JQmnf5AGtUuYHrRvKF2J9GHIIHUhTsPx+RDAz3Icn34ny91FMJC
         eSXotDvZ87NsK7SfBoKKVxxWIA3y+ZzkdFskpDlVpgCEnH6RlU2QUTHRrTgsrF6kouMU
         KzJCdwvVUoZpDJenOECk0exhiaZNsT2ThDVao8avOJo8UwlqSwTZjsjC2DapWX0bzzWN
         tNc58FKlTEN3S1NKER1IMuMhQcMLDTG1bDMZjCHcEUf8Ti3pvzDPU5XVJmDnqrz2zxKS
         VsZjq/c+Vvbk/MIKSihDp0HpqGumETyRx9JEk/pZcOLDm/v9f4zKv1KaefZ4d2sEjCCB
         x6pQ==
X-Gm-Message-State: APjAAAWJRwAz7Y8eEqD5xxbfjq9GTzPmtm46cqT0wzGMbSC6ZHn3ZKnJ
        AVPtk3vrCvY44u8EBDgJ9pnYbQawn3c=
X-Google-Smtp-Source: APXvYqzO5KP7hk8vz5qVogn/npXnogF6OKD1Eq0SEOebNtyygSccWDKN1iDv4Jrri1L4n8+M9c89lw==
X-Received: by 2002:a0d:d746:: with SMTP id z67mr22570129ywd.205.1574113756695;
        Mon, 18 Nov 2019 13:49:16 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e191sm8326079ywe.26.2019.11.18.13.49.15
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 13:49:16 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xAILnF0W011179
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 21:49:15 GMT
Subject: [PATCH v6 2/2] RDMA/cma: Add trace points in RDMA Connection Manager
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 18 Nov 2019 16:49:15 -0500
Message-ID: <20191118214915.27891.61202.stgit@manet.1015granger.net>
In-Reply-To: <20191118214447.27891.58814.stgit@manet.1015granger.net>
References: <20191118214447.27891.58814.stgit@manet.1015granger.net>
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
new trace points are not in performance hot paths.

Also, record each cm_event_handler call to ULPs. This eliminates the
need for each ULP to add its own similar trace point in its CM event
handler function.

These new trace points appear in a new trace subsystem called
"rdma_cma".

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
 drivers/infiniband/core/cma.c       |   60 +++++++---
 drivers/infiniband/core/cma_trace.c |   16 +++
 include/trace/events/rdma_cma.h     |  218 +++++++++++++++++++++++++++++++++++
 4 files changed, 279 insertions(+), 17 deletions(-)
 create mode 100644 drivers/infiniband/core/cma_trace.c
 create mode 100644 include/trace/events/rdma_cma.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 68d9e27c3c61..bab7b6f01982 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -20,7 +20,7 @@ ib_cm-y :=			cm.o
 
 iw_cm-y :=			iwcm.o iwpm_util.o iwpm_msg.o
 
-rdma_cm-y :=			cma.o
+rdma_cm-y :=			cma.o cma_trace.o
 
 rdma_cm-$(CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS) += cma_configfs.o
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index d78f67623f24..5d5e63336954 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -64,6 +64,8 @@
 #include "core_priv.h"
 #include "cma_priv.h"
 
+#include <trace/events/rdma_cma.h>
+
 MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("Generic RDMA CM Agent");
 MODULE_LICENSE("Dual BSD/GPL");
@@ -1890,6 +1892,7 @@ static int cma_rep_recv(struct rdma_id_private *id_priv)
 	if (ret)
 		goto reject;
 
+	trace_cm_send_rtu(id_priv);
 	ret = ib_send_cm_rtu(id_priv->cm_id.ib, NULL, 0);
 	if (ret)
 		goto reject;
@@ -1898,6 +1901,7 @@ static int cma_rep_recv(struct rdma_id_private *id_priv)
 reject:
 	pr_debug_ratelimited("RDMA CM: CONNECT_ERROR: failed to handle reply. status %d\n", ret);
 	cma_modify_qp_err(id_priv);
+	trace_cm_send_rej(id_priv);
 	ib_send_cm_rej(id_priv->cm_id.ib, IB_CM_REJ_CONSUMER_DEFINED,
 		       NULL, 0, NULL, 0);
 	return ret;
@@ -1917,6 +1921,13 @@ static void cma_set_rep_event_data(struct rdma_cm_event *event,
 	event->param.conn.qp_num = rep_data->remote_qpn;
 }
 
+static int cma_cm_event_handler(struct rdma_id_private *id_priv,
+				struct rdma_cm_event *event)
+{
+	trace_cm_event_handler(id_priv, event);
+	return id_priv->id.event_handler(&id_priv->id, event);
+}
+
 static int cma_ib_handler(struct ib_cm_id *cm_id,
 			  const struct ib_cm_event *ib_event)
 {
@@ -1939,8 +1950,10 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
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
@@ -1985,7 +1998,7 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
 		goto out;
 	}
 
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.ib = NULL;
@@ -2146,6 +2159,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	if (IS_ERR(listen_id))
 		return PTR_ERR(listen_id);
 
+	trace_cm_req_handler(listen_id, ib_event->event);
 	if (!cma_ib_check_req_qp_type(&listen_id->id, ib_event)) {
 		ret = -EINVAL;
 		goto net_dev_put;
@@ -2188,7 +2202,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	 * until we're done accessing it.
 	 */
 	atomic_inc(&conn_id->refcount);
-	ret = conn_id->id.event_handler(&conn_id->id, &event);
+	ret = cma_cm_event_handler(conn_id, &event);
 	if (ret)
 		goto err3;
 	/*
@@ -2197,8 +2211,10 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
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
@@ -2313,7 +2329,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	event.status = iw_event->status;
 	event.param.conn.private_data = iw_event->private_data;
 	event.param.conn.private_data_len = iw_event->private_data_len;
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.iw = NULL;
@@ -2390,7 +2406,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 	 * until we're done accessing it.
 	 */
 	atomic_inc(&conn_id->refcount);
-	ret = conn_id->id.event_handler(&conn_id->id, &event);
+	ret = cma_cm_event_handler(conn_id, &event);
 	if (ret) {
 		/* User wants to destroy the CM ID */
 		conn_id->cm_id.iw = NULL;
@@ -2462,6 +2478,7 @@ static int cma_listen_handler(struct rdma_cm_id *id,
 
 	id->context = id_priv->id.context;
 	id->event_handler = id_priv->id.event_handler;
+	trace_cm_event_handler(id_priv, event);
 	return id_priv->id.event_handler(id, event);
 }
 
@@ -2636,7 +2653,7 @@ static void cma_work_handler(struct work_struct *_work)
 	if (!cma_comp_exch(id_priv, work->old_state, work->new_state))
 		goto out;
 
-	if (id_priv->id.event_handler(&id_priv->id, &work->event)) {
+	if (cma_cm_event_handler(id_priv, &work->event)) {
 		cma_exch(id_priv, RDMA_CM_DESTROYING);
 		destroy = 1;
 	}
@@ -2659,7 +2676,7 @@ static void cma_ndev_work_handler(struct work_struct *_work)
 	    id_priv->state == RDMA_CM_DEVICE_REMOVAL)
 		goto out;
 
-	if (id_priv->id.event_handler(&id_priv->id, &work->event)) {
+	if (cma_cm_event_handler(id_priv, &work->event)) {
 		cma_exch(id_priv, RDMA_CM_DESTROYING);
 		destroy = 1;
 	}
@@ -3062,7 +3079,7 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 	} else
 		event.event = RDMA_CM_EVENT_ADDR_RESOLVED;
 
-	if (id_priv->id.event_handler(&id_priv->id, &event)) {
+	if (cma_cm_event_handler(id_priv, &event)) {
 		cma_exch(id_priv, RDMA_CM_DESTROYING);
 		mutex_unlock(&id_priv->handler_mutex);
 		rdma_destroy_id(&id_priv->id);
@@ -3709,7 +3726,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id *cm_id,
 		goto out;
 	}
 
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 
 	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
 	if (ret) {
@@ -3773,6 +3790,7 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
 	req.timeout_ms = 1 << (CMA_CM_RESPONSE_TIMEOUT - 8);
 	req.max_cm_retries = CMA_MAX_CM_RETRIES;
 
+	trace_cm_send_sidr_req(id_priv);
 	ret = ib_send_cm_sidr_req(id_priv->cm_id.ib, &req);
 	if (ret) {
 		ib_destroy_cm_id(id_priv->cm_id.ib);
@@ -3846,6 +3864,7 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	req.max_cm_retries = CMA_MAX_CM_RETRIES;
 	req.srq = id_priv->srq ? 1 : 0;
 
+	trace_cm_send_req(id_priv);
 	ret = ib_send_cm_req(id_priv->cm_id.ib, &req);
 out:
 	if (ret && !IS_ERR(id)) {
@@ -3959,6 +3978,7 @@ static int cma_accept_ib(struct rdma_id_private *id_priv,
 	rep.rnr_retry_count = min_t(u8, 7, conn_param->rnr_retry_count);
 	rep.srq = id_priv->srq ? 1 : 0;
 
+	trace_cm_send_rep(id_priv);
 	ret = ib_send_cm_rep(id_priv->cm_id.ib, &rep);
 out:
 	return ret;
@@ -4008,6 +4028,7 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
 	rep.private_data = private_data;
 	rep.private_data_len = private_data_len;
 
+	trace_cm_send_sidr_rep(id_priv);
 	return ib_send_cm_sidr_rep(id_priv->cm_id.ib, &rep);
 }
 
@@ -4093,13 +4114,15 @@ int rdma_reject(struct rdma_cm_id *id, const void *private_data,
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
@@ -4124,8 +4147,13 @@ int rdma_disconnect(struct rdma_cm_id *id)
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
@@ -4191,7 +4219,7 @@ static int cma_ib_mc_handler(int status, struct ib_sa_multicast *multicast)
 	} else
 		event.event = RDMA_CM_EVENT_MULTICAST_ERROR;
 
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 
 	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
 	if (ret) {
@@ -4626,7 +4654,7 @@ static int cma_remove_id_dev(struct rdma_id_private *id_priv)
 		goto out;
 
 	event.event = RDMA_CM_EVENT_DEVICE_REMOVAL;
-	ret = id_priv->id.event_handler(&id_priv->id, &event);
+	ret = cma_cm_event_handler(id_priv, &event);
 out:
 	mutex_unlock(&id_priv->handler_mutex);
 	return ret;
diff --git a/drivers/infiniband/core/cma_trace.c b/drivers/infiniband/core/cma_trace.c
new file mode 100644
index 000000000000..1093fa813bc1
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
+#include <trace/events/rdma_cma.h>
diff --git a/include/trace/events/rdma_cma.h b/include/trace/events/rdma_cma.h
new file mode 100644
index 000000000000..b6ccdade651c
--- /dev/null
+++ b/include/trace/events/rdma_cma.h
@@ -0,0 +1,218 @@
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
+#include <rdma/rdma_cm.h>
+#include "cma_priv.h"
+
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
+#endif /* _TRACE_RDMA_CMA_H */
+
+#include <trace/define_trace.h>

