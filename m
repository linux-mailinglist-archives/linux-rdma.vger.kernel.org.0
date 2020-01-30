Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7F014D9C9
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 12:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgA3LaD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 06:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgA3LaD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jan 2020 06:30:03 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC67206D3;
        Thu, 30 Jan 2020 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580383802;
        bh=qB/A5PCQflQoXV4KMXaE57+er+ad/9I2EKNTZ3EP6OQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YvvbgGz5zFfIUd39MSZNVsegl1WMlcRg8zHWKHKOFUGm5BUS1LRr3DntQq7OGYFJj
         GlXSPZdIEyAAAKDvV7vhiGpvBHfIfNN2JtfTawsf43rJkrTl5je4PvPTvxoZlM2wTx
         ygxrKUDqiKMA1jo8jP050k7ifdfwlLcktp2IfKhs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix compilation breakage without INFINIBAND_USER_ACCESS
Date:   Thu, 30 Jan 2020 13:29:57 +0200
Message-Id: <20200130112957.337869-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Compilation of mlx5 driver without CONFIG_INFINIBAND_USER_ACCESS generates
the following error.

on x86_64:

ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_handler_MLX5_IB_METHOD_VAR_OBJ_ALLOC':
main.c:(.text+0x186d): undefined reference to `ib_uverbs_get_ucontext_file'
ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x2480): undefined reference to `uverbs_idr_class'
ld: drivers/infiniband/hw/mlx5/main.o:(.rodata+0x24d8): undefined reference to `uverbs_destroy_def_handler'

Guard the problematic code, so VAR objects API won't be compiled without CONFIG_INFINIBAND_USER_ACCESS.

Fixes: 7be76bef320b ("IB/mlx5: Introduce VAR object and its alloc/destroy methods")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 41ccc19d229e..c2afe6929cbb 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2280,15 +2280,6 @@ static int mlx5_ib_mmap_offset(struct mlx5_ib_dev *dev,
 	return ret;
 }

-static u64 mlx5_entry_to_mmap_offset(struct mlx5_user_mmap_entry *entry)
-{
-	u16 cmd = entry->rdma_entry.start_pgoff >> 16;
-	u16 index = entry->rdma_entry.start_pgoff & 0xFFFF;
-
-	return (((index >> 8) << 16) | (cmd << MLX5_IB_MMAP_CMD_SHIFT) |
-		(index & 0xFF)) << PAGE_SHIFT;
-}
-
 static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 {
 	struct mlx5_ib_ucontext *context = to_mucontext(ibcontext);
@@ -6085,6 +6076,16 @@ static void mlx5_ib_cleanup_multiport_master(struct mlx5_ib_dev *dev)
 	mlx5_nic_vport_disable_roce(dev->mdev);
 }

+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
+static u64 mlx5_entry_to_mmap_offset(struct mlx5_user_mmap_entry *entry)
+{
+	u16 cmd = entry->rdma_entry.start_pgoff >> 16;
+	u16 index = entry->rdma_entry.start_pgoff & 0xFFFF;
+
+	return (((index >> 8) << 16) | (cmd << MLX5_IB_MMAP_CMD_SHIFT) |
+		(index & 0xFF)) << PAGE_SHIFT;
+}
+
 static int var_obj_cleanup(struct ib_uobject *uobject,
 			   enum rdma_remove_reason why,
 			   struct uverbs_attr_bundle *attrs)
@@ -6223,6 +6224,7 @@ static bool var_is_supported(struct ib_device *device)
 	return (MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
 			MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q);
 }
+#endif

 ADD_UVERBS_ATTRIBUTES_SIMPLE(
 	mlx5_ib_dm,
@@ -6254,8 +6256,10 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_FLOW_ACTION,
 				&mlx5_ib_flow_action),
 	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_DM, &mlx5_ib_dm),
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(MLX5_IB_OBJECT_VAR,
 				UAPI_DEF_IS_OBJ_SUPPORTED(var_is_supported)),
+#endif
 	{}
 };

--
2.24.1

