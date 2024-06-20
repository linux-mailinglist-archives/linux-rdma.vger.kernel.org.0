Return-Path: <linux-rdma+bounces-3376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729BE911599
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 00:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EAE1C22D28
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 22:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6530B15357A;
	Thu, 20 Jun 2024 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="N/LPXcTR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2A155380
	for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921977; cv=none; b=AlafdDqK9NLg4BCQW8VItrGJFi1qXmbYlwUXDZWVjE1EptfBKV5ZN9cfOWFxUwZRlADC+1r1MJQlSgJK8ocQK8F5VfiEin5EI/ayovFDn+QkQPf5/yMrLTUPXZJ4jwqpT+A7hrwOy8KM8EFROrsyv+0IjP8isd45yDHUxrlLpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921977; c=relaxed/simple;
	bh=VWUAy/ZNxE6p7rDLY6MrQyac9w5PJLnLtwGFxAwwDMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FM9+z+Re0aUKw0h/OFuNQFiiOlNywg8II1VB5cH9Gii5cyExM+TxW+ZuEYT8pelvXo6443l+uqFqXMFp9GKyZTquEgaWjJZe3EIvjk+6MpAE+gKuFv9SDaRt4UrWvu4sROZxgGp4gdFs9X6wy4i2Hc0jAJYe3yEw9wsZNOF1Y9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=N/LPXcTR; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e02b571b0f6so1433359276.0
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921974; x=1719526774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDikH4YaLTXcuYnnpoS1DDj9V6N9+XuA7sB909Kk9Go=;
        b=N/LPXcTR8PnDVduo2vOD3K8Moi9pNDsojIHKgrRnBaT84fe3X72siB2ySDxy+uXmVz
         SYAw6fKmFkui14CNcPo7VHplcZ/E+FuHZ3DndGKSNWnWgaiyXyttGNG5jfzTLZdcvIoB
         A928unxRAUV6cGzd2G/kKPPSj67n5QmXa1C+F9t5CZyUu/7A68H1aW1TFPLYjka85Ox5
         xAgFrgdMJZswQA3F+69+aWNfxA+W8E/VNaQbdL4rhbDQQSGWQoTAVO9+me3J2mIKsqkO
         abDlJNQpbVK4P5BOBMYL4NMXl5tzpNPbk1GvlFXyXt8ddYTJChol2Q0TX9tZ2MgeWqgA
         3M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921974; x=1719526774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDikH4YaLTXcuYnnpoS1DDj9V6N9+XuA7sB909Kk9Go=;
        b=etP5G02mEd7kSM6HtXMIw3ms30jJLr0y/NWhP8XYQARS8rdbxTYm20BfTSH0s9ppYG
         r6LWGP1/HnLw/50NzSQhFx1AbGfkVFZ0jpL3QthTmj7CGUFmABogCYvGhE2izh/KiWKr
         o5HFaRq7A6SRwgffeI+f9d3A+72L8B/mBYfZKmGtFyezhk1wvNgSETXvqp9VGvvxVRw2
         yCpOCDH6xg+BZmuWqr3cYvJiQAvXyDWGwEOIEN+FwsVwYWCJWaw+lhORGRYBHaLhRiC6
         Izwtxh59sdbgLG1eSTNG3ahY7k2ud1/bR6Du4/O+Ago71mu4ywV70a0a88jwGvkoNdYB
         VcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm39oojQEGmZ7m7nuP5peuqTaUZ5vDWj7zvhAU+XVPYYuTvcfSwGDqbe3/rT4CVnq4o+jkZoOCCg3vDgXIyR1NSxezY6PiUA2kwQ==
X-Gm-Message-State: AOJu0YxTln9cZhPdcv87gFWUTVTlNwwsapBvM0BHNCbR9GQCBeYS2i/e
	Bu/FMkTpHcN7Y1QAildkFTzP9lyxG6Kyrkzp57Rs6dfDFNdTH1ZTdOmTRXSJGnE=
X-Google-Smtp-Source: AGHT+IHNipijp9iknX8bwqwkZcNc9ZQwSjOEiZMJ1rIL/QjtE7CaIIK/m+10m7GL91Ub5FwPFGeljA==
X-Received: by 2002:a25:6801:0:b0:dfb:61e:3ee0 with SMTP id 3f1490d57ef6-e02be10a99emr7068721276.10.1718921974450;
        Thu, 20 Jun 2024 15:19:34 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b665a7sm1942401cf.26.2024.06.20.15.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:33 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:31 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Yan Zhai <yan@cloudflare.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC net-next 8/9] mlx5: apply XDP offloading fixup when building skb
Message-ID: <17595a278ee72964b83c0bd0b502152aa025f600.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718919473.git.yan@cloudflare.com>

Add a common point to transfer offloading info from XDP context to skb.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |  8 ++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 4dacaa61e106..9bf49ff2e0dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -250,7 +250,7 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 						    u16 cqe_bcnt,
 						    u32 head_offset,
 						    u32 page_idx,
