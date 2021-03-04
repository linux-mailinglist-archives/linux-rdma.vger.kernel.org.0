Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9972732D3E2
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 14:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbhCDNG1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 08:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241091AbhCDNF7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 08:05:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 493D764F32;
        Thu,  4 Mar 2021 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614863119;
        bh=CLl7tVPYHZhWQqT893mHez6X5wFjhF2suTTjyknjo1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEZm9dNyrxJHAQRF+YUZFEagxagVn1YZX9FthWk/h0rsQJGiSPrYLNXMPS1IP/aO5
         GtTO3B9SM2MwxISsMKtMfF17R/GV3lHXSvbYbTW+PHjg7Q2LzzhRma+mHXDOnbA2e3
         W33QqbCwJoQww1S2Qd29Vgh3dDW4nPjVgBpX6UGZsvCDP0FG3nQup5puSERMY5kSBi
         M6XVRSFMsxdAOk0Up/UeVh1b+fOdXPe9bM3QB5z0BkSigVjVE5GRMJ6+5paAKQ7VIT
         9VcxfZOOIkyFBJNSgeQ0z0TrjLI5L1SwEyi4CC+Z8sFToUZswYyExosgQRIUu44sAu
         Cf1zvQiHnmRXQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 3/3] RDMA/mlx5: Allow larger pages in DevX umem
Date:   Thu,  4 Mar 2021 15:05:01 +0200
Message-Id: <20210304130501.1102577-4-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304130501.1102577-1-leon@kernel.org>
References: <20210304130501.1102577-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The umem DMA list calculation was locked at 4k pages due to confusion
around how this API works and is used when larger pages are present.

The conclusion is:

 - umem's cannot extend past what is mapped into the process, so creating
   a lage page size and referring to a sub-range is not allowed

 - umem's must always have a page offset of zero, except for sub PAGE_SIZE
   umems

 - The feature of umem_offset to create multiple objects inside a umem
   is buggy and isn't used anyplace. Thus we can assume all users of the
   current API have umem_offset == 0 as well

Provide a new page size calculator that limits the DMA list to the VA
range and enforces umem_offset == 0.

Allow user space to specify the page sizes which it can accept, this
bitmap must be derived from the intended use of the umem, based on
per-usage HW limitations.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c        | 64 ++++++++++++++++++++----
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
 2 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index de3c2fc6f361..17ab369efc5e 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2185,27 +2185,69 @@ static int devx_umem_get(struct mlx5_ib_dev *dev, struct ib_ucontext *ucontext,
 	return 0;
 }

+static unsigned int devx_umem_find_best_pgsize(struct ib_umem *umem,
+					       unsigned long pgsz_bitmap)
+{
+	unsigned long page_size;
+
+	/* Don't bother checking larger page sizes as offset must be zero and
+	 * total DEVX umem length must be equal to total umem length.
+	 */
+	pgsz_bitmap &= GENMASK_ULL(max_t(u64, order_base_2(umem->length),
+					 PAGE_SHIFT),
+				   MLX5_ADAPTER_PAGE_SHIFT);
+	if (!pgsz_bitmap)
+		return 0;
+
+	page_size = ib_umem_find_best_pgoff(umem, pgsz_bitmap, U64_MAX);
+	if (!page_size)
+		return 0;
+
+	/* If the page_size is less than the CPU page size then we can use the
+	 * offset and create a umem which is a subset of the page list.
+	 * For larger page sizes we can't be sure the DMA  list reflects the
+	 * VA so we must ensure that the umem extent is exactly equal to the
+	 * page list. Reduce the page size until one of these cases is true.
+	 */
+	while ((ib_umem_dma_offset(umem, page_size) != 0 ||
+		(umem->length % page_size) != 0) &&
+		page_size > PAGE_SIZE)
+		page_size /= 2;
+
+	return page_size;
+}
+
 static int devx_umem_reg_cmd_alloc(struct mlx5_ib_dev *dev,
 				   struct uverbs_attr_bundle *attrs,
 				   struct devx_umem *obj,
 				   struct devx_umem_reg_cmd *cmd)
 {
+	unsigned long pgsz_bitmap;
 	unsigned int page_size;
 	__be64 *mtt;
 	void *umem;
+	int ret;

 	/*
-	 * We don't know what the user intends to use this umem for, but the HW
-	 * restrictions must be met. MR, doorbell records, QP, WQ and CQ all
-	 * have different requirements. Since we have no idea how to sort this
-	 * out, only support PAGE_SIZE with the expectation that userspace will
-	 * provide the necessary alignments inside the known PAGE_SIZE and that
-	 * FW will check everything.
+	 * If the user does not pass in pgsz_bitmap then the user promises not
+	 * to use umem_offset!=0 in any commands that allocate on top of the
+	 * umem.
+	 *
+	 * If the user wants to use a umem_offset then it must pass in
+	 * pgsz_bitmap which guides the maximum page size and thus maximum
+	 * object alignment inside the umem. See the PRM.
+	 *
+	 * Users are not allowed to use IOVA here, mkeys are not supported on
+	 * umem.
 	 */
-	page_size = ib_umem_find_best_pgoff(
-		obj->umem, PAGE_SIZE,
-		__mlx5_page_offset_to_bitmask(__mlx5_bit_sz(umem, page_offset),
-					      0));
+	ret = uverbs_get_const_default(&pgsz_bitmap, attrs,
+			MLX5_IB_ATTR_DEVX_UMEM_REG_PGSZ_BITMAP,
+			GENMASK_ULL(63,
+				    min(PAGE_SHIFT, MLX5_ADAPTER_PAGE_SHIFT)));
+	if (ret)
+		return ret;
+
+	page_size = devx_umem_find_best_pgsize(obj->umem, pgsz_bitmap);
 	if (!page_size)
 		return -EINVAL;

@@ -2791,6 +2833,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 			   UA_MANDATORY),
 	UVERBS_ATTR_FLAGS_IN(MLX5_IB_ATTR_DEVX_UMEM_REG_ACCESS,
 			     enum ib_access_flags),
+	UVERBS_ATTR_CONST_IN(MLX5_IB_ATTR_DEVX_UMEM_REG_PGSZ_BITMAP,
+			     u64),
 	UVERBS_ATTR_PTR_OUT(MLX5_IB_ATTR_DEVX_UMEM_REG_OUT_ID,
 			    UVERBS_ATTR_TYPE(u32),
 			    UA_MANDATORY));
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 3fd9b380a091..3f0bc7597ba7 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -154,6 +154,7 @@ enum mlx5_ib_devx_umem_reg_attrs {
 	MLX5_IB_ATTR_DEVX_UMEM_REG_LEN,
 	MLX5_IB_ATTR_DEVX_UMEM_REG_ACCESS,
 	MLX5_IB_ATTR_DEVX_UMEM_REG_OUT_ID,
+	MLX5_IB_ATTR_DEVX_UMEM_REG_PGSZ_BITMAP,
 };

 enum mlx5_ib_devx_umem_dereg_attrs {
--
2.29.2

