Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A0438AAC
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Oct 2021 18:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhJXQp4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Oct 2021 12:45:56 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:50695 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJXQp4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Oct 2021 12:45:56 -0400
Received: from pop-os.home ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id egaqmaJTtdmYbegarmLVOT; Sun, 24 Oct 2021 18:43:34 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 24 Oct 2021 18:43:34 +0200
X-ME-IP: 92.140.161.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] RDMA/rxe: Save a few bytes from struct rxe_pool
Date:   Sun, 24 Oct 2021 18:43:30 +0200
Message-Id: <2c42065049bb2b99bededdc423a9babf4a98adee.1635093628.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'table_size' is never read, it can be removed.

In fact, the only place that uses something that could be 'table_size' is
'alloc_index()'. In this function, it is re-computed from 'min_index' and
'max_index'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 1 -
 drivers/infiniband/sw/rxe/rxe_pool.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7b4cb46edfd9..271d4ac0e0aa 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -114,7 +114,6 @@ static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
 		goto out;
 	}
 
-	pool->index.table_size = size;
 	bitmap_zero(pool->index.table, max - min + 1);
 
 out:
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 1feca1bffced..1ff2250edf6d 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -74,7 +74,6 @@ struct rxe_pool {
 	struct {
 		struct rb_root		tree;
 		unsigned long		*table;
-		size_t			table_size;
 		u32			last;
 		u32			max_index;
 		u32			min_index;
-- 
2.30.2

