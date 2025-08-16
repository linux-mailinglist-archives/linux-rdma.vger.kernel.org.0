Return-Path: <linux-rdma+bounces-12789-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1FB28F3B
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0ADA5C6543
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5C61A2547;
	Sat, 16 Aug 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNswWi+F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4617A318;
	Sat, 16 Aug 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755358744; cv=none; b=Z3KIfx+wGLYR8/uWI4jxVH+NCjsyfxQNJ8ag2NjycYj97MVsIVElc0c+umouwVxpqeVZ5+SGhhxz3QBpBOkSsd555rFevKt/86CtF5oi6HhjsFJWphu5goKjo8wG8XKtY8DAxQ/cLBGR1Uef13aWm3CdfbSBUZTrCwNcbM7b38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755358744; c=relaxed/simple;
	bh=W+w5qTpFCswGOMwFQnALt7zcVRGe1Lj/RfZnJo6OC2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKhi1NhyzYLUDkKWCNSW6a2QI92L+9eYVu0ZRtHZW6x9umYlKmev7rYKeXmrthkM3lpzYhvgSypRiELFvdtucEMe/GHFlNWbpNATt0NG6DB3Pc4vwdpCWdqFVKRA/aBISu3NaBl+K7oncUFh0uzf4xm+L5p1cUBWmF2v6VDjBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNswWi+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42DE0C4CEF1;
	Sat, 16 Aug 2025 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755358744;
	bh=W+w5qTpFCswGOMwFQnALt7zcVRGe1Lj/RfZnJo6OC2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LNswWi+FomulbcdEtqrrw/oHJLv7sQDOK4u2YjWnbIgMbPDHoiI1iKFVfEvGvjbrJ
	 avQwa1sEQcmK5MXkRW14k2zDXftXo3SbBwt2OWzUXxoHQRTzSTzbI/D9zfv9Dct3dN
	 Om5+rMKFhzShQoyuObj9jHW5Fzgh2YdcKvEfUimxXiE7pskcpQrd109jTQB7ijlE1I
	 9gR7u5fU5CdAMFTVLcDYjU+NOAds4nAaRuicza8E1goGZXZCO75oZsWdB9aWaP1Y4N
	 +js8gTOr08I72GrzRM+aMFsDFL0ErhZLa+SjqMvPDOvWUQq4xxyIPz0h4ofYwbFKzK
	 luEyrBW7vWaVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33399CA0EE6;
	Sat, 16 Aug 2025 15:39:04 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Sat, 16 Aug 2025 08:39:03 -0700
Subject: [PATCH net-next v2 1/2] net/mlx5: Bring back get_cqe_l3_hdr_type
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-1-b11b30bc2d10@openai.com>
References: <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-0-b11b30bc2d10@openai.com>
In-Reply-To: <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-0-b11b30bc2d10@openai.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Gal Pressman <gal@nvidia.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755358743; l=1431;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=SPLeig1w80KP25Uafa7OhBKZ5EPa50evdyHn8YkXEeM=;
 b=d/3rnCLWr1OwI8rYTdOd4PRFB/SB4cmuaGZPp3D6p4shYuTPufe/VH/i4/y3erC+rgQYVvstq
 obsAVc+BRPUDHdZcas/t6MQNeyBOvQmMx18+pymjjvMDmiklQCEFjDM
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



