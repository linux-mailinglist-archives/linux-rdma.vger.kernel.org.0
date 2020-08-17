Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479AB2467BE
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgHQNxX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 09:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgHQNxW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 09:53:22 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB91C061389
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 06:53:19 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g19so17655032ioh.8
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TPaanlLwhTM7j8g7mr04FHH/DugQIIbTHbHYioRXjfY=;
        b=oMQvEuH8AxCZcPh/6EC1Qwu01Jzb3+gKP2NJerwW1SM/yW+KuwjmNOMvfTerp4CbZc
         cgeM1l970Z1tKMFoTz8x/8qEfdzwljjcB4x2vp6N9/Nkl2wrx0UoI9nooav68E6+h6Pb
         Fh1/m90MkRhyelD0i+v3Aaztu+Pnec8usGZFmnYgwyBwM++zTeEkFM1pnDLdc9DkTJ5A
         DR6Ww9vFCz4y0gePjKUzPQzr6O+0+Xg14sZKAYuFuOyqVEM2+a8qUxb9FPtw1ItFMel+
         OMzJ/WSaMn63IdLX7AOvcAQ7UJxsj8TYKW9co7SspgvfGKMnJt9eEB69VI6QyY/MTX9r
         18Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=TPaanlLwhTM7j8g7mr04FHH/DugQIIbTHbHYioRXjfY=;
        b=Hqee4F8UZVuImVIzFcYyG2/+BevV1xRNoMYXNdcDCEJn7EmXVw/tsclTJlCf5a16tQ
         lYL9d7IpXoC9KayS5ps8UlIJq3pqFaqQLc4QKz2eK46lU2Iy+nMvnWDHHpLfI1QLyJfs
         GicVe04IusPDowEwKVRMRJqJ53/5gT+oDso1+SLgc+Fz4gw20Sb5IFjYb6Od5Y7RAttt
         y7K6rwFYsBWNo9QDrojYf7YImer8ex38WTSEn70hX2sqEVB3hbqemTihf35lF9RrqD7d
         4C/3+d4a8O+/qgniYbCVnF9zXr/ASgZ9QY6FxGW/UD1W2EaCzsMhEuwTjGonQwXS76Zr
         plYg==
X-Gm-Message-State: AOAM531psg8psSbZWmNldrhN3iBy/Hdl26BARIkugwxvXjW/NhQJIaRU
        vylUQZYK+xlJ8hLP1tfpgf3XqBcU1G1WNg==
X-Google-Smtp-Source: ABdhPJyucRYeOwZpmYGy0V8r8idVigyYZJm0+mHDxWVGmQtda4QA7us9qPc0mND38IV5vg9+wh2XPQ==
X-Received: by 2002:a02:3e13:: with SMTP id s19mr15009556jas.95.1597672398336;
        Mon, 17 Aug 2020 06:53:18 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q19sm6391259ilj.85.2020.08.17.06.53.17
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 06:53:17 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 07HDrGhq004684
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 13:53:16 GMT
Subject: [PATCH v3 2/3] RDMA/cm: Replace pr_debug() call sites with
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 17 Aug 2020 09:53:16 -0400
Message-ID: <159767239665.2968.10613294222688696646.stgit@klimt.1015granger.net>
In-Reply-To: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
References: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the interest of converging on a common instrumentation
infrastructure, modernize the pr_debug() call sites added by commit
119bf81793ea ("IB/cm: Add debug prints to ib_cm"). The new
tracepoints appear in a new "ib_cma" subsystem.

The conversion is somewhat mechanical. Someone more familiar with
the semantics of the recorded information might suggest additional
data capture.

Some benefits include:
- Tracepoints enable "always on" reporting of these errors
- The error records are structured and compact
- Tracepoints provide hooks for eBPF scripts

