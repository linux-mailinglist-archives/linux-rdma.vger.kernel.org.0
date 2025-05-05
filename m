Return-Path: <linux-rdma+bounces-10015-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56917AAAB2D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 03:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25168164DE7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 01:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3AE3AF3F4;
	Mon,  5 May 2025 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhqoXajX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54BD220F2F;
	Mon,  5 May 2025 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486279; cv=none; b=El060thhoNCd8UgT6CM8z9J1UrjpXS1ZW3UFS+1Qt9KZkC0XraqXCoWYWA6qHfmmwYX6Iv7EQs3hocf9miL1b70CRL6DETL+rMWugkV7JaBPG9J6OJ7K0Keo0ln2E+xuRLLmpgdjlRC+5yyaZVh42rFudDtdLcPRmZ+BlKOx+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486279; c=relaxed/simple;
	bh=+bflkCaRV6hCYkujcfKwjSzQLMTf+YrvxtQ0H0gwMEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvI0j7Vi8RcIB2WJvW6GTdWN6FqivIlvxgPVQQvi5YwVB0Xp05bQhJH+DY7G8yKIZtKhKKQeX9qtWxmzOp5fuxCDKHqJgDZHyXYlKmKq4LeDVcrnBF1/MqGR+fAbeYZId4Pm1Fp1oCMopnp1hxUqtWaH9wkCgMnYexBfEoyZYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhqoXajX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9B9C4CEE4;
	Mon,  5 May 2025 23:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486277;
	bh=+bflkCaRV6hCYkujcfKwjSzQLMTf+YrvxtQ0H0gwMEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhqoXajXQcJgMne/5bT0o8CM8IhK2JcDbaApbsFlKpL+qz7rkOYx6lG0cyBHXm80o
	 GSmJMt59cf56cxr7LEQCQle+/IqqLqfQ3aPdVwyutNHxsgV6G+Ad/kOuIJ1sm5xyB2
	 867980QEGXPBcldgy6b/YaTvRh0oJMN6Co2nNbXFJnjFElTysyGsT5JkNwi01b10gi
	 xGcB0Nt/A7M++8ue4pQ2nlHU1s9mHKCx/d7OUvoG/InBWS6aVCoMXeOjk4vDxMk123
	 kedypSvlAUPFWGIkE3vOhkHFDlDlCrcUSBYkZAWGZvnYaZZRDQ0wrrGycIeHEXUpyA
	 RnLbEOjh/dHIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Tu <witu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dtatulea@nvidia.com,
	alazar@nvidia.com,
	lkayal@nvidia.com,
	yorayz@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 235/294] net/mlx5e: reduce the max log mpwrq sz for ECPF and reps
Date: Mon,  5 May 2025 18:55:35 -0400
Message-Id: <20250505225634.2688578-235-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: William Tu <witu@nvidia.com>

[ Upstream commit e1d68ea58c7e9ebacd9ad7a99b25a3578fa62182 ]

For the ECPF and representors, reduce the max MPWRQ size from 256KB (18)
to 128KB (17). This prepares the later patch for saving representor
memory.

With Striding RQ, there is a minimum of 4 MPWQEs. So with 128KB of max
MPWRQ size, the minimal memory is 4 * 128KB = 512KB. When creating page
pool, consider 1500 mtu, the minimal page pool size will be 512KB/4KB =
128 pages = 256 rx ring entries (2 entries per page).

Before this patch, setting RX ringsize (ethtool -G rx) to 256 causes
driver to allocate page pool size more than it needs due to max MPWRQ
is 256KB (18). Ex: 4 * 256KB = 1MB, 1MB/4KB = 256 pages, but actually
128 pages is good enough. Reducing the max MPWRQ to 128KB fixes the
limitation.

Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/20250209101716.112774-7-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  2 --
 .../net/ethernet/mellanox/mlx5/core/en/params.c   | 15 +++++++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 20a6bc1a234f4..9cf33ae48c216 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -93,8 +93,6 @@ struct page_pool;
 #define MLX5_MPWRQ_DEF_LOG_STRIDE_SZ(mdev) \
 	MLX5_MPWRQ_LOG_STRIDE_SZ(mdev, order_base_2(MLX5E_RX_MAX_HEAD))
 
-#define MLX5_MPWRQ_MAX_LOG_WQE_SZ 18
-
 /* Keep in sync with mlx5e_mpwrq_log_wqe_sz.
  * These are theoretical maximums, which can be further restricted by
  * capabilities. These values are used for static resource allocations and
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 775010e94cb7c..dcd5db907f102 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -9,6 +9,9 @@
 #include <net/page_pool/types.h>
 #include <net/xdp_sock_drv.h>
 
+#define MLX5_MPWRQ_MAX_LOG_WQE_SZ 18
+#define MLX5_REP_MPWRQ_MAX_LOG_WQE_SZ 17
+
 static u8 mlx5e_mpwrq_min_page_shift(struct mlx5_core_dev *mdev)
 {
 	u8 min_page_shift = MLX5_CAP_GEN_2(mdev, log_min_mkey_entity_size);
@@ -102,18 +105,22 @@ u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
 			  enum mlx5e_mpwrq_umr_mode umr_mode)
 {
 	u8 umr_entry_size = mlx5e_mpwrq_umr_entry_size(umr_mode);
-	u8 max_pages_per_wqe, max_log_mpwqe_size;
+	u8 max_pages_per_wqe, max_log_wqe_size_calc;
+	u8 max_log_wqe_size_cap;
 	u16 max_wqe_size;
 
 	/* Keep in sync with MLX5_MPWRQ_MAX_PAGES_PER_WQE. */
 	max_wqe_size = mlx5e_get_max_sq_aligned_wqebbs(mdev) * MLX5_SEND_WQE_BB;
 	max_pages_per_wqe = ALIGN_DOWN(max_wqe_size - sizeof(struct mlx5e_umr_wqe),
 				       MLX5_UMR_FLEX_ALIGNMENT) / umr_entry_size;
-	max_log_mpwqe_size = ilog2(max_pages_per_wqe) + page_shift;
+	max_log_wqe_size_calc = ilog2(max_pages_per_wqe) + page_shift;
+
+	WARN_ON_ONCE(max_log_wqe_size_calc < MLX5E_ORDER2_MAX_PACKET_MTU);
 
-	WARN_ON_ONCE(max_log_mpwqe_size < MLX5E_ORDER2_MAX_PACKET_MTU);
+	max_log_wqe_size_cap = mlx5_core_is_ecpf(mdev) ?
+			   MLX5_REP_MPWRQ_MAX_LOG_WQE_SZ : MLX5_MPWRQ_MAX_LOG_WQE_SZ;
 
-	return min_t(u8, max_log_mpwqe_size, MLX5_MPWRQ_MAX_LOG_WQE_SZ);
+	return min_t(u8, max_log_wqe_size_calc, max_log_wqe_size_cap);
 }
 
 u8 mlx5e_mpwrq_pages_per_wqe(struct mlx5_core_dev *mdev, u8 page_shift,
-- 
2.39.5


