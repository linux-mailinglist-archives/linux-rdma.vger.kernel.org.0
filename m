Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1294D45CE3F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 21:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbhKXUoq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 15:44:46 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:60831 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbhKXUoo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 15:44:44 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id pz4WmRlUBBazopz4cmFJHL; Wed, 24 Nov 2021 21:41:13 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 24 Nov 2021 21:41:14 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/4] IB/mthca: Use bitmap_zalloc() when applicable
Date:   Wed, 24 Nov 2021 21:40:51 +0100
Message-Id: <ea9031e28f453bc179033740f66f0c19293fcf0b.1637785902.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
References: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
open-coded arithmetic in allocator arguments.

Using the 'zalloc' version of the allocator also saves a now useless
'bitmap_zero()' call.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/mthca/mthca_allocator.c |  6 ++----
 drivers/infiniband/hw/mthca/mthca_mr.c        | 12 +++++-------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index aef1d274a14e..06fc8a2e0bd4 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -90,12 +90,10 @@ int mthca_alloc_init(struct mthca_alloc *alloc, u32 num, u32 mask,
 	alloc->max  = num;
 	alloc->mask = mask;
 	spin_lock_init(&alloc->lock);
-	alloc->table = kmalloc_array(BITS_TO_LONGS(num), sizeof(long),
-				     GFP_KERNEL);
+	alloc->table = bitmap_zalloc(num, GFP_KERNEL);
 	if (!alloc->table)
 		return -ENOMEM;
 
-	bitmap_zero(alloc->table, num);
 	for (i = 0; i < reserved; ++i)
 		set_bit(i, alloc->table);
 
@@ -104,7 +102,7 @@ int mthca_alloc_init(struct mthca_alloc *alloc, u32 num, u32 mask,
 
 void mthca_alloc_cleanup(struct mthca_alloc *alloc)
 {
-	kfree(alloc->table);
+	bitmap_free(alloc->table);
 }
 
 /*
diff --git a/drivers/infiniband/hw/mthca/mthca_mr.c b/drivers/infiniband/hw/mthca/mthca_mr.c
index ce0e0867e488..8892fcdbac4c 100644
--- a/drivers/infiniband/hw/mthca/mthca_mr.c
+++ b/drivers/infiniband/hw/mthca/mthca_mr.c
@@ -139,7 +139,7 @@ static void mthca_buddy_free(struct mthca_buddy *buddy, u32 seg, int order)
 
 static int mthca_buddy_init(struct mthca_buddy *buddy, int max_order)
 {
-	int i, s;
+	int i;
 
 	buddy->max_order = max_order;
 	spin_lock_init(&buddy->lock);
@@ -152,12 +152,10 @@ static int mthca_buddy_init(struct mthca_buddy *buddy, int max_order)
 		goto err_out;
 
 	for (i = 0; i <= buddy->max_order; ++i) {
-		s = BITS_TO_LONGS(1 << (buddy->max_order - i));
-		buddy->bits[i] = kmalloc_array(s, sizeof(long), GFP_KERNEL);
+		buddy->bits[i] = bitmap_zalloc(1 << (buddy->max_order - i),
+					       GFP_KERNEL);
 		if (!buddy->bits[i])
 			goto err_out_free;
-		bitmap_zero(buddy->bits[i],
-			    1 << (buddy->max_order - i));
 	}
 
 	set_bit(0, buddy->bits[buddy->max_order]);
@@ -167,7 +165,7 @@ static int mthca_buddy_init(struct mthca_buddy *buddy, int max_order)
 
 err_out_free:
 	for (i = 0; i <= buddy->max_order; ++i)
-		kfree(buddy->bits[i]);
+		bitmap_free(buddy->bits[i]);
 
 err_out:
 	kfree(buddy->bits);
@@ -181,7 +179,7 @@ static void mthca_buddy_cleanup(struct mthca_buddy *buddy)
 	int i;
 
 	for (i = 0; i <= buddy->max_order; ++i)
-		kfree(buddy->bits[i]);
+		bitmap_free(buddy->bits[i]);
 
 	kfree(buddy->bits);
 	kfree(buddy->num_free);
-- 
2.30.2

