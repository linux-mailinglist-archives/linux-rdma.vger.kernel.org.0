Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E9910ECFE
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2019 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfLBQVO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 11:21:14 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39295 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfLBQVO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Dec 2019 11:21:14 -0500
Received: by mail-yw1-f68.google.com with SMTP id h126so4310056ywc.6
        for <linux-rdma@vger.kernel.org>; Mon, 02 Dec 2019 08:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=u3f1GTcFCBWReIX/MA8dH0ID18Y+HcvHy43rQ2+iqdM=;
        b=MvgM9a6BPDyfb51E56zWx+xqHwE0AIjkJvGuafXJCV3+dvHDptiYlqaIdRAY3WDjDq
         jjNGA32jvi3JEac8JO3msDoGze2zT2hQK1oS4Ixfsaze8tNW1b5rOCws+kKEEhJr0mvb
         NHui/fWn+WuUSduAOhwDxplI7Zv+/H/qggJi8Nwp6Mee6t4wBatucYJDLuQu15CKJ51l
         hbSZaNRnyrsYBuLutRtHjHxaVWe/CwAO1eBNQO2fWwmRs2gQL853tFvJ2IrAv3VpxATC
         0p4CCXKlFOCIpO7G61fprx/kieLcRqs7xRIYwVZ1tOPcAcy7ieocTfV0o+J+z5eMEmGj
         TPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=u3f1GTcFCBWReIX/MA8dH0ID18Y+HcvHy43rQ2+iqdM=;
        b=ToG7XU/ZzqauJ1rAXQPD88K0MAYfBYWH7BfdjCl1eTjA7Gd6DCDIgMRVpVTqbPTN6U
         9epzEzbNT4UkON7U3n07TSsDweAx+61SwCeST33bvIN1UOxxLkd2N+VHho9o3r6PxTHz
         BqPHXbjoqi+CytVKkLrqoH9Bc1H2TrPB/QYmP9vXxhUHe8Q1BoTunZhM5A932LTw0KtK
         DAkq9TUbVs3mlSMFSLG2Nxm0ZkUj4XMw3TxI//rjWnWred6/80nK4p7JZ7Psx9+Myp9i
         bgo8URu0KLUWyqRlW3XBOE58rDXdvRpxZ/gpLc03sLsXCA1BrOSv5ceT4lWgUUpTpjXb
         P5yg==
X-Gm-Message-State: APjAAAUBXaKfD6YUMMej5qwpnPef76qlEE/JFXL+anEZhm2pV2AVtYq7
        qqB7+p+HR3Yt0oeDVxRjZ0+LdluW
X-Google-Smtp-Source: APXvYqwKBZOt2euKkliRY5B1bTUS5uj0dTaBNfymt8s90dhUiuuIaxncOKUAb/NUBIvFooyV7hZOCA==
X-Received: by 2002:a81:5795:: with SMTP id l143mr5143318ywb.89.1575303672579;
        Mon, 02 Dec 2019 08:21:12 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o4sm45960ywd.5.2019.12.02.08.21.11
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 08:21:11 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xB2GLAEw014251
        for <linux-rdma@vger.kernel.org>; Mon, 2 Dec 2019 16:21:10 GMT
Subject: [PATCH v8 3/3] RDMA/core: Add trace points to follow MR allocation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 02 Dec 2019 11:21:10 -0500
Message-ID: <20191202162110.3950.33487.stgit@manet.1015granger.net>
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

Track the lifetime of ib_mr objects.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/verbs.c  |   39 +++++++++---
 include/trace/events/rdma_core.h |  123 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 35c2841a569e..49b346ec9609 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -52,6 +52,7 @@
 #include <rdma/rw.h>
 
 #include "core_priv.h"
+#include <trace/events/rdma_core.h>
 
 static int ib_resolve_eth_dmac(struct ib_device *device,
 			       struct rdma_ah_attr *ah_attr);
