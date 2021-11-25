Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D2545E11E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 20:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbhKYTsI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 14:48:08 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:51437 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356720AbhKYTqI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Nov 2021 14:46:08 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id qKdxmbbOcqYovqKdymK6ek; Thu, 25 Nov 2021 20:42:54 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 25 Nov 2021 20:42:54 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     yishaih@nvidia.com, selvin.xavier@broadcom.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/mlx4: Use bitmap_alloc() when applicable
Date:   Thu, 25 Nov 2021 20:42:51 +0100
Message-Id: <4c93b4e02f5d784ddfd3efd4af9e673b9117d641.1637869328.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use 'bitmap_alloc()' to simplify code, improve the semantic and avoid some
open-coded arithmetic in allocator arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/mlx4/main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 0d2fa3338784..d66ce7694bbe 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2784,10 +2784,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		if (err)
 			goto err_counter;
 
-		ibdev->ib_uc_qpns_bitmap =
-			kmalloc_array(BITS_TO_LONGS(ibdev->steer_qpn_count),
-				      sizeof(long),
-				      GFP_KERNEL);
+		ibdev->ib_uc_qpns_bitmap = bitmap_alloc(ibdev->steer_qpn_count,
+							GFP_KERNEL);
 		if (!ibdev->ib_uc_qpns_bitmap)
 			goto err_steer_qp_release;
 
@@ -2875,7 +2873,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	mlx4_ib_diag_cleanup(ibdev);
 
 err_steer_free_bitmap:
-	kfree(ibdev->ib_uc_qpns_bitmap);
+	bitmap_free(ibdev->ib_uc_qpns_bitmap);
 
 err_steer_qp_release:
 	mlx4_qp_release_range(dev, ibdev->steer_qpn_base,
@@ -2988,7 +2986,7 @@ static void mlx4_ib_remove(struct mlx4_dev *dev, void *ibdev_ptr)
 
 	mlx4_qp_release_range(dev, ibdev->steer_qpn_base,
 			      ibdev->steer_qpn_count);
-	kfree(ibdev->ib_uc_qpns_bitmap);
+	bitmap_free(ibdev->ib_uc_qpns_bitmap);
 
 	iounmap(ibdev->uar_map);
 	for (p = 0; p < ibdev->num_ports; ++p)
-- 
2.30.2

