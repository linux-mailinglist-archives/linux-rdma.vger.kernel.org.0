Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627FB428436
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 01:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhJKABo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhJKABn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Oct 2021 20:01:43 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B5C061570
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:44 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id g125so15535368oif.9
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQUlPb9uS4BrEmhtot372Fwk6A5crjCM71pI26AGA9Q=;
        b=QECewIghugfiAjb8TsKtnceNFaLSU9lnS9OpPbZxAaGID5LbAhjEmfBFVOy1Jzv42u
         3EmQWcH0Mq/RnIE9DC1K5ltkgIHE9rSNsg5zmYJm92nt6R/WeNLNfSGI3qIUm/YodPGR
         BXaGeU0UFSz/pHtUzN4KshqSfHmIxL/jVhtNlfTTsx/USXQWvJBiQpiWCocOExbLsAqW
         Vt+x66THNO8ByzzrktPoj27zYiuImcDzZvNA2Y+feYwYDCjtcOK/UxNKMLa5pFUM8GZj
         NhaFaLZbKYOZZcrcXe1Dhcc+C7+RtGb6pYspgqTY6UvqkXMtmPaAlVPp0VLd63TdtTZM
         xjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQUlPb9uS4BrEmhtot372Fwk6A5crjCM71pI26AGA9Q=;
        b=PfkZsh+aGxZY1NqHK7iGbBojt53CjRMDJYjVERE6z4fIGMMzRlOg8VQX0Vui0VgXi4
         aqjKoa3lLbSVwutxkNRhNVfD+69mLbJNIA566eLKYezHd/rMe5OtPzFS3zQKZvSYjENT
         v1qXHDL3BZrQZUJIJUuOCT+6BsVugKUkgxFgX1Mw4/3IGIEP4XprcQzYeowiR/nwUiuc
         qfGRSLZ8cfk5+RSPcPd+59vK6g+rJtDWOeMRTslmJETaRJdRFBErm+nJ2kagulekgnug
         4DxLEZEtxsU7Z5IPqj33uaRgDI+9BGofbkjI8g0x2GRpbfZZk/TMin3TsKxnx9iKuDOe
         oj1Q==
X-Gm-Message-State: AOAM531CJXzOjZyVd9miv9Kv1/XUgOAc+Vjx2gQXVsDKyoHPsLAo3Fyo
        WUSsFWTt510x3E+8R2cxmmo=
X-Google-Smtp-Source: ABdhPJwABipZY9oWRNAKB2w5z8B2HEPiqQ3C2rQESMp/p0eee+bluiQYqkiL+QbZ707PgImtRK6ZBA==
X-Received: by 2002:a05:6808:1a86:: with SMTP id bm6mr6306924oib.125.1633910383972;
        Sun, 10 Oct 2021 16:59:43 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-f9d4-70f1-9065-ca26.res6.spectrum.com. [2603:8081:140c:1a00:f9d4:70f1:9065:ca26])
        by smtp.gmail.com with ESMTPSA id c21sm1375379oiy.18.2021.10.10.16.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 16:59:43 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 3/6] RDMA/rxe: Save object pointer in pool element
Date:   Sun, 10 Oct 2021 18:59:28 -0500
Message-Id: <20211010235931.24042-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010235931.24042-1-rpearsonhpe@gmail.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c currently there are many cases where it is necessary to
compute the offset from a pool element struct to the object containing
the pool element in a type independent way. By saving a pointer to the
object when they are created extra work can be saved.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 16 +++++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.h |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index e9d74ad3f0b7..4caaecdb0d68 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -337,6 +337,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
 
 	elem->pool = pool;
+	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
 	return obj;
@@ -349,7 +350,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	unsigned long flags;
-	u8 *obj;
+	void *obj;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	obj = rxe_alloc_locked(pool);
@@ -364,6 +365,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 		goto out_cnt;
 
 	elem->pool = pool;
+	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
 	return 0;
@@ -378,13 +380,13 @@ void rxe_elem_release(struct kref *kref)
 	struct rxe_pool_entry *elem =
 		container_of(kref, struct rxe_pool_entry, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
-	u8 *obj;
+	void *obj;
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
 	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 		kfree(obj);
 	}
 
@@ -395,7 +397,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	u8 *obj;
+	void *obj;
 
 	node = pool->index.tree.rb_node;
 
@@ -412,7 +414,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 	} else {
 		obj = NULL;
 	}
@@ -436,7 +438,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	u8 *obj;
+	void *obj;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
@@ -457,7 +459,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 	} else {
 		obj = NULL;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index cd962dc5de9d..570bda77f4a6 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -46,6 +46,7 @@ struct rxe_type_info {
 
 struct rxe_pool_entry {
 	struct rxe_pool		*pool;
+	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
 
-- 
2.30.2