@@ -1995,6 +1996,7 @@ int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
 	struct ib_sig_attrs *sig_attrs = mr->sig_attrs;
 	int ret;
 
+	trace_mr_dereg(mr);
 	rdma_restrack_del(&mr->res);
 	ret = mr->device->ops.dereg_mr(mr, udata);
 	if (!ret) {
@@ -2026,11 +2028,16 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 {
 	struct ib_mr *mr;
 
-	if (!pd->device->ops.alloc_mr)
-		return ERR_PTR(-EOPNOTSUPP);
+	if (!pd->device->ops.alloc_mr) {
+		mr = ERR_PTR(-EOPNOTSUPP);
+		goto out;
+	}
 
-	if (WARN_ON_ONCE(mr_type == IB_MR_TYPE_INTEGRITY))
-		return ERR_PTR(-EINVAL);
+	if (mr_type == IB_MR_TYPE_INTEGRITY) {
+		WARN_ON_ONCE(1);
+		mr = ERR_PTR(-EINVAL);
+		goto out;
+	}
 
 	mr = pd->device->ops.alloc_mr(pd, mr_type, max_num_sg, udata);
 	if (!IS_ERR(mr)) {
@@ -2046,6 +2053,8 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 		mr->sig_attrs = NULL;
 	}
 
+out:
+	trace_mr_alloc(pd, mr_type, max_num_sg, mr);
 	return mr;
 }
 EXPORT_SYMBOL(ib_alloc_mr_user);
@@ -2070,21 +2079,27 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	struct ib_sig_attrs *sig_attrs;
 
 	if (!pd->device->ops.alloc_mr_integrity ||
-	    !pd->device->ops.map_mr_sg_pi)
-		return ERR_PTR(-EOPNOTSUPP);
+	    !pd->device->ops.map_mr_sg_pi) {
+		mr = ERR_PTR(-EOPNOTSUPP);
+		goto out;
+	}
 
-	if (!max_num_meta_sg)
-		return ERR_PTR(-EINVAL);
+	if (!max_num_meta_sg) {
+		mr = ERR_PTR(-EINVAL);
+		goto out;
+	}
 
 	sig_attrs = kzalloc(sizeof(struct ib_sig_attrs), GFP_KERNEL);
-	if (!sig_attrs)
-		return ERR_PTR(-ENOMEM);
+	if (!sig_attrs) {
+		mr = ERR_PTR(-ENOMEM);
+		goto out;
+	}
 
 	mr = pd->device->ops.alloc_mr_integrity(pd, max_num_data_sg,
 						max_num_meta_sg);
 	if (IS_ERR(mr)) {
 		kfree(sig_attrs);
-		return mr;
+		goto out;
 	}
 
 	mr->device = pd->device;
@@ -2098,6 +2113,8 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	mr->type = IB_MR_TYPE_INTEGRITY;
 	mr->sig_attrs = sig_attrs;
 
+out:
+	trace_mr_integ_alloc(pd, max_num_data_sg, max_num_meta_sg, mr);
 	return mr;
 }
 EXPORT_SYMBOL(ib_alloc_mr_integrity);
diff --git a/include/trace/events/rdma_core.h b/include/trace/events/rdma_core.h
index 45f74c52ae24..f44b3ceac6ee 100644
--- a/include/trace/events/rdma_core.h
+++ b/include/trace/events/rdma_core.h
@@ -245,6 +245,129 @@
 	TP_printk("cq.id=%u", __entry->id)
 );
 
