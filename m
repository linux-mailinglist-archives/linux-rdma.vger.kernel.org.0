Return-Path: <linux-rdma+bounces-12077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C4BB02EF0
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 08:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1201697FE
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDFF1C3306;
	Sun, 13 Jul 2025 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL1OD/J4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469327263D;
	Sun, 13 Jul 2025 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752388666; cv=none; b=iZRJQ5um4Wejj+dBEVlUpzZDBoUgyzcguGoWLtCLg0zbKS782jujj5rO3/RO3STcJI18XlAX7ghPEAvP0exS69jd+k4TPim+2eKHqKa0pD2eovuShWX2qBZYxDZI/YgdRKONFzQ7kR5PlI7FUDgLgD1HFfUVXwR14unsFZO5B1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752388666; c=relaxed/simple;
	bh=SlBER5Y83DvoQ6b88MC+akcik8+qzVR+nkYlXnf8aAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDb0zpAVapWUCegSNowjRAOSKn2N9GdidjI/Cpl4Lp3QF9ay/YTFy6bEwuBtQIICXdi+VAZ/1sv8d4LitYXc1C07NIOmKY8PrldgdmeNXPCFDwzXP7+7ogvW27SS4jetMc8TeSHlKT4NDZQDeXIGpISGO7toDlYsRrNB+eMeGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL1OD/J4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D0FC4CEE3;
	Sun, 13 Jul 2025 06:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752388666;
	bh=SlBER5Y83DvoQ6b88MC+akcik8+qzVR+nkYlXnf8aAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jL1OD/J43FjdTCMPt1bQWwkrKnJu5dZ28QD/fkfDVYfh4aYlLdjLekNLIIIffiALr
	 i7QGeI1CULuuux/SbF8Ct9mG7DWuzy6Vxu9cTjKGYYgS5Hz6GvEOTFm/t0LKmCLVyE
	 7UsQzWbVHCbb4ohnFNOBO1rLOiMz0WnCF1Gmmb0ebCDGcG7WpNAw9ppYz9M4Yg55kA
	 Q5KoK7zPYFvSzWlFZEegjZ0cYbweEAvQJzwgicQ1UOiyb2wgGzewT+ifC0egp9UrNO
	 j5sWX7BnOjuzajZ6nQ6WhIXoCDWgXoK1rBh1WHwcTTPPC856+Brb08aeFPN3ZUYl+z
	 /3Wh1oOUkhpCQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next v1 2/8] net/mlx5: Expose IFC bits for TPH
Date: Sun, 13 Jul 2025 09:37:23 +0300
Message-ID: <10888bd6303ae05391328c8c1a52be181edee8ac.1752388126.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752388126.git.leon@kernel.org>
References: <cover.1752388126.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Expose IFC bits for the TPH functionality.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 0e93f342be09..5bb124b8024c 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1859,7 +1859,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_280[0x10];
 	u8         max_wqe_sz_sq[0x10];
 
-	u8         reserved_at_2a0[0xb];
+	u8         reserved_at_2a0[0x7];
+	u8         mkey_pcie_tph[0x1];
+	u8         reserved_at_2a8[0x3];
 	u8         shampo[0x1];
 	u8         reserved_at_2ac[0x4];
 	u8         max_wqe_sz_rq[0x10];
@@ -4404,6 +4406,10 @@ enum {
 	MLX5_MKC_ACCESS_MODE_CROSSING = 0x6,
 };
 
+enum {
+	MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX = 0,
+};
+
 struct mlx5_ifc_mkc_bits {
 	u8         reserved_at_0[0x1];
 	u8         free[0x1];
@@ -4455,7 +4461,11 @@ struct mlx5_ifc_mkc_bits {
 	u8         relaxed_ordering_read[0x1];
 	u8         log_page_size[0x6];
 
-	u8         reserved_at_1e0[0x20];
+	u8         reserved_at_1e0[0x5];
+	u8         pcie_tph_en[0x1];
+	u8         pcie_tph_ph[0x2];
+	u8         pcie_tph_steering_tag_index[0x8];
+	u8         reserved_at_1f0[0x10];
 };
 
 struct mlx5_ifc_pkey_bits {
-- 
2.50.1


