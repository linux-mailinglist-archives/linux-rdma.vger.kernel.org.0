Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F87A300CCA
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 20:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbhAVTjP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 14:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730698AbhAVTbl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 14:31:41 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8C6C061793
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:07 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id x137so5981178oix.11
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibDugmfaLdpp1gYk0tRhaWa1miiO3MXc+5tI8LO/nL8=;
        b=C0d4KeuGBiJ3MXf4HzzL3TP0BbxQJSvh324T0PnftiJaf40L7wbvFE/hA5i7OJLGxm
         hIFWxLH2exEeZL3J06qGtFxkjOqvUfuw2Gii51FdezRwS0/Xd3WCTyhnhElPn/SMMdV0
         nDY8y5mM0Q5NUgdGi+dFPf45abZHacWPDbBoAgGp/saFZw23bDhYq2umiMhxLjalDYnP
         NmHnAfdf/FhfnK1WVWHMKebhIR18IDXxd2Q4/V58IbO+9ZqW9lLsk7UdfzTdINT2er9u
         ImI4tIRjxQmPOhOTw9body9hTO5hy2NWMLbvT9zG0fagsa9VT44t0FSL4W9CdFwRWd+l
         KaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibDugmfaLdpp1gYk0tRhaWa1miiO3MXc+5tI8LO/nL8=;
        b=tlPoGrTDFclciyeGUYnttsIUFg1gg7ZV8xU9lpB/iZIve3kpd3E3iTICIeSUgxUdwC
         lyGTQsd4v2Rd65D3XBnQsXO1oWYwP+2PRpuQ1A83FTNkk8HZDGeGjkz9F/aSsO1mcdUP
         NYkrTYQy1qTSnlZElk0fFwvfVR32pWQDIu+zxx5EVng9Fl5iLyqnhKBGnOqMCeUt+6zt
         sd827mjAx2+5TiMjbtyucsQLt7s7z633AgWfQ0KrQi7vpuxfjqWd8fKm/1TqUakxgrYz
         NS5U1XNmB8gjcH86DbqMqCyPGS0w+Jrgz5ady/c0tKiCTpAM5ZZQ6nno2t+kr29o6PET
         hgzQ==
X-Gm-Message-State: AOAM531zXtCPIwjG0W6dR2HYu90vH1kFdKZq3BJshRv3dsCV8xYQW3Ej
        r2/oLTUljzMcDOMsqVIl7OI=
X-Google-Smtp-Source: ABdhPJycj9hUMseqiHvWRBiQPRoTZ+J5nlxtEFfbu2LWabvsYR/tVJxChS7AoMEs1H9mUpxxwaS5WQ==
X-Received: by 2002:aca:d504:: with SMTP id m4mr4513645oig.158.1611343806708;
        Fri, 22 Jan 2021 11:30:06 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-7fcf-0a74-ddeb-d9b7.res6.spectrum.com. [2603:8081:140c:1a00:7fcf:a74:ddeb:d9b7])
        by smtp.gmail.com with ESMTPSA id 36sm1835546oty.62.2021.01.22.11.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:30:06 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 5/6] RDMA/rxe: Remove unneeded pool->state
Date:   Fri, 22 Jan 2021 13:29:42 -0600
Message-Id: <20210122192943.5538-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210122192943.5538-1-rpearson@hpe.com>
References: <20210122192943.5538-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_pool.c uses the field pool->state to mark a pool as invalid
when it is shut down and checks it in several pool APIs to verify
that the pool has not been shut dowm. This is unneeded because the
pools are not marked invalid unless the entire driver is being
removed at which point no functional APIs should or could be
executing. This patch removes this field and associated code.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 38 +---------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 09d8665c5343..7a03d49b263d 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -157,24 +157,16 @@ int rxe_pool_init(
 		pool->key.key_size = rxe_type_info[type].key_size;
 	}
 
-	pool->state = RXE_POOL_STATE_VALID;
-
 out:
 	return err;
 }
 
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
 
-	pool->state = RXE_POOL_STATE_INVALID;
 	kfree(pool->index.table);
 }
 
@@ -328,9 +320,6 @@ void *rxe_alloc__(struct rxe_pool *pool)
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
-	if (pool->state != RXE_POOL_STATE_VALID)
-		return NULL;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -352,19 +341,10 @@ void *rxe_alloc__(struct rxe_pool *pool)
 
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
-	read_unlock_irqrestore(&pool->pool_lock, flags);
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -386,15 +366,6 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
-	unsigned long flags;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
-	if (pool->state != RXE_POOL_STATE_VALID) {
-		read_unlock_irqrestore(&pool->pool_lock, flags);
-		return -EINVAL;
-	}
-	read_unlock_irqrestore(&pool->pool_lock, flags);
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -437,9 +408,6 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 	read_lock_irqsave(&pool->pool_lock, flags);
 
-	if (pool->state != RXE_POOL_STATE_VALID)
-		goto out;
-
 	node = pool->index.tree.rb_node;
 
 	while (node) {
@@ -460,8 +428,8 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 		obj = NULL;
 	}
 
-out:
 	read_unlock_irqrestore(&pool->pool_lock, flags);
+
 	return obj;
 }
 
@@ -473,9 +441,6 @@ void *rxe_pool_get_key__(struct rxe_pool *pool, void *key)
 	u8 *obj = NULL;
 	int cmp;
 
-	if (pool->state != RXE_POOL_STATE_VALID)
-		goto out;
-
 	node = pool->key.tree.rb_node;
 
 	while (node) {
@@ -499,7 +464,6 @@ void *rxe_pool_get_key__(struct rxe_pool *pool, void *key)
 		obj = NULL;
 	}
 
-out:
 	return obj;
 }
 
-- 
2.27.0

