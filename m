Return-Path: <linux-rdma+bounces-10001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9421CAAA66C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 02:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5162A18804F1
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 00:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC872326C05;
	Mon,  5 May 2025 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1a4Rq3G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102B326BF7;
	Mon,  5 May 2025 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484479; cv=none; b=mS/aWyeIqFOMaGFfp61B5whraI6zmp3jf0WgGQsJJri5cIMfEmytIQ9ZzYcVJBzwZUi30hj8k0mMmlsu3eJhnq9MOfaJ4Q+PYWJo3ckVTHWSklcA+jgx2plWYVOWEf4wWtn+TlAkcLCo8P65mfjLZtoqVgolNuIMnyAU2I/zflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484479; c=relaxed/simple;
	bh=qFlBWwhRpPj7uc9mofxCqmu+dvqPifl7yz3DhSEqHyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFnTGvpRq10XoXoKDF7Qxn9YJyrD+oLTqW68BxmNTYZ5zAmJTI34iH5RJGu2mKUtWolXViB2J9C6rGsYNl3C6osyAmqFYfbuub7uOIGtqOBlOp19YMM7n1bUUMhPLFJmKq4MFVHNoYEUNbHv718pJ0iHwGuXxy5Tq4qG3Hum+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1a4Rq3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7852AC4CEE4;
	Mon,  5 May 2025 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484479;
	bh=qFlBWwhRpPj7uc9mofxCqmu+dvqPifl7yz3DhSEqHyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1a4Rq3G0+UYsuaZmA9fmebDckCEVE8ykZ1tRfL8hlM8mgWkDQNlCoRGqER3BnpPo
	 5+s0nTLRvPFMRIGgqUAbbfRRMJYXbDZkKvkncFw0lRyx8XzOb2Q5CA0QdEqoNmrIqS
	 bCQ50Cfv0Pvit695SgRKq/TT6hkdKyf5v0EcIz1/17Qubfh6F7EgQvfQLYylEJ882S
	 2fzEc76zN8bJmisHtxPft42IEIpQ+pXbi6C4MkRfngUzGI1ghPfnnFD6LehZNzgo2G
	 kfd7r/q8gCFrNk0v0SPLybu9XHWjNJdACQ+9S27hjHERGL8eyLRSrGV32QJgz84ur7
	 y9Dk32wifBjlQ==
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
	lkayal@nvidia.com,
	yorayz@nvidia.com,
	alazar@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 490/642] net/mlx5e: reduce the max log mpwrq sz for ECPF and reps
Date: Mon,  5 May 2025 18:11:46 -0400
Message-Id: <20250505221419.2672473-490-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 8f9ec48ecc06d..769e683f24883 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -95,8 +95,6 @@ struct page_pool;
 #define MLX5_MPWRQ_DEF_LOG_STRIDE_SZ(mdev) \
 	MLX5_MPWRQ_LOG_STRIDE_SZ(mdev, order_base_2(MLX5E_RX_MAX_HEAD))
 
-#define MLX5_MPWRQ_MAX_LOG_WQE_SZ 18
-
 /* Keep in sync with mlx5e_mpwrq_log_wqe_sz.
  * These are theoretical maximums, which can be further restricted by
  * capabilities. These values are used for static resource allocations and
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 8c4d710e85675..58ec5e44aa7ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -10,6 +10,9 @@
 #include <net/page_pool/types.h>
 #include <net/xdp_sock_drv.h>
 
+#define MLX5_MPWRQ_MAX_LOG_WQE_SZ 18
+#define MLX5_REP_MPWRQ_MAX_LOG_WQE_SZ 17
+
 static u8 mlx5e_mpwrq_min_page_shift(struct mlx5_core_dev *mdev)
 {
 	u8 min_page_shift = MLX5_CAP_GEN_2(mdev, log_min_mkey_entity_size);
@@ -103,18 +106,22 @@ u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
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


