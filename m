Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADBD21B7CA
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGJOGP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 10:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJOGP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jul 2020 10:06:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD2DC08C5CE
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 07:06:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j80so5307695qke.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pFCgOoz8fcgLSWeVOpLoyBJbDjwV5LNW/np8E3OFO6w=;
        b=ZgWxhvY/5UXiHgTTlIQCo2bKneWPDOea98/rgxW5uvUNaijJ9AloZI7KKQnNrO30Al
         VYhp0g/d5rhPyFV2vzokA8G0HjaEb49855dBjbRb5EmKi/b2qk85ZZmDKVe/oSv2cDfT
         THbhn2cCeXI7iu13h1/Ufksgg/jv59BNuLQYqzBONErxLpNZGmQwzruQcZwU179vR/xk
         XQlQiDajI3+a7IaXiy3GQY1pXNj031M3Ih1Vh+XZsGDWi0qSQ6kGuq04K0A/EZmzJFCW
         Vqh6EDu5b2QnJyPJwtZ5bmcNGFMe8Clg8/Nk4GWreSM2N3IWBjNMkRr917NrZKunRcnW
         WSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=pFCgOoz8fcgLSWeVOpLoyBJbDjwV5LNW/np8E3OFO6w=;
        b=evJheWUK63kj1C/6Kx92CcBDmPE8EHpGP2NlhqSSvHp2jBEItta5reXluirYwG86b8
         djEYA4gEy1JVkaIwYUFZjqCae6dFMPiJFpM8Pg1TkPFeZqQVoJBHSENpGGtLxRSRuW9e
         kv2G/waxiC1TiRA5SR4ntLrimMmtzEvmK5XtHWuEd4j47brI2Ryy1dHOuDpNNyR3pZWP
         ghvLWdFWJHtqO/owXZv6+Bek8zsbJWkQ93VKP2S82JZ/KtbMegujDRW1BM1gundtVQIy
         ofydUkcmMpBhWmXG6c67SuimqFPpsYHNACfD/LpY8DGjmmrD0BYqi9wRZ/T8Hjf3ZBKR
         BDbg==
X-Gm-Message-State: AOAM530PrOY/ECNeGMIiLZfw07nKZpkldvBHUEIgfSZP7fZT9cWm6JZA
        SxF9zhZ86RL4ei6iDP9KY+8ThRhF
X-Google-Smtp-Source: ABdhPJwwZTbOwJPbYiF6srxRgM0U0XiiMv+qqSv+9Mf7UHCDgheWw9Oyc92lWNPIJsMuCCkXRaqjLw==
X-Received: by 2002:a05:620a:2051:: with SMTP id d17mr68789653qka.237.1594389974238;
        Fri, 10 Jul 2020 07:06:14 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p53sm8326307qtc.85.2020.07.10.07.06.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:06:13 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06AE6C7a012320;
        Fri, 10 Jul 2020 14:06:12 GMT
Subject: [PATCH RFC 2/3] RDMA/cm: Replace pr_debug() call sites with
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     aron.silverton@oracle.com
Date:   Fri, 10 Jul 2020 10:06:12 -0400
Message-ID: <20200710140612.14749.47766.stgit@klimt.1015granger.net>
In-Reply-To: <20200710135812.14749.4630.stgit@klimt.1015granger.net>
References: <20200710135812.14749.4630.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
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

            nfsd-1954  [003]    62.017901: cm_send_dreq_err:     local_id=1998890974 remote_id=1129750393 state=DREQ_RCVD lap_state=LAP_UNINIT

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
index 0d1377232933..8dd8039e1a02 100644
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
+		trace_cm_no_listener_err(&cm_id_priv->id);
 		cm_id_priv->id.state = IB_CM_IDLE;
 		ret = -EINVAL;
 		goto destroy;
