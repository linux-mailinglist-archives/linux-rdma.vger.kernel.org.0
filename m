Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472D5300CC4
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbhAVTiU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 14:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbhAVTap (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 14:30:45 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6732EC061786
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:05 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id s2so3996987otp.5
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9nJ7JTUyYxu5fQxugnuhPqq/LbS6Yhpu3mLRRsHkwpo=;
        b=d7vIkAp6p4fwmJ54DXqWblOtqPdNUaIUIaRgyen6sBVnBZEWDQYti4oKRr0cIHl1GB
         m3JszNwqgRLwVL1UooU5S31zCQ/ol5phkIqQE7JPZXbZhjMD0te7uXJ4rZXIqeDg30h0
         oogobo1a9gTjfoFaSQ19n/asQcUqHlVEhkb/hY74kXwdw6ilmAhVPz6TCCxZPZyJ0O3F
         4nabuqJUqY2ZFNoDZEcd97FLdygfAEKe88dfCXrKZ7WFX32fdVapeA8GLi4dgzNg/xve
         uQSrfyGXYnYZOCJsZlh1NmTzKYKdftrUgg7mDjaY/R8eWkM465tfSbTjPHVL75tDDpgb
         55TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nJ7JTUyYxu5fQxugnuhPqq/LbS6Yhpu3mLRRsHkwpo=;
        b=tUE+D+DfU9KLwQEEySWSF/K0qBjzYFy2+WCQ1n0EI+9FADSDmeO6+cYCkPDvV7/lyx
         FtNelRvp9ciJoJTLClEK58UT/+ZqUhvY2N0zn9QUZnOvPcGQguWCB+VqdewnvHffJG+d
         FM3D7EaL1z968xbD67d6qugHxdPz0GLkzRtbs2Dh9OPvWr+yQhCfqv8MGY/9ZfPnzo5B
         hE8nnab+PfK/bQ6qHiD6QNVsDslM4YjPqrk5bu+6TBo2XxWfnqpq9P9RQHJqI5jFiJdR
         EXzAKmLn65csjTprbI6rJ/dLyHphohWFnok14Zm0sO4FB3BGqURnfFLYS0t6Age9kiyY
         yh+A==
X-Gm-Message-State: AOAM533OLGY56uSwYKrDP2xj4SvMPlXuyUgGWoFKYWcgicAW+dTxTbBS
        BUrQO5RZQ1GhzLgu0UnceLc=
X-Google-Smtp-Source: ABdhPJxaWM2Kqw2AyzlTtYfG9przv5SeWiDQSA4A1yDh5FHQINj2jNZqfn09cooFAb3QsjfJHyHlpQ==
X-Received: by 2002:a9d:4d05:: with SMTP id n5mr4532458otf.99.1611343803338;
        Fri, 22 Jan 2021 11:30:03 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-7fcf-0a74-ddeb-d9b7.res6.spectrum.com. [2603:8081:140c:1a00:7fcf:a74:ddeb:d9b7])
        by smtp.gmail.com with ESMTPSA id 36sm1835546oty.62.2021.01.22.11.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:30:02 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>,
        syzbot+ec2fd72374785d0e558e@syzkaller.appspotmail.com
Subject: [PATCH for-next v2 1/6] RDMA/rxe: Fix bug in rxe_alloc
Date:   Fri, 22 Jan 2021 13:29:38 -0600
Message-Id: <20210122192943.5538-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210122192943.5538-1-rpearson@hpe.com>
References: <20210122192943.5538-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A recent patch which added an 'unlocked' version of rxe_alloc
introduced a bug causing kzalloc(..., GFP_KERNEL) to be called
while holding a spin lock. This patch corrects that error.

rxe_alloc_nl() should always be called while holding the pool->pool_lock
so the 2nd argument to kzalloc there should be GFP_ATOMIC.

rxe_alloc() prior to the change only locked the code around checking
that pool->state is RXE_POOL_STATE_VALID to avoid races between
working threads and a thread shutting down the rxe driver. This patch
reverts rxe_alloc() to this behavior so the lock is not held when
kzalloc() is called.

Reported-by: syzbot+ec2fd72374785d0e558e@syzkaller.appspotmail.com
Fixes: 3853c35e243d ("RDMA/rxe: Add unlocked versions of pool APIs")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 41 ++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index d26730eec720..cfcd55175572 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -343,8 +343,6 @@ void *rxe_alloc_nl(struct rxe_pool *pool)
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
-	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
-
 	if (pool->state != RXE_POOL_STATE_VALID)
 		return NULL;
 
@@ -356,8 +354,7 @@ void *rxe_alloc_nl(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	obj = kzalloc(info->size, (pool->flags & RXE_POOL_ATOMIC) ?
-		      GFP_ATOMIC : GFP_KERNEL);
+	obj = kzalloc(info->size, GFP_ATOMIC);
 	if (!obj)
 		goto out_cnt;
 
@@ -378,14 +375,46 @@ void *rxe_alloc_nl(struct rxe_pool *pool)
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
-	u8 *obj;
 	unsigned long flags;
+	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	struct rxe_pool_entry *elem;
+	u8 *obj;
+
+	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
 
 	read_lock_irqsave(&pool->pool_lock, flags);
-	obj = rxe_alloc_nl(pool);
+	if (pool->state != RXE_POOL_STATE_VALID) {
+		read_unlock_irqrestore(&pool->pool_lock, flags);
+		return NULL;
+	}
+
+	kref_get(&pool->ref_cnt);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 
+	if (!ib_device_try_get(&pool->rxe->ib_dev))
+		goto out_put_pool;
+
+	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
+		goto out_cnt;
+
+	obj = kzalloc(info->size, (pool->flags & RXE_POOL_ATOMIC) ?
+		      GFP_ATOMIC : GFP_KERNEL);
+	if (!obj)
+		goto out_cnt;
+
+	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
+
+	elem->pool = pool;
+	kref_init(&elem->ref_cnt);
+
 	return obj;
+
+out_cnt:
+	atomic_dec(&pool->num_elem);
+	ib_device_put(&pool->rxe->ib_dev);
+out_put_pool:
+	rxe_pool_put(pool);
+	return NULL;
 }
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
-- 
2.27.0

