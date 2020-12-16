Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98422DC987
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 00:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgLPXRT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 18:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgLPXRS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 18:17:18 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F55C06138C
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:16:01 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 15so29860135oix.8
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/uZPXIVA1jpJj0yYxg2Xu3Y+knpQFR2IKCnC6gEECtc=;
        b=YNoKKOkVxGR9D5E2T0LvAkPADP4K2O1bkBsfe32fXi6B0kanFglXoLyhtcBxmSzRNg
         Di4pEgF32wurWg6aCU07XNUoIrQgITBm5B94zMYATcGRhGioAGtpDU6hAJGBHGinT4NP
         3FWVH20n/BRClgf6x9IenBWY+fLr6/EsTBGfpLPNmP6K6JB5HZiBKkeFxBz8o7oEdjdk
         IpAa9IcsnhBQZ/2AtuE6Ei0OYWSvbNsWkwdbZI9TBzgL9iXG73GgzqkawrMr1IroxtBh
         RXMQsyt98KvV8pDTS8xbHQZOsvab9JuCfQ4jHpurF893RqrYYeuUXUv6wybi5KHJv0Vm
         z6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/uZPXIVA1jpJj0yYxg2Xu3Y+knpQFR2IKCnC6gEECtc=;
        b=iqX+9RvWveNBpKaC8vqnkjGpwmkEIkEc4Lukhv5W+D3EVbOq8EZm6Y0lmxZVqivgsC
         L0jtB915tfQLaoNqdsovZ7mJ9XLZJs5thknoQS7SV+Df7VBlXWYc1LxFUWppvnKkUJsk
         ocsuwBjj8+R6JWUflbZJ/2d690Le31wea8sLd++YdUS5vI0/z94TV4RGr9kxNLYYbcrH
         FRhdPit1qqvlZiO1i8xW8ddvb/KIUZHUBDNtNlsqBE+0V+8+y/9ibAn5cVOeptbW/tAf
         qQVIxqEFJkAzLZ2MBPtVs5uEF5l3Yaae4Up9lkXqCJ3yuh/vGRHvOcQULV2/gEdhyVNC
         lLPQ==
X-Gm-Message-State: AOAM532Lb9ZPS+dBRgK3qtF1KONwR2rEwPS6J2IamhLuwLORC501DpZe
        neDRJTyWy7VCIiP7XCI2pe4=
X-Google-Smtp-Source: ABdhPJzcddSr+fNRlR8ujIfcImUqDJHsUnvn/WRNuex2MTVn71qs55XpfDUBGiRAxQ0YLtvA7/HLMw==
X-Received: by 2002:aca:4909:: with SMTP id w9mr3243693oia.166.1608160560678;
        Wed, 16 Dec 2020 15:16:00 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-6a03-8d89-0aec-a801.res6.spectrum.com. [2603:8081:140c:1a00:6a03:8d89:aec:a801])
        by smtp.gmail.com with ESMTPSA id f18sm793437otf.55.2020.12.16.15.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:16:00 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 5/7] RDMA/rxe: Make add/drop key/index APIs type safe
Date:   Wed, 16 Dec 2020 17:15:48 -0600
Message-Id: <20201216231550.27224-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201216231550.27224-1-rpearson@hpe.com>
References: <20201216231550.27224-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace 'void *' parameters with 'struct rxe_pool_entry *' and
use a macro to allow
   rxe_add_index,
   rxe_drop_index,
   rxe_add_key,
   rxe_drop_key and
   rxe_add_to_pool
APIs to be type safe against changing the position of pelem in
the objects.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c  | 14 +++++---------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 20 +++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 16 ++++++++--------
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 2873ecfb84c2..c8a6d0d7f01a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -266,9 +266,8 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return;
 }
 
-void rxe_add_key(void *arg, void *key)
+void __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -278,9 +277,8 @@ void rxe_add_key(void *arg, void *key)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void rxe_drop_key(void *arg)
+void __rxe_drop_key(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -289,9 +287,8 @@ void rxe_drop_key(void *arg)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void rxe_add_index(void *arg)
+void __rxe_add_index(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -301,9 +298,8 @@ void rxe_add_index(void *arg)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void rxe_drop_index(void *arg)
+void __rxe_drop_index(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -356,7 +352,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	return NULL;
 }
 
-int rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
 	unsigned long flags;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b37df6198e8a..5db0bdde185e 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -110,23 +110,33 @@ void rxe_pool_cleanup(struct rxe_pool *pool);
 void *rxe_alloc(struct rxe_pool *pool);
 
 /* connect already allocated object to pool */
-int rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+
+#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
 
 /* assign an index to an indexed object and insert object into
  *  pool's rb tree
  */
-void rxe_add_index(void *elem);
+void __rxe_add_index(struct rxe_pool_entry *elem);
+
+#define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
 
 /* drop an index and remove object from rb tree */
-void rxe_drop_index(void *elem);
+void __rxe_drop_index(struct rxe_pool_entry *elem);
+
+#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
 
 /* assign a key to a keyed object and insert object into
  *  pool's rb tree
  */
-void rxe_add_key(void *elem, void *key);
+void __rxe_add_key(struct rxe_pool_entry *elem, void *key);
+
+#define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
 
 /* remove elem from rb tree */
-void rxe_drop_key(void *elem);
+void __rxe_drop_key(struct rxe_pool_entry *elem);
+
+#define rxe_drop_key(obj) __rxe_drop_key(&(obj)->pelem)
 
 /* lookup an indexed object from index. takes a reference on object */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index a031514e2f41..7483a33bcec5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -106,12 +106,12 @@ static enum rdma_link_layer rxe_get_link_layer(struct ib_device *dev,
 	return IB_LINK_LAYER_ETHERNET;
 }
 
-static int rxe_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
+static int rxe_alloc_ucontext(struct ib_ucontext *ibuc, struct ib_udata *udata)
 {
-	struct rxe_dev *rxe = to_rdev(uctx->device);
-	struct rxe_ucontext *uc = to_ruc(uctx);
+	struct rxe_dev *rxe = to_rdev(ibuc->device);
+	struct rxe_ucontext *uc = to_ruc(ibuc);
 
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
 
@@ -273,7 +273,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		goto err1;
 
-	err = rxe_add_to_pool(&rxe->srq_pool, &srq->pelem);
+	err = rxe_add_to_pool(&rxe->srq_pool, srq);
 	if (err)
 		goto err1;
 
@@ -774,7 +774,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (err)
 		return err;
 
-	return rxe_add_to_pool(&rxe->cq_pool, &cq->pelem);
+	return rxe_add_to_pool(&rxe->cq_pool, cq);
 }
 
 static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
-- 
2.27.0

