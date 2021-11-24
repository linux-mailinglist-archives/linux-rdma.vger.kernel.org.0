Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5299F45CF57
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 22:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbhKXVnr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 16:43:47 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:52768 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbhKXVnn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 16:43:43 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id q00BmS3woBazoq00GmFPkK; Wed, 24 Nov 2021 22:40:32 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 24 Nov 2021 22:40:32 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bharat@chelsio.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] RDMA/cxgb4: Use non-atomic bitmap functions when possible
Date:   Wed, 24 Nov 2021 22:40:26 +0100
Message-Id: <0c1c4505ca32f5ba4126e3e324041da191513ef2.1637789139.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1637789139.git.christophe.jaillet@wanadoo.fr>
References: <cover.1637789139.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The accesses to the 'alloc->table' bitmap are protected by the
'alloc->lock' spinlock, so no concurrent accesses can happen.

So prefer the non-atomic '__[set|clear]_bit()' functions to save a few
cycles.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/cxgb4/id_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/id_table.c b/drivers/infiniband/hw/cxgb4/id_table.c
index e09faa659d68..f64e7e02b129 100644
--- a/drivers/infiniband/hw/cxgb4/id_table.c
+++ b/drivers/infiniband/hw/cxgb4/id_table.c
@@ -59,7 +59,7 @@ u32 c4iw_id_alloc(struct c4iw_id_table *alloc)
 			alloc->last = obj + 1;
 		if (alloc->last >= alloc->max)
 			alloc->last = 0;
-		set_bit(obj, alloc->table);
+		__set_bit(obj, alloc->table);
 		obj += alloc->start;
 	} else
 		obj = -1;
@@ -75,7 +75,7 @@ void c4iw_id_free(struct c4iw_id_table *alloc, u32 obj)
 	obj -= alloc->start;
 
 	spin_lock_irqsave(&alloc->lock, flags);
-	clear_bit(obj, alloc->table);
+	__clear_bit(obj, alloc->table);
 	spin_unlock_irqrestore(&alloc->lock, flags);
 }
 
-- 
2.30.2

