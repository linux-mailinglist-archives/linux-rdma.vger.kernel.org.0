Return-Path: <linux-rdma+bounces-12706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F898B24995
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB39169979
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C441DF269;
	Wed, 13 Aug 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQIJSn82"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47054184540
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088569; cv=none; b=DUQceb8qhfUWQuf4d35ax0+j+E5sBT9x0JFz31YjTvsDw0z6NiwHv7Za/ML2rPjrsEPQendERLA0tbsq97fhzRR44bXAYhnXXr/VThqGnEOM/R7jawJVU1KAh+S5iBCkvNzUOylHJHnJR4+2txMMzDTGWOH16AN9dXqMerpSC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088569; c=relaxed/simple;
	bh=AiDRVcBeniZPcSaHxFdztTphBMCqQUs3wXOjhgNN1Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bASMkk2hmW5nwYpILGNKc/G+U+92cY5E+HASoDkqZ0HmxI/ot0BwRmf9k0pbIlf5ZjZ4PN978ew15xZDnZOG2fEodITmN3ndKyFZRRA4XoKTaIgl1yi9a/3EhdC4bk++qlsvuDA4/lG9Vf2JsKVhAGH6TjcUHKVQa3NyQaPETmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQIJSn82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686A0C4CEEB;
	Wed, 13 Aug 2025 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755088568;
	bh=AiDRVcBeniZPcSaHxFdztTphBMCqQUs3wXOjhgNN1Uo=;
	h=From:To:Cc:Subject:Date:From;
	b=gQIJSn82S8C3QlqssfGTRhSCoDSm1J5jsFdF1rhhZfMsPbYCfVLvCC7lxwPh4IlzM
	 AKZIFaAr1FzJNuYWdrCbgbCnmPU0QBNkSQIXD4FbsarUdo3uccEdtsLetmSyVLo8Ic
	 Y4BdyOm9HX2EtchrMR43+azgbr5hA+ds43pNYKhWLN1YYEZu6bvsmQyc+br4WUQEv+
	 ENN/kUo15Igm9yeFcU+b51jrHx1Qm0rsGcokQNEkMfctGNfNJNzJjddmk9KQtmuCnp
	 jpiHa0ZB8SW1UU3u74TQbw573CppIliAEOPqwvxvf1NNvLv0kXpgrGewwOA0JnvGP1
	 21XeXC1M/aRGA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Gal Shalom <galshalom@Nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Enable Data-Direct with Relaxed Ordering
Date: Wed, 13 Aug 2025 15:36:01 +0300
Message-ID: <1221dcdda8061ba5f6bc3519044083c7438b257e.1755088503.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Relaxed Ordering can improve performance in certain scenarios.

Enable it in the Data-Direct use case as well.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Gal Shalom <galshalom@Nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 32 ++++++++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
 drivers/infiniband/hw/mlx5/mr.c      |  8 +++----
 drivers/infiniband/hw/mlx5/umr.c     |  6 +++++-
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d456e4fde3e1..505349c68e79 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3118,6 +3118,7 @@ mlx5_ib_create_data_direct_resources(struct mlx5_ib_dev *dev)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	struct mlx5_core_dev *mdev = dev->mdev;
+	bool ro_supp = false;
 	void *mkc;
 	u32 mkey;
 	u32 pdn;
@@ -3146,14 +3147,37 @@ mlx5_ib_create_data_direct_resources(struct mlx5_ib_dev *dev)
 	MLX5_SET(mkc, mkc, length64, 1);
 	MLX5_SET(mkc, mkc, qpn, 0xffffff);
 	err = mlx5_core_create_mkey(mdev, &mkey, in, inlen);
-	kvfree(in);
 	if (err)
-		goto err;
+		goto err_mkey;
 
 	dev->ddr.mkey = mkey;
 	dev->ddr.pdn = pdn;
+
+	/* create another mkey with RO support */
+	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write)) {
+		MLX5_SET(mkc, mkc, relaxed_ordering_write, 1);
+		ro_supp = true;
+	}
+
+	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read)) {
+		MLX5_SET(mkc, mkc, relaxed_ordering_read, 1);
+		ro_supp = true;
+	}
+
+	if (ro_supp) {
+		err = mlx5_core_create_mkey(mdev, &mkey, in, inlen);
+		/* RO is defined as best effort */
+		if (!err) {
+			dev->ddr.mkey_ro = mkey;
+			dev->ddr.mkey_ro_valid = true;
+		}
+	}
+
+	kvfree(in);
 	return 0;
 
+err_mkey:
+	kvfree(in);
 err:
 	mlx5_core_dealloc_pd(mdev, pdn);
 	return err;
@@ -3162,6 +3186,10 @@ mlx5_ib_create_data_direct_resources(struct mlx5_ib_dev *dev)
 static void
 mlx5_ib_free_data_direct_resources(struct mlx5_ib_dev *dev)
 {
+
+	if (dev->ddr.mkey_ro_valid)
+		mlx5_core_destroy_mkey(dev->mdev, dev->ddr.mkey_ro);
+
 	mlx5_core_destroy_mkey(dev->mdev, dev->ddr.mkey);
 	mlx5_core_dealloc_pd(dev->mdev, dev->ddr.pdn);
 }
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 185d6e67e8ae..a6c83ce2f0ee 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -854,6 +854,8 @@ struct mlx5_ib_port_resources {
 struct mlx5_data_direct_resources {
 	u32 pdn;
 	u32 mkey;
+	u32 mkey_ro;
+	u8 mkey_ro_valid :1;
 };
 
 struct mlx5_ib_resources {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 03729e137385..aded210dc0a8 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1772,11 +1772,11 @@ reg_user_mr_dmabuf_by_data_direct(struct ib_pd *pd, u64 offset,
 		goto end;
 	}
 
-	/* The device's 'data direct mkey' was created without RO flags to
-	 * simplify things and allow for a single mkey per device.
-	 * Since RO is not a must, mask it out accordingly.
+	/* If no device's 'data direct mkey' with RO flags exists
+	 * mask it out accordingly.
 	 */
-	access_flags &= ~IB_ACCESS_RELAXED_ORDERING;
+	if (!dev->ddr.mkey_ro_valid)
+		access_flags &= ~IB_ACCESS_RELAXED_ORDERING;
 	crossed_mr = reg_user_mr_dmabuf(pd, &data_direct_dev->pdev->dev,
 					offset, length, virt_addr, fd,
 					access_flags, MLX5_MKC_ACCESS_MODE_KSM,
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 7ef35cddce81..4e562e0dd9e1 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -761,7 +761,11 @@ _mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, bool dd,
 
 		if (dd) {
 			cur_ksm->va = cpu_to_be64(rdma_block_iter_dma_address(&biter));
-			cur_ksm->key = cpu_to_be32(dev->ddr.mkey);
+			if (mr->access_flags & IB_ACCESS_RELAXED_ORDERING &&
+			    dev->ddr.mkey_ro_valid)
+				cur_ksm->key = cpu_to_be32(dev->ddr.mkey_ro);
+			else
+				cur_ksm->key = cpu_to_be32(dev->ddr.mkey);
 			if (mr->umem->is_dmabuf &&
 			    (flags & MLX5_IB_UPD_XLT_ZAP)) {
 				cur_ksm->va = 0;
-- 
2.50.1


