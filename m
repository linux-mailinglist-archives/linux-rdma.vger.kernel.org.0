Return-Path: <linux-rdma+bounces-6296-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0150A9E56FC
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3339284B5B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF6B230990;
	Thu,  5 Dec 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tdkl5Cdh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F45230980;
	Thu,  5 Dec 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404962; cv=none; b=hcVjNoqLE/yLEa8YFshi502+TVKVVXqxYcsocUg9kakI0LR66jYZnqGsGBL9NbmTfs7EDSOS+e+xeu5G63fHnfY/trlhtoVVqSW2MvJ11WZowQbvuYXNobdeQyglqvxc2goFhTt0BVka2SxVCSh6TnzBEZVueixuFVOiRkjX+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404962; c=relaxed/simple;
	bh=uuhLRDqUmVjvXHMf5rPVR39X+EGeWoydaAaPF9BiMeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bza1Mwg7uxIyfXgGR6ua+QzH+iW6MrscDrf7DJdhRSzYsYuwujbFf+LQC409pLr1j5rmEiLsdc1/U7b2QhEpQN+OTammYfe58I0IO+IvqLnAhRtGMyyyRwhXQh2XjDSDAWp1xgkjkWMTn/j7PKiPF3rvJNxCSTx/y6GPDqGRpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tdkl5Cdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2B8C4CEDC;
	Thu,  5 Dec 2024 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733404962;
	bh=uuhLRDqUmVjvXHMf5rPVR39X+EGeWoydaAaPF9BiMeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tdkl5Cdhl1KqIb4v4p69OashlRr4SxIfkI3xK3PMA/WcVhQkPMyAVSQbrxa6dbbfY
	 lUEWCkwgaASFYBALemqxlIZvmAKOoIk7ADBTYpfIOPjdL3XWnG3QgGAs30ccQb5euv
	 Tz1N0LhsmBf8fPFaZSDnIczR82owJNYDxd/4pX5r4itEaD12c4t2AgBz+mNr+ZI1IQ
	 k0/McmNFMiA7gnYeisGsUBcYx1cOUiPYuEI9N7shk/1rKzw+eK2hiS2w6jDI7crQz7
	 3zHorwJmd195k2dMlnUsqxwV7PL8mEFd8/7f7SGxjrsntExn+SnaIlW97kshfx7jd7
	 7tZ60u9A5Eofw==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 18/18] vfio/mlx5: Enable the DMA link API
Date: Thu,  5 Dec 2024 15:21:17 +0200
Message-ID: <d575391da653eebffa2a3ac2a936df963aa8c6b7.1733398913.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733398913.git.leon@kernel.org>
References: <cover.1733398913.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Remove intermediate scatter-gather table completely and
enable new DMA link API.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.c  | 296 ++++++++++++++++-------------------
 drivers/vfio/pci/mlx5/cmd.h  |  21 ++-
 drivers/vfio/pci/mlx5/main.c |  31 ----
 3 files changed, 146 insertions(+), 202 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 2607f7fb3f73..3d24d91748a8 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -345,25 +345,81 @@ static u32 *alloc_mkey_in(u32 npages, u32 pdn)
 	return in;
 }
 
-static int create_mkey(struct mlx5_core_dev *mdev, u32 npages,
-		       struct mlx5_vhca_data_buffer *buf, u32 *mkey_in,
+static int create_mkey(struct mlx5_core_dev *mdev, u32 npages, u32 *mkey_in,
 		       u32 *mkey)
 {
+	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in) +
+		sizeof(__be64) * round_up(npages, 2);
+
+	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
+}
+
+static void unregister_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
+				 u32 *mkey_in, struct dma_iova_state *state,
+				 enum dma_data_direction dir)
+{
+	dma_addr_t addr;
 	__be64 *mtt;
-	int inlen;
+	int i;
 
-	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
-	if (buf) {
-		struct sg_dma_page_iter dma_iter;
+	WARN_ON_ONCE(dir == DMA_NONE);
 
-		for_each_sgtable_dma_page(&buf->table.sgt, &dma_iter, 0)
-			*mtt++ = cpu_to_be64(sg_page_iter_dma_address(&dma_iter));
+	if (dma_use_iova(state)) {
+		dma_iova_destroy(mdev->device, state, npages * PAGE_SIZE, dir, 0);
+	} else {
+		mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in,
+					     klm_pas_mtt);
+		for (i = npages - 1; i >= 0; i--) {
+			addr = be64_to_cpu(mtt[i]);
+			dma_unmap_page(mdev->device, addr, PAGE_SIZE, dir);
+		}
 	}
+}
 
