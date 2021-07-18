Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07053CC8F1
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 14:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhGRMEO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 08:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233425AbhGRMEM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 08:04:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8BE36113D;
        Sun, 18 Jul 2021 12:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626609674;
        bh=cAnq0DG8YTB9VFO8VFMDen4mU9E05ik62n+FRZ0hxdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRD/f373jpVRJygvZ4rRg0bC0gxJmnpkKB1dcu9Jeu0OpvlEmA/PAD5H6LmzOjsQI
         +dc+G+NxpiiyJiuZyhuRx4d7dPfRQLhqkmvPeYLhmLBCm/rG0vKCaCTLIU2218LW8x
         HoAW7QdDUY82zwBG40J1HK6Kmvq4yGwOtAPyl4VGLPIi/gh+Cfsmlzkc3m3C4tloyr
         6UUDKFLlbOZM8ddbe1Js2pylX5liv+tgtgtpyuw+IB+gTGAgvsNZo4MqQUgBNKmzJV
         HDrPllCREjvk+e6ABBAKEY8rCFPPOqp6ybqNeDByHgc6nDdEY1VWH+psZKfBRDGTih
         zmNETFw83kWxQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 4/9] RDMA/mlx5: Cancel pkey work before destroying device resources
Date:   Sun, 18 Jul 2021 15:00:54 +0300
Message-Id: <dbe3c4b2836c2db07254dfeb4b919b095259cf91.1626609283.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626609283.git.leonro@nvidia.com>
References: <cover.1626609283.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

In the driver release flow, we are ensuring that notifier is disabled
and no new works can be added to pkey_change_handler. It means that
we can cancel that handler before destroying resources to make sure
that our unwind routine is symmetrical to the allocation one.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 9b8dd7a604c9..75d5de14f80b 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2908,6 +2908,15 @@ static void mlx5_ib_dev_res_cleanup(struct mlx5_ib_dev *dev)
 	struct mlx5_ib_resources *devr = &dev->devr;
 	int port;
 
+	/*
+	 * Make sure no change P_Key work items are still executing.
+	 *
+	 * At this stage, the mlx5_ib_event should be unregistered
+	 * and it ensures that no new works are added.
+	 */
+	for (port = 0; port < ARRAY_SIZE(devr->ports); ++port)
+		cancel_work_sync(&devr->ports[port].pkey_change_work);
+
 	mlx5_ib_destroy_srq(devr->s1, NULL);
 	kfree(devr->s1);
 	mlx5_ib_destroy_srq(devr->s0, NULL);
@@ -2918,10 +2927,6 @@ static void mlx5_ib_dev_res_cleanup(struct mlx5_ib_dev *dev)
 	kfree(devr->c0);
 	mlx5_ib_dealloc_pd(devr->p0, NULL);
 	kfree(devr->p0);
-
-	/* Make sure no change P_Key work items are still executing */
-	for (port = 0; port < ARRAY_SIZE(devr->ports); ++port)
-		cancel_work_sync(&devr->ports[port].pkey_change_work);
 }
 
 static u32 get_core_cap_flags(struct ib_device *ibdev,
-- 
2.31.1