+/**
+ ** Memory Region events
+ **/
+
+/*
+ * enum ib_mr_type, from include/rdma/ib_verbs.h
+ */
+#define IB_MR_TYPE_LIST				\
+	ib_mr_type_item(MEM_REG)		\
+	ib_mr_type_item(SG_GAPS)		\
+	ib_mr_type_item(DM)			\
+	ib_mr_type_item(USER)			\
+	ib_mr_type_item(DMA)			\
+	ib_mr_type_end(INTEGRITY)
+
+#undef ib_mr_type_item
+#undef ib_mr_type_end
+
+#define ib_mr_type_item(x)	TRACE_DEFINE_ENUM(IB_MR_TYPE_##x);
+#define ib_mr_type_end(x)	TRACE_DEFINE_ENUM(IB_MR_TYPE_##x);
+
+IB_MR_TYPE_LIST
+
+#undef ib_mr_type_item
+#undef ib_mr_type_end
+
+#define ib_mr_type_item(x)	{ IB_MR_TYPE_##x, #x },
+#define ib_mr_type_end(x)	{ IB_MR_TYPE_##x, #x }
+
+#define rdma_show_ib_mr_type(x) \
+		__print_symbolic(x, IB_MR_TYPE_LIST)
+
+TRACE_EVENT(mr_alloc,
+	TP_PROTO(
+		const struct ib_pd *pd,
+		enum ib_mr_type mr_type,
+		u32 max_num_sg,
+		const struct ib_mr *mr
+	),
+
+	TP_ARGS(pd, mr_type, max_num_sg, mr),
+
+	TP_STRUCT__entry(
+		__field(u32, pd_id)
+		__field(u32, mr_id)
+		__field(u32, max_num_sg)
+		__field(int, rc)
+		__field(unsigned long, mr_type)
+	),
+
+	TP_fast_assign(
+		__entry->pd_id = pd->res.id;
+		if (IS_ERR(mr)) {
+			__entry->mr_id = 0;
+			__entry->rc = PTR_ERR(mr);
+		} else {
+			__entry->mr_id = mr->res.id;
+			__entry->rc = 0;
+		}
+		__entry->max_num_sg = max_num_sg;
+		__entry->mr_type = mr_type;
+	),
+
+	TP_printk("pd.id=%u mr.id=%u type=%s max_num_sg=%u rc=%d",
+		__entry->pd_id, __entry->mr_id,
+		rdma_show_ib_mr_type(__entry->mr_type),
+		__entry->max_num_sg, __entry->rc)
+);
+
+TRACE_EVENT(mr_integ_alloc,
+	TP_PROTO(
+		const struct ib_pd *pd,
+		u32 max_num_data_sg,
+		u32 max_num_meta_sg,
+		const struct ib_mr *mr
+	),
+
+	TP_ARGS(pd, max_num_data_sg, max_num_meta_sg, mr),
+
+	TP_STRUCT__entry(
+		__field(u32, pd_id)
+		__field(u32, mr_id)
+		__field(u32, max_num_data_sg)
+		__field(u32, max_num_meta_sg)
+		__field(int, rc)
+	),
+
+	TP_fast_assign(
+		__entry->pd_id = pd->res.id;
+		if (IS_ERR(mr)) {
+			__entry->mr_id = 0;
+			__entry->rc = PTR_ERR(mr);
+		} else {
+			__entry->mr_id = mr->res.id;
+			__entry->rc = 0;
+		}
+		__entry->max_num_data_sg = max_num_data_sg;
+		__entry->max_num_meta_sg = max_num_meta_sg;
+	),
+
+	TP_printk("pd.id=%u mr.id=%u max_num_data_sg=%u max_num_meta_sg=%u rc=%d",
+		__entry->pd_id, __entry->mr_id, __entry->max_num_data_sg,
+		__entry->max_num_meta_sg, __entry->rc)
+);
+
+TRACE_EVENT(mr_dereg,
+	TP_PROTO(
+		const struct ib_mr *mr
+	),
+
+	TP_ARGS(mr),
+
+	TP_STRUCT__entry(
+		__field(u32, id)
+	),
+
+	TP_fast_assign(
+		__entry->id = mr->res.id;
+	),
+
+	TP_printk("mr.id=%u", __entry->id)
+);
+
 #endif /* _TRACE_RDMA_CORE_H */
 
 #include <trace/define_trace.h>