Sample output:

            nfsd-1954  [003]    62.017901: icm_dreq_skipped:     local_id=1998890974 remote_id=1129750393 state=DREQ_RCVD lap_state=LAP_UNINIT

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/Makefile   |    2 
 drivers/infiniband/core/cm.c       |   80 +++------
 drivers/infiniband/core/cm_trace.c |   15 ++
 drivers/infiniband/core/cm_trace.h |  309 ++++++++++++++++++++++++++++++++++++
 4 files changed, 351 insertions(+), 55 deletions(-)
 create mode 100644 drivers/infiniband/core/cm_trace.c
 create mode 100644 drivers/infiniband/core/cm_trace.h

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 24cb71a16a28..ccf2670ef45e 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -17,7 +17,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
 
-ib_cm-y :=			cm.o
+ib_cm-y :=			cm.o cm_trace.o
 
 iw_cm-y :=			iwcm.o iwpm_util.o iwpm_msg.o
 
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index dc0558b23158..79a593941a12 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -27,6 +27,7 @@
 #include <rdma/ib_cm.h>
 #include "cm_msgs.h"
 #include "core_priv.h"
+#include "cm_trace.h"
 
 MODULE_AUTHOR("Sean Hefty");
 MODULE_DESCRIPTION("InfiniBand CM");
@@ -2124,8 +2125,7 @@ static int cm_req_handler(struct cm_work *work)
 
 	listen_cm_id_priv = cm_match_req(work, cm_id_priv);
 	if (!listen_cm_id_priv) {
-		pr_debug("%s: local_id %d, no listen_cm_id_priv\n", __func__,
-			 be32_to_cpu(cm_id_priv->id.local_id));
+		trace_icm_no_listener_err(&cm_id_priv->id);
 		cm_id_priv->id.state = IB_CM_IDLE;
 		ret = -EINVAL;
 		goto destroy;
@@ -2274,8 +2274,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id->state != IB_CM_REQ_RCVD &&
 	    cm_id->state != IB_CM_MRA_REQ_SENT) {
-		pr_debug("%s: local_comm_id %d, cm_id->state: %d\n", __func__,
-			 be32_to_cpu(cm_id_priv->id.local_id), cm_id->state);
+		trace_icm_send_rep_err(cm_id_priv->id.local_id, cm_id->state);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2348,8 +2347,7 @@ int ib_send_cm_rtu(struct ib_cm_id *cm_id,
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id->state != IB_CM_REP_RCVD &&
 	    cm_id->state != IB_CM_MRA_REP_SENT) {
-		pr_debug("%s: local_id %d, cm_id->state %d\n", __func__,
-			 be32_to_cpu(cm_id->local_id), cm_id->state);
+		trace_icm_send_cm_rtu_err(cm_id);
 		ret = -EINVAL;
 		goto error;
 	}
@@ -2465,7 +2463,7 @@ static int cm_rep_handler(struct cm_work *work)
 		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)), 0);
 	if (!cm_id_priv) {
 		cm_dup_rep_handler(work);
-		pr_debug("%s: remote_comm_id %d, no cm_id_priv\n", __func__,
+		trace_icm_remote_no_priv_err(
 			 IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
 		return -EINVAL;
 	}
@@ -2479,11 +2477,10 @@ static int cm_rep_handler(struct cm_work *work)
 		break;
 	default:
 		ret = -EINVAL;
-		pr_debug(
-			"%s: cm_id_priv->id.state: %d, local_comm_id %d, remote_comm_id %d\n",
-			__func__, cm_id_priv->id.state,
+		trace_icm_rep_unknown_err(
 			IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg),
-			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
+			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg),
+			cm_id_priv->id.state);
 		spin_unlock_irq(&cm_id_priv->lock);
 		goto error;
 	}
@@ -2500,7 +2497,7 @@ static int cm_rep_handler(struct cm_work *work)
 		spin_unlock(&cm.lock);
 		spin_unlock_irq(&cm_id_priv->lock);
 		ret = -EINVAL;
-		pr_debug("%s: Failed to insert remote id %d\n", __func__,
+		trace_icm_insert_failed_err(
 			 IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
 		goto error;
 	}
@@ -2517,9 +2514,8 @@ static int cm_rep_handler(struct cm_work *work)
 			     IB_CM_REJ_STALE_CONN, CM_MSG_RESPONSE_REP,
 			     NULL, 0);
 		ret = -EINVAL;
