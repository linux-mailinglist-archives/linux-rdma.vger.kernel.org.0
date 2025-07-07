Return-Path: <linux-rdma+bounces-11933-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F19AFB96C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 19:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726D61894227
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D972E7F34;
	Mon,  7 Jul 2025 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAvQcBe6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057822DF9E;
	Mon,  7 Jul 2025 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907849; cv=none; b=RVJSUagPU/95JdNGwscjA8pmfNQB0iwJRipibD3dXpagJmMVDwfCke5Ej2FtDjcYI5AnP6+eUfoBq2DVxYiBCLhNLd8f7hi6YNsz/2tClzJJSXElAPpjy6zVHgpwpInH5sqy4DF1j4cxQ+UkBGavNopdlkemy4QVq2361ZrEDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907849; c=relaxed/simple;
	bh=Oeu9SsBm6VYeTdDdFtN/VL7b5F1WBZvyvekvSo4dBl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEBIlEvrxEAuwiqXA4JvSQcyQfFuORBxWNpYYFH8gX+V/pB/WpeyPSWzgmq1fea0y6uXkhozFxm4T698AAtvvIifJa0f/b7nF9ckeGMzJiaKqBiGPF1IrPQqPmgvQlmGioT3JI6uFVvBh3nxO2yBn1fAE1N82CegxlokCfeWNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAvQcBe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CA3C4CEF1;
	Mon,  7 Jul 2025 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751907849;
	bh=Oeu9SsBm6VYeTdDdFtN/VL7b5F1WBZvyvekvSo4dBl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iAvQcBe6dHkRv6rPXxmpo1FOiuFmgkK2Jr+qk1TuRGWk7REpiKp4XpLH0KGqEXZs+
	 y9NAdK6xXTJAdK0kQzeIRgTz+V9hMOt1WSNx9wzT8JEkI3Qj1KCbpoDQj0/K7JN9Pa
	 PeAqznvrxT1AZfFBb/lwOvucBgS6+TIxfxDSvS7kHfn4IPloB/X0AbI4s4nix6YJW6
	 9DKgqeM5yp3FKdw9wYbUf6gfvAX+sMzoyx6Q0C6SX5U3affc7+xQ1RrGybVHIP+8BD
	 u1I43VV0e3sKYbqI8oq9Lt9w0WMhKRRiAbCcCyVn/IS5L4fFO6Uvmy3IWubj/4OxA9
	 sowMHwp6oFpNQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 2/8] net/mlx5: Expose IFC bits for TPH
Date: Mon,  7 Jul 2025 20:03:02 +0300
Message-ID: <70a30ed6ff159d2aa94834d39409dff7d18d6d18.1751907231.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751907231.git.leon@kernel.org>
References: <cover.1751907231.git.leon@kernel.org>
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
2.50.0


