Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6111540BC04
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 01:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhINXKF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 19:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236360AbhINXJs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 19:09:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C592E60F46;
        Tue, 14 Sep 2021 23:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631660910;
        bh=3Kkx0Uhy+H9fUZSLKru8YYLp+dTH4+uckqZAhNytfIg=;
        h=From:To:Cc:Subject:Date:From;
        b=rTs9bn0OGrsUmjOb6MNOL2HT5UL+xrK/lbYDRJYKMsTvEeZ1nD9BuAYkvnVrG+sWV
         ynMfrRSEZD1eQSv6nTCkVXUjtjM2kG+q3WgFDlUHPegKvUfce2KLdrMHfkWA4w7f/3
         3CwbeOzQFwhKnJGERGGuWL13JCdGiNMuY365TWk1PRuTBry46B6H2eJfm86MbUg6po
         bdp276TGbsQBjUHsIezlou/T0/erKVb5ruRG0otz9ckB2UFrBLX+tVk5wwq0Q27LnU
         De3VQzt1cnsIWqq6JQWBgLqTceFqbtrB4uX9oTLFPxVKCOBkvrqQwgLNj63SR3+jW6
         zjg8CeN4LHkZg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alaa Hleihel <alaa@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/mlx5: Add dummy umem to IB_MR_TYPE_DM
Date:   Wed, 15 Sep 2021 02:08:25 +0300
Message-Id: <9c6478b70dc23cfec3a7bfc345c30ff817e7e799.1631660866.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Alaa Hleihel <alaa@nvidia.com>

After the cited patch, and for the case of IB_MR_TYPE_DM that doesn't
have a umem (even though it is a user MR), function mlx5_free_priv_descs()
will think that it's a kernel MR, leading to wrongly accessing mr->descs
that will get wrong values in the union which leads to attempting to
release resources that were not allocated in the first place.

For example:
 DMA-API: mlx5_core 0000:08:00.1: device driver tries to free DMA memory it has not allocated [device address=0x0000000000000000] [size=0 bytes]
 WARNING: CPU: 8 PID: 1021 at kernel/dma/debug.c:961 check_unmap+0x54f/0x8b0
 RIP: 0010:check_unmap+0x54f/0x8b0
 Call Trace:
  debug_dma_unmap_page+0x57/0x60
  mlx5_free_priv_descs+0x57/0x70 [mlx5_ib]
  mlx5_ib_dereg_mr+0x1fb/0x3d0 [mlx5_ib]
  ib_dereg_mr_user+0x60/0x140 [ib_core]
  uverbs_destroy_uobject+0x59/0x210 [ib_uverbs]
  uobj_destroy+0x3f/0x80 [ib_uverbs]
  ib_uverbs_cmd_verbs+0x435/0xd10 [ib_uverbs]
  ? uverbs_finalize_object+0x50/0x50 [ib_uverbs]
  ? lock_acquire+0xc4/0x2e0
  ? lock_acquired+0x12/0x380
  ? lock_acquire+0xc4/0x2e0
  ? lock_acquire+0xc4/0x2e0
  ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
  ? lock_release+0x28a/0x400
  ib_uverbs_ioctl+0xc0/0x140 [ib_uverbs]
  ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
  __x64_sys_ioctl+0x7f/0xb0
  do_syscall_64+0x38/0x90

Fix it by adding a dummy umem to IB_MR_TYPE_DM MRs.

Fixes: f18ec4223117 ("RDMA/mlx5: Use a union inside mlx5_ib_mr")
Signed-off-by: Alaa Hleihel <alaa@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem.c  | 21 +++++++++++++++++++++
 drivers/infiniband/hw/mlx5/mr.c |  5 +++++
 include/rdma/ib_umem.h          |  5 +++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 44a0f0b2570f..518682a64daf 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -299,6 +299,27 @@ struct ib_umem *ib_umem_get_peer(struct ib_device *device, unsigned long addr,
 }
 EXPORT_SYMBOL(ib_umem_get_peer);
 
+/**
+ * ib_umem_get_dummy - Create an empty umem
+ *
+ * @device: IB device to connect UMEM
+ */
+struct ib_umem *ib_umem_get_dummy(struct ib_device *device)
+{
+	struct ib_umem *umem;
+
+	umem = kzalloc(sizeof(*umem), GFP_KERNEL);
+	if (!umem)
+		return ERR_PTR(-ENOMEM);
+
+	umem->ibdev = device;
+	umem->owning_mm = current->mm;
+	mmgrab(umem->owning_mm);
+
+	return umem;
+}
+EXPORT_SYMBOL(ib_umem_get_dummy);
+
 /**
  * ib_umem_release - release memory pinned with ib_umem_get
  * @umem: umem struct to release
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 94f2c0c0f42c..2d54db152e54 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1386,6 +1386,11 @@ static struct ib_mr *mlx5_ib_get_dm_mr(struct ib_pd *pd, u64 start_addr,
 	kfree(in);
 
 	set_mr_fields(dev, mr, length, acc);
+	mr->umem = ib_umem_get_dummy(&dev->ib_dev);
+	if (IS_ERR(mr->umem)) {
+		err = PTR_ERR(mr->umem);
+		goto err_free;
+	}
 
 	return &mr->ibmr;
 
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index bd64e6749951..18ea9c25207d 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -106,6 +106,7 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
 
 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 			    size_t size, int access);
+struct ib_umem *ib_umem_get_dummy(struct ib_device *device);
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
@@ -167,6 +168,10 @@ static inline struct ib_umem *ib_umem_get(struct ib_device *device,
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+static struct ib_umem *ib_umem_get_dummy(struct ib_device *device)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline void ib_umem_release(struct ib_umem *umem) { }
 static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      		    size_t length) {
-- 
2.31.1