-		pr_debug(
-			"%s: Stale connection. local_comm_id %d, remote_comm_id %d\n",
-			__func__, IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg),
+		trace_icm_staleconn_err(
+			IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg),
 			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
 
 		if (cur_cm_id_priv) {
@@ -2646,9 +2642,7 @@ static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
 		return -EINVAL;
 
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED) {
-		pr_debug("%s: local_id %d, cm_id->state: %d\n", __func__,
-			 be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_icm_dreq_skipped(&cm_id_priv->id);
 		return -EINVAL;
 	}
 
@@ -2722,10 +2716,7 @@ static int cm_send_drep_locked(struct cm_id_private *cm_id_priv,
 		return -EINVAL;
 
 	if (cm_id_priv->id.state != IB_CM_DREQ_RCVD) {
-		pr_debug(
-			"%s: local_id %d, cm_idcm_id->state(%d) != IB_CM_DREQ_RCVD\n",
-			__func__, be32_to_cpu(cm_id_priv->id.local_id),
-			cm_id_priv->id.state);
+		trace_icm_send_drep_err(&cm_id_priv->id);
 		kfree(private_data);
 		return -EINVAL;
 	}
@@ -2810,9 +2801,8 @@ static int cm_dreq_handler(struct cm_work *work)
 		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
 				counter[CM_DREQ_COUNTER]);
 		cm_issue_drep(work->port, work->mad_recv_wc);
-		pr_debug(
-			"%s: no cm_id_priv, local_comm_id %d, remote_comm_id %d\n",
-			__func__, IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg),
+		trace_icm_no_priv_err(
+			IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg),
 			IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg));
 		return -EINVAL;
 	}
@@ -2858,9 +2848,7 @@ static int cm_dreq_handler(struct cm_work *work)
 				counter[CM_DREQ_COUNTER]);
 		goto unlock;
 	default:
-		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_icm_dreq_unknown_err(&cm_id_priv->id);
 		goto unlock;
 	}
 	cm_id_priv->id.state = IB_CM_DREQ_RCVD;
@@ -2945,9 +2933,7 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 			      state);
 		break;
 	default:
-		pr_debug("%s: local_id %d, cm_id->state: %d\n", __func__,
-			 be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_icm_send_unknown_rej_err(&cm_id_priv->id);
 		return -EINVAL;
 	}
 
@@ -3060,9 +3046,7 @@ static int cm_rej_handler(struct cm_work *work)
 		}
 		/* fall through */
 	default:
-		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_icm_rej_unknown_err(&cm_id_priv->id);
 		spin_unlock_irq(&cm_id_priv->lock);
 		goto out;
 	}
@@ -3118,9 +3102,7 @@ int ib_send_cm_mra(struct ib_cm_id *cm_id,
 		}
 		/* fall through */
 	default:
-		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_icm_send_mra_unknown_err(&cm_id_priv->id);
 		ret = -EINVAL;
 		goto error1;
 	}
@@ -3229,9 +3211,7 @@ static int cm_mra_handler(struct cm_work *work)
 				counter[CM_MRA_COUNTER]);
 		/* fall through */
 	default:
-		pr_debug("%s local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_icm_mra_unknown_err(&cm_id_priv->id);
 		goto out;
 	}
 
