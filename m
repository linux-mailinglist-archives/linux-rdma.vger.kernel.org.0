Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC945CE43
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 21:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhKXUpj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 15:45:39 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:55535 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbhKXUpi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 15:45:38 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id pz5HmRlgHBazopz5NmFJL8; Wed, 24 Nov 2021 21:42:01 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 24 Nov 2021 21:42:02 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/4] IB/mthca: Use bitmap_set() when applicable
Date:   Wed, 24 Nov 2021 21:41:36 +0100
Message-Id: <f1bd33f6ea6c8ad519a222db6e9aa17c55610557.1637785902.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
References: <cover.1637785902.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The 'alloc->table' bitmap has just been allocated, so this is safe to use
the faster and non-atomic 'bitmap_set()' function. There is no need to
hand-write it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/mthca/mthca_allocator.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index 06fc8a2e0bd4..57fa1cc202bc 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -79,8 +79,6 @@ void mthca_free(struct mthca_alloc *alloc, u32 obj)
 int mthca_alloc_init(struct mthca_alloc *alloc, u32 num, u32 mask,
 		     u32 reserved)
 {
-	int i;
-
 	/* num must be a power of 2 */
 	if (num != 1 << (ffs(num) - 1))
 		return -EINVAL;
@@ -94,8 +92,7 @@ int mthca_alloc_init(struct mthca_alloc *alloc, u32 num, u32 mask,
 	if (!alloc->table)
 		return -ENOMEM;
 
-	for (i = 0; i < reserved; ++i)
-		set_bit(i, alloc->table);
+	bitmap_set(alloc->table, 0, reserved);
 
 	return 0;
 }
-- 
2.30.2

