Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D911A4FB0B3
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 00:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiDJWqU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Apr 2022 18:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiDJWqO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Apr 2022 18:46:14 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1AF18E;
        Sun, 10 Apr 2022 15:44:01 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id e189so14220414oia.8;
        Sun, 10 Apr 2022 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpXBKems3UG+wFxv0QCe5MNRbLOMx85cf7BfRRO6zmU=;
        b=LHcqPy2pCPxk0g7PcqDQbA5+VjLEZ388wIecksOL4Rs8mquDlHheaBsjsei2K1xPjj
         IW0S2i6DdjoKMkliXqOEmwSd9w2GE8GzhVqqhFkYlg9mU0O/eQU5ikbJhEYAcemZ2cg0
         X0QLfKATIX69kDDp9N9eiHgjVfYro7smDr7xJobD+IH896POevvNCJuO9eCMJb9sz2V7
         uWy+O/cHJSnf4MwbsEe2gIMO3XLR9ZQqzl1d7YHa25mWg/7yRzDMkJR8HkOgxJCSWpyU
         i3aZkrLhcPQgtCRrYefIsW65uZXovCbYCWZeaqwhlWOqnmPF5vKAPKkWDtdXIzzqVik+
         1ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpXBKems3UG+wFxv0QCe5MNRbLOMx85cf7BfRRO6zmU=;
        b=LcQF2xRcSokSvSbFq6N594wDoUWkdiYQKB80iJN5Tu8rF2jOBbNVm0TqRg3OL5iGwJ
         bQLgStrwiDv8M6O6wqfWcBKpOSvRYvrKSYqawXY/PfpjXV+a2lSxp2jN4rcbIPjEOYEr
         5s4GKi1SMDV2bROfEl14Hb+p4eAnlGVXq/Tw0Uq4YzrRkB6QtMzrLVKdT90Mctx+AuJM
         7DP/wBekTe7KP9EJTDR9yYpNt2YWnNiCXr/631zHlcu0jXZNnwuneCCsjOJXLa7YGOfD
         7ajgMhKhNHZwFZkUKwc64olaZl5r/CbdRz6jisxffFObVROpvEzPc7SAHpH3HBzJRoNO
         ofxA==
X-Gm-Message-State: AOAM530B8sTILw+Om32ifCciHalPgXO8DKQFW4TJg9FRtcAgP2mQM630
        DwVdtFKPF71k3iO1FBSz9FE=
X-Google-Smtp-Source: ABdhPJy3eekkjOw+1iVq4Y0fJoVCg3ivdiOox0nSgj0fSybVf6+AZOkC2Bvx2a7V1AbGu4dUXj5/xQ==
X-Received: by 2002:aca:705:0:b0:2d9:6bb6:5b0 with SMTP id 5-20020aca0705000000b002d96bb605b0mr4106169oih.11.1649630641165;
        Sun, 10 Apr 2022 15:44:01 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-dc1d-a6ff-2878-e7c1.res6.spectrum.com. [2603:8081:140c:1a00:dc1d:a6ff:2878:e7c1])
        by smtp.googlemail.com with ESMTPSA id 60-20020a9d0642000000b005b22a82458csm11610304otn.55.2022.04.10.15.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 15:44:00 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     bvanassche@acm.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@redhat.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix "Replace red-black trees by xarrays"
Date:   Sun, 10 Apr 2022 17:39:40 -0500
Message-Id: <20220410223939.3769-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The referenced commit causes lockdep warnings by using the
default spin_lock in xa_alloc_cyclic and xa_erase which
include calls to xa_lock()/xa_unlock() while at the same time
explicitly calling xa_lock_irqsave() in rxe_pool_get_index().

The latter is required to handle some object lookups correctly. The
immediate fix is to explicitly use xa_lock_irqsave() everywhere.

This commit replaces xa_alloc_cyclic() by __xa_alloc_cyclic() and
xa_erase() by __xa_erase() and explicitly lock these calls with
xa_lock_irqsave().

This commit will be reverted later when the read side operations
in rxe_pool.c will be converted to rcu_read_locks which will not
require locking the write side operations with irqsave locks.

This commit fixes the "WARNING: Inconsistent lock state" bug in
blktests. The recent revert patch from Bart fixes the other
bug in blktests with very long delays.

Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 87066d04ed18..440f96af213b 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -118,7 +118,9 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
+	struct xarray *xa = &pool->xa;
 	struct rxe_pool_elem *elem;
+	unsigned long flags;
 	void *obj;
 	int err;
 
@@ -138,8 +140,10 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+	xa_lock_irqsave(xa, flags);
+	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
 			      &pool->next, GFP_KERNEL);
+	xa_unlock_irqrestore(xa, flags);
 	if (err)
 		goto err_free;
 
@@ -154,6 +158,8 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
+	struct xarray *xa = &pool->xa;
+	unsigned long flags;
 	int err;
 
 	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
@@ -166,8 +172,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+	xa_lock_irqsave(xa, flags);
+	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
 			      &pool->next, GFP_KERNEL);
+	xa_unlock_irqrestore(xa, flags);
 	if (err)
 		goto err_cnt;
 
@@ -200,8 +208,12 @@ static void rxe_elem_release(struct kref *kref)
 {
 	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
 	struct rxe_pool *pool = elem->pool;
+	struct xarray *xa = &pool->xa;
+	unsigned long flags;
 
-	xa_erase(&pool->xa, elem->index);
+	xa_lock_irqsave(xa, flags);
+	__xa_erase(&pool->xa, elem->index);
+	xa_unlock_irqrestore(xa, flags);
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
-- 
2.32.0

