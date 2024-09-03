Return-Path: <linux-rdma+bounces-4718-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72FF969C21
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46F7282B1D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1501D0958;
	Tue,  3 Sep 2024 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRce118U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722C1AD246;
	Tue,  3 Sep 2024 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363484; cv=none; b=VhrAcdyolgd+AH4615SsBAw+Wo2phvmkrcZaNIZXMaLVjHzLn12zdmZz3J4w090kktWGs3zV4B43Qd/tzYkOVtAypyBgJ74zRoHZc0BzHS/lJL8Q/+xVtkLSTi3AlVmjgRm163yqO5Gw7mf1DRu/0OcVL3PjmUxrbjPslDVULRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363484; c=relaxed/simple;
	bh=0Ys4q8ivLitWi4+R1O7R7yFfhG8tkWHJ7YSGu6MQPxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/S0AweOsRIL2fayPuKxsFqDuiWIB2Ajnz+D00TuJKf7XB/jl8je5N8uyevFT/M6GO8/X1ibDoTT2zWhEwvbIqPsmWalfMV5EqKWXLQ48UhyuMrdf1BSbTRTaYTrNwdjR2d4Y4YkkD/wRSren/SGMWuFhpvnvhGNKXyVIZuuuvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRce118U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF31C4CEC8;
	Tue,  3 Sep 2024 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725363483;
	bh=0Ys4q8ivLitWi4+R1O7R7yFfhG8tkWHJ7YSGu6MQPxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRce118UCK5Ar9FzKrnuE2jdXM+7xjcwVl7axvERoKmHbciZeS4+P7L3UFv9DuF8S
	 VxnLbDyft9tGDKRl6DbD0A6jQFAPjBqsi2NTNWZuxBE1l/Aucflsupwz6PwnvqWWzt
	 hmStieSsPFFQjTGAaJMsRmLNnhC6OzIKLpgvq1oLmI7NObrcfDylybudphIANHLk/b
	 aDvI3LUQq6xKfMaFYuDN9JUEdNH1U4NXvG74zoF+QetnL7t927tMF7AonNYQgKXuNi
	 2Yaue7sCKMlvoCLMLu4WrLnQS8GDNKjhjjCTf/Qgx0qKtP2P5YZvk35QnOIbBA2+Ox
	 UCA4YGyqYYItw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH mlx5-next 1/2] net/mlx5: Introduce data placement ordering bits
Date: Tue,  3 Sep 2024 14:37:51 +0300
Message-ID: <f30e5cbb5459fd02f27f35909bb545cab346b58b.1725362773.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725362773.git.leon@kernel.org>
References: <cover.1725362773.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Srouji <edwards@nvidia.com>

Introduce out-of-order (OOO) data placement (DP) IFC related bits to
support OOO DP QP.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 970c9d8473ef..691a285f9c1e 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1765,7 +1765,12 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_328[0x2];
 	u8	   relaxed_ordering_read[0x1];
 	u8         log_max_pd[0x5];
-	u8         reserved_at_330[0x6];
+	u8         dp_ordering_ooo_all_ud[0x1];
+	u8         dp_ordering_ooo_all_uc[0x1];
+	u8         dp_ordering_ooo_all_xrc[0x1];
+	u8         dp_ordering_ooo_all_dc[0x1];
+	u8         dp_ordering_ooo_all_rc[0x1];
+	u8         reserved_at_335[0x1];
 	u8         pci_sync_for_fw_update_with_driver_unload[0x1];
 	u8         vnic_env_cnt_steering_fail[0x1];
 	u8         vport_counter_local_loopback[0x1];
@@ -1986,7 +1991,9 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   reserved_at_0[0x80];
 
 	u8         migratable[0x1];
-	u8         reserved_at_81[0x11];
+	u8         reserved_at_81[0x7];
+	u8         dp_ordering_force[0x1];
+	u8         reserved_at_89[0x9];
 	u8         query_vuid[0x1];
 	u8         reserved_at_93[0xd];
 
@@ -3397,7 +3404,8 @@ struct mlx5_ifc_qpc_bits {
 	u8         latency_sensitive[0x1];
 	u8         reserved_at_24[0x1];
 	u8         drain_sigerr[0x1];
-	u8         reserved_at_26[0x2];
+	u8         reserved_at_26[0x1];
+	u8         dp_ordering_force[0x1];
 	u8         pd[0x18];
 
 	u8         mtu[0x3];
@@ -3470,7 +3478,8 @@ struct mlx5_ifc_qpc_bits {
 	u8         rae[0x1];
 	u8         reserved_at_493[0x1];
 	u8         page_offset[0x6];
-	u8         reserved_at_49a[0x3];
+	u8         reserved_at_49a[0x2];
+	u8         dp_ordering_1[0x1];
 	u8         cd_slave_receive[0x1];
 	u8         cd_slave_send[0x1];
 	u8         cd_master[0x1];
@@ -4377,7 +4386,8 @@ struct mlx5_ifc_dctc_bits {
 	u8         state[0x4];
 	u8         reserved_at_8[0x18];
 
-	u8         reserved_at_20[0x8];
+	u8         reserved_at_20[0x7];
+	u8         dp_ordering_force[0x1];
 	u8         user_index[0x18];
 
 	u8         reserved_at_40[0x8];
@@ -4392,7 +4402,9 @@ struct mlx5_ifc_dctc_bits {
 	u8         latency_sensitive[0x1];
 	u8         rlky[0x1];
 	u8         free_ar[0x1];
-	u8         reserved_at_73[0xd];
+	u8         reserved_at_73[0x1];
+	u8         dp_ordering_1[0x1];
+	u8         reserved_at_75[0xb];
 
 	u8         reserved_at_80[0x8];
 	u8         cs_res[0x8];
-- 
2.46.0


