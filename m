Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB9B2467BB
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 15:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgHQNxQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 09:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgHQNxO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 09:53:14 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DE9C061389
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 06:53:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p18so10721993ilm.7
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IuCdSG3Agt9xfLKqHbAe0tidom+hR2CFOoKolzr7mMk=;
        b=CfneKXPlA665Fn14aLQAzGQEdj+9A23TQMSTkQ8wPyTZmUPcRbCT75kX8Llhbssctx
         ShQTiHJGCyOHoBZihYOE7vtExKuW7sdM9MD4ww+NylC45xXLGdLCfY2c5Hyo9azSONnj
         YDasrVzM2VLHtP1WWmh3yLOQ8TsHQ2iRVpBpi9Je3qU8V37YHYmzMd65Vknp0ow+aPVt
         f62oYBw4200+q2xsqcHGVrjnZ6RsDw5o0OCqwJDyL8o0ZYF8WDMnp7X7xupH2U8gj2tI
         0/0mmp4iFH0eOz3H457Ki/XBtZFluapgaZl6U0/63dJ8TdtzKiUsVuun0au2wiPbUYzn
         MvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=IuCdSG3Agt9xfLKqHbAe0tidom+hR2CFOoKolzr7mMk=;
        b=c8kM8g02VjolN4kD37bYqzj4JfmFnd+BTSCQLHHNWy3WK/qOR/235M8OeRME4RH62R
         31kHmPi97JpPETpwCsYLnuEv4gqKrfpogyOUu9BAWuxMihjKjdcCjoImP3ZOIlkMpNGU
         eh4HhUc5RHNPENJB/Te+apav44mMkoe1e3490DCJQfk+2YHuBxes558rkrn2Kz1bSvAJ
         ZgCWoJVeKN/EhmS//GBtX5a7L5R/PaMgN9QG83YPACR6lubk9rB1VeeD3QJDUiY1aZRJ
         g0EtKQwm+lbVpKKGInJufq5LAFeOM9+6fFe6bQWQ8VWaR/nWW90+PMhSbZ1m21uEqJs0
         CPAw==
X-Gm-Message-State: AOAM533LizXxNlOKuOmXAdm75J1N2HAD2xz5Mj/yyjSb8zCDADPN6P6t
        xO1NEiG6f6suXBLmPX4rN3KDSGvqcYybjQ==
X-Google-Smtp-Source: ABdhPJwbUCdBtvMVvvtxll+M9IawLPdqML6WdN2tNzGRQ3D6cmJVhgZGZyEKj57J7IURn5avsryXow==
X-Received: by 2002:a92:c7ae:: with SMTP id f14mr14535860ilk.39.1597672393070;
        Mon, 17 Aug 2020 06:53:13 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r9sm2022127iln.18.2020.08.17.06.53.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 06:53:12 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 07HDrBFc004681
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 13:53:11 GMT
Subject: [PATCH v3 1/3] RDMA/core: Move the rdma_show_ib_cm_event() macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 17 Aug 2020 09:53:11 -0400
Message-ID: <159767239131.2968.9520990257041764685.stgit@klimt.1015granger.net>
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


