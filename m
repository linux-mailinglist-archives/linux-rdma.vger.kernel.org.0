Return-Path: <linux-rdma+bounces-6656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 150529F7B87
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 13:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582EE1895050
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7675224AE8;
	Thu, 19 Dec 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZhBOmsf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81841221DAD;
	Thu, 19 Dec 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611862; cv=none; b=PUaLeV/hmyM9yUjC8+Qvx30p/UuFwle4XHVMQwzXzQ2qzEZ4MRCe8TeyaE2awRXhv3Tgqz46tmonMYPNJgOKTl2W95u1A39Qxn2SlXUMTkY4Chcj65/kSdracfhU8Ebf5sgMZb5OpCHUkKIVEgaXYugES30jj790Bs6Ljk0peJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611862; c=relaxed/simple;
	bh=kebG8IY9GuK7BjBaFN081v5919vSr25Swd0HHOeXBh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgBmUAhEvYqSca+ME4u/JgyUsa20aZx6AUeUUZGZqskK12b3UBYUeLcCDLmjp9boAjpTDghZ5wf0UaIVJWVgYABlmcI0AeOuyeZ033oic5EGMQkvi1AHqT5+FYcVStWlDqhNMwgegXWzks8Y6a1A1TRASeJzgz79gAsPzwlSr9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZhBOmsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66995C4CECE;
	Thu, 19 Dec 2024 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734611862;
	bh=kebG8IY9GuK7BjBaFN081v5919vSr25Swd0HHOeXBh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZhBOmsfx0fOSnnSBuJhTuJM9WVmH8YDdBai9AIMChs8JvcDepD2U9RM1+/7W/En1
	 gafX3cAO/JfN3GZDdeRnKIZTerzu7SwH0zC6GCkA1Lu+uKeuZIlrADVfoRYAbBzRLO
	 xUYWAsWNTQzH2OKz4y+SvUme2ePdqjItDAMkqF7mdOkPBUQyp2J21/qXlDy1gxkSQS
	 yO6rIFNst/gbh2d87q2wV/npOOwfLhkrtqCgeFu17OiyZJkYp39jI8KlDfoyg3NjAA
	 qPcyR2Swm4ls/ISesM2Qx/NwshrysdV1q8eiCk/VA44vMzxKjngcITCB875i24zNJZ
	 0cbyu/GsNg9Yw==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH ipsec-next 2/2] net/mlx5e: Update TX ESN context for IPSec hardware offload
Date: Thu, 19 Dec 2024 14:37:30 +0200
Message-ID: <e9a68656c4b7cd0ba05055760c60dd649dbe1a5b.1734611621.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <874f965d786606b0b4351c976f50271349f68b03.1734611621.git.leon@kernel.org>
References: <874f965d786606b0b4351c976f50271349f68b03.1734611621.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

ESN context must be synced between software and hardware for both RX
and TX. As the call to xfrm_dev_state_advance_esn() is added for TX,
this patch add the missing logic for TX. So the update is also checked
on every packet sent, to see if need to trigger ESN update worker.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 40 +++++++------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 3dd4f2492090..8489b0a0e8bd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -94,25 +94,14 @@ static bool mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry)
 	u32 esn, esn_msb;
 	u8 overlap;
 
-	switch (x->xso.type) {
-	case XFRM_DEV_OFFLOAD_PACKET:
-		switch (x->xso.dir) {
-		case XFRM_DEV_OFFLOAD_IN:
-			esn = x->replay_esn->seq;
-			esn_msb = x->replay_esn->seq_hi;
-			break;
-		case XFRM_DEV_OFFLOAD_OUT:
-			esn = x->replay_esn->oseq;
-			esn_msb = x->replay_esn->oseq_hi;
-			break;
-		default:
-			WARN_ON(true);
-			return false;
-		}
-		break;
-	case XFRM_DEV_OFFLOAD_CRYPTO:
-		/* Already parsed by XFRM core */
+	switch (x->xso.dir) {
+	case XFRM_DEV_OFFLOAD_IN:
 		esn = x->replay_esn->seq;
+		esn_msb = x->replay_esn->seq_hi;
+		break;
+	case XFRM_DEV_OFFLOAD_OUT:
+		esn = x->replay_esn->oseq;
+		esn_msb = x->replay_esn->oseq_hi;
 		break;
 	default:
 		WARN_ON(true);
@@ -121,11 +110,15 @@ static bool mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 	overlap = sa_entry->esn_state.overlap;
 
-	if (esn >= x->replay_esn->replay_window)
-		seq_bottom = esn - x->replay_esn->replay_window + 1;
+	if (!x->replay_esn->replay_window) {
+		seq_bottom = esn;
+	} else {
+		if (esn >= x->replay_esn->replay_window)
+			seq_bottom = esn - x->replay_esn->replay_window + 1;
 
-	if (x->xso.type == XFRM_DEV_OFFLOAD_CRYPTO)
-		esn_msb = xfrm_replay_seqhi(x, htonl(seq_bottom));
+		if (x->xso.type == XFRM_DEV_OFFLOAD_CRYPTO)
+			esn_msb = xfrm_replay_seqhi(x, htonl(seq_bottom));
+	}
 
 	if (sa_entry->esn_state.esn_msb)
 		sa_entry->esn_state.esn = esn;
@@ -980,9 +973,6 @@ static void mlx5e_xfrm_advance_esn_state(struct xfrm_state *x)
 	struct mlx5e_ipsec_sa_entry *sa_entry_shadow;
 	bool need_update;
 
-	if (x->xso.dir != XFRM_DEV_OFFLOAD_IN)
-		return;
-
 	need_update = mlx5e_ipsec_update_esn_state(sa_entry);
 	if (!need_update)
 		return;
-- 
2.47.0