-						    struct mlx5e_xdp_buff *mxbuf_)
+						    struct mlx5e_xdp_buff *mxbuf_caller)
 {
 	struct mlx5e_xdp_buff *mxbuf = xsk_buff_to_mxbuf(wi->alloc_units.xsk_buffs[page_idx]);
 	struct bpf_prog *prog;
@@ -270,6 +270,7 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 
 	/* mxbuf->rq is set on allocation, but cqe is per-packet so set it here */
 	mxbuf->cqe = cqe;
+	xdp_init_buff_minimal(&mxbuf->xdp);
 	xsk_buff_set_size(&mxbuf->xdp, cqe_bcnt);
 	xsk_buff_dma_sync_for_cpu(&mxbuf->xdp);
 	net_prefetch(mxbuf->xdp.data);
@@ -295,6 +296,7 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 			__set_bit(page_idx, wi->skip_release_bitmap); /* non-atomic */
 		return NULL; /* page/packet was consumed by XDP */
 	}
+	mxbuf_caller->xdp.flags = mxbuf->xdp.flags;
 
 	/* XDP_PASS: copy the data from the UMEM to a new SKB and reuse the
 	 * frame. On SKB allocation failure, NULL is returned.
@@ -306,7 +308,7 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 					      struct mlx5e_wqe_frag_info *wi,
 					      struct mlx5_cqe64 *cqe,
 					      u32 cqe_bcnt,
-					      struct mlx5e_xdp_buff *mxbuf_)
+					      struct mlx5e_xdp_buff *mxbuf_caller)
 {
 	struct mlx5e_xdp_buff *mxbuf = xsk_buff_to_mxbuf(*wi->xskp);
 	struct bpf_prog *prog;
@@ -320,6 +322,7 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 
 	/* mxbuf->rq is set on allocation, but cqe is per-packet so set it here */
 	mxbuf->cqe = cqe;
+	xdp_init_buff_minimal(&mxbuf->xdp);
 	xsk_buff_set_size(&mxbuf->xdp, cqe_bcnt);
 	xsk_buff_dma_sync_for_cpu(&mxbuf->xdp);
 	net_prefetch(mxbuf->xdp.data);
@@ -330,6 +333,7 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 			wi->flags |= BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
 		return NULL; /* page/packet was consumed by XDP */
 	}
+	mxbuf_caller->xdp.flags = mxbuf->xdp.flags;
 
 	/* XDP_PASS: copy the data from the UMEM to a new SKB. The frame reuse
 	 * will be handled by mlx5e_free_rx_wqe.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1a592a1ab988..0a47889e281e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1670,6 +1670,8 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 	dma_addr_t addr;
 	u32 frag_size;
 
+	xdp_init_buff_minimal(&mxbuf->xdp);
+
 	va             = page_address(frag_page->page) + wi->offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
@@ -1721,6 +1723,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	void *va;
 
 	frag_page = wi->frag_page;
+	xdp_init_buff_minimal(&mxbuf->xdp);
 
 	va = page_address(frag_page->page) + wi->offset;
 	frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
@@ -1837,6 +1840,7 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	}
 
 	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	xdp_buff_fixup_skb_offloading(&mxbuf.xdp, skb);
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -1885,6 +1889,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	}
 
 	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	xdp_buff_fixup_skb_offloading(&mxbuf.xdp, skb);
 
 	if (rep->vlan && skb_vlan_tag_present(skb))
 		skb_vlan_pop(skb);
@@ -1935,6 +1940,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 		goto mpwrq_cqe_out;
 
 	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	xdp_buff_fixup_skb_offloading(&mxbuf.xdp, skb);
 
 	mlx5e_rep_tc_receive(cqe, rq, skb);
 
@@ -2138,6 +2144,8 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		return NULL;
 	}
 
+	xdp_init_buff_minimal(&mxbuf->xdp);
+
 	va             = page_address(frag_page->page) + head_offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
@@ -2345,6 +2353,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	}
 
 	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
+	xdp_buff_fixup_skb_offloading(&mxbuf.xdp, *skb);
+
 	if (flush && rq->hw_gro_data->skb)
 		mlx5e_shampo_flush_skb(rq, cqe, match);
 free_hd_entry:
@@ -2404,6 +2414,7 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 		goto mpwrq_cqe_out;
 
 	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	xdp_buff_fixup_skb_offloading(&mxbuf.xdp, skb);
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -2649,6 +2660,8 @@ static void mlx5i_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 
 	mlx5i_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	xdp_buff_fixup_skb_offloading(&mxbuf.xdp, skb);
+
 	if (unlikely(!skb->dev)) {
 		dev_kfree_skb_any(skb);
 		goto wq_cyc_pop;
@@ -2740,6 +2753,7 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 
 	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
 	skb_push(skb, ETH_HLEN);
+	xdp_buff_fixup_skb_offloading(&mxbuf.xdp, skb);
 
 	mlx5_devlink_trap_report(rq->mdev, trap_id, skb,
 				 rq->netdev->devlink_port);
-- 
2.30.2



