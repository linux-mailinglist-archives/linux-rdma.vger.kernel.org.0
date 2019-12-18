Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8209E12530B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2019 21:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRUSY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 15:18:24 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37082 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfLRUSX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Dec 2019 15:18:23 -0500
Received: by mail-yw1-f65.google.com with SMTP id z7so1288116ywd.4
        for <linux-rdma@vger.kernel.org>; Wed, 18 Dec 2019 12:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TFx2mLU9BGYwwLUGArxo1xNG/igymDH2A6SvJ4Zxe50=;
        b=NB/lnI28CVyUhrOrFPZxSXwfeYxH/4IN07Wiymmfliu+K7QrcO84uon+xwPak3CZuY
         U9LR7kKViWYKnJ4ISB96pJWS6heBn5OCuqAxaH0mjCwVB0bNQLv+nMtMitnwif+A+bDk
         wtCxoL3UbQcsTKnU8MZusej3H+lYur9d8wFwH1Il3KU7wEfR+sU4po2KX6AqzP408WXp
         teDP0vQ0QxRs6g19M23vwYZyrAxukTw8o9jPiiik5ISZ9304+Q+TcrURshHBNpUTceW2
         Hf8FgAdR34J72gFYGHoNqyG+BJ+jSwD1HzNN8NXL3P9D6Na7r7RDxYExB0bKyzRaeMS2
         AH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=TFx2mLU9BGYwwLUGArxo1xNG/igymDH2A6SvJ4Zxe50=;
        b=lINS0fxMCvIe9UMfmcP7N9RglAoMJ23cwC+DRC2D4+mtDqsvAGa9/RRpOfM+bwVqGp
         Iw9+qyDsLom0crpX6H2SOdKfGbSxyKZOyYtjzqgJhs91V6vYox2e+0BhUlr+LD6GdR3g
         WUqnWnMDgsPKtIqOadfDNs2f9ibEG8rXkulXhf9fQ9HHWAa6D+ZcGpA4yNaXFqemYqCH
         2fYTXPuNEf1ieBP4OZM7xIGP3LrXCuGvGzE/7AawKqOE2nn/zbpki9bPFEzj+Q5VMPTo
         ZURFPAmq0apjYrRQywbQxlDhlGKRz2eGxhmITs7POkuiOE51AC9ZMJ0rIeA0x//Ib/m+
         pteA==
X-Gm-Message-State: APjAAAX5NOGfelIMAoH90ixjDzA7RMmvfnKOsR0gTqEJ9qwTGeYXnqC2
        AfA7ek2TL+Zf+R4HYXtUdgDS50Br
X-Google-Smtp-Source: APXvYqxoafxjvaZyOAV3nDvxq4rvtj2kPsUL3FPHFoAWhbpne/MRPOMY9VMGGfxF2Ze0hU/wkjXNhg==
X-Received: by 2002:a81:1dd6:: with SMTP id d205mr3620818ywd.479.1576700302256;
        Wed, 18 Dec 2019 12:18:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o4sm1447789ywd.5.2019.12.18.12.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 12:18:21 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBIKIKYk022503;
        Wed, 18 Dec 2019 20:18:20 GMT
Subject: [PATCH v10 3/3] RDMA/core: Add trace points to follow MR allocation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dledford@redhat.com, jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 18 Dec 2019 15:18:20 -0500
Message-ID: <20191218201820.30584.34636.stgit@manet.1015granger.net>
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

