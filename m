Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F88045CE4A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 21:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhKXUqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 15:46:49 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:58481 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbhKXUqn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 15:46:43 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id pz69mRlx6Bazopz6ImFJQk; Wed, 24 Nov 2021 21:43:24 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 24 Nov 2021 21:43:24 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/4] IB/mthca: Use non-atomic bitmap functions when possible in 'mthca_allocator.c'
Date:   Wed, 24 Nov 2021 21:42:32 +0100
Message-Id: <5f909ca1284fa4d2cf13952b08b9e303b656c968.1637785902.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
References: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
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
 drivers/infiniband/hw/mthca/mthca_allocator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index 57fa1cc202bc..9f0f79d02d3c 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -51,7 +51,7 @@ u32 mthca_alloc(struct mthca_alloc *alloc)
 	}
 
 	if (obj < alloc->max) {
-		set_bit(obj, alloc->table);
+		__set_bit(obj, alloc->table);
 		obj |= alloc->top;
 	} else
 		obj = -1;
@@ -69,7 +69,7 @@ void mthca_free(struct mthca_alloc *alloc, u32 obj)
 
 	spin_lock_irqsave(&alloc->lock, flags);
 
-	clear_bit(obj, alloc->table);
+	__clear_bit(obj, alloc->table);
 	alloc->last = min(alloc->last, obj);
 	alloc->top = (alloc->top + alloc->max) & alloc->mask;
 
-- 
2.30.2

