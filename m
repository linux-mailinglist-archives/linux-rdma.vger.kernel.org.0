Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1364625A773
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIBILq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgIBILp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:11:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497A12087E;
        Wed,  2 Sep 2020 08:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034305;
        bh=1ZSyhTuTDYHvQ+Y7pyF7+o4SsP2l73YssbFYud/RUGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/MqXpEXO4IifuD+QJNU1A08SZCtt+mkU+fSgwPHTf/CyM3f/hTP6ZJTS/WrDQs2c
         +UdJs3HXHiW9EYDyXfJtKp1d5sk+HxXh0IkPqQzwHvg7+80Zzh4cZ5iI509l99GXoG
         BTXZiVun3Ri4e77fdfThTCyUUt5+dE83CuxZlXTI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 6/8] RDMA/cma: Remove dead code for kernel rdmacm multicast
Date:   Wed,  2 Sep 2020 11:11:20 +0300
Message-Id: <20200902081122.745412-7-leon@kernel.org>
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

There is no kernel user of RDMA CM multicast so this code managing the
multicast subscription of the kernel-only internal QP is dead. Remove it.

This makes the bug fixes in the next patches much simpler.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 088981db10f7..b9d794ba9f6a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4366,16 +4366,6 @@ static int cma_ib_mc_handler(int status, struct ib_sa_multicast *multicast)
 	else
 		pr_debug_ratelimited("RDMA CM: MULTICAST_ERROR: failed to join multicast. status %d\n",
 				     status);
-	mutex_lock(&id_priv->qp_mutex);
-	if (!status && id_priv->id.qp) {
-		status = ib_attach_mcast(id_priv->id.qp, &multicast->rec.mgid,
-					 be16_to_cpu(multicast->rec.mlid));
-		if (status)
-			pr_debug_ratelimited("RDMA CM: MULTICAST_ERROR: failed to attach QP. status %d\n",
-					     status);
-	}
-	mutex_unlock(&id_priv->qp_mutex);
-
 	event.status = status;
 	event.param.ud.private_data = mc->context;
 	if (!status) {
@@ -4629,6 +4619,10 @@ int rdma_join_multicast(struct rdma_cm_id *id, struct sockaddr *addr,
 	struct cma_multicast *mc;
 	int ret;
 
+	/* Not supported for kernel QPs */
+	if (WARN_ON(id->qp))
+		return -EINVAL;
+
 	/* ULP is calling this wrong. */
 	if (!id->device || (READ_ONCE(id_priv->state) != RDMA_CM_ADDR_BOUND &&
 			    READ_ONCE(id_priv->state) != RDMA_CM_ADDR_RESOLVED))
@@ -4680,11 +4674,6 @@ void rdma_leave_multicast(struct rdma_cm_id *id, struct sockaddr *addr)
 			list_del(&mc->list);
 			spin_unlock_irq(&id_priv->lock);
 
-			if (id->qp)
-				ib_detach_mcast(id->qp,
-						&mc->multicast.ib->rec.mgid,
-						be16_to_cpu(mc->multicast.ib->rec.mlid));
-
 			BUG_ON(id_priv->cma_dev->device != id->device);
 
 			if (rdma_cap_ib_mcast(id->device, id->port_num)) {
-- 
2.26.2

