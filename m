Return-Path: <linux-rdma+bounces-12092-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1325BB03376
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 01:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8B01899676
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BB420C00D;
	Sun, 13 Jul 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTTmfrLQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5010E5;
	Sun, 13 Jul 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752449639; cv=none; b=L+qOQAZDWHNcT1Rr6ChmM3K3STtFdhA/udzFXl0y1oZJ9xMpJuPgW2SUkLd5AFPi9B4VEBDUTi4cx5OPBSBMosr8sUV50i9vCvBrq0bK0m/Vp6CGiLFDnuR6wR9PJp9n2Xn+Lr9G5xl+kABSLU+Nf3zD3VcObqbqpe/ooZMLP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752449639; c=relaxed/simple;
	bh=eRNVTUnDH6SRacX+8ga8G5F2Bn8TNaVJS/JOUxNUk0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPG+UBCJ5i3B4Z/O4K/xDfVgtLD/inGODP3qD4hIy2yU2jQ8bfliR2/evYS3dDY3BtNBV+scYWvVhw1bCmvdH8/xUANtHwkmUgN1NowSOHk/+PvzVMqcpneWL2M8h3aq2mdHlWbyjXytUlxVBGYFUtybDafMKP+cC6gmnXTXO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTTmfrLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96402C4CEF6;
	Sun, 13 Jul 2025 23:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752449639;
	bh=eRNVTUnDH6SRacX+8ga8G5F2Bn8TNaVJS/JOUxNUk0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DTTmfrLQ9P6kxt4ujHX1LyXks0uKtypm7Bi5ils0GnB90TvFi1q+aJUhPiBDejaGL
	 UPgnBxwYB5Sc5lpcR26G5fyGmVfWU+8HgeLjnzKU7hFDIwUHZ/VP5SpD78t49rJHCj
	 TnhKb36FWmPIPb8hp9QFV+tcff1RsvKg+1V/8eNCAPtSqNXPIqjhv8k1K+zoNS0s8C
	 FMONfd8TR1Z8Jhm2Vq33CkYBPxdOrzrdaLWdiQa13YiGmjUQZdsA3edJwak5rd0RFC
	 4RYYBYTdm/RjIx312SunZxnOYHjQhO/u++81nNEpNqEWjFa6ntZ+FCO3nfLTP+PRkn
	 KCDuOrQa/Vf6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85083C83F17;
	Sun, 13 Jul 2025 23:33:59 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Sun, 13 Jul 2025 16:33:06 -0700
Subject: [PATCH net-next 1/2] net/mlx5: Bring back get_cqe_l3_hdr_type
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-1-ecaed8c2844e@openai.com>
References: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com>
In-Reply-To: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752449639; l=1431;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=C/3QdRtBQlKCPf2WiTbNIp27bIs6JfitVu8RamyZd4M=;
 b=P+MRWHpJXo9YemPNR4iawvXjGeZy7ROhD5Jf2QK7J4zM1PXrwZGPRItguUzqQVaZKKHo0/Ygd
 4qJH9HTurmrAo6cpA0HtM1QBLzbYfBIsJfRZp74PJVzLhiyIODpzRxC
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
index 6822cfa5f4ad31ef6fb61be2dcfae3ac9a46d659..a0098df1b82bf746bf0132d547440b9dab22e57f 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -926,11 +926,16 @@ static inline u8 get_cqe_lro_tcppsh(struct mlx5_cqe64 *cqe)
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
@@ -1011,6 +1016,11 @@ enum {
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
2.49.0



