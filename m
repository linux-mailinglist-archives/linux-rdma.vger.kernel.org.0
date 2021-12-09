Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32646F3C3
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 20:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhLITTT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhLITTS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 14:19:18 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455CAC061353
        for <linux-rdma@vger.kernel.org>; Thu,  9 Dec 2021 11:15:44 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so7256971otg.4
        for <linux-rdma@vger.kernel.org>; Thu, 09 Dec 2021 11:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNcQgDoglkZdK/qBgwS9qvGtOqGJRVNg81ydlR0iztE=;
        b=fE6+qMdZURlh2nxIjzVKpzEn5pCzpRTfcOFBBTO35wxjw7N05v+Gfax4TT3TVI34LP
         DJqH1YWxUK4//asds1y7+Tu0WFuroIjWQcHiTf0rFyHtSO48gC/h261LC8GukGMClUjq
         AZ6oEvFTCEYQZTkSIHvK2LQo4j925iauxm7XuAp0kDCW1+s6SgyiJoKsuiZpdl5V1Vfn
         JFHhBh1ijL3CsAL6wEuhDjzJPTw6dT80WBhREs4y5NJ7PuO5nW0GaaqRPJI+EemdL5db
         YYx+3xePQ6maBsqUYAKeBOYwlENjIackDdKMP3Mq3B/GdmPIAF1/5WIIFeQQF765RkkC
         1gUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNcQgDoglkZdK/qBgwS9qvGtOqGJRVNg81ydlR0iztE=;
        b=sx9Vf76/TtJ3Kp57/93QUpHhik0GXBVGSBs9FATIYUcyL/3ZlaA2d1L8SPDF6U3VWt
         hnsV7suL4jzzyxLrPhdxrtEyEvdvu5nTPzlqk1pOihETAJHtgIH78e7qEP4gPCqYmOB6
         gem7sDxjKomZ48qS08/RcFoCJU5WgJBEbJ0ptB4WLqQcmzp1+ftVOo/cgHGrL02CHqMe
         Z/Wf+HpQJsn9D/HOH+crNbBcbRYT5gvio4KOJZPVIUPREd2z74IcBMzHmBiYDLSU/4VA
         qnlS/y0j0HmlLRjdyvEQ1HAe3L8KV0Z1AFldVfGnye29ZwhO1mE5N1FQoqqM+mSS7kJb
         g8SQ==
X-Gm-Message-State: AOAM5326ayQ1IQpU3LnObTcTmbczy3uRoZ2ajszMNtRFa2J3Jq+xNKPa
        woVxFuDei1hRXubMZBgaLOKJSJl6maU=
X-Google-Smtp-Source: ABdhPJyTzzGf5iJhUW5AOUlYp+Y8qgObcrRXEEAFPZY3T+tTUfv/WjQJI+0sIiHmW0dfo5CajsrzkA==
X-Received: by 2002:a9d:200b:: with SMTP id n11mr7081608ota.169.1639077343583;
        Thu, 09 Dec 2021 11:15:43 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-9c23-089d-4ab2-4477.res6.spectrum.com. [2603:8081:140c:1a00:9c23:89d:4ab2:4477])
        by smtp.googlemail.com with ESMTPSA id h3sm117807oon.34.2021.12.09.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:15:43 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next v7 8/8] RDMA/rxe: Add wait for completion to obj destruct
Date:   Thu,  9 Dec 2021 13:14:27 -0600
Message-Id: <20211209191426.15596-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211209191426.15596-1-rpearsonhpe@gmail.com>
References: <20211209191426.15596-1-rpearsonhpe@gmail.com>
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
v7
  Reverted rxe_add_ref back to just a void calling kref_get.
  Dropped checks of the return value of rxe_add_ref
v6
  Corrected incorrect comment before __rxe_fini()
  Added a #define for complete timeout value.
  Changed type of __rxe_fini to int to return value from wait_for_completion.
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
index 1eab692a8399..c630d8aaba63 100644
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
@@ -393,8 +397,33 @@ void rxe_elem_release(struct kref *kref)
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

