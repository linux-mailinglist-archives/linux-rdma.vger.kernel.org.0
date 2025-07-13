Return-Path: <linux-rdma+bounces-12094-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E21B03379
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 01:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E703B7D37
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 23:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E80720E31C;
	Sun, 13 Jul 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T++XEX8F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8820C038;
	Sun, 13 Jul 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752449640; cv=none; b=JGb4rJdsrOzJ/H3/uOxTSO8ur7cYvsKLVwSjRV8ehDGEJR9hxCf9uRczPtPHMwGxSQ2M54nvA3U6atTxopkUBvOXU6hcgyKcSy1YpGHR7EcpwlWKXBjUdvOky95igLlZdi+IT4PFwS00NyVwGDB0e9aIvuYqiri1JaPCQCyB28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752449640; c=relaxed/simple;
	bh=rZx1SkMZveDxpFokWjq4zHyNKfaAGFrKGY/aCfWh3Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TXL3QLP7PdU132dBLDIOdeE1j2Kw7HP2FKNLkHvi1Axpp9TBkVwGhrOgk7MKxvKoq7jF5l1ZztblJQlotITmCTQrRwwdVmWQ1q8n/mwYYQY/b0Hqr0h57MIOcGVe3g1+TcpGr2FCj2WlPLwJTSwgGs1b9Rdk2JQUYPVpSjdIRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T++XEX8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0E52C4CEE3;
	Sun, 13 Jul 2025 23:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752449639;
	bh=rZx1SkMZveDxpFokWjq4zHyNKfaAGFrKGY/aCfWh3Rw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T++XEX8FlZS3xxKooXEKyUrARt/DhR4lePd7U4kYLPFbDZyc9eWc95fL9TQj9iVvS
	 Fs0JYPBJ+LwNpbwCfwPar6Hw4wZF8WnH+xFzvMVPPYJrGf1R40cPGcF/r7+B1kussb
	 v7gteguZUhVsZfzqWWgm7L6lhlhrFdDPDopCvtglDT4kuAidnUFP75osOchWTWZTVN
	 cG/ygYpqQ+Rvq+ADldyuLsEAQe1dFjseJaDBmYzfpMsSIxbN/+9JOkaB6y3r/flSUi
	 EPb/0Qmngk2oOSoixjS3ODoSh8YkN11LQy838IWOZV7OrmfjL/gES59dnkWTJO3yIO
	 G+R7t8c/+6anw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F76C83F20;
	Sun, 13 Jul 2025 23:33:59 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Sun, 13 Jul 2025 16:33:07 -0700
Subject: [PATCH net-next 2/2] net/mlx5: Avoid copying payload to the skb's
 linear part
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752449639; l=4505;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=3eoDYR0mKHyF/8ZXKHLXmSDgpOtYhWd87w/vzV9U0ug=;
 b=TfxPnRtIqMqcg8MpgRH9G8tq/ps0qMu4H5Tg50NXLlhGNWisYuE69UZBKKW0CRTHgWQ1F4kOQ
 ezVyJhW6W8WBcd96TsG6gsR8fK4fVU1bXBip3ixCpRUZaxJjVRy/n3x
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
cqe_l3/l4_hdr_type and kind of do a lower-bound estimate. This is now
done in mlx5e_cqe_get_min_hdr_len(). We always assume that TCP timestamps
are present, as that's the most common use-case.

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

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 33 ++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 2bb32082bfccdc85d26987f792eb8c1047e44dd0..2de669707623882058e3e77f82d74893e5d6fefe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1986,13 +1986,40 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 	} while (data_bcnt);
 }
 
+static u16
+mlx5e_cqe_get_min_hdr_len(const struct mlx5_cqe64 *cqe)
+{
+	u16 min_hdr_len = sizeof(struct ethhdr);
+	u8 l3_type = get_cqe_l3_hdr_type(cqe);
+	u8 l4_type = get_cqe_l4_hdr_type(cqe);
+
+	if (cqe_has_vlan(cqe))
+		min_hdr_len += VLAN_HLEN;
+
+	if (l3_type == CQE_L3_HDR_TYPE_IPV4)
+		min_hdr_len += sizeof(struct iphdr);
+	else if (l3_type == CQE_L3_HDR_TYPE_IPV6)
+		min_hdr_len += sizeof(struct ipv6hdr);
+
+	if (l4_type == CQE_L4_HDR_TYPE_UDP)
+		min_hdr_len += sizeof(struct udphdr);
+	else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
+			    CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
+			    CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA))
+		/* Previous condition works because we know that
+		 * l4_type != 0x2 (CQE_L4_HDR_TYPE_UDP)
+		 */
+		min_hdr_len += sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
+
+	return min_hdr_len;
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
@@ -2004,10 +2031,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 linear_frame_sz;
 	u16 linear_data_len;
 	u16 linear_hr;
+	u16 headlen;
 	void *va;
 
 	prog = rcu_dereference(rq->xdp_prog);
 
+	headlen = min3(mlx5e_cqe_get_min_hdr_len(cqe), cqe_bcnt,
+		       (u16)MLX5E_RX_MAX_HEAD);
+
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
 		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);

-- 
2.49.0



