Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4EC25A774
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBILu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgIBILs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:11:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D005C2084C;
        Wed,  2 Sep 2020 08:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034308;
        bh=Bwn/4/bZweb60S/YGxJ9z6KwR4SHKHgl/efkISgH0ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3ntI87b0XLFvT2N4qcPzIQFLNbApBfycWEhOEmu+nVPExuTAoC8bcCVLb0VRSLvf
         ozbibbAl2BY1DOLlevf8sJxOrt4eazme2be3qorwHTutfoqF/MAMPywo52bTD/IrG4
         NSe2n4y8Fwg1ZpJSQL9DgtXELGNh2rj3Y5RcQozA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 4/8] RDMA/cma: Remove cma_comp()
Date:   Wed,  2 Sep 2020 11:11:18 +0300
Message-Id: <20200902081122.745412-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902081122.745412-1-leon@kernel.org>
References: <20200902081122.745412-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The only place that still uses it is rdma_join_multicast() which is only
doing a sanity check that the caller hasn't done something wrong and
doesn't need the spinlock.

At least in the case of rdma_join_multicast() the information it needs
will remain until the ID is destroyed once it enters these
states. Similarly there is no reason to check for these specific states in
the handler callback, instead use the usual check for a destroyed id under
the handler_mutex.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1ab779e63762..1d5781f507e9 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -404,17 +404,6 @@ struct cma_req_info {
 	u16 pkey;
 };
 
-static int cma_comp(struct rdma_id_private *id_priv, enum rdma_cm_state comp)
-{
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&id_priv->lock, flags);
-	ret = (id_priv->state == comp);
-	spin_unlock_irqrestore(&id_priv->lock, flags);
-	return ret;
-}
-
 static int cma_comp_exch(struct rdma_id_private *id_priv,
 			 enum rdma_cm_state comp, enum rdma_cm_state exch)
 {
@@ -4392,8 +4381,8 @@ static int cma_ib_mc_handler(int status, struct ib_sa_multicast *multicast)
 
 	id_priv = mc->id_priv;
 	mutex_lock(&id_priv->handler_mutex);
-	if (id_priv->state != RDMA_CM_ADDR_BOUND &&
-	    id_priv->state != RDMA_CM_ADDR_RESOLVED)
+	if (READ_ONCE(id_priv->state) == RDMA_CM_DEVICE_REMOVAL ||
+	    READ_ONCE(id_priv->state) == RDMA_CM_DESTROYING)
 		goto out;
 
 	if (!status)
@@ -4659,16 +4648,14 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 int rdma_join_multicast(struct rdma_cm_id *id, struct sockaddr *addr,
 			u8 join_state, void *context)
 {
-	struct rdma_id_private *id_priv;
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
 	struct cma_multicast *mc;
 	int ret;
 
-	if (!id->device)
-		return -EINVAL;
-
-	id_priv = container_of(id, struct rdma_id_private, id);
-	if (!cma_comp(id_priv, RDMA_CM_ADDR_BOUND) &&
-	    !cma_comp(id_priv, RDMA_CM_ADDR_RESOLVED))
+	/* ULP is calling this wrong. */
+	if (!id->device || (READ_ONCE(id_priv->state) != RDMA_CM_ADDR_BOUND &&
+			    READ_ONCE(id_priv->state) != RDMA_CM_ADDR_RESOLVED))
 		return -EINVAL;
 
 	mc = kmalloc(sizeof *mc, GFP_KERNEL);
-- 
2.26.2

