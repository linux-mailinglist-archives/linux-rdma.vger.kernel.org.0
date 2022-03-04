Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A404CCA8F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiCDAJh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiCDAJf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:35 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E04D269
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:49 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso7635687ooc.12
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HgWXVeHo1hUdjhPFA2XSav7mquXNX2WtALbOGZf4Lx4=;
        b=Mz5doqCMqORXusWSwAjmtKMGonbSbeBDeSn52+CKt2fZCi1eUMVmRC7Wa14exBTGeZ
         Li7eBG8xXKjgL3jeIv7+lTRvWhZniMCjlJ32YMtqC6xPqOfllZZV3aPFg+f6JYO/xRcx
         X2eyWCrYnr/5PEavyE/rJPHVyREnMirGup1JppkPcfixDBUAs2nDyOiVH+EGkHk0sOUF
         Qs0M7tW6J8tvozkjj3WKAnfJUAv3o6FuS8KVuBq4U4gVJ9lWbngBs7Pnj4jaFCs6Y1GR
         IGPY7ILY5u4PMAKbkgVrTvYCFxpWSMAnqbB0W+BkkXIajzyo9IcFWp0TuZyVGyYf73Oc
         jEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HgWXVeHo1hUdjhPFA2XSav7mquXNX2WtALbOGZf4Lx4=;
        b=IenqEqO4uDPTxgrxT4z/fkdtVtehiCKuztdeJL0bFjMVSvadzKplEo+o9Sio81Xq+j
         M0RKKs/iKa8eLNqKDRCjtte0qSc5kEAyleC0QbM5lHLEBNqY5WGW0J1asXlPubVwdl6Q
         TfnYDb9+F29su4Sc0ZWOsgYW3BwPnzT398DmdHFYYVhh3wu3JCLGdQqkKGaOQucgTfED
         ASJj003s5O7YTiZWo7ArG85STLG7tDOl4NG4ftfpwrgmgSyKFgNFEnmdK6uzSjRkaaLX
         Fw/fZZLqmtq7iTvTAALEF3VyTLauebzN/Mw6Ikvl4NqSc9gjvUORANG6b7tbB8UmGddb
         GABA==
X-Gm-Message-State: AOAM533/s6hpl3gs66NU7HU0652F5xd759Hf8sZSw3RntpxqXCvNTnxq
        f1QiqAWGNJO22LtLps4eti7lrgiarFw=
X-Google-Smtp-Source: ABdhPJxQzW4DWyyhIjKrqwAWgZm2pF/tPMzx8Sy6nl+2lpc8CG5vI8gvcpLmE0CzpCrWWlGmHUIdAQ==
X-Received: by 2002:a05:6870:702b:b0:d7:433a:ded with SMTP id u43-20020a056870702b00b000d7433a0dedmr6250184oae.64.1646352528599;
        Thu, 03 Mar 2022 16:08:48 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:48 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 10/13] RDMA/rxe: Stop lookup of partially built objects
Date:   Thu,  3 Mar 2022 18:08:06 -0600
Message-Id: <20220304000808.225811-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rdma_rxe driver has a security weakness due to giving
objects which are partially initialized indices allowing external
actors to gain access to them by sending packets which refer to
their index (e.g. qpn, rkey, etc) causing unpredictable results.

This patch adds two new APIs rxe_show(obj) and rxe_hide(obj) which
enable or disable looking up pool objects from indices using
rxe_pool_get_index(). By default objects are disabled. These APIs
are used to enable looking up objects which have indices:
AH, SRQ, QP, MR, and MW. They are added in create verbs after the
objects are fully initialized and as soon as possible in destroy
verbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 ++
 drivers/infiniband/sw/rxe/rxe_mw.c    |  4 +++
 drivers/infiniband/sw/rxe/rxe_pool.c  | 40 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_pool.h  |  5 ++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 12 ++++++++
 5 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 60a31b718774..e4ad2cc12584 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -689,6 +689,8 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		return -EINVAL;
 	}
 
+	rxe_hide(mr);
+
 	mr->state = RXE_MR_STATE_INVALID;
 	rxe_put(mr_pd(mr));
 	rxe_put(mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index c86b2efd58f2..4edbed1410e9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -25,6 +25,8 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 			RXE_MW_STATE_FREE : RXE_MW_STATE_VALID;
 	spin_lock_init(&mw->lock);
 
+	rxe_show(mw);
+
 	return 0;
 }
 
