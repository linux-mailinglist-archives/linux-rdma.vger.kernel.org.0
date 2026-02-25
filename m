Return-Path: <linux-rdma+bounces-17176-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCJUIboFn2mZYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17176-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:22:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45262198A59
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AF9D30A00AE
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25DA3D3491;
	Wed, 25 Feb 2026 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YROCJD7a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46E3194C96;
	Wed, 25 Feb 2026 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029192; cv=none; b=d3/m/ykXf0Eqy+agPfYLkWVLnHpmA7j49jCHwjYECWoCK0y+PEslKb3WKKJhYcxc07syxPgGuzg4OilNBDpoRrJg6IdDVykxLw0lOgtJ7AC32wvzP6stqZ9nbpu0F7qdkINuxf3W7Ov+140whKcLuKRu3gR2bi29SxWZaJ60MrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029192; c=relaxed/simple;
	bh=oCHXWqbGbkbUkAeuFWoJ2UsgSUH4bWiDsWHTPRNOBYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tv0jFK6YFdC0BpmePNOaiXRkBYeaw293cxc/DYsKU3pBm55Jql9/ahkn/h8vm0Iab+oluJm6asf19wGANW/V90QIF6EVx08+KOQevJ0Qo3tFf8RDO9G8g5+L0qpZW0jt3CYcCaDDn9W0RMw5/VlS7o00tmCbq3KxAaiq3Iua55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YROCJD7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00942C19421;
	Wed, 25 Feb 2026 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772029192;
	bh=oCHXWqbGbkbUkAeuFWoJ2UsgSUH4bWiDsWHTPRNOBYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YROCJD7anBwanDxoHs3wcZNaK5Gbv81M3l1OBpBSjkm36GeI1q5i4gOkpVDMR6K/L
	 WZEUMKvRVHcA/VU7gL3KwBgjYT+7+j25TylZSXNhehFPY4LjAVe2c619dA9CBFpgg0
	 Ga7/sz22fjB48Gf0STnRwfhzb2o2t3G304kZll/vYNyNocYtoat2UvptpN8HdD9YXd
	 ilL0gz/cci/OxciHthoGhWikmh0S4zyL0pSdnmwfbkytIv2IdTYKLDZ1jh54QljDt8
	 PUcaqaL/PT2ctri1Nhp24qwfbiRvBNybNl0Xr/pt8mnMK0el/9SBegCOUnfe/SSkS6
	 wUceiouDHAQEw==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next 3/6] RDMA/mlx5: Refactor VAR table to use region abstraction
Date: Wed, 25 Feb 2026 16:19:33 +0200
Message-ID: <20260225-var-tlp-v1-3-fe14a7ac7731@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
References: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17176-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45262198A59
X-Rspamd-Action: no action

From: Maher Sanalla <msanalla@nvidia.com>

Extract mlx5_var_region struct from mlx5_var_table to enable
supporting multiple VAR regions in VAR table, which will be used in
the upcoming patches (Virtio emulation VAR and TLP emulation VAR).

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 62 +++++++++++++++++++-----------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 +++-
 2 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 26ee8e763d5e..835fe2a95ad6 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2524,6 +2524,7 @@ static void mlx5_ib_mmap_free(struct rdma_user_mmap_entry *entry)
 	struct mlx5_ib_dev *dev = to_mdev(entry->ucontext->device);
 	struct mlx5_var_table *var_table = &dev->var_table;
 	struct mlx5_ib_ucontext *context = to_mucontext(entry->ucontext);
+	struct mlx5_var_region *var_region;
 
 	switch (mentry->mmap_flag) {
 	case MLX5_IB_MMAP_TYPE_MEMIC:
@@ -2531,9 +2532,10 @@ static void mlx5_ib_mmap_free(struct rdma_user_mmap_entry *entry)
 		mlx5_ib_dm_mmap_free(dev, mentry);
 		break;
 	case MLX5_IB_MMAP_TYPE_VAR:
-		mutex_lock(&var_table->bitmap_lock);
-		clear_bit(mentry->page_idx, var_table->bitmap);
-		mutex_unlock(&var_table->bitmap_lock);
+		var_region = &var_table->var_region;
+		mutex_lock(&var_region->bitmap_lock);
+		clear_bit(mentry->page_idx, var_region->bitmap);
+		mutex_unlock(&var_region->bitmap_lock);
 		kfree(mentry);
 		break;
 	case MLX5_IB_MMAP_TYPE_UAR_WC:
@@ -4143,43 +4145,45 @@ static struct mlx5_user_mmap_entry *
 alloc_var_entry(struct mlx5_ib_ucontext *c)
 {
 	struct mlx5_user_mmap_entry *entry;
+	struct mlx5_var_region *var_region;
 	struct mlx5_var_table *var_table;
 	u32 page_idx;
 	int err;
 
 	var_table = &to_mdev(c->ibucontext.device)->var_table;
+	var_region = &var_table->var_region;
 	entry = kzalloc_obj(*entry);
 	if (!entry)
 		return ERR_PTR(-ENOMEM);
 
-	mutex_lock(&var_table->bitmap_lock);
-	page_idx = find_first_zero_bit(var_table->bitmap,
-				       var_table->num_var_hw_entries);
-	if (page_idx >= var_table->num_var_hw_entries) {
+	mutex_lock(&var_region->bitmap_lock);
+	page_idx = find_first_zero_bit(var_region->bitmap,
+				       var_region->num_var_hw_entries);
+	if (page_idx >= var_region->num_var_hw_entries) {
 		err = -ENOSPC;
-		mutex_unlock(&var_table->bitmap_lock);
+		mutex_unlock(&var_region->bitmap_lock);
 		goto end;
 	}
 
-	set_bit(page_idx, var_table->bitmap);
-	mutex_unlock(&var_table->bitmap_lock);
+	set_bit(page_idx, var_region->bitmap);
+	mutex_unlock(&var_region->bitmap_lock);
 
-	entry->address = var_table->hw_start_addr +
-				(page_idx * var_table->stride_size);
+	entry->address = var_region->hw_start_addr +
+				(page_idx * var_region->stride_size);
 	entry->page_idx = page_idx;
 	entry->mmap_flag = MLX5_IB_MMAP_TYPE_VAR;
 
 	err = mlx5_rdma_user_mmap_entry_insert(c, entry,
-					       var_table->stride_size);
+					       var_region->stride_size);
 	if (err)
 		goto err_insert;
 
 	return entry;
 
 err_insert:
-	mutex_lock(&var_table->bitmap_lock);
-	clear_bit(page_idx, var_table->bitmap);
-	mutex_unlock(&var_table->bitmap_lock);
+	mutex_lock(&var_region->bitmap_lock);
+	clear_bit(page_idx, var_region->bitmap);
+	mutex_unlock(&var_region->bitmap_lock);
 end:
 	kfree(entry);
 	return ERR_PTR(err);
@@ -4607,10 +4611,10 @@ static const struct ib_device_ops mlx5_ib_dev_xrc_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_xrcd, mlx5_ib_xrcd, ibxrcd),
 };
 
