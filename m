Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E722FFBB7
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 05:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbhAVEYL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 23:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbhAVEYK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 23:24:10 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D010FC061756
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 20:23:29 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 15so4714209oix.8
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 20:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9nJ7JTUyYxu5fQxugnuhPqq/LbS6Yhpu3mLRRsHkwpo=;
        b=ZWAttvMidmbGkRnk/sIGksV9DzqW2Fe2T61w/lCzlRET9gAgAA/Y4atBGKqnI9lIna
         KCnDq32T59llE4fxEKtrSWuXaBHlzAIPs3ruWWp/9ZIcDkLsPc4WaPsNqH5FIDg//2xS
         uIk9lG/8kXTWEJ2DH4wAvfiHmWbhbxYrDCriTcsOxC5tkshXV0u2+zA0Edf05uHLV5SM
         RRZdbctNj/YX1bmgch8NTe3us3gLmlhjlKJEI8SrWNF9RbKSGuAwbknsivH/E3kGWbda
         roCeLNUkgsISVJlHT4sgIRkr95Cuw+zaA7NuiyFV+HKWywZfuoOBnTuQDDLs9KLDNhpH
         DkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nJ7JTUyYxu5fQxugnuhPqq/LbS6Yhpu3mLRRsHkwpo=;
        b=Dkwym1csTO+fqxX6b6DtW7b5HVGTfaIexCi9VgcyyuuT+Ld6vNq1cEuccXIhmtbgi4
         /vzanyNkbRh+pI51+Z8dV2CiyHRd4IKVWJE8K14oohE1qBJtV8vcmjFH1xbgEy43hslI
         a1HBNISVZpDVfSV+h2NYRlUZDUUKTDnn4xXuLt9yz4mlc3pJ72CsnBq8oe3hKN+EcK/t
         AUcstjOpLg2K6EwNI6fR0QVMmrkAFMUIN87KevVJMuZwPIz3MDgBgI6XU7uFO0w3OAPS
         5Nu/+PS1inuKYqZu+1Dtf6a5ZrN5KcQ9/AIcvUUK8SGPVOeZ6BFctgYT9CXSSbg9yfsc
         XMCw==
X-Gm-Message-State: AOAM531FXfqKVvtl2wUqh0m7naambfm4IslJhvAZlz18DrzHpqor0zmf
        hdTuyxK2Mp1Cei0rkqHzxqo=
X-Google-Smtp-Source: ABdhPJwmxzLbIKyadeAF+Lxse15UZ2egP26oEdVBpAkMpDwKnYU2mn1kkzpwFrqZJ7s2RLl89hgszA==
X-Received: by 2002:aca:5709:: with SMTP id l9mr2054325oib.67.1611289409222;
        Thu, 21 Jan 2021 20:23:29 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-5689-5322-9983-137f.res6.spectrum.com. [2603:8081:140c:1a00:5689:5322:9983:137f])
        by smtp.gmail.com with ESMTPSA id q26sm14244otg.28.2021.01.21.20.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 20:23:28 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>,
        syzbot+ec2fd72374785d0e558e@syzkaller.appspotmail.com
Subject: [PATCH for-next 1/5] RDMA/rxe: Fix bug in rxe_alloc
Date:   Thu, 21 Jan 2021 22:23:09 -0600
Message-Id: <20210122042313.3336-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210122042313.3336-1-rpearson@hpe.com>
References: <20210122042313.3336-1-rpearson@hpe.com>
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

