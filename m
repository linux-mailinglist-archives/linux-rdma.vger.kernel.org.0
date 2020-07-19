Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F7224FF7
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jul 2020 08:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgGSGyn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jul 2020 02:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgGSGym (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Jul 2020 02:54:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 493E02073A;
        Sun, 19 Jul 2020 06:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595141682;
        bh=lPu5X20Q92p/+UqxUcUel1xhGv6FA9sAnE36UZWnM1k=;
        h=From:To:Cc:Subject:Date:From;
        b=dB/6qa++AxGe5JXWgKI6d+x4fwDSl1BxJjD91lldDPrSbK7hlK10NA/Q82QkAg+5L
         9B0OJJCsmqxstlp81xBIgG4P6o1tcam0E1ZneWZw+r+0GUzZhpPjo5n+Rig97oZHYU
         8mxiytIp88vzjeSTVy31bp4R87e1OpBQET+EWf1o=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/mlx5: Prevent prefetch from racing with implicit destruction
Date:   Sun, 19 Jul 2020 09:54:35 +0300
Message-Id: <20200719065435.130722-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Prefetch work in mlx5_ib_prefetch_mr_work can be queued and able to run
concurrently with destruction of the implicit MR. The num_deferred_work
was intended to serialize this, but there is a race:

       CPU0                                          CPU1

    mlx5_ib_free_implicit_mr()
      xa_erase(odp_mkeys)
      synchronize_srcu()
      __xa_erase(implicit_children)
                                      mlx5_ib_prefetch_mr_work()
                                        pagefault_mr()
                                         pagefault_implicit_mr()
                                          implicit_get_child_mr()
                                           xa_cmpxchg()
                                        atomic_dec_and_test(num_deferred_mr)
      wait_event(imr->q_deferred_work)
      ib_umem_odp_release(odp_imr)
        kfree(odp_imr)

At this point in mlx5_ib_free_implicit_mr() the implicit_children list is
supposed to be empty forever so that destroy_unused_implicit_child_mr()
and related are not and will not be running.

Since it is not empty the destroy_unused_implicit_child_mr() flow ends up
touching deallocated memory as mlx5_ib_free_implicit_mr() already tore down the
imr parent.

The solution is to flush out the prefetch wq by driving num_deferred_work
to zero after creation of new prefetch work is blocked.

Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 7d2ec9ee5097..1ab676b66894 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -601,6 +601,23 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 	 */
 	synchronize_srcu(&dev->odp_srcu);
 
+	/*
+	 * All work on the prefetch list must be completed, xa_erase() prevented
+	 * new work from being created.
+	 */
+	wait_event(imr->q_deferred_work, !atomic_read(&imr->num_deferred_work));
+
+	/*
+	 * At this point it is forbidden for any other thread to enter
+	 * pagefault_mr() on this imr. It is already forbidden to call
+	 * pagefault_mr() on an implicit child. Due to this additions to
+	 * implicit_children are prevented.
+	 */
+
+	/*
+	 * Block destroy_unused_implicit_child_mr() from incrementing
+	 * num_deferred_work.
+	 */
 	xa_lock(&imr->implicit_children);
 	xa_for_each (&imr->implicit_children, idx, mtt) {
 		__xa_erase(&imr->implicit_children, idx);
@@ -609,9 +626,8 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 	xa_unlock(&imr->implicit_children);
 
 	/*
-	 * num_deferred_work can only be incremented inside the odp_srcu, or
-	 * under xa_lock while the child is in the xarray. Thus at this point
-	 * it is only decreasing, and all work holding it is now on the wq.
+	 * Wait for any concurrent destroy_unused_implicit_child_mr() to
+	 * complete.
 	 */
 	wait_event(imr->q_deferred_work, !atomic_read(&imr->num_deferred_work));
 
-- 
2.26.2