@@ -3767,8 +3747,7 @@ static void cm_process_send_error(struct ib_mad_send_buf *msg,
 	if (msg != cm_id_priv->msg || state != cm_id_priv->id.state)
 		goto discard;
 
-	pr_debug_ratelimited("CM: failed sending MAD in state %d. (%s)\n",
-			     state, ib_wc_status_msg(wc_status));
+	trace_icm_mad_send_err(state, wc_status);
 	switch (state) {
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
@@ -3891,7 +3870,7 @@ static void cm_work_handler(struct work_struct *_work)
 		ret = cm_timewait_handler(work);
 		break;
 	default:
-		pr_debug("cm_event.event: 0x%x\n", work->cm_event.event);
+		trace_icm_handler_err(work->cm_event.event);
 		ret = -EINVAL;
 		break;
 	}
@@ -3927,8 +3906,7 @@ static int cm_establish(struct ib_cm_id *cm_id)
 		ret = -EISCONN;
 		break;
 	default:
-		pr_debug("%s: local_id %d, cm_id->state: %d\n", __func__,
-			 be32_to_cpu(cm_id->local_id), cm_id->state);
+		trace_icm_establish_err(cm_id);
 		ret = -EINVAL;
 		break;
 	}
@@ -4125,9 +4103,7 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
 		ret = 0;
 		break;
 	default:
-		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_icm_qp_init_err(&cm_id_priv->id);
 		ret = -EINVAL;
 		break;
 	}
@@ -4175,9 +4151,7 @@ static int cm_init_qp_rtr_attr(struct cm_id_private *cm_id_priv,
 		ret = 0;
 		break;
 	default:
-		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_icm_qp_rtr_err(&cm_id_priv->id);
 		ret = -EINVAL;
 		break;
 	}
@@ -4237,9 +4211,7 @@ static int cm_init_qp_rts_attr(struct cm_id_private *cm_id_priv,
 		ret = 0;
 		break;
 	default:
-		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_icm_qp_rts_err(&cm_id_priv->id);
 		ret = -EINVAL;
 		break;
 	}
