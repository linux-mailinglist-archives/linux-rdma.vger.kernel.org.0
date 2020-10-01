Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7E62805D9
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbgJARtB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARs7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:48:59 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3CC0613D0
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:48:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a2so6287386otr.11
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H0Pa4DycvodekXTAXArEWJli50xpBUboI/r2vry1bLM=;
        b=DfFJh3Uwh/gUYyVOYRg9Bi5UdBK3TAGZvYcHXA0OjFw6dP4OLKU1HGC87DN3y0fsfa
         9JUHfsX+7cz/ea/zYLgX2fbc25/tk9Rnc+jwGWUjk7iM75ZhAihbf94RWpbhKgwX0G3A
         aMfCdtH81qvaOptQkmG4sH2eGu4qqsLeMu1BiElZpw4Yrne4izCg4d4I4IlM3IA09j6n
         TZJn8u1kMRa3FWr5HsQPqqE17w93m2+JIvVkyqD5xr0KRSkJkkZv06FSOsGPDFiqfWRY
         hnPrKA9EfebnwZN5uIL8Xbw26/2cXtJUy4zUQ9m/tgZodGmRcGvjJKYrF20wHokBs/uo
         brMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H0Pa4DycvodekXTAXArEWJli50xpBUboI/r2vry1bLM=;
        b=rvXAU7m0pSAnGZFPOng/xGG1vl6hEg32oQRlL13ZK1zFAbpCPAx719hBe9sRbrvJQ9
         oMFU4IEAUfieBDZfwm3aWuZU25Z5Oz31haQi7pAwHfvgxqZietkU8o8qWcSgXacDQ2g5
         0V8hB92zoUv/Rb32mHER9FD35rBqiXZs5bzGDDylDFXuH4HOHk6f5gDhxDxKuofRwtF9
         rYdWvZYl7qc7my6EighmPZ6NWIoq+dzlyfixZY33x8bTLmDX3p+AxRCnhryjY/s8rEeS
         GVlhhgcmtRqNnJL3wlPhEZ50iQJGOkxmiKllHjQMqpDcOPTuMDpwEL8Fc2CRoBPqOANn
         Qg+w==
X-Gm-Message-State: AOAM530Z/vuDOrowT9mbzW3zNZpHVwFMicNb7aMNxAQ8zWIEr9PIWLBf
        Q3ntfIZ+4+fK0Tq/pDishDU=
X-Google-Smtp-Source: ABdhPJwH98eHwyCWIRr5hy0mqonkAEJWakli8jFQMLQ8+D1PLDNHP90DDUmkuc1H6u+aIKqNG/sd3A==
X-Received: by 2002:a05:6830:1e8a:: with SMTP id n10mr5917822otr.371.1601574538617;
        Thu, 01 Oct 2020 10:48:58 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id d83sm1192790oib.43.2020.10.01.10.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:48:58 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 05/19] rdma_rxe: remove void * parameters in pool APIs
Date:   Thu,  1 Oct 2020 12:48:33 -0500
Message-Id: <20201001174847.4268-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

More work to make rxe pools type safe.
Replaced routines that took void * as parameters and
and replaced them with rxe_pool_entry *elem. Then added macros
to convert objects to pool entries. This makes these routines
type safe against moving the pool entries around in the objects.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c  | 14 +++++--------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 29 ++++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 10 ++++-----
 3 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index c4f1318ea761..e40a64616d79 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -264,9 +264,8 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return;
 }
 
-void rxe_add_key(void *arg, void *key)
+void __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -276,9 +275,8 @@ void rxe_add_key(void *arg, void *key)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void rxe_drop_key(void *arg)
+void __rxe_drop_key(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -287,9 +285,8 @@ void rxe_drop_key(void *arg)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void rxe_add_index(void *arg)
+void __rxe_add_index(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -299,9 +296,8 @@ void rxe_add_index(void *arg)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void rxe_drop_index(void *arg)
+void __rxe_drop_index(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -354,7 +350,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	return NULL;
 }
 
-int rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
 	unsigned long flags;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 68c6dbeb72d4..2f9be92ef6f9 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -109,24 +109,25 @@ void rxe_pool_cleanup(struct rxe_pool *pool);
 /* allocate an object from pool */
 void *rxe_alloc(struct rxe_pool *pool);
 
-/* connect already allocated object to pool */
-int rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
 
-/* assign an index to an indexed object and insert object into
- *  pool's rb tree
- */
-void rxe_add_index(void *elem);
+#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
 
-/* drop an index and remove object from rb tree */
-void rxe_drop_index(void *elem);
+void __rxe_add_index(struct rxe_pool_entry *elem);
 
-/* assign a key to a keyed object and insert object into
- *  pool's rb tree
- */
-void rxe_add_key(void *elem, void *key);
+#define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
+
+void __rxe_drop_index(struct rxe_pool_entry *elem);
+
+#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
+
+void __rxe_add_key(struct rxe_pool_entry *elem, void *key);
+
+#define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
+
+void __rxe_drop_key(struct rxe_pool_entry *elem);
 
-/* remove elem from rb tree */
-void rxe_drop_key(void *elem);
+#define rxe_drop_key(obj) __rxe_drop_key(&(obj)->pelem)
 
 /* lookup an indexed object from index. takes a reference on object */
 void *rxe_get_index(struct rxe_pool *pool, u32 index);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 664bcb025aae..db1d7f5ca2a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -111,7 +111,7 @@ static int rxe_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(uctx->device);
 	struct rxe_ucontext *uc = to_ruc(uctx);
 
-	return rxe_add_to_pool(&rxe->uc_pool, &uc->pelem);
+	return rxe_add_to_pool(&rxe->uc_pool, uc);
 }
 
 static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
@@ -145,7 +145,7 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	return rxe_add_to_pool(&rxe->pd_pool, &pd->pelem);
+	return rxe_add_to_pool(&rxe->pd_pool, pd);
 }
 
 static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
@@ -169,7 +169,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	if (err)
 		return err;
 
-	err = rxe_add_to_pool(&rxe->ah_pool, &ah->pelem);
+	err = rxe_add_to_pool(&rxe->ah_pool, ah);
 	if (err)
 		return err;
 
@@ -275,7 +275,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		goto err1;
 
-	err = rxe_add_to_pool(&rxe->srq_pool, &srq->pelem);
+	err = rxe_add_to_pool(&rxe->srq_pool, srq);
 	if (err)
 		goto err1;
 
@@ -776,7 +776,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (err)
 		return err;
 
-	return rxe_add_to_pool(&rxe->cq_pool, &cq->pelem);
+	return rxe_add_to_pool(&rxe->cq_pool, cq);
 }
 
 static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
-- 
2.25.1