@@ -2274,8 +2274,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id->state != IB_CM_REQ_RCVD &&
 	    cm_id->state != IB_CM_MRA_REQ_SENT) {
-		pr_debug("%s: local_comm_id %d, cm_id->state: %d\n", __func__,
-			 be32_to_cpu(cm_id_priv->id.local_id), cm_id->state);
+		trace_cm_send_rep_err(cm_id_priv->id.local_id, cm_id->state);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2348,8 +2347,7 @@ int ib_send_cm_rtu(struct ib_cm_id *cm_id,
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id->state != IB_CM_REP_RCVD &&
 	    cm_id->state != IB_CM_MRA_REP_SENT) {
-		pr_debug("%s: local_id %d, cm_id->state %d\n", __func__,
-			 be32_to_cpu(cm_id->local_id), cm_id->state);
+		trace_cm_send_cm_rtu_err(cm_id);
 		ret = -EINVAL;
 		goto error;
 	}
@@ -2465,7 +2463,7 @@ static int cm_rep_handler(struct cm_work *work)
 		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)), 0);
 	if (!cm_id_priv) {
 		cm_dup_rep_handler(work);
-		pr_debug("%s: remote_comm_id %d, no cm_id_priv\n", __func__,
+		trace_cm_remote_no_priv_err(
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
+		trace_cm_rep_unknown_err(
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
+		trace_cm_insert_failed_err(
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
+		trace_cm_staleconn_err(
+			IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg),
 			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
 
 		if (cur_cm_id_priv) {
@@ -2646,9 +2642,7 @@ static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
 		return -EINVAL;
 
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED) {
-		pr_debug("%s: local_id %d, cm_id->state: %d\n", __func__,
-			 be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_cm_dreq_skipped(&cm_id_priv->id);
 		return -EINVAL;
 	}
 
@@ -2722,10 +2716,7 @@ static int cm_send_drep_locked(struct cm_id_private *cm_id_priv,
 		return -EINVAL;
 
 	if (cm_id_priv->id.state != IB_CM_DREQ_RCVD) {
-		pr_debug(
-			"%s: local_id %d, cm_idcm_id->state(%d) != IB_CM_DREQ_RCVD\n",
-			__func__, be32_to_cpu(cm_id_priv->id.local_id),
-			cm_id_priv->id.state);
+		trace_cm_send_drep_err(&cm_id_priv->id);
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
+		trace_cm_no_priv_err(
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
+		trace_cm_dreq_unknown_err(&cm_id_priv->id);
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
+		trace_cm_send_unknown_rej_err(&cm_id_priv->id);
 		return -EINVAL;
 	}
 
@@ -3060,9 +3046,7 @@ static int cm_rej_handler(struct cm_work *work)
 		}
 		/* fall through */
 	default:
-		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_cm_rej_unknown_err(&cm_id_priv->id);
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
+		trace_cm_send_mra_unknown_err(&cm_id_priv->id);
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
+		trace_cm_mra_unknown_err(&cm_id_priv->id);
 		goto out;
 	}
 
@@ -3765,8 +3745,7 @@ static void cm_process_send_error(struct ib_mad_send_buf *msg,
 	if (msg != cm_id_priv->msg || state != cm_id_priv->id.state)
 		goto discard;
 
-	pr_debug_ratelimited("CM: failed sending MAD in state %d. (%s)\n",
-			     state, ib_wc_status_msg(wc_status));
+	trace_cm_mad_send_err(state, wc_status);
 	switch (state) {
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
@@ -3889,7 +3868,7 @@ static void cm_work_handler(struct work_struct *_work)
 		ret = cm_timewait_handler(work);
 		break;
 	default:
-		pr_debug("cm_event.event: 0x%x\n", work->cm_event.event);
+		trace_cm_handler_err(work->cm_event.event);
 		ret = -EINVAL;
 		break;
 	}
@@ -3925,8 +3904,7 @@ static int cm_establish(struct ib_cm_id *cm_id)
 		ret = -EISCONN;
 		break;
 	default:
-		pr_debug("%s: local_id %d, cm_id->state: %d\n", __func__,
-			 be32_to_cpu(cm_id->local_id), cm_id->state);
+		trace_cm_establish_err(cm_id);
 		ret = -EINVAL;
 		break;
 	}
@@ -4123,9 +4101,7 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
 		ret = 0;
 		break;
 	default:
-		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_cm_qp_init_err(&cm_id_priv->id);
 		ret = -EINVAL;
 		break;
 	}
@@ -4173,9 +4149,7 @@ static int cm_init_qp_rtr_attr(struct cm_id_private *cm_id_priv,
 		ret = 0;
 		break;
 	default:
-		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_cm_qp_rtr_err(&cm_id_priv->id);
 		ret = -EINVAL;
 		break;
 	}
@@ -4235,9 +4209,7 @@ static int cm_init_qp_rts_attr(struct cm_id_private *cm_id_priv,
 		ret = 0;
 		break;
 	default:
-		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
-			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
-			 cm_id_priv->id.state);
+		trace_cm_qp_rts_err(&cm_id_priv->id);
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
index 000000000000..84f65f597e34
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
+DECLARE_EVENT_CLASS(cm_id_class,
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
+		DEFINE_EVENT(cm_id_class,				\
+				cm_##name##_err,			\
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
+DEFINE_EVENT(cm_id_class,						\
+	cm_dreq_skipped,						\
+	TP_PROTO(							\
+		const struct ib_cm_id *cm_id				\
+	),								\
+	TP_ARGS(cm_id)							\
+);
+
+DECLARE_EVENT_CLASS(cm_local_class,
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
+		DEFINE_EVENT(cm_local_class,				\
+				cm_##name,				\
+				TP_PROTO(				\
+					unsigned int local_id,			\
+					unsigned int remote_id			\
+				),					\
+				TP_ARGS(local_id, remote_id))
+
+DEFINE_CM_LOCAL_EVENT(staleconn_err);
+DEFINE_CM_LOCAL_EVENT(no_priv_err);
+
+DECLARE_EVENT_CLASS(cm_remote_class,
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
+		DEFINE_EVENT(cm_remote_class,				\
+				cm_##name,				\
+				TP_PROTO(				\
+					u32 remote_id			\
+				),					\
+				TP_ARGS(remote_id))
+
+DEFINE_CM_REMOTE_EVENT(remote_no_priv_err);
+DEFINE_CM_REMOTE_EVENT(insert_failed_err);
+
+TRACE_EVENT(cm_send_rep_err,
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
+TRACE_EVENT(cm_rep_unknown_err,
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
+TRACE_EVENT(cm_handler_err,
+	TP_PROTO(
+		enum ib_event_type event
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
+		rdma_show_ib_event(__entry->event)
+	)
+);
+
+TRACE_EVENT(cm_mad_send_err,
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