-	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) +
-		sizeof(__be64) * round_up(npages, 2);
+static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
+			      struct page **page_list, u32 *mkey_in,
+			      struct dma_iova_state *state,
+			      enum dma_data_direction dir)
+{
+	dma_addr_t addr;
+	size_t mapped = 0;
+	__be64 *mtt;
+	int i, err;
 
-	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
+	WARN_ON_ONCE(dir == DMA_NONE);
+
+	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
+
+	if (dma_iova_try_alloc(mdev->device, state, 0, npages * PAGE_SIZE)) {
+		addr = state->addr;
+		for (i = 0; i < npages; i++) {
+			err = dma_iova_link(mdev->device, state,
+					    page_to_phys(page_list[i]), mapped,
+					    PAGE_SIZE, dir, 0);
+			if (err)
+				goto error;
+			*mtt++ = cpu_to_be64(addr);
+			addr += PAGE_SIZE;
+			mapped += PAGE_SIZE;
+		}
+		err = dma_iova_sync(mdev->device, state, 0, mapped);
+		if (err)
+			goto error;
+	} else {
+		for (i = 0; i < npages; i++) {
+			addr = dma_map_page(mdev->device, page_list[i], 0,
+					    PAGE_SIZE, dir);
+			err = dma_mapping_error(mdev->device, addr);
+			if (err)
+				goto error;
+			*mtt++ = cpu_to_be64(addr);
+		}
+	}
+	return 0;
+
+error:
+	unregister_dma_pages(mdev, i, mkey_in, state, dir);
+	return err;
 }
 
 static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
@@ -379,98 +435,90 @@ static int mlx5vf_dma_data_buffer(struct mlx5_vhca_data_buffer *buf)
 	if (buf->mkey_in || !buf->npages)
 		return -EINVAL;
 
-	ret = dma_map_sgtable(mdev->device, &buf->table.sgt, buf->dma_dir, 0);
-	if (ret)
-		return ret;
-
 	buf->mkey_in = alloc_mkey_in(buf->npages, buf->migf->pdn);
-	if (!buf->mkey_in) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!buf->mkey_in)
+		return -ENOMEM;
 
-	ret = create_mkey(mdev, buf->npages, buf, buf->mkey_in, &buf->mkey);
+	ret = register_dma_pages(mdev, buf->npages, buf->page_list,
+				 buf->mkey_in, &buf->state, buf->dma_dir);
+	if (ret)
+		goto err_register_dma;
+
+	ret = create_mkey(mdev, buf->npages, buf->mkey_in, &buf->mkey);
 	if (ret)
 		goto err_create_mkey;
 
 	return 0;
 
 err_create_mkey:
+	unregister_dma_pages(mdev, buf->npages, buf->mkey_in, &buf->state,
+			     buf->dma_dir);
+err_register_dma:
 	kvfree(buf->mkey_in);
 	buf->mkey_in = NULL;
-err:
-	dma_unmap_sgtable(mdev->device, &buf->table.sgt, buf->dma_dir, 0);
 	return ret;
 }
 
+static void free_page_list(u32 npages, struct page **page_list)
+{
+	int i;
+
+	/* Undo alloc_pages_bulk_array() */
+	for (i = npages - 1; i >= 0; i--)
+		__free_page(page_list[i]);
+
+	kvfree(page_list);
+}
+
 void mlx5vf_free_data_buffer(struct mlx5_vhca_data_buffer *buf)
 {
-	struct mlx5_vf_migration_file *migf = buf->migf;
-	struct sg_page_iter sg_iter;
+	struct mlx5vf_pci_core_device *mvdev = buf->migf->mvdev;
+	struct mlx5_core_dev *mdev = mvdev->mdev;
 
-	lockdep_assert_held(&migf->mvdev->state_mutex);
-	WARN_ON(migf->mvdev->mdev_detach);
+	lockdep_assert_held(&mvdev->state_mutex);
+	WARN_ON(mvdev->mdev_detach);
 
 	if (buf->mkey_in) {
-		mlx5_core_destroy_mkey(migf->mvdev->mdev, buf->mkey);
+		mlx5_core_destroy_mkey(mdev, buf->mkey);
+		unregister_dma_pages(mdev, buf->npages, buf->mkey_in,
+				     &buf->state, buf->dma_dir);
 		kvfree(buf->mkey_in);
-		dma_unmap_sgtable(migf->mvdev->mdev->device, &buf->table.sgt,
-				  buf->dma_dir, 0);
 	}
 
-	/* Undo alloc_pages_bulk_array() */
-	for_each_sgtable_page(&buf->table.sgt, &sg_iter, 0)
-		__free_page(sg_page_iter_page(&sg_iter));
-	sg_free_append_table(&buf->table);
+	free_page_list(buf->npages, buf->page_list);
 	kfree(buf);
 }
 