-static int mlx5_ib_init_var_table(struct mlx5_ib_dev *dev)
+static int mlx5_ib_init_var_region(struct mlx5_ib_dev *dev)
 {
+	struct mlx5_var_region *var_region = &dev->var_table.var_region;
 	struct mlx5_core_dev *mdev = dev->mdev;
-	struct mlx5_var_table *var_table = &dev->var_table;
 	u8 log_doorbell_bar_size;
 	u8 log_doorbell_stride;
 	u64 bar_size;
@@ -4619,17 +4623,17 @@ static int mlx5_ib_init_var_table(struct mlx5_ib_dev *dev)
 					log_doorbell_bar_size);
 	log_doorbell_stride = MLX5_CAP_DEV_VDPA_EMULATION(mdev,
 					log_doorbell_stride);
-	var_table->hw_start_addr = dev->mdev->bar_addr +
+	var_region->hw_start_addr = dev->mdev->bar_addr +
 				MLX5_CAP64_DEV_VDPA_EMULATION(mdev,
 					doorbell_bar_offset);
 	bar_size = (1ULL << log_doorbell_bar_size) * 4096;
-	var_table->stride_size = 1ULL << log_doorbell_stride;
-	var_table->num_var_hw_entries = div_u64(bar_size,
-						var_table->stride_size);
-	mutex_init(&var_table->bitmap_lock);
-	var_table->bitmap = bitmap_zalloc(var_table->num_var_hw_entries,
-					  GFP_KERNEL);
-	return (var_table->bitmap) ? 0 : -ENOMEM;
+	var_region->stride_size = 1ULL << log_doorbell_stride;
+	var_region->num_var_hw_entries = div_u64(bar_size,
+						 var_region->stride_size);
+	mutex_init(&var_region->bitmap_lock);
+	var_region->bitmap = bitmap_zalloc(var_region->num_var_hw_entries,
+					   GFP_KERNEL);
+	return (var_region->bitmap) ? 0 : -ENOMEM;
 }
 
 static void mlx5_ib_cleanup_ucaps(struct mlx5_ib_dev *dev)
@@ -4673,7 +4677,7 @@ static void mlx5_ib_stage_caps_cleanup(struct mlx5_ib_dev *dev)
 	    MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_RDMA_CTRL)
 		mlx5_ib_cleanup_ucaps(dev);
 
-	bitmap_free(dev->var_table.bitmap);
+	bitmap_free(dev->var_table.var_region.bitmap);
 }
 
 static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
@@ -4721,7 +4725,7 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 
 	if (MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
 			MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q) {
-		err = mlx5_ib_init_var_table(dev);
+		err = mlx5_ib_init_var_region(dev);
 		if (err)
 			return err;
 	}
@@ -4738,7 +4742,7 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	return 0;
 
 err_ucaps:
-	bitmap_free(dev->var_table.bitmap);
+	bitmap_free(dev->var_table.var_region.bitmap);
 	return err;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2556e326afde..3d0ae52c68a7 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1132,7 +1132,7 @@ struct mlx5_devx_event_table {
 	struct xarray event_xa;
 };
 
-struct mlx5_var_table {
+struct mlx5_var_region {
 	/* serialize updating the bitmap */
 	struct mutex bitmap_lock;
 	unsigned long *bitmap;
@@ -1141,6 +1141,10 @@ struct mlx5_var_table {
 	u64 num_var_hw_entries;
 };
 
+struct mlx5_var_table {
+	struct mlx5_var_region var_region;
+};
+
 struct mlx5_port_caps {
 	bool has_smi;
 	u8 ext_port_cap;

-- 
2.53.0


