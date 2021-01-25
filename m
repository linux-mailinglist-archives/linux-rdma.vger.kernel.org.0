Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA6E302DA2
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jan 2021 22:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbhAYVTR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 16:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbhAYVR4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jan 2021 16:17:56 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A4C0613ED
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:45 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id i25so4898076oie.10
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1fNm7hAq2LAMRsJr67mUat+oeMfmUk+H6CjsCCKEX0M=;
        b=Bi/VUbbHtXrQjZcxa1pcz+vp/LHWHYCMuE93sV0lHcmo1oAnYJwNyH4mrnCIbmhrzP
         M28hMiyG6n+UFW272cqwlTypTwYQLE9ThLfC5c6vv/5tDUsIwE+5T0w6DJhrH5yx97RV
         Kh+QGXfgKHcbRZBlwpwBE7YM/1YDAsDs7TorxQyfu00EpF90ryVvcP93Re/u5LU8iSJh
         Wj0vu47+33T6UPtlAfdeNymt4YkPvLsqpeF1osYFP5Hgx8hx9UL51YzyG6thAHnwga36
         L3xW15BZWUKxNYmY2biXaNBXVmo+I9qjdXtYWvEsAOKVDRZNrg/whk/rdyI1sPJ7RgwH
         kWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1fNm7hAq2LAMRsJr67mUat+oeMfmUk+H6CjsCCKEX0M=;
        b=Jcf1BCE6EKAYJHd6/gixnwRnUDv2hMwdRBSp6qqXe/RGIvlgeUPEpf+Q1zMSnQjYs2
         5hhWWPArwDAAFTBc7FWiUzz3eMBbhCYtsuosSISKfP4RAsCWFdpJ2Zy20ISCq3Wxlq15
         0htQ+xxumegbgFZTNVNrRPKEo8L03UJoGpcnx7el6qlhXqadBue17CQNPsmUN60RLMtV
         fy5vilFXzsfl8iLm+j6fdP8Wr0g7sWxxj+4W5voqCQsLW27hH6meJFZmUX8Q7fm9AK5F
         368dn7YAgCwiaZmiKgOlaNHg1P9XIEQaR74jAKb/RlqUdBmbAFzPr4mzf4X0tSTSBz0J
         sqdQ==
X-Gm-Message-State: AOAM5315muDLqMcBIc4JC+Pwje/PIBj3DRvAjQ58ZVjr2ml4wx7By+1H
        ArVyE95dDwb8YFeembVUBZA=
X-Google-Smtp-Source: ABdhPJzAZ4Gk9aveDWT57ndsYNtBjFI02sE/DwTDmCiTImN//JzmqQsSdtiK6y/tLeKIaWk9llpO2Q==
X-Received: by 2002:aca:f00a:: with SMTP id o10mr1334677oih.128.1611609405425;
        Mon, 25 Jan 2021 13:16:45 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-8baa-bb83-cd49-4ca4.res6.spectrum.com. [2603:8081:140c:1a00:8baa:bb83:cd49:4ca4])
        by smtp.gmail.com with ESMTPSA id w11sm3722564otg.58.2021.01.25.13.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:16:45 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>,
        syzbot+ec2fd72374785d0e558e@syzkaller.appspotmail.com
Subject: [PATCH for-next v3 1/6] RDMA/rxe: Fix bug in rxe_alloc
Date:   Mon, 25 Jan 2021 15:16:36 -0600
Message-Id: <20210125211641.2694-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210125211641.2694-1-rpearson@hpe.com>
References: <20210125211641.2694-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[v1]
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