-static int mlx5vf_add_migration_pages(struct mlx5_vhca_data_buffer *buf,
-				      unsigned int npages)
+static int mlx5vf_add_pages(struct page ***page_list, unsigned int npages)
 {
-	unsigned int to_alloc = npages;
-	struct page **page_list;
-	unsigned long filled;
-	unsigned int to_fill;
-	int ret;
+	unsigned int filled, done = 0;
 	int i;
 
-	to_fill = min_t(unsigned int, npages, PAGE_SIZE / sizeof(*page_list));
-	page_list = kvzalloc(to_fill * sizeof(*page_list), GFP_KERNEL_ACCOUNT);
-	if (!page_list)
+	*page_list = kvcalloc(npages, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
+	if (!*page_list)
 		return -ENOMEM;
 
-	do {
-		filled = alloc_pages_bulk_array(GFP_KERNEL_ACCOUNT, to_fill,
-						page_list);
-		if (!filled) {
-			ret = -ENOMEM;
+	for (;;) {
+		filled = alloc_pages_bulk_array(GFP_KERNEL_ACCOUNT,
+						npages - done,
+						*page_list + done);
+		if (!filled)
 			goto err;
-		}
-		to_alloc -= filled;
-		ret = sg_alloc_append_table_from_pages(
-			&buf->table, page_list, filled, 0,
-			filled << PAGE_SHIFT, UINT_MAX, SG_MAX_SINGLE_ALLOC,
-			GFP_KERNEL_ACCOUNT);
 
-		if (ret)
-			goto err_append;
-		buf->npages += filled;
-		/* clean input for another bulk allocation */
-		memset(page_list, 0, filled * sizeof(*page_list));
-		to_fill = min_t(unsigned int, to_alloc,
-				PAGE_SIZE / sizeof(*page_list));
-	} while (to_alloc > 0);
+		done += filled;
+		if (done == npages)
+			break;
+	}
 
-	kvfree(page_list);
 	return 0;
 
-err_append:
-	for (i = filled - 1; i >= 0; i--)
-		__free_page(page_list[i]);
 err:
-	kvfree(page_list);
-	return ret;
+	for (i = 0; i < done; i++)
+		__free_page(*page_list[i]);
+
+	kvfree(*page_list);
+	*page_list = NULL;
+	return -ENOMEM;
 }
 
 struct mlx5_vhca_data_buffer *
@@ -487,10 +535,12 @@ mlx5vf_alloc_data_buffer(struct mlx5_vf_migration_file *migf, u32 npages,
 	buf->dma_dir = dma_dir;
 	buf->migf = migf;
 	if (npages) {
-		ret = mlx5vf_add_migration_pages(buf, npages);
+		ret = mlx5vf_add_pages(&buf->page_list, npages);
 		if (ret)
 			goto end;
 
+		buf->npages = npages;
+
 		if (dma_dir != DMA_NONE) {
 			ret = mlx5vf_dma_data_buffer(buf);
 			if (ret)
@@ -1349,101 +1399,16 @@ static void mlx5vf_destroy_qp(struct mlx5_core_dev *mdev,
 	kfree(qp);
 }
 
-static void free_recv_pages(struct mlx5_vhca_recv_buf *recv_buf)
-{
-	int i;
-
-	/* Undo alloc_pages_bulk_array() */
-	for (i = 0; i < recv_buf->npages; i++)
-		__free_page(recv_buf->page_list[i]);
-
-	kvfree(recv_buf->page_list);
-}
-
-static int alloc_recv_pages(struct mlx5_vhca_recv_buf *recv_buf,
-			    unsigned int npages)
-{
-	unsigned int filled = 0, done = 0;
-	int i;
-
-	recv_buf->page_list = kvcalloc(npages, sizeof(*recv_buf->page_list),
-				       GFP_KERNEL_ACCOUNT);
-	if (!recv_buf->page_list)
-		return -ENOMEM;
-
-	for (;;) {
-		filled = alloc_pages_bulk_array(GFP_KERNEL_ACCOUNT,
-						npages - done,
-						recv_buf->page_list + done);
-		if (!filled)
-			goto err;
-
-		done += filled;
-		if (done == npages)
-			break;
-	}
-
-	recv_buf->npages = npages;
-	return 0;
-
-err:
-	for (i = 0; i < npages; i++) {
-		if (recv_buf->page_list[i])
-			__free_page(recv_buf->page_list[i]);
-	}
-
-	kvfree(recv_buf->page_list);
-	return -ENOMEM;
-}
-static void unregister_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
-				 u32 *mkey_in)
-{
-	dma_addr_t addr;
-	__be64 *mtt;
-	int i;
-
-	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
-	for (i = npages - 1; i >= 0; i--) {
-		addr = be64_to_cpu(mtt[i]);
-		dma_unmap_single(mdev->device, addr, PAGE_SIZE,
-				DMA_FROM_DEVICE);
-	}
-}
-
-static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
-			      struct page **page_list, u32 *mkey_in)
-{
-	dma_addr_t addr;
-	__be64 *mtt;
-	int i;
-
-	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
-
-	for (i = 0; i < npages; i++) {
-		addr = dma_map_page(mdev->device, page_list[i], 0, PAGE_SIZE,
-				    DMA_FROM_DEVICE);
-		if (dma_mapping_error(mdev->device, addr))
-			goto error;
-
-		*mtt++ = cpu_to_be64(addr);
-	}
-
-	return 0;
-
-error:
-	unregister_dma_pages(mdev, i, mkey_in);
-	return -ENOMEM;
-}
-
 static void mlx5vf_free_qp_recv_resources(struct mlx5_core_dev *mdev,
 					  struct mlx5_vhca_qp *qp)
 {
 	struct mlx5_vhca_recv_buf *recv_buf = &qp->recv_buf;
 
 	mlx5_core_destroy_mkey(mdev, recv_buf->mkey);
-	unregister_dma_pages(mdev, recv_buf->npages, recv_buf->mkey_in);
+	unregister_dma_pages(mdev, recv_buf->npages, recv_buf->mkey_in,
+			     &recv_buf->state, DMA_FROM_DEVICE);
 	kvfree(recv_buf->mkey_in);
-	free_recv_pages(&qp->recv_buf);
+	free_page_list(recv_buf->npages, recv_buf->page_list);
 }
 
 static int mlx5vf_alloc_qp_recv_resources(struct mlx5_core_dev *mdev,
@@ -1454,10 +1419,12 @@ static int mlx5vf_alloc_qp_recv_resources(struct mlx5_core_dev *mdev,
 	struct mlx5_vhca_recv_buf *recv_buf = &qp->recv_buf;
 	int err;
 
-	err = alloc_recv_pages(recv_buf, npages);
-	if (err < 0)
+	err = mlx5vf_add_pages(&recv_buf->page_list, npages);
+	if (err)
 		return err;
 
+	recv_buf->npages = npages;
+
 	recv_buf->mkey_in = alloc_mkey_in(npages, pdn);
 	if (!recv_buf->mkey_in) {
 		err = -ENOMEM;
@@ -1465,24 +1432,25 @@ static int mlx5vf_alloc_qp_recv_resources(struct mlx5_core_dev *mdev,
 	}
 
 	err = register_dma_pages(mdev, npages, recv_buf->page_list,
-				 recv_buf->mkey_in);
+				 recv_buf->mkey_in, &recv_buf->state,
+				 DMA_FROM_DEVICE);
 	if (err)
 		goto err_register_dma;
 
-	err = create_mkey(mdev, npages, NULL, recv_buf->mkey_in,
-			  &recv_buf->mkey);
+	err = create_mkey(mdev, npages, recv_buf->mkey_in, &recv_buf->mkey);
 	if (err)
 		goto err_create_mkey;
 
 	return 0;
 
 err_create_mkey:
-	unregister_dma_pages(mdev, npages, recv_buf->mkey_in);
+	unregister_dma_pages(mdev, npages, recv_buf->mkey_in, &recv_buf->state,
+			     DMA_FROM_DEVICE);
 err_register_dma:
 	kvfree(recv_buf->mkey_in);
 	recv_buf->mkey_in = NULL;
 end:
-	free_recv_pages(recv_buf);
+	free_page_list(npages, recv_buf->page_list);
 	return err;
 }
 
diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index 25dd6ff54591..d7821b5ca772 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -53,7 +53,8 @@ struct mlx5_vf_migration_header {
 };
 
 struct mlx5_vhca_data_buffer {
-	struct sg_append_table table;
+	struct page **page_list;
+	struct dma_iova_state state;
 	loff_t start_pos;
 	u64 length;
 	u32 npages;
@@ -63,10 +64,6 @@ struct mlx5_vhca_data_buffer {
 	u8 stop_copy_chunk_num;
 	struct list_head buf_elm;
 	struct mlx5_vf_migration_file *migf;
-	/* Optimize mlx5vf_get_migration_page() for sequential access */
-	struct scatterlist *last_offset_sg;
-	unsigned int sg_last_entry;
-	unsigned long last_offset;
 };
 
 struct mlx5vf_async_data {
@@ -133,6 +130,7 @@ struct mlx5_vhca_cq {
 struct mlx5_vhca_recv_buf {
 	u32 npages;
 	struct page **page_list;
+	struct dma_iova_state state;
 	u32 next_rq_offset;
 	u32 *mkey_in;
 	u32 mkey;
@@ -224,8 +222,17 @@ struct mlx5_vhca_data_buffer *
 mlx5vf_get_data_buffer(struct mlx5_vf_migration_file *migf, u32 npages,
 		       enum dma_data_direction dma_dir);
 void mlx5vf_put_data_buffer(struct mlx5_vhca_data_buffer *buf);
-struct page *mlx5vf_get_migration_page(struct mlx5_vhca_data_buffer *buf,
-				       unsigned long offset);
+static inline struct page *
+mlx5vf_get_migration_page(struct mlx5_vhca_data_buffer *buf,
+			  unsigned long offset)
+{
+	int page_entry = offset / PAGE_SIZE;
+
+	if (page_entry >= buf->npages)
+		return NULL;
+
+	return buf->page_list[page_entry];
+}
 void mlx5vf_state_mutex_unlock(struct mlx5vf_pci_core_device *mvdev);
 void mlx5vf_disable_fds(struct mlx5vf_pci_core_device *mvdev,
 			enum mlx5_vf_migf_state *last_save_state);
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index 83247f016441..c528932e5739 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -34,37 +34,6 @@ static struct mlx5vf_pci_core_device *mlx5vf_drvdata(struct pci_dev *pdev)
 			    core_device);
 }
 
-struct page *
-mlx5vf_get_migration_page(struct mlx5_vhca_data_buffer *buf,
-			  unsigned long offset)
-{
-	unsigned long cur_offset = 0;
-	struct scatterlist *sg;
-	unsigned int i;
-
-	/* All accesses are sequential */
-	if (offset < buf->last_offset || !buf->last_offset_sg) {
-		buf->last_offset = 0;
-		buf->last_offset_sg = buf->table.sgt.sgl;
-		buf->sg_last_entry = 0;
-	}
-
-	cur_offset = buf->last_offset;
-
-	for_each_sg(buf->last_offset_sg, sg,
-			buf->table.sgt.orig_nents - buf->sg_last_entry, i) {
-		if (offset < sg->length + cur_offset) {
-			buf->last_offset_sg = sg;
-			buf->sg_last_entry += i;
-			buf->last_offset = cur_offset;
-			return nth_page(sg_page(sg),
-					(offset - cur_offset) / PAGE_SIZE);
-		}
-		cur_offset += sg->length;
-	}
-	return NULL;
-}
-
 static void mlx5vf_disable_fd(struct mlx5_vf_migration_file *migf)
 {
 	mutex_lock(&migf->lock);
-- 
2.47.0


