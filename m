Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732A0302D76
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jan 2021 22:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbhAYVTP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 16:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732568AbhAYVSX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jan 2021 16:18:23 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88143C06178C
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:49 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id m13so8358532oig.8
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9E77g67+kgLL6DKT76WJ3KWOIjkCnglA8Markr+v0xM=;
        b=BDF99oER9+ZDKZBKJTJWKWwC9oF8n6iAgJ8CI8uRN4vAT+PUpbawcg6pfgKzT0KfhY
         vkZ2ac5tELvjTL4LhJH1iPnCDx9toG4MJZVgQ1Gt83DQSpENBy7tVp6aGvvtXPiS/1uS
         64t37lEDjYEzgqQdpocjpEN1SYGpEj6zxiMQaHl0tzPfwEGZAxiIRSK/ltc+0bXzmiUs
         JJi2TCq3PMJvCCUvm47LRj6dtDjU+I9PY21fOHmwpiVHl3rusSnBhXzLJ+f8Ptwoyh48
         QoYfbR+fFJx8zLO0WJ/z/CCzMi7/FE56lJZrCG6ioowt+jw4y20YKm5yRm+rP9IieaLB
         Kd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9E77g67+kgLL6DKT76WJ3KWOIjkCnglA8Markr+v0xM=;
        b=gk+1DNgD/lijpMN8Bfv0WJjO8Ip+oh3VYqlI5bBEHwD+xVreZsaw1yFMDi/NIbHAUQ
         cOkwC1jsBDyPCoyY8ryuO/ePw0HuUmbGPAOPyHGW+nfnyCP1mC8wIhW5DJ+bHMo1fVMA
         qMPweJ5CQU9gBuZYkm5i4Efw04FIFh1pNxXVCxbgw4UtWGejoSP5k5DzoacOEvHFrxC0
         8X5ja8twjC41sIaKLfIrw/idnw3T+SSd8hsEgSAobrlBNpQMh9Qnq3ZVh58ATstjXBZW
         i2ZTsfIAZZ5oYynusc222wPCN7n2OUjKv2oFiAiNCRhaQ388xAhFxk/LMI8YcI03conn
         D/kg==
X-Gm-Message-State: AOAM530t0usq3lFW1TNJBeUvky18+R9W2km3scL9NCB3Ah8vwDPZsn9B
        Z1OelAeTsLREO+xkStAshFrVbSsgUYM=
X-Google-Smtp-Source: ABdhPJw407eB2lShKQHeG2AXnTEdKf2uXBBliDV/rNGcQ+oElzG6KLzBUK78CdTeQ8i8Z+8cPEuVxg==
X-Received: by 2002:aca:f009:: with SMTP id o9mr1312380oih.133.1611609409070;
        Mon, 25 Jan 2021 13:16:49 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-8baa-bb83-cd49-4ca4.res6.spectrum.com. [2603:8081:140c:1a00:8baa:bb83:cd49:4ca4])
        by smtp.gmail.com with ESMTPSA id w11sm3722564otg.58.2021.01.25.13.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:16:48 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v3 6/6] RDMA/rxe: Replace missing rxe_pool_get_index_locked
Date:   Mon, 25 Jan 2021 15:16:41 -0600
Message-Id: <20210125211641.2694-7-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210125211641.2694-1-rpearson@hpe.com>
References: <20210125211641.2694-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[v2]
One of the pool APIs for when caller is holding lock was not defined
but is declared in rxe_pool.h. This patch adds the definition.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 5aa835028460..307d8986e7c9 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -398,15 +398,12 @@ void rxe_elem_release(struct kref *kref)
 	atomic_dec(&pool->num_elem);
 }
 
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	u8 *obj = NULL;
-	unsigned long flags;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
+	u8 *obj;
 
 	node = pool->index.tree.rb_node;
 
@@ -428,6 +425,16 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 		obj = NULL;
 	}
 
+	return obj;
+}
+
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+{
+	u8 *obj;
+	unsigned long flags;
+
+	read_lock_irqsave(&pool->pool_lock, flags);
+	obj = rxe_pool_get_index_locked(pool, index);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
@@ -438,7 +445,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	u8 *obj = NULL;
+	u8 *obj;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
@@ -469,7 +476,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 {
-	u8 *obj = NULL;
+	u8 *obj;
 	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
-- 
2.27.0

