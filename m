Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB74780AE
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Dec 2021 00:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhLPXeI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 18:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhLPXeF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Dec 2021 18:34:05 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287B7C061574
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:34:05 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q25so1240936oiw.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ctg4MN9ozVc98WDNFjU/p+VFavDwpuTq38LY2pJ8QQM=;
        b=VtIcOyJcJ9mI8syuPiZr6HUrGIui+ai8D2RvHOQGocvHSQBQJOqP9dg5vdYchqvJBy
         /PuYqT9gFT4lYxOlA038FuP8OwGsjtjxSdJfoepO9HES56abg32EfXHbINUz42iZQR85
         BTnHw0AERt2bDwJ6bleF/P/jWtBGPrSYjpT47t/lEvM10D/oceif1xsHY1NsPoE6uhGJ
         5kxexEO3pUt9xkp0MHoPGG2xzeEyfGh9yT8U68aqO0L/dnCCkDHOJ1Bnb35UzzyL95Af
         VpjKy6QPlYYiAPZS6setFtMcjD6aPeMWEOCjfvSJk+zZA5QHExM0badtZYYnPAhjZkmx
         VTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ctg4MN9ozVc98WDNFjU/p+VFavDwpuTq38LY2pJ8QQM=;
        b=nLsk9QJi7HirwHI4GX//8gH5ZAD/c7dhR5adU7rl/ATw/axx7n4gn7xHregRUo7lYC
         jl2kAmm0hNkcSwN81t/20fLMCYQlQ0czdMioilv4U58KeoKnkh85jOCypkzq+RxTBVNO
         bkGQ+OFdCrCgP1gjmedW4RT2joeeyywVNMlSWEbMZ3V7+Who0XASXQRy6PWaNNUnXQlJ
         +WXuKBki+877wLtVgLApIZ8r21tXbrsClqquT3bcJJbVs/sV1rGRo3Hx5A3GnJkd80tp
         pPoEwmb4uKOpbdkgrItLRyCUUVCuxcS0OgTt7s4Wfi2iAf2Uww0/KT3tbZRwoNUqpbZ1
         GtDg==
X-Gm-Message-State: AOAM532Z85zIASzJNmYjhWnhonx1LPdiDMXxlByObmNRlYK+gjwFLFf2
        dVY1jVS50tieJPVYuuQ347A=
X-Google-Smtp-Source: ABdhPJxtCnwgy19yRu2FYrBAd13D58o1KPCDFBPtWOeMGFl/ndTnKADVN85FGPXkOUQZfqISySQKXA==
X-Received: by 2002:a05:6808:1396:: with SMTP id c22mr6258479oiw.59.1639697644414;
        Thu, 16 Dec 2021 15:34:04 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-ec41-d089-dfdb-6fb5.res6.spectrum.com. [2603:8081:140c:1a00:ec41:d089:dfdb:6fb5])
        by smtp.googlemail.com with ESMTPSA id w19sm1253888oih.44.2021.12.16.15.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:34:04 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next v8 8/8] RDMA/rxe: Add wait for completion to obj destruct
Date:   Thu, 16 Dec 2021 17:32:02 -0600
Message-Id: <20211216233201.14893-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233201.14893-1-rpearsonhpe@gmail.com>
References: <20211216233201.14893-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds code to wait until pending activity on RDMA objects has
completed before freeing or returning to rdma-core where the object may
be freed.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 10 +++++
 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +
 drivers/infiniband/sw/rxe/rxe_mw.c    |  3 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 31 +++++++++++++-
 drivers/infiniband/sw/rxe/rxe_pool.h  |  4 ++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 60 ++++++++++++++++++---------
 6 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index b935634f86cd..d91c2e30665a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -122,6 +122,11 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 out_drop_ref:
 	rxe_drop_ref(grp);			/* ref from get_key */
+	/* when grp ref count drops to zero
+	 * go ahead and free it
+	 */
+	if (grp->elem.complete.done)
+		rxe_fini(grp);
 err1:
 	return ret;
 }
@@ -149,6 +154,11 @@ void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 		spin_unlock_bh(&grp->mcg_lock);
 		rxe_drop_ref(qp);
 		rxe_drop_ref(grp);
+		/* when grp ref count drops to zero
+		 * go ahead and free it
+		 */
+		if (grp->elem.complete.done)
+			rxe_fini(grp);
 		kfree(elem);
 	}
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 3c4390adfb80..5f8c08da352d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -695,6 +695,8 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	rxe_drop_ref(mr_pd(mr));
 	rxe_drop_ref(mr);
 
+	rxe_fini(mr);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 3ae981d77c25..666a641f9934 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -60,8 +60,9 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	rxe_do_dealloc_mw(mw);
 	spin_unlock_bh(&mw->lock);
 
-	rxe_drop_ref(mw);
 	rxe_drop_ref(pd);
+	rxe_drop_ref(mw);
+	rxe_fini(mw);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 0f785d14f646..b23c58281eb6 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -6,6 +6,8 @@
 
 #include "rxe.h"
 