@@ -56,6 +58,8 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	struct rxe_mw *mw = to_rmw(ibmw);
 	struct rxe_pd *pd = to_rpd(ibmw->pd);
 
+	rxe_hide(mw);
+
 	spin_lock_bh(&mw->lock);
 	rxe_do_dealloc_mw(mw);
 	spin_unlock_bh(&mw->lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index b0dfeb08a470..c0b70687a83e 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -159,7 +159,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
 	if (err)
 		goto err_free;
@@ -187,7 +187,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
 	if (err)
 		goto err_cnt;
@@ -221,8 +221,12 @@ static void rxe_elem_release(struct kref *kref)
 {
 	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
 	struct rxe_pool *pool = elem->pool;
+	struct xarray *xa = &pool->xa;
+	unsigned long flags;
 
-	xa_erase(&pool->xa, elem->index);
+	xa_lock_irqsave(xa, flags);
+	__xa_erase(&pool->xa, elem->index);
+	xa_unlock_irqrestore(xa, flags);
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
@@ -242,3 +246,33 @@ int __rxe_put(struct rxe_pool_elem *elem)
 {
 	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
+
+int __rxe_show(struct rxe_pool_elem *elem)
+{
+	struct xarray *xa = &elem->pool->xa;
+	unsigned long flags;
+	void *ret;
+
+	xa_lock_irqsave(xa, flags);
+	ret = __xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
+	xa_unlock_irqrestore(xa, flags);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+	else
+		return 0;
+}
+
+int __rxe_hide(struct rxe_pool_elem *elem)
+{
+	struct xarray *xa = &elem->pool->xa;
+	unsigned long flags;
+	void *ret;
+
+	xa_lock_irqsave(xa, flags);
+	ret = __xa_store(&elem->pool->xa, elem->index, NULL, GFP_KERNEL);
+	xa_unlock_irqrestore(xa, flags);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+	else
+		return 0;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 24bcc786c1b3..c48d8f6f95f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -79,4 +79,9 @@ int __rxe_put(struct rxe_pool_elem *elem);
 
 #define rxe_read(obj) kref_read(&(obj)->elem.ref_cnt)
 
+int __rxe_show(struct rxe_pool_elem *elem);
+#define rxe_show(obj) __rxe_show(&(obj)->elem)
+int __rxe_hide(struct rxe_pool_elem *elem);
+#define rxe_hide(obj) __rxe_hide(&(obj)->elem)
+
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 67184b0281a0..e010e8860492 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -197,6 +197,8 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	}
 
 	rxe_init_av(init_attr->ah_attr, &ah->av);
+	rxe_show(ah);
+
 	return 0;
 }
 
@@ -228,6 +230,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
+	rxe_hide(ah);
 	rxe_put(ah);
 	return 0;
 }
@@ -310,6 +313,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		goto err2;
 
+	rxe_show(srq);
 	return 0;
 
 err2:
@@ -368,6 +372,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 
+	rxe_hide(srq);
 	if (srq->rq.queue)
 		rxe_queue_cleanup(srq->rq.queue);
 
@@ -439,6 +444,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	if (err)
 		goto qp_init;
 
+	rxe_show(qp);
 	return 0;
 
 qp_init:
@@ -491,6 +497,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct rxe_qp *qp = to_rqp(ibqp);
 	int ret;
 
+	rxe_hide(qp);
 	ret = rxe_qp_chk_destroy(qp);
 	if (ret)
 		return ret;
@@ -904,6 +911,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 	rxe_get(pd);
 	rxe_mr_init_dma(pd, access, mr);
+	rxe_show(mr);
 
 	return &mr->ibmr;
 }
@@ -932,6 +940,8 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	if (err)
 		goto err3;
 
+	rxe_show(mr);
+
 	return &mr->ibmr;
 
 err3:
@@ -964,6 +974,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	if (err)
 		goto err2;
 
+	rxe_show(mr);
+
 	return &mr->ibmr;
 
 err2:
-- 
2.32.0

