Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E6226D00
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 19:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgGTRQi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 13:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgGTRQi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 13:16:38 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9047C061794
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jul 2020 10:16:37 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id s21so13959201ilk.5
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jul 2020 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IuCdSG3Agt9xfLKqHbAe0tidom+hR2CFOoKolzr7mMk=;
        b=BoyZKhDZwuKfIFn+q6S1BXcUMkuuMdiiBzV/pdTA5UjjVpMTCcZlMEk9CCmqOR9fF7
         WGz+Ork6DwKIbiBeUdZx0mf5A3vU6Rqo7g4HXPZHSN0i8JAScPDz3MrnpDKQs5XTM8IN
         veH/8e+6URE8s0I1IrxavyHe/lG3dMfl5Z4Zo5N16E8A2ulRZcy6IeI812Dy9Q/5J9o/
         KbBsvfrYH3+JNHdb0cFfWElDVnjNSwAixXyFTzM39w0GELkCSpbiNfyvQf5eWp16NBf2
         TRBg0PtUmKvTVYWa5bEuO+ONDS76EdqsKVCxuP/D2u9Wd94Al7zU4wa0L0o139kTBxbk
         b7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=IuCdSG3Agt9xfLKqHbAe0tidom+hR2CFOoKolzr7mMk=;
        b=BT754OrNN+M31uIwPIuydn28gMNAIm0+WKeul/pV0JOzOkT9hgQCFiAezCqFc8GHOF
         EDTsaRHHHCh/Fv9x+PE1FXM+VJM3V4OCewdu7TvvJGfakV745WiCN2+xJMEVFrfYOFW0
         xqQZ52sx1t5wWaiR1JyuDF4yozdF4ekSLV1+4emG1Ijb9aOTIVGoRpIOUNHCKSTB9krP
         9GAimxFMbEnqhMAXyYqfNeRJ+e3Fy/3jPLd9ZU3MPp3V+503b+kcmVFZUV8j1bJZ/hZS
         0ABwsNjAoYvdmFiQzHobmWE57tOMz+LMUUYV/qjcanNw6GltH3X9aqFx6R7A1Us43b/0
         Kx/g==
X-Gm-Message-State: AOAM530MKX+u9pYA6Jyuxn2rKRgBrMIvwPklvV8yYNecQLU2oLhOuiJc
        cR9R44VmQV9IYORqr4XAYopeMh61
X-Google-Smtp-Source: ABdhPJzmYkK5ysKm7IOtUT7CJNkoCgcDJjJosnidk7vIeJTDBpRImYObav7QGGBh8/4GSLae+PNiWA==
X-Received: by 2002:a92:8947:: with SMTP id n68mr24780314ild.235.1595265397193;
        Mon, 20 Jul 2020 10:16:37 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 5sm9139621ion.7.2020.07.20.10.16.36
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 10:16:36 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06KHGanH023978
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jul 2020 17:16:36 GMT
Subject: [PATCH v2 1/3] RDMA/core: Move the rdma_show_ib_cm_event() macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 20 Jul 2020 13:16:36 -0400
Message-ID: <159526539617.1543.257325920146781254.stgit@klimt.1015granger.net>
In-Reply-To: <159526519212.1543.15414933891659731269.stgit@klimt.1015granger.net>
References: <159526519212.1543.15414933891659731269.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Refactor: Make it globally available in the utilities header.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cma_trace.h |   40 ----------------------------------
 include/trace/events/rdma.h         |   41 ++++++++++++++++++++++++++++++++++-
 include/trace/events/rpcrdma.h      |    1 +
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/core/cma_trace.h b/drivers/infiniband/core/cma_trace.h
index e6e20c36c538..e45264267bcc 100644
--- a/drivers/infiniband/core/cma_trace.h
+++ b/drivers/infiniband/core/cma_trace.h
@@ -17,46 +17,6 @@
 #include <linux/tracepoint.h>
 #include <trace/events/rdma.h>
 
-/*
- * enum ib_cm_event_type, from include/rdma/ib_cm.h
- */
-#define IB_CM_EVENT_LIST			\
-	ib_cm_event(REQ_ERROR)			\
-	ib_cm_event(REQ_RECEIVED)		\
-	ib_cm_event(REP_ERROR)			\
-	ib_cm_event(REP_RECEIVED)		\
-	ib_cm_event(RTU_RECEIVED)		\
-	ib_cm_event(USER_ESTABLISHED)		\
-	ib_cm_event(DREQ_ERROR)			\
-	ib_cm_event(DREQ_RECEIVED)		\
-	ib_cm_event(DREP_RECEIVED)		\
-	ib_cm_event(TIMEWAIT_EXIT)		\
-	ib_cm_event(MRA_RECEIVED)		\
-	ib_cm_event(REJ_RECEIVED)		\
-	ib_cm_event(LAP_ERROR)			\
-	ib_cm_event(LAP_RECEIVED)		\
-	ib_cm_event(APR_RECEIVED)		\
-	ib_cm_event(SIDR_REQ_ERROR)		\
-	ib_cm_event(SIDR_REQ_RECEIVED)		\
-	ib_cm_event_end(SIDR_REP_RECEIVED)
-
-#undef ib_cm_event
-#undef ib_cm_event_end
-
-#define ib_cm_event(x)		TRACE_DEFINE_ENUM(IB_CM_##x);
-#define ib_cm_event_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
-
-IB_CM_EVENT_LIST
-
-#undef ib_cm_event
-#undef ib_cm_event_end
-
-#define ib_cm_event(x)		{ IB_CM_##x, #x },
-#define ib_cm_event_end(x)	{ IB_CM_##x, #x }
-
-#define rdma_show_ib_cm_event(x) \
-		__print_symbolic(x, IB_CM_EVENT_LIST)
-
 
 DECLARE_EVENT_CLASS(cma_fsm_class,
 	TP_PROTO(
diff --git a/include/trace/events/rdma.h b/include/trace/events/rdma.h
index aa19afc73a4e..81bb454fc288 100644
--- a/include/trace/events/rdma.h
+++ b/include/trace/events/rdma.h
@@ -6,7 +6,6 @@
 /*
  * enum ib_event_type, from include/rdma/ib_verbs.h
  */
-
 #define IB_EVENT_LIST				\
 	ib_event(CQ_ERR)			\
 	ib_event(QP_FATAL)			\
@@ -90,6 +89,46 @@ IB_WC_STATUS_LIST
 #define rdma_show_wc_status(x) \
 		__print_symbolic(x, IB_WC_STATUS_LIST)
 
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
 /*
  * enum rdma_cm_event_type, from include/rdma/rdma_cm.h
  */
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index abe942225637..b6aad52beb62 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -13,6 +13,7 @@
 #include <linux/scatterlist.h>
 #include <linux/sunrpc/rpc_rdma_cid.h>
 #include <linux/tracepoint.h>
+#include <rdma/ib_cm.h>
 #include <trace/events/rdma.h>
 
 /**


