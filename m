Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0901C6A5B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgEFHrj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgEFHrj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:47:39 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E594206D5;
        Wed,  6 May 2020 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751259;
        bh=EPYmFwRiOPzq3NEifRHiT+nEDxvH42kUgfkXMDCCSDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MT9ddl/RrVV+8CCKoWa7jW8/0PgAFGCbbru2gwjBWQ5DCZA9CJKFU4ez9PV0eUMxi
         bHw5VYV2P2Z99tQt1FIt9NrVLRL4whRICGp2zmrxxVI1BOfAWGxNEH/MCM4Ucc6yEg
         /rmTD0uzx8zKQJ0ACZXwE0qwEweLbg1JOkKWXpeo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 10/10] RDMA/cm: Increment the refcount inside cm_find_listen()
Date:   Wed,  6 May 2020 10:47:01 +0300
Message-Id: <20200506074701.9775-11-leon@kernel.org>
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

All callers need the 'get', so do it in a central place before returning
the pointer.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index c8b2088dcd0a..44ab4fc7c5d4 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -690,9 +690,10 @@ static struct cm_id_private * cm_find_listen(struct ib_device *device,
 		cm_id_priv = rb_entry(node, struct cm_id_private, service_node);
 		if ((cm_id_priv->id.service_mask & service_id) ==
 		     cm_id_priv->id.service_id &&
-		    (cm_id_priv->id.device == device))
+		    (cm_id_priv->id.device == device)) {
+			refcount_inc(&cm_id_priv->refcount);
 			return cm_id_priv;
-
+		}
 		if (device < cm_id_priv->id.device)
 			node = node->rb_left;
 		else if (device > cm_id_priv->id.device)
@@ -2020,7 +2021,6 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 			     NULL, 0);
 		return NULL;
 	}
-	refcount_inc(&listen_cm_id_priv->refcount);
 	spin_unlock_irq(&cm.lock);
 	return listen_cm_id_priv;
 }
@@ -3591,7 +3591,6 @@ static int cm_sidr_req_handler(struct cm_work *work)
 					    .status = IB_SIDR_UNSUPPORTED });
 		goto out; /* No match. */
 	}
-	refcount_inc(&listen_cm_id_priv->refcount);
 	spin_unlock_irq(&cm.lock);
 
 	cm_id_priv->id.cm_handler = listen_cm_id_priv->id.cm_handler;
-- 
2.26.2

