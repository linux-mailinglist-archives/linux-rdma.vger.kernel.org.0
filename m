Return-Path: <linux-rdma+bounces-14044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8DC09A91
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 18:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57966426181
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C143161A8;
	Sat, 25 Oct 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwDCYCvg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624A307ADE;
	Sat, 25 Oct 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409494; cv=none; b=OK/TIzZVRS1+hbIqSc07n2iiTrFOzy8poso8wlrzu8gRCBnIcwihcS15kjGmPXdMAD6EThWSmIxfvdN8HBvsW8F/i8cGcbKjx/M1NpmFQ3ZKS7gwEG2+17mmN8pTTNz1AGSt/aVdoQN/VHtOYSBt7d+NjsApfKTohXblPH1MYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409494; c=relaxed/simple;
	bh=5Fqf7xQRGNgf3w0BjFQApDqbIP/VnlQhBrWVmtZ/ANs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQdi5fX18FtYV3m7Kte5fxK4ELIPckzdoBcgt/PBXJESnFww9pbieL19Ai95VtBqvwIhpN0irLwRUU9tThWCcetJUUAANOPKcP1YdpjsGTpiInax98j2RZcFKdL5463mf6JX1W/20qIo3ZHZyImw9ISu18zKAeKBvrO5g4EswaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwDCYCvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626D3C4CEFF;
	Sat, 25 Oct 2025 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409493;
	bh=5Fqf7xQRGNgf3w0BjFQApDqbIP/VnlQhBrWVmtZ/ANs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwDCYCvg38xnQuVolbnwuj7LZH8/nb+NAocIf7jDE3b85RSwHzwH4w9hGIgAMewP0
	 uDUkwU9hJrHqx4SXepf7jkMRKnhuJZmELyiZ8Lvm56/0y53LlPhtlGKzrEGCd3Du1e
	 wRGbE9QoSgkE1pZkr/DwBJP31WIXTgvjYxyxS4HdB3IpImXTFWSyT1fRUyROLJi2Xh
	 Au05QIyDbJQ+kYs202YHEb152bo50sn0Qq7qzMs7aDnzzJk19sHeM7mD2Je8sqlCRH
	 +Dbv4z0wex8d8ejOLOVSfKAqNw52O0zd6OOLddglmFW0JbNE7dctGBJXnVXUpg21n7
	 UZlYTs8nedcIA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Carolina Jubran <cjubran@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Yael Chemla <ychemla@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] net/mlx5e: Don't query FEC statistics when FEC is disabled
Date: Sat, 25 Oct 2025 11:59:41 -0400
Message-ID: <20251025160905.3857885-350-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

[ Upstream commit 6b81b8a0b1978284e007566d7a1607b47f92209f ]

Update mlx5e_stats_fec_get() to check the active FEC mode and skip
statistics collection when FEC is disabled.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Link: https://patch.msgid.link/20250924124037.1508846-3-vadim.fedorenko@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- `drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:1611` now checks
  `mode == MLX5E_FEC_NOFEC` before touching the PPCNT register groups,
  so the driver stops trying to read FEC statistics when hardware
  reports that FEC is disabled. Previously `mlx5e_stats_fec_get()` still
  called `fec_set_corrected_bits_total()` even in that state, so every
  FEC stats query attempted an unsupported PPCNT access.
- Those reads go through `mlx5_core_access_reg()` with `verbose=true`
  (`drivers/net/ethernet/mellanox/mlx5/core/port.c:36-83`), which means
  firmware failures get logged and waste command bandwidth. Admins hit
  this whenever tools poll FEC stats on links running without FEC, so it
  is a user-visible bug.
- Passing the already computed `mode` into `fec_set_block_stats()`
  (`drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:1448-1471` and
  `:1616`) keeps the existing per-mode handling while avoiding redundant
  `fec_active_mode()` calls; no other callers are affected, so the
  change stays self-contained.
- The patch introduces no new features or interfaces—it simply avoids
  querying counters that do not exist in the “no FEC” configuration—so
  it satisfies stable rules (clear bug fix, minimal risk, contained to
  the mlx5e stats code) and should be backported.

 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index c6185ddba04b8..9c45c6e670ebf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1446,16 +1446,13 @@ static void fec_set_rs_stats(struct ethtool_fec_stats *fec_stats, u32 *ppcnt)
 }
 
 static void fec_set_block_stats(struct mlx5e_priv *priv,
+				int mode,
 				struct ethtool_fec_stats *fec_stats)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u32 out[MLX5_ST_SZ_DW(ppcnt_reg)] = {};
 	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {};
 	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
-	int mode = fec_active_mode(mdev);
-
-	if (mode == MLX5E_FEC_NOFEC)
-		return;
 
 	MLX5_SET(ppcnt_reg, in, local_port, 1);
 	MLX5_SET(ppcnt_reg, in, grp, MLX5_PHYSICAL_LAYER_COUNTERS_GROUP);
@@ -1497,11 +1494,14 @@ static void fec_set_corrected_bits_total(struct mlx5e_priv *priv,
 void mlx5e_stats_fec_get(struct mlx5e_priv *priv,
 			 struct ethtool_fec_stats *fec_stats)
 {
-	if (!MLX5_CAP_PCAM_FEATURE(priv->mdev, ppcnt_statistical_group))
+	int mode = fec_active_mode(priv->mdev);
+
+	if (mode == MLX5E_FEC_NOFEC ||
+	    !MLX5_CAP_PCAM_FEATURE(priv->mdev, ppcnt_statistical_group))
 		return;
 
 	fec_set_corrected_bits_total(priv, fec_stats);
-	fec_set_block_stats(priv, fec_stats);
+	fec_set_block_stats(priv, mode, fec_stats);
 }
 
 #define PPORT_ETH_EXT_OFF(c) \
-- 
2.51.0


