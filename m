Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C45120EA2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2019 16:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfLPPyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Dec 2019 10:54:03 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39240 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfLPPyC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Dec 2019 10:54:02 -0500
Received: by mail-yw1-f66.google.com with SMTP id h126so2627428ywc.6
        for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2019 07:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TFx2mLU9BGYwwLUGArxo1xNG/igymDH2A6SvJ4Zxe50=;
        b=oO1wXzBOXShCjsd8DlSKs+tPX3enx5HArADGTWdc5I7XJN7mD68cx9Ep+UWQ93SELZ
         J18rt/E+eFDelxT4ekghgGbZJu581TmNEuzBJ56GqYJizmzLDSr3B/OZEZckoaEpV67A
         +PhVOjlIowm/PTMW+erAt7TiYBaCiWDUsaNVh+yMA+5+txfNuquR6qK4qxQSnXFLb8G9
         2LPUs+hFHSvDXd7lk8sIFFFasnTYBFvupjdsuWWN5do1nul2TWK/9O3UOrW3AfV+qA9H
         nwT65GXDk8Omtw9OxwfL44UaX+nhvDmnxfiWu48Fp7rYNJrtesmvnP4NaGaF1mjVDSSm
         nqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=TFx2mLU9BGYwwLUGArxo1xNG/igymDH2A6SvJ4Zxe50=;
        b=V+YXUVyxCBp5w127K6+OdC8WRfDHLBbU9pYUG6FTX/WdKAEtWX3R/46GdBStxLBz7d
         sleD5RvFV0P7+XWph2/Cx+CFyThqa0UBakP3D4Wf7o58x1vLCjiFup+05dQeHUM/waVg
         2oaIKklvVotZ2ZAicrWGn4r/5wMyGCfMf/xE2SvMrgluu4LOhZ5Wx7pE8yTFXTZsN3dz
         DdlDIQKB9+jDhMEqfBnvdgI2/YCbFtjKxEjHQqPCsqTckJ/lJBTXjJ+AQWmm6I/Qf3gD
         5hARHYgyT4qi4HsNNmpda3MVxgHqLFpX9ldTd9UlXZAgXai6wiXqQmJwUHbaskCSZ0tv
         QCfg==
X-Gm-Message-State: APjAAAWqEUti/eDQswgOZHNlnF4z7kqgL24cGzaHbVIK1OoqyjWs7tRX
        UsMIg+6ciq51F2sfqaQbrpeT3icS
X-Google-Smtp-Source: APXvYqwWWPuGrTV34ISZMgHP/3lTwtqO36qNnmdgtshb6dObG+vgdwAjmT+bzVyWYFV6A5yMVQkDGQ==
X-Received: by 2002:a0d:fd42:: with SMTP id n63mr15577863ywf.422.1576511641293;
        Mon, 16 Dec 2019 07:54:01 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a202sm8650749ywe.8.2019.12.16.07.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:54:00 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBGFrxZQ014708;
        Mon, 16 Dec 2019 15:53:59 GMT
