Return-Path: <linux-rdma+bounces-12917-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DFAB3525A
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 05:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAA13AD076
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 03:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94D2D5427;
	Tue, 26 Aug 2025 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqaHbDkp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD42D46D1;
	Tue, 26 Aug 2025 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180044; cv=none; b=ht4nEORTSt7YzyBwy2xo7lk1CIhykclx2HsiH4qrbhL7j1tff4FWVOmkRgWRdTj93zinQYwhuy1p1xR7zCKQ808EFZiNC+VRb4Q8mvJmdlrv+NbsFUNUoe1HFWot//dzQ0id485tz/AneSwTbq0GPJ7QqeFJaD2ypECsrnmuHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180044; c=relaxed/simple;
	bh=yLYQVKhqwB/ijZirbZGgAU4hOXvqaurt5kLnfO9bU8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWrNbEWQYF0Fl4hxV0cNkE7QqZA/mEJkyKxqM0kZM7sd5rYhctODU6lkmu7CBT80ITDrqkjujMBnJjnNTZdQ68kVTMzPYqQ8Y64JkAKfoBB9Gx469XiCCQqyj647FVNvx4qeeJlzl/OF5/vHFrSg0kPk1QKOmJmydNz822nX/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqaHbDkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5A48C116B1;
	Tue, 26 Aug 2025 03:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756180043;
	bh=yLYQVKhqwB/ijZirbZGgAU4hOXvqaurt5kLnfO9bU8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tqaHbDkpnwkSwCgAA6hLpxcnhvAUpuxCKL3LnqCjBlDeoeXmORubLNXhmuTEeWw1C
	 NnIsad0cA6Q5vybbCYdSFL2YhwC467uPuPuxre/Py2k5yWJ9NZUtkO3vrsYgkvF2ae
	 I4EiYyxBGYG15MrUBzzeONR9eiKbHjADUe7kq0TmHYREMx1nEzu2sEEDOo0U+fbGKw
	 8y7dYthxnymzL7pZoFcX6XTjNsWwYcIAnmXUuwi2fkiStN8uo9XJ/k7JQ6WibFX9A/
	 S8/rPPM2ngGHP4iypsx4/fh4iyjiExUB4Xq72R/v6HHrGCuRPCCh80lhrz/iwPryip
	 iwOof5Y7p90pQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A229FCA0EFA;
	Tue, 26 Aug 2025 03:47:23 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Mon, 25 Aug 2025 20:47:13 -0700
Subject: [PATCH net-next v3 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-2-5527e9eb6efc@openai.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756180043; l=5447;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=D9E65BwQNcFvlAPB/eyJC0zHDSe2SK53bOifpMzA4GA=;
 b=EbNFWUl4M6B4ZFYeUkogwcsUxWNMy5CP1KLDAhKVRptNzM/Y5jWOyqbwjjBoZATbZutEHNyU7
 TdkR4PtGvkVAtFi/uPiz862fVX6B9qXUwyJwaoofxEcWdh1K2D+bXpX
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
bytes from the page-pool to the skb's linear part. Those 256 bytes
include part of the payload.

When attempting to do GRO in skb_gro_receive, if headlen > data_offset
(and skb->head_frag is not set), we end up aggregating packets in the
frag_list.

This is of course not good when we are CPU-limited. Also causes a worse
skb->len/truesize ratio,...

So, let's avoid copying parts of the payload to the linear part. The
goal here is to err on the side of caution and prefer to copy too little
instead of copying too much (because once it has been copied over, we
trigger the above described behavior in skb_gro_receive).

So, we can do a rough estimate of the header-space by looking at
cqe_l3/l4_hdr_type. This is now done in mlx5e_cqe_estimate_hdr_len().
We always assume that TCP timestamps are present, as that's the most common
use-case.

That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
the headlen (which defines what is being copied over). We still
allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
needs to call pskb_may_pull() later on, we don't need to reallocate
memory.

This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
LRO enabled):

BEFORE:
=======
(netserver pinned to core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.01    32547.82

(netserver pinned to adjacent core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    52531.67

AFTER:
======
(netserver pinned to core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    52896.06

(netserver pinned to adjacent core receiving interrupts)
 $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    85094.90

Additional tests across a larger range of parameters w/ and w/o LRO, w/
and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
better performance with this patch.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 49 ++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11bd315e8fb67f794a91bd37cd28c0..050f3efca34f3b8984c30f335ee43f487fef33ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1991,13 +1991,54 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 	} while (data_bcnt);
 }
 
+static u16
+mlx5e_cqe_estimate_hdr_len(const struct mlx5_cqe64 *cqe, u16 cqe_bcnt)
+{
+	u8 l3_type, l4_type;
+	u16 hdr_len;
+
+	hdr_len = sizeof(struct ethhdr);
+
+	if (cqe_has_vlan(cqe))
+		hdr_len += VLAN_HLEN;
+
+	l3_type = get_cqe_l3_hdr_type(cqe);
+	if (l3_type == CQE_L3_HDR_TYPE_IPV4) {
+		hdr_len += sizeof(struct iphdr);
+	} else if (l3_type == CQE_L3_HDR_TYPE_IPV6) {
+		hdr_len += sizeof(struct ipv6hdr);
+	} else {
+		hdr_len = MLX5E_RX_MAX_HEAD;
+		goto out;
+	}
+
+	l4_type = get_cqe_l4_hdr_type(cqe);
+	if (l4_type == CQE_L4_HDR_TYPE_UDP) {
+		hdr_len += sizeof(struct udphdr);
+	} else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
+			      CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
+			      CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA)) {
+		/* ACK_NO_ACK | ACK_NO_DATA | ACK_AND_DATA == 0x7, but
+		 * the previous condition checks for _UDP which is 0x2.
+		 *
+		 * As we know that l4_type != 0x2, we can simply check
+		 * if any of the bits of 0x7 is set.
+		 */
+		hdr_len += sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
+	} else {
+		hdr_len = MLX5E_RX_MAX_HEAD;
+	}
+
+out:
+	return min3(hdr_len, cqe_bcnt, MLX5E_RX_MAX_HEAD);
+}
+
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
 				   u32 page_idx)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
-	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
 	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
 	u32 frag_offset    = head_offset;
@@ -2009,6 +2050,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 linear_frame_sz;
 	u16 linear_data_len;
 	u16 linear_hr;
+	u16 headlen;
 	void *va;
 
 	prog = rcu_dereference(rq->xdp_prog);
@@ -2039,6 +2081,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		net_prefetchw(va); /* xdp_frame data area */
 		net_prefetchw(skb->data);
 
+		headlen = mlx5e_cqe_estimate_hdr_len(cqe, cqe_bcnt);
+
 		frag_offset += headlen;
 		byte_cnt -= headlen;
 		linear_hr = skb_headroom(skb);
@@ -2115,6 +2159,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				pagep->frags++;
 			while (++pagep < frag_page);
 		}
+
+		headlen = mlx5e_cqe_estimate_hdr_len(cqe, cqe_bcnt);
+
 		__pskb_pull_tail(skb, headlen);
 	} else {
 		dma_addr_t addr;

-- 
2.50.1



