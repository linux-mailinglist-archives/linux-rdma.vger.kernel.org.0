Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84738438AAF
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Oct 2021 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhJXQqV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Oct 2021 12:46:21 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:56573 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhJXQqV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Oct 2021 12:46:21 -0400
Received: from pop-os.home ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id egbGmaJd7dmYbegbHmLVRS; Sun, 24 Oct 2021 18:43:59 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 24 Oct 2021 18:43:59 +0200
X-ME-IP: 92.140.161.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] RDMA/rxe: Use 'bitmap_zalloc()' when applicable
Date:   Sun, 24 Oct 2021 18:43:56 +0200
Message-Id: <4a3e11d45865678d570333d1962820eb13168848.1635093628.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2c42065049bb2b99bededdc423a9babf4a98adee.1635093628.git.christophe.jaillet@wanadoo.fr>
References: <2c42065049bb2b99bededdc423a9babf4a98adee.1635093628.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'index.table' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
improve the semantic and avoid some open-coded arithmetic in allocator
arguments.

Using 'bitmap_zalloc()' also allows the removal of a now useless
'bitmap_zero()'.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Finally, while at it, axe the useless 'bitmap' variable and use
'mem->bitmap' directly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 271d4ac0e0aa..ed2427369c2c 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -96,7 +96,6 @@ static inline const char *pool_name(struct rxe_pool *pool)
 static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
 {
 	int err = 0;
-	size_t size;
 
 	if ((max - min + 1) < pool->max_elem) {
 		pr_warn("not enough indices for max_elem\n");
@@ -107,15 +106,12 @@ static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
 	pool->index.max_index = max;
 	pool->index.min_index = min;
 
-	size = BITS_TO_LONGS(max - min + 1) * sizeof(long);
-	pool->index.table = kmalloc(size, GFP_KERNEL);
+	pool->index.table = bitmap_zalloc(max - min + 1, GFP_KERNEL);
 	if (!pool->index.table) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	bitmap_zero(pool->index.table, max - min + 1);
-
 out:
 	return err;
 }
@@ -167,7 +163,7 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 		pr_warn("%s pool destroyed with unfree'd elem\n",
 			pool_name(pool));
 
-	kfree(pool->index.table);
+	bitmap_free(pool->index.table);
 }
 
 static u32 alloc_index(struct rxe_pool *pool)
-- 
2.30.2

