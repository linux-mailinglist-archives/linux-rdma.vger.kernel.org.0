Return-Path: <linux-rdma+bounces-17179-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIIeOlgGn2neYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17179-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:25:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9958198AE6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E4F830FD340
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774F3D412A;
	Wed, 25 Feb 2026 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDg3ADMo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284373B961D;
	Wed, 25 Feb 2026 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029202; cv=none; b=Y5J1UOMT92kZ5hFjr1HJmfndyGM/xy7nzxICeGNmrLhUzFq5usBaeHUigES16bmPuCC2YpDqFuUY9IgbWQ7OJkaFK6hIGFmgEbjM4uR/GPUeH9zf+3IzC5SqVSU5KjHE842Qac4ah4R5zvjkyoKHVLM6C0w2/ayonouJmaUOxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029202; c=relaxed/simple;
	bh=oz+j+A+rE2XswhiJBlj63eWf/P56b9Co0UAl2knfd6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHm+l5Ey/4/vg/zg38phW6DAJt394fNEyoJr7fVjpzJJXqGK3asBULK5JykkH+jsfiTELR+eIq0gqiOW9y/uE13YReEk1dGjqV7So/9kiqrF6COJMqYrGqa+hX3R6Wg/i2OFa7km6pPiXSaGExqE6himSsbdBTVBxrW/5wtFYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDg3ADMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D40C116D0;
	Wed, 25 Feb 2026 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772029201;
	bh=oz+j+A+rE2XswhiJBlj63eWf/P56b9Co0UAl2knfd6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UDg3ADMo0Rfs+pyTBPF5xEda7wOWBknOgKyz5CqT2Wd2oGdwAXryOgrH0dkR8pXXJ
	 l6u+GsZxBnmmRU3UY4s6tUFTeq4pN7scLWWA75Y0pwqPvdhDUFxXJGho2FGl5vpJ8t
	 3dkWTbS8XMJgEmGfu9qeR2Rxf0oBh0avQkAwtml3IjZbmwPpEeNEvV/VXkeLSo1Dq+
	 PtQ3nptlSsiwjMj57I9Zt5JKN/5cceN316ZHAvddluGj2tC8PZV2AE5Xwxh6HEOsOx
	 y4Hl2nFQw0l6EYWxsc/xuw0JiwKPvP03xk9XNI2R1+e8NNcEsvg9TWNBQg/eDYaXDr
	 EABu+QlMydPoA==
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
Subject: [PATCH rdma-next 4/6] RDMA/mlx5: Add TLP VAR region support and infrastructure
Date: Wed, 25 Feb 2026 16:19:34 +0200
Message-ID: <20260225-var-tlp-v1-4-fe14a7ac7731@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17179-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9958198AE6
X-Rspamd-Action: no action

From: Maher Sanalla <msanalla@nvidia.com>

Add support for TLP (Transaction Layer Packet) VAR regions used by
software-defined device emulation. TLP VAR provides dedicated response
gateways for sending TLP responses back to the host in TLP emulation
scenarios.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 57 ++++++++++++++++++++++++++++++++----
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 835fe2a95ad6..424426a2cd76 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2518,6 +2518,15 @@ mlx5_ib_pgoff_to_mmap_entry(struct ib_ucontext *ucontext, off_t pg_off)
 	return rdma_user_mmap_entry_get_pgoff(ucontext, entry_pgoff);
 }
 
