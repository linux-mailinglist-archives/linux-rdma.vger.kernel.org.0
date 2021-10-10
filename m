Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9D428434
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 01:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhJKABn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 20:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhJKABm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Oct 2021 20:01:42 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999BCC06161C
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:43 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id o204so14089242oih.13
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhQRoAI5C8GwdjDfE7PmcUW/h+BkYNOFrJSHy3H8Z2o=;
        b=QlsPPVDDTM/SrJ9dE2D1UqUH4iKuiLHHGY32fZdbLtd9Cx/cHmpUgjkuHC8p+Jl58o
         jCm1qc4SUv1qPA/s7Zn0mCqUmz1X1m5gf0UuU31Bma2ZZVlvQ1nN6pqOWhrJfyJdb4wv
         Y79lrBYQalFMbDHw2hIiq+c7M7hf6xRpkp9+HSljkZXq3ruHwGzUdHqBdaHM1FUHsG8h
         Mi1msof5J11YMKN75tYgzNGnsOs1iaFcmpL/vjDgJgYlBNVpMF4S+Y54EFBFAq06B4sq
         4Hr9FF2kXf/IcEQW6uaVEstlqrf11RmvIVNdwpcOZNoVFLeRtI8gJmLdwzIOeeT5q2Ot
         KgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhQRoAI5C8GwdjDfE7PmcUW/h+BkYNOFrJSHy3H8Z2o=;
        b=rTpbA8tp12Mt2cTYsVSW+sZDkcQlpVCcBQD4xXId/0lLWBoo3DnyPOr7KcIS/ON2Xx
         KGzZZuEpHGWvuCuN89FeCkmOWXwN7Dw8zRJAxRZLW/WPbYptCh4J1mo7jQqqpHPoX+x2
         bcp8SQoKicCIDfqAE4sjrDekJEyzVSP0Fu1gVuStu7FUFoITZbBiIylNJBUqrvxGUZXg
         8VaRtouq0+FiQ7b7YZ+E7FICK9CSmHWX8svOg+eWQQ2n4csKgY8bkrElWxN55eLskZbu
         tJBTt3jShoj7VBceYHyr+hJOXYDUoF6e+j0gbg91XTa4p4pqKY8Nm4OopRtAj7DBBHWs
         LcMA==
X-Gm-Message-State: AOAM530nmAfpKVjAhYK3MQBZKLX1ezsIhR8pRr7ri8pthN8P0oYxkklI
        ba+QPEX4uD+077+8PaAbcE4=
X-Google-Smtp-Source: ABdhPJxx+FbV2+PX6eLAqHe+5wOwgT+mqmaDWMMFDXTs9aaUP5y3QL6D+upNYiBP9l1c/i9ywqdqRQ==
X-Received: by 2002:a54:408f:: with SMTP id i15mr16147400oii.17.1633910382947;
        Sun, 10 Oct 2021 16:59:42 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-f9d4-70f1-9065-ca26.res6.spectrum.com. [2603:8081:140c:1a00:f9d4:70f1:9065:ca26])
        by smtp.gmail.com with ESMTPSA id c21sm1375379oiy.18.2021.10.10.16.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 16:59:42 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 1/6] RDMA/rxe: Make rxe_alloc() take pool lock
Date:   Sun, 10 Oct 2021 18:59:26 -0500
Message-Id: <20211010235931.24042-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010235931.24042-1-rpearsonhpe@gmail.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe there are two separate pool APIs for creating a new object
rxe_alloc() and rxe_alloc_locked(). Currently they are identical.
Make rxe_alloc() take the pool lock which is in line with the other
APIs in the library.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index ffa8420b4765..7a288ebacceb 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -352,27 +352,14 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
-	struct rxe_pool_entry *elem;
+	unsigned long flags;
 	u8 *obj;
 
-	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
-
-	obj = kzalloc(info->size, GFP_KERNEL);
-	if (!obj)
-		goto out_cnt;
-
-	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
-
-	elem->pool = pool;
-	kref_init(&elem->ref_cnt);
+	write_lock_irqsave(&pool->pool_lock, flags);
+	obj = rxe_alloc_locked(pool);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
-
-out_cnt:
-	atomic_dec(&pool->num_elem);
-	return NULL;
 }
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
-- 
2.30.2

