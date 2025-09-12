Return-Path: <linux-rdma+bounces-13320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEACB55421
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 17:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FF8AE4E14
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4943043B9;
	Fri, 12 Sep 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKn3iU5x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995F2AC17;
	Fri, 12 Sep 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692173; cv=none; b=RwTH621AMfeq3IZGhhHqql0Jr/lELoYOdcl4oU5YBlUaCqNf/+hKogq4bPs4QcZgApNV3KNXqizI3SK1YbBzhDBex5TaBFSBAf4eMvrmp1jHUYoZ5wOXHusLg3THrO4k7HsE3MdLn68jbGEBGSqWJ6W6+UVGEcpRxyCWHlCMZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692173; c=relaxed/simple;
	bh=oYVzC7tZjxxq6Zp3GdbKqJsbqRR/wPhIfgtU/YrCoc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7yY2DfMbiiTQtipTTew8wC9M5OfLYBfdegriYeuu/aevfpq5nc1PrTZNtEWrWiGTw3hufHq6jwuZkt0B584tBZ85SV6sH+hxldJlugbThQkbLi6NxDfnoYSsepGs1uWaBWSWHgUWlGDCfLiWxCS+/iKF49NadsHTQcTXy2zde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKn3iU5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B50C4CEF1;
	Fri, 12 Sep 2025 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757692172;
	bh=oYVzC7tZjxxq6Zp3GdbKqJsbqRR/wPhIfgtU/YrCoc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKn3iU5xMHxJPtWKw3aAKBbDHY6hZ4bYpvcibDPz4NHZFpsLDdTdNxFm4uw/fRG7j
	 6E8e9VdkE5MZMFXlj0S684FEB46rlRHoLW8mybkDC0aeTbYnONrsM3Vjne10MDSTE5
	 WxZNB90ItxqdJvfnYBglPocNIxFpMCLyJjo7YACv+NtEb/scrE9qXoUlvi46EOQGxM
	 8uTOCzwHC0rE3G4uPCVbuekozk/uGKpU9/+6zCRd/D+zsv98y41VL0VURFCGTixqN8
	 dHit5rzQSjYNdpzy8nCqHBkoIwRzLLJ460UEn6J4/0FstYgRV20LOXPnVHodcDJRtu
	 VNUrkYRjCEjMQ==
Date: Fri, 12 Sep 2025 16:49:26 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH mlx5-next 2/3] net/mlx5: Refactor MACsec WQE metadata
 shifts
Message-ID: <20250912154926.GG30363@horms.kernel.org>
References: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
 <1757574619-604874-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1757574619-604874-3-git-send-email-tariqt@nvidia.com>

On Thu, Sep 11, 2025 at 10:10:18AM +0300, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Introduce MLX5_ETH_WQE_FT_META_SHIFT as a shared base offset for
> features that use the lower 8 bits of the WQE flow_table_metadata
> field, currently used for timestamping, IPsec, and MACsec.
> 
> Define MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK so that fs_id occupies
> bits 2–5, making it clear that fs_id occupies bits in the metadata.
> 
> Set MLX5_ETH_WQE_FT_META_MACSEC_MASK as the OR of the MACsec flag and
> MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK, corresponding to the original
> 0x3E mask.
> 
> Update the fs_id macro to right-shift the MACsec flag by
> MLX5_ETH_WQE_FT_META_SHIFT and update the RoCE modify-header action to
> use it.
> 
> Introduce the helper macro MLX5_MACSEC_TX_METADATA(fs_id) to compose
> the full shifted MACsec metadata value.
> 
> These changes make it explicit exactly which metadata bits carry MACsec
> information, simplifying future feature exclusions when multiple
> features share the WQE flowtable metadata.
> 
> In addition, drop the incorrect “RX flow steering” comment, since this
> applies to TX flow steering.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Hi Carolina, Tariq, all,

I'm wondering if dropping _SHIFT and making use of FIELD_PREP
would lead to a cleaner and more idiomatic implementation.

I'm thinking that such an approach would involve
updating MLX5_ETH_WQE_FT_META_MACSEC_MASK rather
than MLX5_ETH_WQE_FT_META_MACSEC_SHIFT in the following patch.

I'm thinking of something along the lines of following incremental patch.

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 9ec450603176..58c0ff4af78f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -2218,7 +2218,7 @@ static int mlx5_macsec_fs_add_roce_rule_tx(struct mlx5_macsec_fs *macsec_fs, u32
 	MLX5_SET(set_action_in, action, data,
 		 mlx5_macsec_fs_set_tx_fs_id(fs_id));
 	MLX5_SET(set_action_in, action, offset,
-		 MLX5_ETH_WQE_FT_META_MACSEC_SHIFT);
+		 __bf_shf(MLX5_ETH_WQE_FT_META_MACSEC_MASK));
 	MLX5_SET(set_action_in, action, length, 32);
 
 	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
index 15acaff43641..402840cb3110 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
@@ -13,18 +13,15 @@
 #define MLX5_MACSEC_RX_METADAT_HANDLE(metadata)  ((metadata) & MLX5_MACSEC_RX_FS_ID_MASK)
 
 /* MACsec TX flow steering */
-#define MLX5_ETH_WQE_FT_META_MACSEC_MASK \
-	(MLX5_ETH_WQE_FT_META_MACSEC | MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK)
-#define MLX5_ETH_WQE_FT_META_MACSEC_SHIFT MLX5_ETH_WQE_FT_META_SHIFT
+#define MLX5_ETH_WQE_FT_META_MACSEC_MASK GENMASK(7, 0)
 
 /* MACsec fs_id handling for steering */
 #define mlx5_macsec_fs_set_tx_fs_id(fs_id) \
-	(((MLX5_ETH_WQE_FT_META_MACSEC) >> MLX5_ETH_WQE_FT_META_MACSEC_SHIFT) \
-	 | ((fs_id) << 2))
+	(MLX5_ETH_WQE_FT_META_IPSEC | (fs_id) << 2)
 
 #define MLX5_MACSEC_TX_METADATA(fs_id) \
-	(mlx5_macsec_fs_set_tx_fs_id(fs_id) << \
-	 MLX5_ETH_WQE_FT_META_MACSEC_SHIFT)
+	FIELD_PREP(MLX5_ETH_WQE_FT_META_MACSEC_MASK, \
+		   mlx5_macsec_fs_set_tx_fs_id(fs_id))
 
 /* MACsec fs_id uses 4 bits, supports up to 16 interfaces */
 #define MLX5_MACSEC_NUM_OF_SUPPORTED_INTERFACES 16
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index b21be7630575..5546c7bd2c83 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -251,14 +251,9 @@ enum {
 	MLX5_ETH_WQE_SWP_OUTER_L4_UDP   = 1 << 5,
 };
 
-/* Base shift for metadata bits used by timestamping, IPsec, and MACsec */
-#define MLX5_ETH_WQE_FT_META_SHIFT 0
-
 enum {
-	MLX5_ETH_WQE_FT_META_IPSEC = BIT(0) << MLX5_ETH_WQE_FT_META_SHIFT,
-	MLX5_ETH_WQE_FT_META_MACSEC = BIT(1) << MLX5_ETH_WQE_FT_META_SHIFT,
-	MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK =
-		GENMASK(5, 2) << MLX5_ETH_WQE_FT_META_SHIFT,
+	MLX5_ETH_WQE_FT_META_IPSEC = BIT(0),
+	MLX5_ETH_WQE_FT_META_MACSEC = BIT(1),
 };
 
 struct mlx5_wqe_eth_seg {

