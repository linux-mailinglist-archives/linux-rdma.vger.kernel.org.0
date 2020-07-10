Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BDE21B7C9
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 16:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGJOGK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 10:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgGJOGK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jul 2020 10:06:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF8FC08C5CE
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 07:06:09 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b4so5254424qkn.11
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 07:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IuCdSG3Agt9xfLKqHbAe0tidom+hR2CFOoKolzr7mMk=;
        b=mg2/QJMPAWN7k4HGyaaaXs+EJTrLKt5phHBwSSslssXwKmiq2FcaIL+EKxHN21VDVJ
         HEj1Hxr21QXsC+dOr18X7+FtWtZssUqoWViJKBpVEY/vOasKUjowoGG1VTNiaAWA6G8s
         fMMMzyO0z+6uVzWiIRLZfbJ/RGWrW0NqllkogWusMVBfZprBBYQkQ1pOTBTYwoWq1Pn5
         /4plqe2cDe70Q//v1DFg776LmjzIn27PRW2zcVbZJD2N29meNU8AVKqw1ynxjD+y2NoC
         CBw4Axbcjim7rkG2ft7Zj7YKjwcHvKXHNLHxnZ+L3swUc6oGgkgkW70tMtisANu2rHsi
         qzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=IuCdSG3Agt9xfLKqHbAe0tidom+hR2CFOoKolzr7mMk=;
        b=hm2leORxV53HMJlg0EdSJUX6kIfFT7caPWO7flSYk+0SB1bduNHoi4yC/b38PuMfaD
         BW7Z/j9OIxVTiXOcSOritF/T+5k8v3hc0hmei1KZVECiYhVXpSlueQEGnvfWqcE/2yex
         9xPoquTrFr2W5LVesyKJQmCW6kCGF82/iWQm/oaqC0XqjNt0r1bWf7Yvro5pwY5XHNf1
         EQ85O7mVnccWvkn7pUOSYiwL9LsDz7YHlHfDDzuG0K1KTEo/vVGOpPIxkMK6arVap3pb
         nio85L+OzhcItKVVAj1jrF0pCYGhdyZYBWh/Wq3EVO50b7FuudaplyjiTP3LJvP/1sax
         hxhg==
X-Gm-Message-State: AOAM532JnvKs2v8lA9amgpMtJ3I2zLdJ9+qgd4Hcuzlwd8v3oQzHwG3r
        h+diLjA7nU5pxIC8HkSG23K3l+p9
X-Google-Smtp-Source: ABdhPJzsMbZRqjzqoqGzoKQCMTIet9753koN0QFJc6zsnk+wHiHYL70VeZrvKnKzhM0yuf0X/X9r3Q==
X-Received: by 2002:a05:620a:211a:: with SMTP id l26mr69154762qkl.408.1594389969201;
        Fri, 10 Jul 2020 07:06:09 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z18sm7773846qta.51.2020.07.10.07.06.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:06:08 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06AE67fq012317;
        Fri, 10 Jul 2020 14:06:07 GMT
Subject: [PATCH RFC 1/3] RDMA/core: Move the rdma_show_ib_cm_event() macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     aron.silverton@oracle.com
Date:   Fri, 10 Jul 2020 10:06:07 -0400
Message-ID: <20200710140607.14749.31996.stgit@klimt.1015granger.net>
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