+/* timeout in jiffies for pool element to complete */
+#define RXE_POOL_TIMEOUT	(100)
 #define RXE_POOL_ALIGN		(16)
 
 static const struct rxe_type_info {
@@ -160,6 +162,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->pool = pool;
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	if (pool->init) {
 		err = pool->init(elem);
@@ -194,6 +197,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
 	if (pool->init) {
 		err = pool->init(elem);
@@ -413,8 +417,33 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
+	atomic_dec(&pool->num_elem);
+
+	complete(&elem->complete);
+}
+
+/**
+ * __rxe_fini() - wait for completion of pool element
+ * @elem: the pool elem
+ *
+ * Wait until the reference count of an object drops to zero when
+ * rxe_elem_release() will complete the object and then, if locally
+ * allocated, free the memory containing the object and return
+ *
+ * Returns: non-zero if the object completed successfully else zero
+ */
+int __rxe_fini(struct rxe_pool_elem *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	int ret;
+
+	ret = wait_for_completion_timeout(&elem->complete, RXE_POOL_TIMEOUT);
+	if (!ret)
+		pr_warn("Timed out waiting for %s#%d to complete\n",
+				pool->name, elem->index);
+
 	if (pool->flags & RXE_POOL_ALLOC)
 		kfree(elem->obj);
 
-	atomic_dec(&pool->num_elem);
+	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index ccb923b10276..252f25bf5a1a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -30,6 +30,7 @@ struct rxe_pool_elem {
 	struct rxe_pool		*pool;
 	void			*obj;
 	struct kref		ref_cnt;
+	struct completion	complete;
 	struct list_head	list;
 
 	/* only used if keyed */
@@ -100,4 +101,7 @@ static inline bool __rxe_drop_ref(struct rxe_pool_elem *elem)
 }
 #define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
+int __rxe_fini(struct rxe_pool_elem *elem);
+#define rxe_fini(obj) __rxe_fini(&(obj)->elem)
+
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e3f64eae088c..450b5c557860 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -116,6 +116,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
 	rxe_drop_ref(uc);
+	rxe_fini(uc);
 }
 
 static int rxe_port_immutable(struct ib_device *dev, u32 port_num,
@@ -150,6 +151,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct rxe_pd *pd = to_rpd(ibpd);
 
 	rxe_drop_ref(pd);
+	rxe_fini(pd);
 	return 0;
 }
 
@@ -189,6 +191,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 					 sizeof(uresp->ah_num));
 		if (err) {
 			rxe_drop_ref(ah);
+			rxe_fini(ah);
 			return -EFAULT;
 		}
 	} else if (ah->is_user) {
@@ -229,6 +232,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 	struct rxe_ah *ah = to_rah(ibah);
 
 	rxe_drop_ref(ah);
+	rxe_fini(ah);
 	return 0;
 }
 
@@ -297,25 +301,26 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 
 	err = rxe_srq_chk_attr(rxe, NULL, &init->attr, IB_SRQ_INIT_MASK);
 	if (err)
-		goto err1;
+		goto err_out;
 
 	err = rxe_add_to_pool(&rxe->srq_pool, srq);
 	if (err)
-		goto err1;
+		goto err_out;
 
 	rxe_add_ref(pd);
 	srq->pd = pd;
 
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
 	if (err)
-		goto err2;
+		goto err_drop_pd;
 
 	return 0;
 
-err2:
+err_drop_pd:
 	rxe_drop_ref(pd);
 	rxe_drop_ref(srq);
-err1:
+	rxe_fini(srq);
+err_out:
 	return err;
 }
 
@@ -373,6 +378,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 
 	rxe_drop_ref(srq->pd);
 	rxe_drop_ref(srq);
+	rxe_fini(srq);
 	return 0;
 }
 
@@ -442,6 +448,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 
 qp_init:
 	rxe_drop_ref(qp);
+	rxe_fini(qp);
 	return err;
 }
 
@@ -486,6 +493,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	rxe_qp_destroy(qp);
 	rxe_drop_ref(qp);
+	rxe_fini(qp);
 	return 0;
 }
 
@@ -797,6 +805,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	rxe_cq_disable(cq);
 
 	rxe_drop_ref(cq);
+	rxe_fini(cq);
 	return 0;
 }
 
@@ -882,15 +891,22 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
+	int err;
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	if (!mr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
 	rxe_add_ref(pd);
+
 	rxe_mr_init_dma(pd, access, mr);
 
 	return &mr->ibmr;
+
+err_out:
+	return ERR_PTR(err);
 }
 
 static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
@@ -899,30 +915,30 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 				     u64 iova,
 				     int access, struct ib_udata *udata)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
+	int err;
 
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr) {
 		err = -ENOMEM;
-		goto err2;
+		goto err_out;
 	}
 
-
 	rxe_add_ref(pd);
 
 	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
 	if (err)
-		goto err3;
+		goto err_drop_pd;
 
 	return &mr->ibmr;
 
-err3:
+err_drop_pd:
 	rxe_drop_ref(pd);
 	rxe_drop_ref(mr);
-err2:
+	rxe_fini(mr);
+err_out:
 	return ERR_PTR(err);
 }
 
@@ -934,27 +950,30 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	struct rxe_mr *mr;
 	int err;
 
-	if (mr_type != IB_MR_TYPE_MEM_REG)
-		return ERR_PTR(-EINVAL);
+	if (mr_type != IB_MR_TYPE_MEM_REG) {
+		err = -EINVAL;
+		goto err_out;
+	}
 
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr) {
 		err = -ENOMEM;
-		goto err1;
+		goto err_out;
 	}
 
 	rxe_add_ref(pd);
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
-		goto err2;
+		goto err_drop_pd;
 
 	return &mr->ibmr;
 
-err2:
+err_drop_pd:
 	rxe_drop_ref(pd);
 	rxe_drop_ref(mr);
-err1:
+	rxe_fini(mr);
+err_out:
 	return ERR_PTR(err);
 }
 
@@ -994,8 +1013,10 @@ static int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	if (err)
 		return err;
 
+	/* adds a ref on grp if successful */
 	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
 
+	/* drops the ref from ..get_grp() */
 	rxe_drop_ref(grp);
 	return err;
 }
@@ -1005,6 +1026,7 @@ static int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
 
+	/* drops a ref on grp if successful */
 	return rxe_mcast_drop_grp_elem(rxe, qp, mgid);
 }
 
-- 
2.32.0

