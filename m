Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9292DC981
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 00:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgLPXQk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 18:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLPXQk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 18:16:40 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D60FC0617B0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:16:00 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id b24so7656145otj.0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PsXzxcoOGom3blPQmGb/0N1UjQgyx0UMORYQXYP7Tyk=;
        b=F+LwnogOAvXos1JF1d8/HyoXJ8YZ/GA3X5fbVEQgSW5M8WRGX4mIfIyTEOqXoF9uQ/
         GjO6RdetMIicQbFFN4MBcOZtWG+F/DZPjxSkMsK163DFkXWVYIP1Gxzw5q4axbK63boW
         88wptPFo8w6ZFrbF2jRe8X5kXo8lHs6AeZb+nBd4nFi3SPUgBoljjJa4E4k/pg0066px
         JiIq5U/S53i044B9WxyG8dd/Qf8KnxDKINyYgH+D2C7v/E/P+sY1wL/SFkIBx1Kv075b
         HFG7AE+3/DawqXxeeymKsTgND9SMaU+fFXV0xcxWWFCvyEHx+FbOKx40Yz8L3+1YnxvV
         ofIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsXzxcoOGom3blPQmGb/0N1UjQgyx0UMORYQXYP7Tyk=;
        b=RwGJ2/3uRtwh/pSYo6xGWI2kbEvq/WyF1QU5/UpzZQ1dBrrG0b9a7CJxmPoWBu8nHL
         RbVDmi/oIRdBC+03AMbb5u4R8AyEfQ5pHw7uPz/LR2cRzC/wFPxp/6pPfwFvuaR2w/PN
         nck64eu80TSLOET3tcnLmnNN0PfKPYWfleQqwWC03sq7RMkNUVVP0e+nQVhluP3ybfkX
         u4de026gGEA1nAhT5oqRFO6ApjaUXNLI0zwogvX8n9YySFyB++jyKHMKYZ5MZPhJ5EnC
         o3hRRWj2mtbO0KM2xdM2Kx15rDmODjONTsmR1cKl/L3UcqiZ125oTzc3e03J6XzyFj3c
         Qx5Q==
X-Gm-Message-State: AOAM531EvNvCRfBdMi7CF4yisiv5sHAbW0psRF0wOdea2mRBin4eOCbv
        /LWYRec7XdQsgtBsUKXGwAM=
X-Google-Smtp-Source: ABdhPJykQuqzwSBWdV3d4tS79KSMFDlKGT3GGbWzaZH9KZeWEKjPdqN+Dse1D13wAWOuUQrZiFqOIA==
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr28037695otq.125.1608160559923;
        Wed, 16 Dec 2020 15:15:59 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-6a03-8d89-0aec-a801.res6.spectrum.com. [2603:8081:140c:1a00:6a03:8d89:aec:a801])
        by smtp.gmail.com with ESMTPSA id f18sm793437otf.55.2020.12.16.15.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:15:59 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 4/7] RDMA/rxe: Make pool lookup and alloc APIs type safe
Date:   Wed, 16 Dec 2020 17:15:47 -0600
Message-Id: <20201216231550.27224-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201216231550.27224-1-rpearson@hpe.com>
References: <20201216231550.27224-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The allocate, lookup index, lookup key and cleanup routines
in rxe_pool.c currently are not type safe against relocating
the pelem field in the objects. Planned changes to move
allocation of objects into rdma-core make addressing this a
requirement.

Use the elem_offset field in rxe_type_info make these APIs
safe against moving the pelem field.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 55 +++++++++++++++++++---------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 4d667b78af9b..2873ecfb84c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -315,7 +315,9 @@ void rxe_drop_index(void *arg)
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
+	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
+	u8 *obj;
 	unsigned long flags;
 
 	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
@@ -334,16 +336,17 @@ void *rxe_alloc(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	elem = kzalloc(rxe_type_info[pool->type].size,
-				 (pool->flags & RXE_POOL_ATOMIC) ?
-				 GFP_ATOMIC : GFP_KERNEL);
-	if (!elem)
+	obj = kzalloc(info->size, (pool->flags & RXE_POOL_ATOMIC) ?
+		      GFP_ATOMIC : GFP_KERNEL);
+	if (!obj)
 		goto out_cnt;
 
+	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
+
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
 
-	return elem;
+	return obj;
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
@@ -391,12 +394,17 @@ void rxe_elem_release(struct kref *kref)
 	struct rxe_pool_entry *elem =
 		container_of(kref, struct rxe_pool_entry, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
+	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	u8 *obj;
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (!(pool->flags & RXE_POOL_NO_ALLOC))
-		kfree(elem);
+	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
+		obj = (u8 *)elem - info->elem_offset;
+		kfree(obj);
+	}
+
 	atomic_dec(&pool->num_elem);
 	ib_device_put(&pool->rxe->ib_dev);
 	rxe_pool_put(pool);
@@ -404,8 +412,10 @@ void rxe_elem_release(struct kref *kref)
 
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
-	struct rb_node *node = NULL;
-	struct rxe_pool_entry *elem = NULL;
+	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	struct rb_node *node;
+	struct rxe_pool_entry *elem;
+	u8 *obj = NULL;
 	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
@@ -422,21 +432,28 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 			node = node->rb_left;
 		else if (elem->index < index)
 			node = node->rb_right;
-		else {
-			kref_get(&elem->ref_cnt);
+		else
 			break;
-		}
+	}
+
+	if (node) {
+		kref_get(&elem->ref_cnt);
+		obj = (u8 *)elem - info->elem_offset;
+	} else {
+		obj = NULL;
 	}
 
 out:
 	read_unlock_irqrestore(&pool->pool_lock, flags);
-	return node ? elem : NULL;
+	return obj;
 }
 
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 {
-	struct rb_node *node = NULL;
-	struct rxe_pool_entry *elem = NULL;
+	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	struct rb_node *node;
+	struct rxe_pool_entry *elem;
+	u8 *obj = NULL;
 	int cmp;
 	unsigned long flags;
 
@@ -461,10 +478,14 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 			break;
 	}
 
-	if (node)
+	if (node) {
 		kref_get(&elem->ref_cnt);
+		obj = (u8 *)elem - info->elem_offset;
+	} else {
+		obj = NULL;
+	}
 
 out:
 	read_unlock_irqrestore(&pool->pool_lock, flags);
-	return node ? elem : NULL;
+	return obj;
 }
-- 
2.27.0

