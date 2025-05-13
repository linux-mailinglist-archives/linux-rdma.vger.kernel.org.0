Return-Path: <linux-rdma+bounces-10320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A95AB536B
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 13:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24973AAB7C
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2B727F4F5;
	Tue, 13 May 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku55cAXq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53E21C9F6
	for <linux-rdma@vger.kernel.org>; Tue, 13 May 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134228; cv=none; b=Y6Cv2kVFeUR7IFOLIGGzBvGI1GIRWsOR4z9tjCgFjxAqRavlsd43cK2IFaTc+/X84OxITfNJllsINnGwhQcVXP/p5/c1L7CBexowaIzWxuhy1G6eaoBRa3OrzhohHM494MmraRFu0gqmIM+xD/e2MqeTOfLBozBKXOdrv3I+jFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134228; c=relaxed/simple;
	bh=/BwYdnvJCsjRAHT4n1V6bq324XWZr36xV36NxiDVHg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHieFBM/ou2JTdf+RY0a0HmFKtSYTNpFXmFHATwAo08y56ek4uYBqt6MtF1VQv7hScKrp5tcgrAn72UTmKZyq8rhpAHUG4FOMjxYJZTrfJRU3JRvs52Vdza7jACrveZQKak6pImV3IwZBjBEPlUHd9mfBAIgfDr9p34bGVMdYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku55cAXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310CDC4CEE4;
	Tue, 13 May 2025 11:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747134227;
	bh=/BwYdnvJCsjRAHT4n1V6bq324XWZr36xV36NxiDVHg8=;
	h=From:To:Cc:Subject:Date:From;
	b=Ku55cAXq3YJnPsz/blOdttBW3tnHquPY4P260thhxbx3hiQhTPCX5dMbOWpEXjBdp
	 gEoT8Dr+NNFIp7qKz3bdPCMfZL6MiGxwo+DSHbPF7qqOymowmkIxQJP6qBGpow01Cf
	 RtezBrw8knQB0+d5xZJ3JnHDTNq9ebqOXUXkcFoflfYw+klw6enzNdVV9ZgfGpBOko
	 Kx1f6B77ZCYUFXewPxQCw8G7LhEPHi3N2e32o6lejp3vi5zvxBKDeB922/32EY9lBN
	 RAatRLlXCOErAbzYfcWDCuBr/enb3BVEwzajHfpZrAySRzCaSEmbgIAKhed5Sxakkg
	 NzHIxDyPO1p8A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Add support for 200Gbps per lane speeds
Date: Tue, 13 May 2025 14:03:41 +0300
Message-ID: <b842d2f523e9b82e221378c444ebd5860d612959.1747134197.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Add support for 200Gbps per lane speeds speed when querying PTYS and
report it back correctly when needed.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 32ad066c3c4a..ce7610740412 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -485,6 +485,10 @@ static int translate_eth_ext_proto_oper(u32 eth_proto_oper, u16 *active_speed,
 		*active_width = IB_WIDTH_2X;
 		*active_speed = IB_SPEED_NDR;
 		break;
+	case MLX5E_PROT_MASK(MLX5E_200GAUI_1_200GBASE_CR1_KR1):
+		*active_width = IB_WIDTH_1X;
+		*active_speed = IB_SPEED_XDR;
+		break;
 	case MLX5E_PROT_MASK(MLX5E_400GAUI_8_400GBASE_CR8):
 		*active_width = IB_WIDTH_8X;
 		*active_speed = IB_SPEED_HDR;
@@ -493,10 +497,18 @@ static int translate_eth_ext_proto_oper(u32 eth_proto_oper, u16 *active_speed,
 		*active_width = IB_WIDTH_4X;
 		*active_speed = IB_SPEED_NDR;
 		break;
+	case MLX5E_PROT_MASK(MLX5E_400GAUI_2_400GBASE_CR2_KR2):
+		*active_width = IB_WIDTH_2X;
+		*active_speed = IB_SPEED_XDR;
+		break;
 	case MLX5E_PROT_MASK(MLX5E_800GAUI_8_800GBASE_CR8_KR8):
 		*active_width = IB_WIDTH_8X;
 		*active_speed = IB_SPEED_NDR;
 		break;
+	case MLX5E_PROT_MASK(MLX5E_800GAUI_4_800GBASE_CR4_KR4):
+		*active_width = IB_WIDTH_4X;
+		*active_speed = IB_SPEED_XDR;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.49.0


