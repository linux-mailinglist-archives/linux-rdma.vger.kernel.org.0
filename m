Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F236826037D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgIGRuB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 13:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgIGMLX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 08:11:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4276221707;
        Mon,  7 Sep 2020 12:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599480583;
        bh=+eET6VZEcudzCy4g0/kov4VYsvKPVpqPBLY37t7iOBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05wPFSsPpjpWYOhuHeo4+yI2iINU6Rk84C9lHi3NwwDUbEE4OIOPGk5VQBl4VRMW+
         ChoTKzfSyHKC8VJ8BaGyPe/FgzAZ9F5WAGxR2z/A+LWDPdbiXrcszvDAIE3lIXWFEH
         GyT9D2SZCHc5m1JbK8ayGYBUIPPpEOK6gNhi7cDQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 3/9] RDMA/mlx5: Issue FW command to destroy SRQ on reentry
Date:   Mon,  7 Sep 2020 15:09:15 +0300
Message-Id: <20200907120921.476363-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907120921.476363-1-leon@kernel.org>
References: <20200907120921.476363-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The HW release can fail and leave the system in limbo state,
where SRQ is removed from the table, but can't be destroyed later.
In every reentry, the initial xa_erase_irq() check will fail.

Rewrite the erase logic to keep index, but don't store the entry
itself. By doing it, we can safely reinsert entry back in the case
of destroy failure.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/srq_cmd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index 37aaacebd3f2..c6b32b15c3f2 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -596,13 +596,22 @@ void mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
 	struct mlx5_core_srq *tmp;
 	int err;

-	tmp = xa_erase_irq(&table->array, srq->srqn);
-	if (!tmp || tmp != srq)
+	/* Delete entry, but leave index occupied */
+	tmp = xa_cmpxchg_irq(&table->array, srq->srqn, srq, XA_ZERO_ENTRY, 0);
+	if (WARN_ON(!tmp || tmp != srq) || xa_err(tmp))
 		return;

 	err = destroy_srq_split(dev, srq);
-	if (err)
+	if (err) {
+		/*
+		 * We don't need to check returned result for an error,
+		 * because  we are storing in pre-allocated space xarray
+		 * entry and it can't fail at this stage.
+		 */
+		xa_cmpxchg_irq(&table->array, srq->srqn, XA_ZERO_ENTRY, srq, 0);
 		return;
+	}
+	xa_erase_irq(&table->array, srq->srqn);

 	mlx5_core_res_put(&srq->common);
 	wait_for_completion(&srq->common.free);
--
2.26.2