diff --git a/drivers/infiniband/core/cm_trace.c b/drivers/infiniband/core/cm_trace.c
new file mode 100644
index 000000000000..8f3482f66338
--- /dev/null
+++ b/drivers/infiniband/core/cm_trace.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Trace points for the IB Connection Manager.
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#include <rdma/rdma_cm.h>
+#include "cma_priv.h"
+
+#define CREATE_TRACE_POINTS
+
+#include "cm_trace.h"
diff --git a/drivers/infiniband/core/cm_trace.h b/drivers/infiniband/core/cm_trace.h
new file mode 100644
index 000000000000..c69e28564913
--- /dev/null
+++ b/drivers/infiniband/core/cm_trace.h
@@ -0,0 +1,309 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Trace point definitions for the RDMA Connect Manager.
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2020 Oracle and/or its affiliates.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ib_cma
+
+#if !defined(_TRACE_IB_CMA_H) || defined(TRACE_HEADER_MULTI_READ)
+
+#define _TRACE_IB_CMA_H
+
+#include <linux/tracepoint.h>
+#include <rdma/ib_cm.h>
+#include <trace/events/rdma.h>
+
+/*
+ * enum ib_cm_state, from include/rdma/ib_cm.h
+ */
+#define IB_CM_STATE_LIST					\
+	ib_cm_state(IDLE)					\
+	ib_cm_state(LISTEN)					\
+	ib_cm_state(REQ_SENT)					\
+	ib_cm_state(REQ_RCVD)					\
+	ib_cm_state(MRA_REQ_SENT)				\
+	ib_cm_state(MRA_REQ_RCVD)				\
+	ib_cm_state(REP_SENT)					\
+	ib_cm_state(REP_RCVD)					\
+	ib_cm_state(MRA_REP_SENT)				\
+	ib_cm_state(MRA_REP_RCVD)				\
+	ib_cm_state(ESTABLISHED)				\
+	ib_cm_state(DREQ_SENT)					\
+	ib_cm_state(DREQ_RCVD)					\
+	ib_cm_state(TIMEWAIT)					\
+	ib_cm_state(SIDR_REQ_SENT)				\
+	ib_cm_state_end(SIDR_REQ_RCVD)
+
+#undef  ib_cm_state
+#undef  ib_cm_state_end
+#define ib_cm_state(x)		TRACE_DEFINE_ENUM(IB_CM_##x);
+#define ib_cm_state_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
+
+IB_CM_STATE_LIST
+
+#undef  ib_cm_state
+#undef  ib_cm_state_end
+#define ib_cm_state(x)		{ IB_CM_##x, #x },
+#define ib_cm_state_end(x)	{ IB_CM_##x, #x }
+
+#define show_ib_cm_state(x) \
+		__print_symbolic(x, IB_CM_STATE_LIST)
+
+/*
+ * enum ib_cm_lap_state, from include/rdma/ib_cm.h
+ */
+#define IB_CM_LAP_STATE_LIST					\
+	ib_cm_lap_state(LAP_UNINIT)				\
+	ib_cm_lap_state(LAP_IDLE)				\
+	ib_cm_lap_state(LAP_SENT)				\
+	ib_cm_lap_state(LAP_RCVD)				\
+	ib_cm_lap_state(MRA_LAP_SENT)				\
+	ib_cm_lap_state_end(MRA_LAP_RCVD)
+
+#undef  ib_cm_lap_state
+#undef  ib_cm_lap_state_end
+#define ib_cm_lap_state(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
+#define ib_cm_lap_state_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
+
+IB_CM_LAP_STATE_LIST
+
+#undef  ib_cm_lap_state
+#undef  ib_cm_lap_state_end
+#define ib_cm_lap_state(x)	{ IB_CM_##x, #x },
+#define ib_cm_lap_state_end(x)	{ IB_CM_##x, #x }
+
+#define show_ib_cm_lap_state(x) \
+		__print_symbolic(x, IB_CM_LAP_STATE_LIST)
+
+
+DECLARE_EVENT_CLASS(icm_id_class,
+	TP_PROTO(
+		const struct ib_cm_id *cm_id
+	),
+
+	TP_ARGS(cm_id),
+
+	TP_STRUCT__entry(
+		__field(const void *, cm_id)	/* for eBPF scripts */
+		__field(unsigned int, local_id)
+		__field(unsigned int, remote_id)
+		__field(unsigned long, state)
+		__field(unsigned long, lap_state)
+	),
+
+	TP_fast_assign(
+		__entry->cm_id = cm_id;
+		__entry->local_id = be32_to_cpu(cm_id->local_id);
+		__entry->remote_id = be32_to_cpu(cm_id->remote_id);
+		__entry->state = cm_id->state;
+		__entry->lap_state = cm_id->lap_state;
+	),
+
+	TP_printk("local_id=%u remote_id=%u state=%s lap_state=%s",
+		__entry->local_id, __entry->remote_id,
+		show_ib_cm_state(__entry->state),
+		show_ib_cm_lap_state(__entry->lap_state)
+	)
+);
+
+#define DEFINE_CM_ERR_EVENT(name)					\
+		DEFINE_EVENT(icm_id_class,				\
+				icm_##name##_err,			\
+				TP_PROTO(				\
+					const struct ib_cm_id *cm_id	\
+				),					\
+				TP_ARGS(cm_id))
+
+DEFINE_CM_ERR_EVENT(send_cm_rtu);
+DEFINE_CM_ERR_EVENT(establish);
+DEFINE_CM_ERR_EVENT(no_listener);
+DEFINE_CM_ERR_EVENT(send_drep);
+DEFINE_CM_ERR_EVENT(dreq_unknown);
+DEFINE_CM_ERR_EVENT(send_unknown_rej);
+DEFINE_CM_ERR_EVENT(rej_unknown);
+DEFINE_CM_ERR_EVENT(send_mra_unknown);
+DEFINE_CM_ERR_EVENT(mra_unknown);
+DEFINE_CM_ERR_EVENT(qp_init);
+DEFINE_CM_ERR_EVENT(qp_rtr);
+DEFINE_CM_ERR_EVENT(qp_rts);
+
+DEFINE_EVENT(icm_id_class,						\
+	icm_dreq_skipped,						\
+	TP_PROTO(							\
+		const struct ib_cm_id *cm_id				\
+	),								\
+	TP_ARGS(cm_id)							\
+);
+
+DECLARE_EVENT_CLASS(icm_local_class,
+	TP_PROTO(
+		unsigned int local_id,
+		unsigned int remote_id
+	),
+
+	TP_ARGS(local_id, remote_id),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, local_id)
+		__field(unsigned int, remote_id)
+	),
+
+	TP_fast_assign(
+		__entry->local_id = local_id;
+		__entry->remote_id = remote_id;
+	),
+
+	TP_printk("local_id=%u remote_id=%u",
+		__entry->local_id, __entry->remote_id
+	)
+);
+
+#define DEFINE_CM_LOCAL_EVENT(name)					\
+		DEFINE_EVENT(icm_local_class,				\
+				icm_##name,				\
+				TP_PROTO(				\
+					unsigned int local_id,			\
+					unsigned int remote_id			\
+				),					\
+				TP_ARGS(local_id, remote_id))
+
+DEFINE_CM_LOCAL_EVENT(staleconn_err);
+DEFINE_CM_LOCAL_EVENT(no_priv_err);
+
+DECLARE_EVENT_CLASS(icm_remote_class,
+	TP_PROTO(
+		u32 remote_id
+	),
+
+	TP_ARGS(remote_id),
+
+	TP_STRUCT__entry(
+		__field(u32, remote_id)
+	),
+
+	TP_fast_assign(
+		__entry->remote_id = remote_id;
+	),
+
+	TP_printk("remote_id=%u",
+		__entry->remote_id
+	)
+);
+
+#define DEFINE_CM_REMOTE_EVENT(name)					\
+		DEFINE_EVENT(icm_remote_class,				\
+				icm_##name,				\
+				TP_PROTO(				\
+					u32 remote_id			\
+				),					\
+				TP_ARGS(remote_id))
+
+DEFINE_CM_REMOTE_EVENT(remote_no_priv_err);
+DEFINE_CM_REMOTE_EVENT(insert_failed_err);
+
+TRACE_EVENT(icm_send_rep_err,
+	TP_PROTO(
+		__be32 local_id,
+		enum ib_cm_state state
+	),
+
+	TP_ARGS(local_id, state),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, local_id)
+		__field(unsigned long, state)
+	),
+
+	TP_fast_assign(
+		__entry->local_id = be32_to_cpu(local_id);
+		__entry->state = state;
+	),
+
+	TP_printk("local_id=%u state=%s",
+		__entry->local_id, show_ib_cm_state(__entry->state)
+	)
+);
+
+TRACE_EVENT(icm_rep_unknown_err,
+	TP_PROTO(
+		unsigned int local_id,
+		unsigned int remote_id,
+		enum ib_cm_state state
+	),
+
+	TP_ARGS(local_id, remote_id, state),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, local_id)
+		__field(unsigned int, remote_id)
+		__field(unsigned long, state)
+	),
+
+	TP_fast_assign(
+		__entry->local_id = local_id;
+		__entry->remote_id = remote_id;
+		__entry->state = state;
+	),
+
+	TP_printk("local_id=%u remote_id=%u state=%s",
+		__entry->local_id, __entry->remote_id,
+		show_ib_cm_state(__entry->state)
+	)
+);
+
+TRACE_EVENT(icm_handler_err,
+	TP_PROTO(
+		enum ib_cm_event_type event
+	),
+
+	TP_ARGS(event),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, event)
+	),
+
+	TP_fast_assign(
+		__entry->event = event;
+	),
+
+	TP_printk("unhandled event=%s",
+		rdma_show_ib_cm_event(__entry->event)
+	)
+);
+
+TRACE_EVENT(icm_mad_send_err,
+	TP_PROTO(
+		enum ib_cm_state state,
+		enum ib_wc_status wc_status
+	),
+
+	TP_ARGS(state, wc_status),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, state)
+		__field(unsigned long, wc_status)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->wc_status = wc_status;
+	),
+
+	TP_printk("state=%s completion status=%s",
+		show_ib_cm_state(__entry->state),
+		rdma_show_wc_status(__entry->wc_status)
+	)
+);
+
+#endif /* _TRACE_IB_CMA_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE cm_trace
+
+#include <trace/define_trace.h>


