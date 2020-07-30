Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76928232EAD
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgG3I1c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jul 2020 04:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728883AbgG3I1b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jul 2020 04:27:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A192075F;
        Thu, 30 Jul 2020 08:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596097651;
        bh=oqEDtsTB72k+oL+yQyEZYDHJ7uuL60Vq47gF48HLonU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6ULiPxfHnT8CDJpO8ufKnXSCqcUrF3n0fBuKSOoJthCdudH/XQmeUMWXF30TCToM
         tG9UWy9Tb4k5WvyI0p01GVmx6nouNFgpkl0ANqaZzZtX1RNHaKDPVcCJyQo8UoVir0
         OU+Oue9dR7Z36MiFiOAlsxSNz0x2uN/d71GR6Qw8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH rdma-rc 2/3] RDMA/core: Stop DIM before destroying CQ
Date:   Thu, 30 Jul 2020 11:27:18 +0300
Message-Id: <20200730082719.1582397-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730082719.1582397-1-leon@kernel.org>
References: <20200730082719.1582397-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

HW destroy operation should be last operation after all possible CQ
users completed their work, so move DIM work cancellation before such
destroy call.

Fixes: da6629793aa6 ("RDMA/core: Provide RDMA DIM support for ULPs")
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 655795bfa0ee..33759b39c3d3 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -72,6 +72,15 @@ static void rdma_dim_init(struct ib_cq *cq)
 	INIT_WORK(&dim->work, ib_cq_rdma_dim_work);
 }
 
+static void rdma_dim_destroy(struct ib_cq *cq)
+{
+	if (!cq->dim)
+		return;
+
+	cancel_work_sync(&cq->dim->work);
+	kfree(cq->dim);
+}
+
 static int __poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc)
 {
 	int rc;
@@ -331,12 +340,10 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 		WARN_ON_ONCE(1);
 	}
 
+	rdma_dim_destroy(cq);
 	trace_cq_free(cq);
 	rdma_restrack_del(&cq->res);
 	cq->device->ops.destroy_cq(cq, udata);
-	if (cq->dim)
-		cancel_work_sync(&cq->dim->work);
-	kfree(cq->dim);
 	kfree(cq->wc);
 	kfree(cq);
 }
-- 
2.26.2

