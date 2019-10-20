Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B615DDD16
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 08:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfJTGpA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 02:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfJTGo7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 02:44:59 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61CFE222C2;
        Sun, 20 Oct 2019 06:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571553899;
        bh=DtdlSd+rTeZSqtC+CVSVASslNp1ROPooNwTGQGtTJN8=;
        h=From:To:Cc:Subject:Date:From;
        b=m4ctkxeOTkfBmeLkT0XUD/oqQ9HQfT1HFoDpENPCpYq3KoESKy7YezjE3gsuMAvpi
         veH+SKtaJmNSies6VN2EG140LOqUchS0C4j8vqj7DNIe4qBJsmJY1goDsvzcu7GZf3
         n5OoZqnEA1fWOXobFJMaOb1EFy7XYTy1HkjpQQeo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ran Rozenstein <ranro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/mlx5: Remove dead code
Date:   Sun, 20 Oct 2019 09:44:54 +0300
Message-Id: <20191020064454.8551-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ran Rozenstein <ranro@mellanox.com>

mlx5_ib_dc_atomic_is_supported function is not used anywhere. Remove the
dead code.

Fixes: a60109dc9a95 ("IB/mlx5: Add support for extended atomic operations")
Signed-off-by: Ran Rozenstein <ranro@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 15 ---------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 27255f68b2fb..fd3dd4523a22 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -694,21 +694,6 @@ static void get_atomic_caps_qp(struct mlx5_ib_dev *dev,
 	get_atomic_caps(dev, atomic_size_qp, props);
 }
 
-static void get_atomic_caps_dc(struct mlx5_ib_dev *dev,
-			       struct ib_device_attr *props)
-{
-	u8 atomic_size_qp = MLX5_CAP_ATOMIC(dev->mdev, atomic_size_dc);
-
-	get_atomic_caps(dev, atomic_size_qp, props);
-}
-
-bool mlx5_ib_dc_atomic_is_supported(struct mlx5_ib_dev *dev)
-{
-	struct ib_device_attr props = {};
-
-	get_atomic_caps_dc(dev, &props);
-	return (props.atomic_cap == IB_ATOMIC_HCA) ? true : false;
-}
 static int mlx5_query_system_image_guid(struct ib_device *ibdev,
 					__be64 *sys_image_guid)
 {
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d5c80aa9efb1..d925ce0e46b5 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1239,7 +1239,6 @@ struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
 						      struct ib_rwq_ind_table_init_attr *init_attr,
 						      struct ib_udata *udata);
 int mlx5_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
-bool mlx5_ib_dc_atomic_is_supported(struct mlx5_ib_dev *dev);
 struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 			       struct ib_ucontext *context,
 			       struct ib_dm_alloc_attr *attr,
-- 
2.20.1

