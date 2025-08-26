Return-Path: <linux-rdma+bounces-12915-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96220B35259
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 05:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3F81A869D3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 03:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C72D4806;
	Tue, 26 Aug 2025 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4tYg2W/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C214A8B;
	Tue, 26 Aug 2025 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180044; cv=none; b=m5PWndpRGXIqUi7wskL0SE6QVsxnb4LM3O21uoU61uhqoRpAtjeMTCyZw3rjm1jxA2jWS/aVEqLF7dTt6D+3RAXBGJPrPnNMziuZF1tUl5uucI/oYbXgjFg+8grIY9r2UQKXu3tFfAZq88pclfP873KCqRa5GHDX/pWm39vEuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180044; c=relaxed/simple;
	bh=W+w5qTpFCswGOMwFQnALt7zcVRGe1Lj/RfZnJo6OC2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ORxdC8y7bXprFonzlK9knXtQ0Bjdj/M6eSbsNw+VeXJORNA0tHq+qDSFm/LUwAYx/cbO2UacFO8nXqOF/LbHiRu1GBXtFiPdhKwyZx8vyPBHwTQvQ+gSonvFpELscdDXBoQqyYfYL04lGPF5nH2rgxB1QwX9jeFczSeyivOFB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4tYg2W/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3B97C4CEF1;
	Tue, 26 Aug 2025 03:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756180043;
	bh=W+w5qTpFCswGOMwFQnALt7zcVRGe1Lj/RfZnJo6OC2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m4tYg2W/2CQDh1gnXA0ES4Lcbm4LFuJ2li2X7TWaxlf1fCjmRQS0enmh/S3CNjPqH
	 G10aTHeLgtciVUnUiTvWDWcwX20kmaHstv5WvsSeE2TKOs4bkFb862sbGCRDoHbO/u
	 UWoEVGOg6v0FBeAmBpi2ilkxvhjD9JFksqc0P0NMql1q4FmMF3U+biyTSuotOAqWVU
	 DHV0Yx8pJ8P7OiBpDMBu96F4BTO+Q/9Y9szkj/af6LnMvCndioiyRN2GEW498AiYj2
	 3RGpHuOZaJrGwSNd9tz/jtCusKZ3n6cqvVyNFq26+5EqLT8UkPozhYVELKrcKIRdKO
	 PXz8VNNHpCEAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9349FCA0EE4;
	Tue, 26 Aug 2025 03:47:23 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Mon, 25 Aug 2025 20:47:12 -0700
Subject: [PATCH net-next v3 1/2] net/mlx5: Bring back get_cqe_l3_hdr_type
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-1-5527e9eb6efc@openai.com>
References: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-0-5527e9eb6efc@openai.com>
In-Reply-To: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-0-5527e9eb6efc@openai.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756180043; l=1431;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=SPLeig1w80KP25Uafa7OhBKZ5EPa50evdyHn8YkXEeM=;
 b=HgvBG4kttZykTui4idPziE/vWifA/0oBdBKeBSMQwAc70alyUk7B3XVLk312v3Jsxh7dFPW0+
 PnjiDPUa7uqDW7OHmnQlh/facHwnG+fRaHrujKPIrAbwQ0LB5TNRwfD
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

Commit 66af4fe37119 ("net/mlx5: Remove unused functions") removed
get_cqe_l3_hdr_type. Let's bring it back.

Also, define CQE_L3_HDR_TYPE_* to identify IPv6 and IPv4 packets.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 include/linux/mlx5/device.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 9d2467f982ad4697f0b36f6975b820c3a41fc78a..5e4a03cff0f1d9b11c5f562c23dbf85c3302f681 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -927,11 +927,16 @@ static inline u8 get_cqe_lro_tcppsh(struct mlx5_cqe64 *cqe)
 	return (cqe->lro.tcppsh_abort_dupack >> 6) & 1;
 }
 
-static inline u8 get_cqe_l4_hdr_type(struct mlx5_cqe64 *cqe)
+static inline u8 get_cqe_l4_hdr_type(const struct mlx5_cqe64 *cqe)
 {
 	return (cqe->l4_l3_hdr_type >> 4) & 0x7;
 }
 
+static inline u8 get_cqe_l3_hdr_type(const struct mlx5_cqe64 *cqe)
+{
+	return (cqe->l4_l3_hdr_type >> 2) & 0x3;
+}
+
 static inline bool cqe_is_tunneled(struct mlx5_cqe64 *cqe)
 {
 	return cqe->tls_outer_l3_tunneled & 0x1;
@@ -1012,6 +1017,11 @@ enum {
 	CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA	= 0x4,
 };
 
+enum {
+	CQE_L3_HDR_TYPE_IPV6			= 0x1,
+	CQE_L3_HDR_TYPE_IPV4			= 0x2,
+};
+
 enum {
 	CQE_RSS_HTYPE_IP	= GENMASK(3, 2),
 	/* cqe->rss_hash_type[3:2] - IP destination selected for hash

-- 
2.50.1