Subject: [PATCH v9 3/3] RDMA/core: Add trace points to follow MR allocation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dledford@redhat.com, jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 16 Dec 2019 10:53:59 -0500
Message-ID: <20191216155359.21101.15485.stgit@manet.1015granger.net>
In-Reply-To: <20191216154924.21101.64860.stgit@manet.1015granger.net>
References: <20191216154924.21101.64860.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Track the lifetime of ib_mr objects. Here's sample output from a
test run with NFS/RDMA:

           <...>-361   [009] 79238.772782: mr_alloc:             pd.id=3 mr.id=11 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79238.772812: mr_alloc:             pd.id=3 mr.id=12 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79238.772839: mr_alloc:             pd.id=3 mr.id=13 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79238.772866: mr_alloc:             pd.id=3 mr.id=14 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79238.772893: mr_alloc:             pd.id=3 mr.id=15 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79238.772921: mr_alloc:             pd.id=3 mr.id=16 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79238.772947: mr_alloc:             pd.id=3 mr.id=17 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79238.772974: mr_alloc:             pd.id=3 mr.id=18 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79238.773001: mr_alloc:             pd.id=3 mr.id=19 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79238.773028: mr_alloc:             pd.id=3 mr.id=20 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79238.773055: mr_alloc:             pd.id=3 mr.id=21 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.270942: mr_alloc:             pd.id=3 mr.id=22 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.270975: mr_alloc:             pd.id=3 mr.id=23 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.271007: mr_alloc:             pd.id=3 mr.id=24 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.271036: mr_alloc:             pd.id=3 mr.id=25 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.271067: mr_alloc:             pd.id=3 mr.id=26 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.271095: mr_alloc:             pd.id=3 mr.id=27 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.271121: mr_alloc:             pd.id=3 mr.id=28 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.271153: mr_alloc:             pd.id=3 mr.id=29 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.271181: mr_alloc:             pd.id=3 mr.id=30 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.271208: mr_alloc:             pd.id=3 mr.id=31 type=MEM_REG max_num_sg=30 rc=0
           <...>-361   [009] 79240.271236: mr_alloc:             pd.id=3 mr.id=32 type=MEM_REG max_num_sg=30 rc=0
           <...>-4351  [001] 79242.299400: mr_dereg:             mr.id=32
           <...>-4351  [001] 79242.299467: mr_dereg:             mr.id=31
           <...>-4351  [001] 79242.299554: mr_dereg:             mr.id=30
           <...>-4351  [001] 79242.299615: mr_dereg:             mr.id=29
           <...>-4351  [001] 79242.299684: mr_dereg:             mr.id=28
           <...>-4351  [001] 79242.299748: mr_dereg:             mr.id=27
           <...>-4351  [001] 79242.299812: mr_dereg:             mr.id=26
           <...>-4351  [001] 79242.299874: mr_dereg:             mr.id=25
           <...>-4351  [001] 79242.299944: mr_dereg:             mr.id=24
           <...>-4351  [001] 79242.300009: mr_dereg:             mr.id=23
           <...>-4351  [001] 79242.300190: mr_dereg:             mr.id=22
           <...>-4351  [001] 79242.300263: mr_dereg:             mr.id=21
           <...>-4351  [001] 79242.300326: mr_dereg:             mr.id=20
           <...>-4351  [001] 79242.300388: mr_dereg:             mr.id=19
           <...>-4351  [001] 79242.300450: mr_dereg:             mr.id=18
           <...>-4351  [001] 79242.300516: mr_dereg:             mr.id=17
           <...>-4351  [001] 79242.300629: mr_dereg:             mr.id=16
           <...>-4351  [001] 79242.300718: mr_dereg:             mr.id=15
           <...>-4351  [001] 79242.300784: mr_dereg:             mr.id=14
           <...>-4351  [001] 79242.300879: mr_dereg:             mr.id=13
           <...>-4351  [001] 79242.300945: mr_dereg:             mr.id=12
           <...>-4351  [001] 79242.301012: mr_dereg:             mr.id=11

Some features of the output:
- The lifetime and owner PD of each MR is clearly visible.
- The type of MR is captured, as is the SGE array size.
- Failing MR allocation can be recorded.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/verbs.c  |   39 +++++++++---
 include/trace/events/rdma_core.h |  123 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 289b2f7a9d5e..47d54c31eb2a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -52,6 +52,7 @@
 #include <rdma/rw.h>
 
 #include "core_priv.h"
+#include <trace/events/rdma_core.h>
 
 #include <trace/events/rdma_core.h>
 
@@ -1999,6 +2000,7 @@ int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
 	struct ib_sig_attrs *sig_attrs = mr->sig_attrs;
 	int ret;
 
+	trace_mr_dereg(mr);
 	rdma_restrack_del(&mr->res);
 	ret = mr->device->ops.dereg_mr(mr, udata);
 	if (!ret) {
@@ -2030,11 +2032,16 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
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
@@ -2050,6 +2057,8 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 		mr->sig_attrs = NULL;
 	}
 
+out:
+	trace_mr_alloc(pd, mr_type, max_num_sg, mr);
 	return mr;
 }
 EXPORT_SYMBOL(ib_alloc_mr_user);
@@ -2074,21 +2083,27 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
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
@@ -2102,6 +2117,8 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	mr->type = IB_MR_TYPE_INTEGRITY;
 	mr->sig_attrs = sig_attrs;
 
+out:
+	trace_mr_integ_alloc(pd, max_num_data_sg, max_num_meta_sg, mr);
 	return mr;
 }
 EXPORT_SYMBOL(ib_alloc_mr_integrity);
diff --git a/include/trace/events/rdma_core.h b/include/trace/events/rdma_core.h
index 08f481554e7f..17642aa54437 100644
--- a/include/trace/events/rdma_core.h
+++ b/include/trace/events/rdma_core.h
@@ -266,6 +266,129 @@
 	TP_printk("cq.id=%u", __entry->cq_id)
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

