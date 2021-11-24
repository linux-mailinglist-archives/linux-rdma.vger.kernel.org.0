Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC70F45CF50
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 22:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhKXVnl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 16:43:41 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:49560 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhKXVnk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 16:43:40 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id q00BmS3woBazoq00CmFPjq; Wed, 24 Nov 2021 22:40:29 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 24 Nov 2021 22:40:29 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bharat@chelsio.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/3] RDMA/cxgb4: Use bitmap_zalloc() when applicable
Date:   Wed, 24 Nov 2021 22:40:24 +0100
Message-Id: <e396c4aa16cd8945d43877570a8f6d926cea555a.1637789139.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1637789139.git.christophe.jaillet@wanadoo.fr>
References: <cover.1637789139.git.christophe.jaillet@wanadoo.fr>
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

While at it, remove an extra space in a statement just a few lines above.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/cxgb4/id_table.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/id_table.c b/drivers/infiniband/hw/cxgb4/id_table.c
index 724d23297b35..9d08a48c4926 100644
--- a/drivers/infiniband/hw/cxgb4/id_table.c
+++ b/drivers/infiniband/hw/cxgb4/id_table.c
@@ -90,14 +90,12 @@ int c4iw_id_table_alloc(struct c4iw_id_table *alloc, u32 start, u32 num,
 		alloc->last = prandom_u32() % RANDOM_SKIP;
 	else
 		alloc->last = 0;
-	alloc->max  = num;
+	alloc->max = num;
 	spin_lock_init(&alloc->lock);
-	alloc->table = kmalloc_array(BITS_TO_LONGS(num), sizeof(long),
-				     GFP_KERNEL);
+	alloc->table = bitmap_zalloc(num, GFP_KERNEL);
 	if (!alloc->table)
 		return -ENOMEM;
 
-	bitmap_zero(alloc->table, num);
 	if (!(alloc->flags & C4IW_ID_TABLE_F_EMPTY))
 		for (i = 0; i < reserved; ++i)
 			set_bit(i, alloc->table);
@@ -107,5 +105,5 @@ int c4iw_id_table_alloc(struct c4iw_id_table *alloc, u32 start, u32 num,
 
 void c4iw_id_table_free(struct c4iw_id_table *alloc)
 {
-	kfree(alloc->table);
+	bitmap_free(alloc->table);
 }
-- 
2.30.2

