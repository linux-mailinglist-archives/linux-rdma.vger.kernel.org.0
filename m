Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778FD1C6A5A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgEFHrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgEFHrf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:47:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85F620714;
        Wed,  6 May 2020 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751255;
        bh=skt+hCuNuTye/ai9j2xfN2hro8Lrhv5wMxe7uBsMV88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T156B18yzPxooycf98t1Feaix53AUOU6OMFBSBedObORSW8u96wnKsy9MNNAXnk81
         qZYEoQTey6tYMsSAU0mM3JuOO6ePZ8qJQgn43ZBf+aezty//fzi2Tpgh1IHqi9Xj7X
         WUjIFkyirLarwK1K7HjIEKE+98KwVp06jXdBW2Do=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 08/10] RDMA/cm: Remove the cm_free_id() wrapper function
Date:   Wed,  6 May 2020 10:46:59 +0300
Message-Id: <20200506074701.9775-9-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506074701.9775-1-leon@kernel.org>
References: <20200506074701.9775-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Just call xa_erase directly during cm_destroy_id()

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index dfbad8b924b3..e70b4c70f00c 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -584,11 +584,6 @@ static u32 cm_local_id(__be32 local_id)
 	return (__force u32) (local_id ^ cm.random_id_operand);
 }
 
-static void cm_free_id(__be32 local_id)
-{
-	xa_erase_irq(&cm.local_id_table, cm_local_id(local_id));
-}
-
 static struct cm_id_private *cm_acquire_id(__be32 local_id, __be32 remote_id)
 {
 	struct cm_id_private *cm_id_priv;
@@ -1140,7 +1135,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	case IB_CM_TIMEWAIT:
 		/*
 		 * The cm_acquire_id in cm_timewait_handler will stop working
-		 * once we do cm_free_id() below, so just move to idle here for
+		 * once we do xa_erase below, so just move to idle here for
 		 * consistency.
 		 */
 		cm_id->state = IB_CM_IDLE;
@@ -1170,7 +1165,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	spin_unlock(&cm.lock);
 	spin_unlock_irq(&cm_id_priv->lock);
 
-	cm_free_id(cm_id->local_id);
+	xa_erase_irq(&cm.local_id_table, cm_local_id(cm_id->local_id));
 	cm_deref_id(cm_id_priv);
 	wait_for_completion(&cm_id_priv->comp);
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
-- 
2.26.2

