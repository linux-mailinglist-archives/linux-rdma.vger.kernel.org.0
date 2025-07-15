Return-Path: <linux-rdma+bounces-12203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD71B067AD
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 22:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0686B563E53
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 20:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11396271440;
	Tue, 15 Jul 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViRfJpet"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92A17BA1;
	Tue, 15 Jul 2025 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610868; cv=none; b=LFpKquydPb4mvQ9EANkRvR1JYXaJaZZ2lUXE8uMa7l79eiq8+en1MtIzqgqlKkL/RTkAEthES9WQ/X2474VM2DQZlsKBy6xHP2iBnQc8i4fNZqQPZH4gJsHQdZc+dbkpnhLMYtvv16WjXBaAeA+QDKCQ77IvXBUjQFMp4BiURTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610868; c=relaxed/simple;
	bh=RMXg9EKZ89w9cSfutCV0PjCQjBsYREV1Sowlx6zCVFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R9kYRt2J57NgOHDOGQ0emsYboWVhmuSAhlKTMfttt8vWhHLhmXQBSghvKAJLuFK7uq8huH7ztzIQaO1/nV5a7b1N+PNjNu5w45yJBLImTortQdz2NpLJnyPE6gEE9tvDtXS2LJWKqQRMUB9MWtJB7j4k3LF/EOHxnXZF7C4pr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViRfJpet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3597BC4CEE3;
	Tue, 15 Jul 2025 20:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752610868;
	bh=RMXg9EKZ89w9cSfutCV0PjCQjBsYREV1Sowlx6zCVFw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ViRfJpetBd4FYAL9SdBFbhFTTRm7Z5lpfaNgRmdrRFCe7sLtk94KTH9+qhy7iT6zz
	 opMLkQGu0fR7pHWrHcv1iqZ/dPtihpZJdYi0STMQbcV/VybVauW4Nm4OURAKDJOkhq
	 pbwvPwymVU749j89HUcHsETgA4xNnLVSrghdK07A4KBI33s9AyiI+bml8FZqDo7Anx
	 X07T1BcG67DR9FGssKYgZtU7mewDTL3XEdRaSgqCqRzvfS1hdFeWDiX0wxRuBnx3R9
	 sz+54fzUqNmZj+EFZTORJHLWksiqoNLiJnHIROqC9jxHDNjoF6kiIuAFCbBf4XeI1z
	 yBBtzESVbbSNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29675C83F27;
	Tue, 15 Jul 2025 20:21:08 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Tue, 15 Jul 2025 13:20:53 -0700
Subject: [PATCH net v2] net/mlx5: Correctly set gso_size when LRO is used
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
X-B4-Tracking: v=1; b=H4sIACS4dmgC/x2N0QqDMAwAf0XyvIArFt1+ZQzpYqx5SUtTRCb++
 8oeD467E4yLsMGzO6HwLiZJG7hbB7QFjYyyNAbXO9+P9wEph2C0YV7x4TyK7mxVYqjNVEqlMFW
 MlmaTL2NSpANHVCGcvPsMvg/TEhZo/Vx4leP/foFyhfd1/QDj4EQQkAAAAA==
X-Change-ID: 20250714-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-852b450a8dad
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Gal Pressman <gal@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752610867; l=3259;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=+zux3SKfHs3vKZon0w9riKpNcRAgFX0sLiVki6c1lMw=;
 b=yhoowKJGwpVa5ITYjE0xwLhyxs8867DSSeKO3J423J8X0y7cPV8oOTJZ/r6H/GXg9HhtTT4eN
 ljKX+BSfcQgCu/OsWUgDx2za891lZgCPk5MF7coVRhZ6rMm+sHf0Wq0
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

gso_size is expected by the networking stack to be the size of the
payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bcnt
is the full sized frame (including the headers). Dividing cqe_bcnt by
lro_num_seg will then give incorrect results.

For example, running a bpftrace higher up in the TCP-stack
(tcp_event_data_recv), we commonly have gso_size set to 1450 or 1451 even
though in reality the payload was only 1448 bytes.

This can have unintended consequences:
- In tcp_measure_rcv_mss() len will be for example 1450, but. rcv_mss
will be 1448 (because tp->advmss is 1448). Thus, we will always
recompute scaling_ratio each time an LRO-packet is received.
- In tcp_gro_receive(), it will interfere with the decision whether or
not to flush and thus potentially result in less gro'ed packets.

So, we need to discount the protocol headers from cqe_bcnt so we can
actually divide the payload by lro_num_seg to get the real gso_size.

v2:
 - Use "(unsigned char *)tcp + tcp->doff * 4 - skb->data)" to compute header-len
   (Tariq Toukan <tariqt@nvidia.com>)
 - Improve commit-message (Gal Pressman <gal@nvidia.com>)

Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 84b1ab8233b8107f0d954ea29c33601b279a2c27..7462514c7f3d1606339ede13a6207c1629ab65a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1154,8 +1154,9 @@ static void mlx5e_lro_update_tcp_hdr(struct mlx5_cqe64 *cqe, struct tcphdr *tcp)
 	}
 }
 
-static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
-				 u32 cqe_bcnt)
+static unsigned int mlx5e_lro_update_hdr(struct sk_buff *skb,
+					 struct mlx5_cqe64 *cqe,
+					 u32 cqe_bcnt)
 {
 	struct ethhdr	*eth = (struct ethhdr *)(skb->data);
 	struct tcphdr	*tcp;
@@ -1205,6 +1206,8 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
 		tcp->check = tcp_v6_check(payload_len, &ipv6->saddr,
 					  &ipv6->daddr, check);
 	}
+
+	return (unsigned int)((unsigned char *)tcp + tcp->doff * 4 - skb->data);
 }
 
 static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
@@ -1561,8 +1564,9 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 		mlx5e_macsec_offload_handle_rx_skb(netdev, skb, cqe);
 
 	if (lro_num_seg > 1) {
-		mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
-		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt, lro_num_seg);
+		unsigned int hdrlen = mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
+
+		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt - hdrlen, lro_num_seg);
 		/* Subtract one since we already counted this as one
 		 * "regular" packet in mlx5e_complete_rx_cqe()
 		 */

---
base-commit: 0e9418961f897be59b1fab6e31ae1b09a0bae902
change-id: 20250714-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-852b450a8dad

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>