+static void mlx5_ib_free_var_mmap_entry(struct mlx5_user_mmap_entry *mentry,
+					struct mlx5_var_region *var_region)
+{
+	mutex_lock(&var_region->bitmap_lock);
+	clear_bit(mentry->page_idx, var_region->bitmap);
+	mutex_unlock(&var_region->bitmap_lock);
+	kfree(mentry);
+}
+
 static void mlx5_ib_mmap_free(struct rdma_user_mmap_entry *entry)
 {
 	struct mlx5_user_mmap_entry *mentry = to_mmmap(entry);
@@ -2533,10 +2542,11 @@ static void mlx5_ib_mmap_free(struct rdma_user_mmap_entry *entry)
 		break;
 	case MLX5_IB_MMAP_TYPE_VAR:
 		var_region = &var_table->var_region;
-		mutex_lock(&var_region->bitmap_lock);
-		clear_bit(mentry->page_idx, var_region->bitmap);
-		mutex_unlock(&var_region->bitmap_lock);
-		kfree(mentry);
+		mlx5_ib_free_var_mmap_entry(mentry, var_region);
+		break;
+	case MLX5_IB_MMAP_TYPE_TLP_VAR:
+		var_region = &var_table->tlp_var_region;
+		mlx5_ib_free_var_mmap_entry(mentry, var_region);
 		break;
 	case MLX5_IB_MMAP_TYPE_UAR_WC:
 	case MLX5_IB_MMAP_TYPE_UAR_NC:
@@ -2687,6 +2697,7 @@ static int mlx5_ib_mmap_offset(struct mlx5_ib_dev *dev,
 	mentry = to_mmmap(entry);
 	pfn = (mentry->address >> PAGE_SHIFT);
 	if (mentry->mmap_flag == MLX5_IB_MMAP_TYPE_VAR ||
+	    mentry->mmap_flag == MLX5_IB_MMAP_TYPE_TLP_VAR ||
 	    mentry->mmap_flag == MLX5_IB_MMAP_TYPE_UAR_NC)
 		prot = pgprot_noncached(vma->vm_page_prot);
 	else
@@ -4636,6 +4647,28 @@ static int mlx5_ib_init_var_region(struct mlx5_ib_dev *dev)
 	return (var_region->bitmap) ? 0 : -ENOMEM;
 }
 
+static int mlx5_ib_init_tlp_var_region(struct mlx5_ib_dev *dev)
+{
+	struct mlx5_var_region *var_region = &dev->var_table.tlp_var_region;
+	struct mlx5_core_dev *mdev = dev->mdev;
+	u8 log_tlp_var_stride;
+
+	log_tlp_var_stride =
+		MLX5_CAP_DEV_TLP_EMULATION(mdev, log_tlp_rsp_gw_page_stride);
+	var_region->hw_start_addr =
+		dev->mdev->bar_addr +
+		MLX5_CAP64_DEV_TLP_EMULATION(mdev, tlp_rsp_gw_pages_bar_offset);
+
+	var_region->stride_size = (1ULL << log_tlp_var_stride) * 4096;
+	var_region->num_var_hw_entries =
+		MLX5_CAP_DEV_TLP_EMULATION(mdev, tlp_rsp_gw_num_pages);
+
+	mutex_init(&var_region->bitmap_lock);
+	var_region->bitmap = bitmap_zalloc(var_region->num_var_hw_entries,
+					   GFP_KERNEL);
+	return (var_region->bitmap) ? 0 : -ENOMEM;
+}
+
 static void mlx5_ib_cleanup_ucaps(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RDMA_CTRL)
@@ -4671,13 +4704,19 @@ static int mlx5_ib_init_ucaps(struct mlx5_ib_dev *dev)
 	return ret;
 }
 
+static void mlx5_ib_cleanup_var_table(struct mlx5_ib_dev *dev)
+{
+	bitmap_free(dev->var_table.var_region.bitmap);
+	bitmap_free(dev->var_table.tlp_var_region.bitmap);
+}
+
 static void mlx5_ib_stage_caps_cleanup(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN_2_64(dev->mdev, general_obj_types_127_64) &
 	    MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_RDMA_CTRL)
 		mlx5_ib_cleanup_ucaps(dev);
 
-	bitmap_free(dev->var_table.var_region.bitmap);
+	mlx5_ib_cleanup_var_table(dev);
 }
 
 static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
@@ -4737,10 +4776,18 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 			goto err_ucaps;
 	}
 
+	if (MLX5_CAP_GEN(dev->mdev, tlp_device_emulation_manager)) {
+		err = mlx5_ib_init_tlp_var_region(dev);
+		if (err)
+			goto err_tlp_var;
+	}
+
 	dev->ib_dev.use_cq_dim = true;
 
 	return 0;
 
+err_tlp_var:
+	mlx5_ib_cleanup_ucaps(dev);
 err_ucaps:
 	bitmap_free(dev->var_table.var_region.bitmap);
 	return err;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 3d0ae52c68a7..5f789291be93 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -162,6 +162,7 @@ enum mlx5_ib_mmap_type {
 	MLX5_IB_MMAP_TYPE_UAR_WC = 3,
 	MLX5_IB_MMAP_TYPE_UAR_NC = 4,
 	MLX5_IB_MMAP_TYPE_MEMIC_OP = 5,
+	MLX5_IB_MMAP_TYPE_TLP_VAR = 6,
 };
 
 struct mlx5_bfreg_info {
@@ -1143,6 +1144,7 @@ struct mlx5_var_region {
 
 struct mlx5_var_table {
 	struct mlx5_var_region var_region;
+	struct mlx5_var_region tlp_var_region;
 };
 
 struct mlx5_port_caps {

-- 
2.53.0


