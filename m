Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5A22E9A3
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 11:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgG0J5R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 05:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0J5R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 05:57:17 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0A782075D;
        Mon, 27 Jul 2020 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595843837;
        bh=C+LgWBhn6Kuqs8rTdsG6YhEg8KnvL3JldX9Tt+LmbKc=;
        h=From:To:Cc:Subject:Date:From;
        b=fBln0a4xmTqqdnVQdFcOymP6KBU+TNYN0rKAzCnz+nSgHzz8H0DrUBnZd9HappPrd
         fhLUu/pA05Gb9Qt3PudFW9+qIxdEhlfWs4NYUF7+15I8TvKSSnAr/XsexTwS86l+7/
         Ov0I9Ju4+S1hYJVtwOJOKiaqakt2HBfQl5JA9ToU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix prefetch memory leak if get_prefetchable_mr fails
Date:   Mon, 27 Jul 2020 12:57:12 +0300
Message-Id: <20200727095712.495652-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

destroy_prefetch_work() must always be called if the work is not going
to be queued. The num_sge also should have been set to i, not i-1
which avoids the condition where it shouldn't have been called in the
first place.

Cc: stable@vger.kernel.org
Fixes: fb985e278a30 ("RDMA/mlx5: Use SRCU properly in ODP prefetch")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4f1e46733830..cfd7efab114e 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1806,9 +1806,7 @@ static bool init_prefetch_work(struct ib_pd *pd,
 		work->frags[i].mr =
 			get_prefetchable_mr(pd, advice, sg_list[i].lkey);
 		if (!work->frags[i].mr) {
-			work->num_sge = i - 1;
-			if (i)
-				destroy_prefetch_work(work);
+			work->num_sge = i;
 			return false;
 		}

@@ -1875,6 +1873,7 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 	srcu_key = srcu_read_lock(&dev->odp_srcu);
 	if (!init_prefetch_work(pd, advice, pf_flags, work, sg_list, num_sge)) {
 		srcu_read_unlock(&dev->odp_srcu, srcu_key);
+		destroy_prefetch_work(work);
 		return -EINVAL;
 	}
 	queue_work(system_unbound_wq, &work->work);
--
2.26.2

