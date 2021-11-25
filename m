Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86045E14F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 21:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356867AbhKYULD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 15:11:03 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:62455 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbhKYUJD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Nov 2021 15:09:03 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id qL0AmbjsbqYovqL0AmK9AF; Thu, 25 Nov 2021 21:05:50 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 25 Nov 2021 21:05:50 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] RDMA/pvrdma: Use non-atomic bitmap functions when possible
Date:   Thu, 25 Nov 2021 21:05:49 +0100
Message-Id: <271b0e2c316e2b4cf34ac6fbca0701edd2d882ec.1637870667.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <33e8b993bfa6b7164e9bee95e3c27fb2c53949ce.1637870667.git.christophe.jaillet@wanadoo.fr>
References: <33e8b993bfa6b7164e9bee95e3c27fb2c53949ce.1637870667.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In 'pvrdma_uar_table_init()', the 'tbl->table' bitmap has just been
allocated, so no concurrent accesses can occur.

The other accesses to the 'tbl->table' bitmap are protected by the
'tbl->lock' spinlock, so no concurrent accesses can happen.

So prefer the non-atomic '__[set|clear]_bit()' functions to save a few
cycles.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c
index 21ef3fb39915..9a4de962e947 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c
@@ -68,7 +68,7 @@ int pvrdma_uar_table_init(struct pvrdma_dev *dev)
 		return -ENOMEM;
 
 	/* 0th UAR is taken by the device. */
-	set_bit(0, tbl->table);
+	__set_bit(0, tbl->table);
 
 	return 0;
 }
@@ -100,7 +100,7 @@ int pvrdma_uar_alloc(struct pvrdma_dev *dev, struct pvrdma_uar_map *uar)
 		return -ENOMEM;
 	}
 
-	set_bit(obj, tbl->table);
+	__set_bit(obj, tbl->table);
 	obj |= tbl->top;
 
 	spin_unlock_irqrestore(&tbl->lock, flags);
@@ -120,7 +120,7 @@ void pvrdma_uar_free(struct pvrdma_dev *dev, struct pvrdma_uar_map *uar)
 
 	obj = uar->index & (tbl->max - 1);
 	spin_lock_irqsave(&tbl->lock, flags);
-	clear_bit(obj, tbl->table);
+	__clear_bit(obj, tbl->table);
 	tbl->last = min(tbl->last, obj);
 	tbl->top = (tbl->top + tbl->max) & tbl->mask;
 	spin_unlock_irqrestore(&tbl->lock, flags);
-- 
2.30.2

