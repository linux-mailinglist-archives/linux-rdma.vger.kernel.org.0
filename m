Return-Path: <linux-rdma+bounces-12533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6CEB152DE
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 20:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C57F4E2E81
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7750E244681;
	Tue, 29 Jul 2025 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGasT69i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E845220F20;
	Tue, 29 Jul 2025 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814052; cv=none; b=rXZC846JfA9tqkR5Oq3kG+MSZCaGTPcBumpJ/2y2TlsaQwquIrGKBK1UnsN65XLET2CMnNxhH0KcOFmgjE9OupQFibZwHb44vObIsgnX1GYrFbSM4LVpYcrKph2yTfxC8LT3Ik1VSCWzEYA00dM78in3umB+RoB47nZSiB7e2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814052; c=relaxed/simple;
	bh=FL9N2jUW9ILZvMTN4kv4hjivBOzbZrdxkcak7uxAnuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iX1K36Wd/r5Z4D11ZRiRANEI51+XozQLmSsmjzeektWi7HhEZE/WW0Y2qeod3RT4WfetyMnhFtdsXGu37Lumj7369rEnWvtV4nJpq6KSodOTc0p+h74Aai3R9Tq4g6l3HbMioYvbEC2ImxemfU6KMAkfpeNPkH8jICx74hqA6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGasT69i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB641C4CEEF;
	Tue, 29 Jul 2025 18:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814052;
	bh=FL9N2jUW9ILZvMTN4kv4hjivBOzbZrdxkcak7uxAnuA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=FGasT69iyDvEF4s7Z1+JN86M1M4Zcuzi/d4ii0HSEqljoRFMVwN5hcuNLfSUrmd28
	 1bFR4peXanuSv5H1ehUleXC0g5XgGgwwxsi+vG//QOa9eBNrHY6X+CBDLGlrlJScJG
	 JdqykLK7y9gKW47nee0B8ZJ0zrcX6ph55DtHlYTr4BGjnja31zWiJuOx8kZmgYgfIA
	 Ehm5s9c4tdeh5Cb9r9krSm+dv3c2L3JP1hOudUW/kznXz5oXqTqb0hfoz73EONCnl3
	 bhD19PVxs7D+rne4ETAENYPoCslOELNXuFdNjrpVmkepy1+7/FX5xNhBUHzcsG7/zI
	 JJjFYUPrcXK7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2178C87FCA;
	Tue, 29 Jul 2025 18:34:11 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Tue, 29 Jul 2025 11:34:00 -0700
Subject: [PATCH net] net/mlx5: Correctly set gso_segs when LRO is used
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-mlx5_gso_segs-v1-1-b48c480c1c12@openai.com>
X-B4-Tracking: v=1; b=H4sIABcUiWgC/x3MSQqAMBAF0atIrw3EYHC4iog4fGODRkmLCOLdD
 S7fouohQWAI1clDARcL7z4iSxMal947KJ6iyWhjdWEqta237ZzsncCJKmHRmykfqkFTbI6Ame/
 /15DHSe37fvYiHwdkAAAA
X-Change-ID: 20250729-mlx5_gso_segs-8e5ea2d4b9b0
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Amir Vadai <amirv@mellanox.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>, Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753814051; l=2293;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=BEl29bER/lvNXl8OFGctWB+GNXoUpmP6lKzTKh8mgKg=;
 b=yG4Ad4zj5YUqZ8aVs2erdhWF4rIFYiTUjcQ5GjoBH6yq2o/jWDsZQQKaa5fOXpKT2toAU1YBc
 BIRIRVF3CTBAzabqecpVEuwaesH5SNP3pEififo1w7jqr08AnCvRt9H
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

When gso_segs is left at 0, a number of assumptions will end up being
incorrect throughout the stack.

For example, in the GRO-path, we set NAPI_GRO_CB()->count to gso_segs.
So, if a non-LRO'ed packet followed by an LRO'ed packet is being
processed in GRO, the first one will have NAPI_GRO_CB()->count set to 1 and
the next one to 0 (in dev_gro_receive()).
Since commit 531d0d32de3e
("net/mlx5: Correctly set gso_size when LRO is used")
these packets will get merged (as their gso_size now matches).
So, we end up in gro_complete() with NAPI_GRO_CB()->count == 1 and thus
don't call inet_gro_complete(). Meaning, checksum-validation in
tcp_checksum_complete() will fail with a "hw csum failure".

Even before the above mentioned commit, incorrect gso_segs means that other
things like TCP's accounting of incoming packets (tp->segs_in,
data_segs_in, rcv_ooopack) will be incorrect. Which means that if one
does bytes_received/data_segs_in, the result will be bigger than the
MTU.

Fix this by initializing gso_segs correctly when LRO is used.

Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
Reported-by: Gal Pressman <gal@nvidia.com>
Closes: https://lore.kernel.org/netdev/6583783f-f0fb-4fb1-a415-feec8155bc69@nvidia.com/
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 7462514c7f3d1606339ede13a6207c1629ab65a3..da3e340c99b72ce27861cccaa5bd722c1b446a55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1567,6 +1567,7 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 		unsigned int hdrlen = mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
 
 		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt - hdrlen, lro_num_seg);
+		skb_shinfo(skb)->gso_segs = lro_num_seg;
 		/* Subtract one since we already counted this as one
 		 * "regular" packet in mlx5e_complete_rx_cqe()
 		 */

---
base-commit: afd8c2c9e2e29c6c7705635bea2960593976dacc
change-id: 20250729-mlx5_gso_segs-8e5ea2d4b9b0

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>



