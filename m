Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01F62FFBB9
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 05:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbhAVEY5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 23:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbhAVEYu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 23:24:50 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B56BC061788
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 20:23:33 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i30so3932450ota.6
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 20:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IoLQ6Kb0lyZM9KouXLHmO29EO02ozzdL35YEzatFBKg=;
        b=jWcFKkUU3COJgzfYD4sPs9i2v7KOhREZFTNY0HGQhHHkAaz9pUqBTs2j1DdtpkU+2P
         xjB2PCSGVdhDgi3h3K8Hw2Nch/9CrX8dRlwVyCMYXH6Vq1jRuYOGKACzfar8OdB5nYiI
         VNZAtG5Caci40+oA7g/vxCispLq7iBmkO30JTJD9NncV53yOpKAPEm+TKJ0t8KNmJMLd
         28nFYMxyOIcTgmr/Mpz7KCDKR1BTGrJfGqYv4Lb4YlVx4X95ta2ltJNAIBLTNSXcCHYp
         xMrCSL9N2bpfaBMrWu72e9rqcDKYxFKO4huU/4Xw7U0GU6joo+MXQ81B4uq0vAFXq1Us
         Ta+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IoLQ6Kb0lyZM9KouXLHmO29EO02ozzdL35YEzatFBKg=;
        b=rITGwkcH/FzO+YDiQJUUE4x1dJe5vh9opmGCPbz5hYUTfTo7f/o1zqnD+Lg1f8ViT3
         VITC4crgZ2uxPmeZb+T6ujHy8nNmCbELwBBNCb58LkksDe4iEA9VZx9gB9dHY2K4ZCfL
         a2e5V+qMtB2rRCsMlL48VY14hEFYwV2/Os34weLIMB0uKExUSRdnd4SY6UmzqpFzBxkg
         iRszlC6z3SB0I9oDaIHLLd7QoFdifhHDoH5YZQq+Fgl3chRv3R7MwNKIwhXdQi/h1VB0
         LYni8puQ6SoZroB881UpsxWzCFq5a+gZ3vsfzpYtkQsa5CyZq8wCnTu1CrgG+vumFrmQ
         J6jA==
X-Gm-Message-State: AOAM530+xc3q0JxNUIPpPcUn0f2eJf6oRhLJa58txEQvo/jX0+rUAa6k
        ri5kfPN7NEGUgmjDtbL8SUQ=
X-Google-Smtp-Source: ABdhPJz9xf5D/bASHa17kBgvk6fmcVFXojBh+Y3KCdDCqLtZffW0nJp/Ojd7WxaeokeVpoWw2b4+Jw==
X-Received: by 2002:a9d:4d8c:: with SMTP id u12mr2008281otk.186.1611289412509;
        Thu, 21 Jan 2021 20:23:32 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-5689-5322-9983-137f.res6.spectrum.com. [2603:8081:140c:1a00:5689:5322:9983:137f])
        by smtp.gmail.com with ESMTPSA id q26sm14244otg.28.2021.01.21.20.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 20:23:32 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 5/5] RDMA/rxe: Remove unneeded pool->flag
Date:   Thu, 21 Jan 2021 22:23:13 -0600
Message-Id: <20210122042313.3336-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210122042313.3336-1-rpearson@hpe.com>
References: <20210122042313.3336-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rxe driver used the field pool->flag to mark a pool as it was
begin shut down and checked this flag in several pool APIs to
validate that the pool had not been shut dowm. This is really
unneeded because the pools were not marked invalid unless the
entire driver was being removed at which point no functional
APIs should or could be executing. This patch removes this
flag, associated enums and spinlock code, and unneeded labels.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 38 ----------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  6 -----
 2 files changed, 44 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 157fb340a3fb..0d177a823365 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -159,8 +159,6 @@ int rxe_pool_init(
 		pool->key.key_size = rxe_type_info[type].key_size;
 	}
 
-	pool->state = RXE_POOL_STATE_VALID;
-
 out:
 	return err;
 }
@@ -169,7 +167,6 @@ static void rxe_pool_release(struct kref *kref)
 {
 	struct rxe_pool *pool = container_of(kref, struct rxe_pool, ref_cnt);
 
-	pool->state = RXE_POOL_STATE_INVALID;
 	kfree(pool->index.table);
 }
 
@@ -180,14 +177,9 @@ static void rxe_pool_put(struct rxe_pool *pool)
 
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
-	unsigned long flags;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	pool->state = RXE_POOL_STATE_INVALID;
 	if (atomic_read(&pool->num_elem) > 0)
 		pr_warn("%s pool destroyed with unfree'd elem\n",
 			pool_name(pool));
-	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	rxe_pool_put(pool);
 }
@@ -342,9 +334,6 @@ void *rxe_alloc__(struct rxe_pool *pool)
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
-	if (pool->state != RXE_POOL_STATE_VALID)
-		return NULL;
-
 	kref_get(&pool->ref_cnt);
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
@@ -363,26 +352,17 @@ void *rxe_alloc__(struct rxe_pool *pool)
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
-out_put_pool:
 	rxe_pool_put(pool);
 	return NULL;
 }
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
-	unsigned long flags;
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
-	read_lock_irqsave(&pool->pool_lock, flags);
-	if (pool->state != RXE_POOL_STATE_VALID) {
-		read_unlock_irqrestore(&pool->pool_lock, flags);
-		return NULL;
-	}
-
 	kref_get(&pool->ref_cnt);
-	read_unlock_irqrestore(&pool->pool_lock, flags);
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
@@ -400,22 +380,13 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
-out_put_pool:
 	rxe_pool_put(pool);
 	return NULL;
 }
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
-	unsigned long flags;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
-	if (pool->state != RXE_POOL_STATE_VALID) {
-		read_unlock_irqrestore(&pool->pool_lock, flags);
-		return -EINVAL;
-	}
 	kref_get(&pool->ref_cnt);
-	read_unlock_irqrestore(&pool->pool_lock, flags);
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
@@ -427,7 +398,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
-out_put_pool:
 	rxe_pool_put(pool);
 	return -EINVAL;
 }
@@ -462,9 +432,6 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 	read_lock_irqsave(&pool->pool_lock, flags);
 
-	if (pool->state != RXE_POOL_STATE_VALID)
-		goto out;
-
 	node = pool->index.tree.rb_node;
 
 	while (node) {
@@ -485,7 +452,6 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 		obj = NULL;
 	}
 
-out:
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 	return obj;
 }
@@ -498,9 +464,6 @@ void *rxe_pool_get_key__(struct rxe_pool *pool, void *key)
 	u8 *obj = NULL;
 	int cmp;
 
-	if (pool->state != RXE_POOL_STATE_VALID)
-		goto out;
-
 	node = pool->key.tree.rb_node;
 
 	while (node) {
@@ -524,7 +487,6 @@ void *rxe_pool_get_key__(struct rxe_pool *pool, void *key)
 		obj = NULL;
 	}
 
-out:
 	return obj;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index f916ad4d0406..d259531430d7 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -46,11 +46,6 @@ struct rxe_type_info {
 
 extern struct rxe_type_info rxe_type_info[];
 
-enum rxe_pool_state {
-	RXE_POOL_STATE_INVALID,
-	RXE_POOL_STATE_VALID,
-};
-
 struct rxe_pool_entry {
 	struct rxe_pool		*pool;
 	struct kref		ref_cnt;
@@ -70,7 +65,6 @@ struct rxe_pool {
 	size_t			elem_size;
 	struct kref		ref_cnt;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
-	enum rxe_pool_state	state;
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
 
-- 
2.27.0

