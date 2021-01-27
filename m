Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0044305FB4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 16:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhA0PFW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 10:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235323AbhA0PCz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 10:02:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D50720C56;
        Wed, 27 Jan 2021 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611759633;
        bh=vThR8JoD3KCufXTeyKibZYnn+fS9RllSFXcNW7NXN4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ukvSF/NpmknO9OVWhrr/sZa5kCeWsBS9TZXEUMsCDElT9RmTAhNcJjy17iZO4ZFDy
         365UfgUsnfOLj5EMOUc9FF1vUz3+t1Ru7X42R9W0b051Tp586jGysd4wcgsMYXFVtH
         m6MNlJLKJVkZWBFSFpFbfQ17aJeNn++fIyxv9PvLUKQ5GDMzYL/Y95oJv9IWgMisJ1
         CSy97h1VffSna8osBgmu+jhL5ik2Zy/+XEHFBw02Kf2C0KnWOnnVphpchBiDKkkFh1
         jfGIE8zSyw6aMfd05dNeAQuTlCp1p0QbHAPcCPBDIQpQoVxgrpiYbu+pkhTsAdwsMe
         bHbjrTMY2KOzQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 06/10] IB/mlx5: Use rdma_for_each_port for port iteration
Date:   Wed, 27 Jan 2021 17:00:06 +0200
Message-Id: <20210127150010.1876121-7-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127150010.1876121-1-leon@kernel.org>
References: <20210127150010.1876121-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

Instead of open coding the loop for port iteration, use
rdma_for_each_port macro provided by core.

To use such macro, early initialization of phys_port_cnt is needed.
Hence, initialize such constant early enough in the init stage.

Whichever functions are called with port using rdma_for_each_port(),
convert their port type from u8 to unsigned int to match the core API.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mad.c     |  2 +-
 drivers/infiniband/hw/mlx5/main.c    | 15 ++++++++-------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index cdb47a00e516..652c6ccf1881 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -279,7 +279,7 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
 }

-int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, u8 port)
+int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, unsigned int port)
 {
 	struct ib_smp *in_mad  = NULL;
 	struct ib_smp *out_mad = NULL;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 742e565309f8..ad7bb37e501d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2982,9 +2982,9 @@ static int set_has_smi_cap(struct mlx5_ib_dev *dev)

 static void get_ext_port_caps(struct mlx5_ib_dev *dev)
 {
-	int port;
+	unsigned int port;

-	for (port = 1; port <= dev->num_ports; port++)
+	rdma_for_each_port (&dev->ib_dev, port)
 		mlx5_query_ext_port_caps(dev, port);
 }

@@ -3905,6 +3905,12 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	int err;
 	int i;

+	dev->ib_dev.node_type = RDMA_NODE_IB_CA;
+	dev->ib_dev.local_dma_lkey = 0 /* not supported for now */;
+	dev->ib_dev.phys_port_cnt = dev->num_ports;
+	dev->ib_dev.dev.parent = mdev->device;
+	dev->ib_dev.lag_flags = RDMA_LAG_FLAGS_HASH_ALL_SLAVES;
+
 	for (i = 0; i < dev->num_ports; i++) {
 		spin_lock_init(&dev->port[i].mp.mpi_lock);
 		rwlock_init(&dev->port[i].roce.netdev_lock);
@@ -3930,12 +3936,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (mlx5_use_mad_ifc(dev))
 		get_ext_port_caps(dev);

-	dev->ib_dev.node_type		= RDMA_NODE_IB_CA;
-	dev->ib_dev.local_dma_lkey	= 0 /* not supported for now */;
-	dev->ib_dev.phys_port_cnt	= dev->num_ports;
 	dev->ib_dev.num_comp_vectors    = mlx5_comp_vectors_count(mdev);
-	dev->ib_dev.dev.parent		= mdev->device;
-	dev->ib_dev.lag_flags		= RDMA_LAG_FLAGS_HASH_ALL_SLAVES;

 	mutex_init(&dev->cap_mask_mutex);
 	INIT_LIST_HEAD(&dev->qp_list);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 69c45adb2518..88cc26e008fc 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1291,7 +1291,7 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 			size_t *out_mad_size, u16 *out_mad_pkey_index);
 int mlx5_ib_alloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
 int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata);
-int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, u8 port);
+int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, unsigned int port);
 int mlx5_query_mad_ifc_system_image_guid(struct ib_device *ibdev,
 					 __be64 *sys_image_guid);
 int mlx5_query_mad_ifc_max_pkeys(struct ib_device *ibdev,
--
2.29.2

