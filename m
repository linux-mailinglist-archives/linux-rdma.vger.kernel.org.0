Return-Path: <linux-rdma+bounces-15442-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A020D1116E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9A7B307B066
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB233F361;
	Mon, 12 Jan 2026 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fhTLfgsl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166EE32E138;
	Mon, 12 Jan 2026 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205059; cv=none; b=UjQg3U2CYZ7IQH/+3RY6L529j3XdpeCGr+0gJMHIf45/R3nJA/wvT4eKHuSXbcKa5tZaMb2trwUDFHmN6qQb8wN4WZclfZWJDjpmGJrHmBynhNm3Krf3Q3IW95uKvHMAZGTGW8Nfr1hEdXyqRp9lZLiVAIf17P76M6xMrlXn/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205059; c=relaxed/simple;
	bh=N89CHE+jyXjgzNAuRTZUQT2yOxWFHhz2J4jXh2RqipE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnS0ZLVg+qbS1Vh25KyV73FbDZuDFnin304TgSMnMgB5FNW64ueyedI6Y/hcf553CV3FDGTjBWHoB8PRG8kgGPO/AxlSRph+QBazxFjA2PqzXxHi3En5QUvb0gDPyfaM9gEuLP9nscUXb7BtdWSicOI4GaOfNm4b281YFaGmRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fhTLfgsl; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768205051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p4Z4ytyxGeEbNSpkRlt95EmE6o89ZwisT6/HLnk71e4=;
	b=fhTLfgslzcQo2Qbxa+67R+P/b/RAEaHadpj8X9gtQ8BCuasRHCgdYzi7sIOYxTD1F0LrQG
	DYBul1b9uxDxT07d/3vPT4vGP56DFo+iXAKWZVjPgcEM4Rg3fAESYFsj8KguJLXVi5TzNb
	Se/US4LLPCY/GJPzhL+nYdSkUIu8vf4=
From: Leon Hwang <leon.hwang@linux.dev>
To: netdev@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oz Shlomo <ozsh@mellanox.com>,
	Paul Blakey <paulb@mellanox.com>,
	Khalid Manaa <khalidm@nvidia.com>,
	Achiad Shochat <achiad@mellanox.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Leon Huang Fu <leon.huangfu@shopee.com>
Subject: [PATCH net-next] net/mlx5e: Mask wqe_id when handling rx cqe
Date: Mon, 12 Jan 2026 16:03:23 +0800
Message-ID: <20260112080323.65456-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The wqe_id from CQE contains wrap counter bits in addition to the WQE
index. Mask it with sz_m1 to prevent out-of-bounds access to the
rq->mpwqe.info[] array when wrap counter causes wqe_id to exceed RQ size.

Without this fix, the driver crashes with NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000020
  RIP: 0010:mlx5e_skb_from_cqe_mpwrq_linear+0xb3/0x280 [mlx5_core]
  Call Trace:
   <IRQ>
   mlx5e_handle_rx_cqe_mpwrq+0xe3/0x290 [mlx5_core]
   mlx5e_poll_rx_cq+0x97/0x820 [mlx5_core]
   mlx5e_napi_poll+0x110/0x820 [mlx5_core]

Fixes: dfd9e7500cd4 ("net/mlx5e: Rx, Split rep rx mpwqe handler from nic")
Fixes: f97d5c2a453e ("net/mlx5e: Add handle SHAMPO cqe support")
Fixes: 461017cb006a ("net/mlx5e: Support RX multi-packet WQE (Striding RQ)")
Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 7e191e1569e8..df8e671d5115 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -583,4 +583,9 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
 
 	return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_size(i, isz));
 }
+
+static inline u16 mlx5e_rq_cqe_wqe_id(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
+{
+	return be16_to_cpu(cqe->wqe_id) & rq->mpwqe.wq.fbc.sz_m1;
+}
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1f6930c77437..25c04684271c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1957,7 +1957,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	u16 cstrides       = mpwrq_get_cqe_consumed_strides(cqe);
-	u16 wqe_id         = be16_to_cpu(cqe->wqe_id);
+	u16 wqe_id         = mlx5e_rq_cqe_wqe_id(rq, cqe);
 	struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, wqe_id);
 	u16 stride_ix      = mpwrq_get_cqe_stride_index(cqe);
 	u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
@@ -2373,7 +2373,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	u16 cstrides		= mpwrq_get_cqe_consumed_strides(cqe);
 	u32 data_offset		= wqe_offset & (PAGE_SIZE - 1);
 	u32 cqe_bcnt		= mpwrq_get_cqe_byte_cnt(cqe);
-	u16 wqe_id		= be16_to_cpu(cqe->wqe_id);
+	u16 wqe_id		= mlx5e_rq_cqe_wqe_id(rq, cqe);
 	u32 page_idx		= wqe_offset >> PAGE_SHIFT;
 	u16 head_size		= cqe->shampo.header_size;
 	struct sk_buff **skb	= &rq->hw_gro_data->skb;
@@ -2478,7 +2478,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	u16 cstrides       = mpwrq_get_cqe_consumed_strides(cqe);
-	u16 wqe_id         = be16_to_cpu(cqe->wqe_id);
+	u16 wqe_id         = mlx5e_rq_cqe_wqe_id(rq, cqe);
 	struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, wqe_id);
 	u16 stride_ix      = mpwrq_get_cqe_stride_index(cqe);
 	u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
-- 
2.52.0


