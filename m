Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B145CE4E
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 21:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbhKXUrU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 15:47:20 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:58216 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbhKXUrU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 15:47:20 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id pz7BmRmGIBazopz7HmFJWk; Wed, 24 Nov 2021 21:44:05 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 24 Nov 2021 21:44:06 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/4] IB/mthca: Use non-atomic bitmap functions when possible in 'mthca_mr.c'
Date:   Wed, 24 Nov 2021 21:43:35 +0100
Message-Id: <a19b88ccdbc03972fd97306b998731814283041f.1637785902.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
References: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In 'mthca_buddy_init()', the 'buddy->bits[n]' bitmap has just been
allocated, so no concurrent accesses can occur.

The other accesses to the 'buddy->bits[n]' bitmap are protected by the
'buddy->lock' spinlock, so no concurrent accesses can occur.

So prefer the non-atomic '__[set|clear]_bit()' functions to save a few
cycles.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/mthca/mthca_mr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_mr.c b/drivers/infiniband/hw/mthca/mthca_mr.c
index 8892fcdbac4c..a59100c496b4 100644
--- a/drivers/infiniband/hw/mthca/mthca_mr.c
+++ b/drivers/infiniband/hw/mthca/mthca_mr.c
@@ -101,13 +101,13 @@ static u32 mthca_buddy_alloc(struct mthca_buddy *buddy, int order)
 	return -1;
 
  found:
-	clear_bit(seg, buddy->bits[o]);
+	__clear_bit(seg, buddy->bits[o]);
 	--buddy->num_free[o];
 
 	while (o > order) {
 		--o;
 		seg <<= 1;
-		set_bit(seg ^ 1, buddy->bits[o]);
+		__set_bit(seg ^ 1, buddy->bits[o]);
 		++buddy->num_free[o];
 	}
 
@@ -125,13 +125,13 @@ static void mthca_buddy_free(struct mthca_buddy *buddy, u32 seg, int order)
 	spin_lock(&buddy->lock);
 
 	while (test_bit(seg ^ 1, buddy->bits[order])) {
-		clear_bit(seg ^ 1, buddy->bits[order]);
+		__clear_bit(seg ^ 1, buddy->bits[order]);
 		--buddy->num_free[order];
 		seg >>= 1;
 		++order;
 	}
 
-	set_bit(seg, buddy->bits[order]);
+	__set_bit(seg, buddy->bits[order]);
 	++buddy->num_free[order];
 
 	spin_unlock(&buddy->lock);
@@ -158,7 +158,7 @@ static int mthca_buddy_init(struct mthca_buddy *buddy, int max_order)
 			goto err_out_free;
 	}
 
-	set_bit(0, buddy->bits[buddy->max_order]);
+	__set_bit(0, buddy->bits[buddy->max_order]);
 	buddy->num_free[buddy->max_order] = 1;
 
 	return 0;
-- 
2.30.2

