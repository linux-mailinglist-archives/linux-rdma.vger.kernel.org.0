Return-Path: <linux-rdma+bounces-13825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D55BD3EF1
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71F5A4F366E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812103101D4;
	Mon, 13 Oct 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBPnpKP4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97C30F7E9
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367221; cv=none; b=OSG9OT0vgZ2H+xo2762P8PEB9so3GJxc8DD6sqCVvc7zT+PfjGhoKJZq3NuG2WgGVkRjIz1HNBE/NQ/BQK+QKC1P8O64O55/lYD2ye0KzMaGY/06sWyvcVLH/LSpFJUuRQGgz1hqXe/ZdmTWHF9aVYCxlNLTWBfiHQhu4/yKVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367221; c=relaxed/simple;
	bh=01HcQ+bfWPiQW2hfPP1jD1pyLZ1kMeF3Kk/SUPuy8aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izqLPbT+g+drFPr4E4/t6pF7N655NMeVWBpvGa20iGXcjaimE+7MpXusVhbfW6zjrq4QXqEY0jNf81CEFtBUcSytaTQ2KVR69RWOT/APVPuRw1b0sW0WbH/d7SpitGmY9zXWJuw4JzVzpLJCCmhoyvM3Qtshfb35XTUhwMONFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBPnpKP4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42421b1514fso2156214f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367216; x=1760972016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDydaL+0kX4XVTgkMgf2Tdq79K2+oRpgLC/WXO4c2NY=;
        b=KBPnpKP4Ji9mtBj0UtQH2XnZqsg4/0C+2FXpQjdsR/dyEBzY35xzX3LJdoTvORFimo
         EAZkU3SjJh2695nGmxoyKzaZm0qNSCfkqzCb6RSnn7XrW3M57vcA+5NgL6esQCyefElt
         vxG/+hq2TAT2si4AQIS2wocgzQiHTV1H+pzACXV6bbNI5vifQxC1A+zbSdNwShTsou1c
         NdzRJ+67hvJ+rGv8/uYydvw5q8Q+RZcVSpYwXTJ7VyWp/xQU9bUOwE3w5W+KKtNRzf/u
         C9LWKWiNbOmqW6r8VH1apStsA29QwMXUabjBtdAFwom9pXItQM9L04zM4MtxyHJEYbsX
         zRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367216; x=1760972016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDydaL+0kX4XVTgkMgf2Tdq79K2+oRpgLC/WXO4c2NY=;
        b=oTmqqIv8/Arhkhi0jG9OGiLP1MyJ0YOhsoBfjGU8MrVAtGmedqOOSlPIUMhZIOww6D
         ZtA3gt0DdOa86Fu+18hhwlUYkgWA9YRYhoBMBdLbsbB77QPrani5eNxJ6yMWohWedm2Q
         ZgC310wf80blh6NMI6G98oLor+m1N0HQ/seo+4k5/ouZuqz6Xg6JJNwOKFgZjmCjxa7+
         zn/pJlKq6/+N7vM+RhF9HjOKuVmkQmSWT1Vnh0Km1Egx1h5DXohCS3hVAb84PZudeHo3
         3uSDrSHokpvk8YEbARLqUE870nGRVYd3LIJ9/Qmy4QNFIpkg4hu6k0zgbrEspESYewp9
         jwUA==
X-Forwarded-Encrypted: i=1; AJvYcCXfzBwM0gLqtcUwaC7+6D6i4Z3yQCqVK81fOMHcpmfIrBt28QJFv0VQEta1Kf4m37eg/2JcPBnggulC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Ypn5qwvodYlNylYnpRhJAXj489K7Q0LTYIh/XfOYfXTZ+nnH
	O7I83wNbhj+v7nHIZVFCKLmdBEAGdzRmhBUZsCepeMgcYf/20blkAexm
X-Gm-Gg: ASbGnctN5RzSDBpmzkPF/szBCmpRn0ICAwTiNeD0eoVuAZaIbAeQMEHo0RqgLPxZY0q
	FNkTYyryHIxpT8o834A76kBiz1SwkxcmDrhsK84JL8Z2oJa1rP5gEqKQok6uqVkJzN0IiOikIGo
	hWSp7JYrCdIjFhXaLzweLKuUAFxaKSQsAbWn+NjYb9AMt7d/voFjELlqZ/1BYwE/sbQsly8ZVDT
	A/F5tvrlBIcfzGJlkuG9UPIxyUawGTAb25thRc6J7G3Trgygc17yR11P/d7lVTbxNrmkkLpyfL2
	nvx6Wk7NR40Grad7RYVlcQpa2AMtE7hxDUkTbp5iknpgffQOf2atEhtonKSiqyprPKTZqBgQCC5
	JlHJ/+yfyIQTuez/Pa3zJiH2A
X-Google-Smtp-Source: AGHT+IHRs27nVpctjKFY9Eh6lI0fbhQhREsazw83w2WNaCFmZvecllGP5owrumusgM8b2+r8u2mOcQ==
X-Received: by 2002:a05:6000:178c:b0:3e7:5f26:f1e8 with SMTP id ffacd0b85a97d-42666ab3390mr14959494f8f.5.1760367216021;
        Mon, 13 Oct 2025 07:53:36 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:35 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 08/24] eth: bnxt: read the page size from the adapter struct
Date: Mon, 13 Oct 2025 15:54:10 +0100
Message-ID: <d4e27a4a9a6daae6a80b79dfd675ea641e4e2097.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Switch from using a constant to storing the BNXT_RX_PAGE_SIZE
inside struct bnxt. This will allow configuring the page size
at runtime in subsequent patches.

The MSS size calculation for older chip continues to use the constant.
I'm intending to support the configuration only on more recent HW,
looks like on older chips setting this per queue won't work,
and that's the ultimate goal.

This patch should not change the current behavior as value
read from the struct will always be BNXT_RX_PAGE_SIZE at this stage.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: place const on right side in comparisons]
[pavel: update __bnxt_alloc_rx_netmem's size check]
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 32 ++++++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 +--
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3fc33b1b4dfb..13286f4a2fa7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -905,7 +905,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 
 static bool bnxt_separate_head_pool(struct bnxt_rx_ring_info *rxr)
 {
-	return rxr->need_head_pool || PAGE_SIZE > BNXT_RX_PAGE_SIZE;
+	return rxr->need_head_pool || rxr->bnapi->bp->rx_page_size < PAGE_SIZE;
 }
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
@@ -915,9 +915,9 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 {
 	struct page *page;
 
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
+	if (bp->rx_page_size < PAGE_SIZE) {
 		page = page_pool_dev_alloc_frag(rxr->page_pool, offset,
-						BNXT_RX_PAGE_SIZE);
+						bp->rx_page_size);
 	} else {
 		page = page_pool_dev_alloc_pages(rxr->page_pool);
 		*offset = 0;
@@ -936,8 +936,9 @@ static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *mapping,
 {
 	netmem_ref netmem;
 
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
-		netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset, BNXT_RX_PAGE_SIZE, gfp);
+	if (bp->rx_page_size < PAGE_SIZE) {
+		netmem = page_pool_alloc_frag_netmem(rxr->page_pool, offset,
+						     bp->rx_page_size, gfp);
 	} else {
 		netmem = page_pool_alloc_netmems(rxr->page_pool, gfp);
 		*offset = 0;
@@ -1155,9 +1156,9 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, bp->rx_page_size,
 				bp->rx_dir);
-	skb = napi_build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
+	skb = napi_build_skb(data_ptr - bp->rx_offset, bp->rx_page_size);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
@@ -1189,7 +1190,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, bp->rx_page_size,
 				bp->rx_dir);
 
 	if (unlikely(!payload))
@@ -1203,7 +1204,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	skb_mark_for_recycle(skb);
 	off = (void *)data_ptr - page_address(page);
-	skb_add_rx_frag(skb, 0, page, off, len, BNXT_RX_PAGE_SIZE);
+	skb_add_rx_frag(skb, 0, page, off, len, bp->rx_page_size);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1288,7 +1289,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 		if (skb) {
 			skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netmem,
 					       cons_rx_buf->offset,
-					       frag_len, BNXT_RX_PAGE_SIZE);
+					       frag_len, bp->rx_page_size);
 		} else {
 			skb_frag_t *frag = &shinfo->frags[i];
 
@@ -1313,7 +1314,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 			if (skb) {
 				skb->len -= frag_len;
 				skb->data_len -= frag_len;
-				skb->truesize -= BNXT_RX_PAGE_SIZE;
+				skb->truesize -= bp->rx_page_size;
 			}
 
 			--shinfo->nr_frags;
@@ -1328,7 +1329,7 @@ static u32 __bnxt_rx_agg_netmems(struct bnxt *bp,
 		}
 
 		page_pool_dma_sync_netmem_for_cpu(rxr->page_pool, netmem, 0,
-						  BNXT_RX_PAGE_SIZE);
+						  bp->rx_page_size);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -4478,7 +4479,7 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
 	ring = &rxr->rx_agg_ring_struct;
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
-		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
+		type = ((u32)bp->rx_page_size << RX_BD_LEN_SHIFT) |
 			RX_BD_TYPE_RX_AGG_BD | RX_BD_FLAGS_SOP;
 
 		bnxt_init_rxbd_pages(ring, type);
@@ -4740,7 +4741,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	bp->rx_agg_nr_pages = 0;
 
 	if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
-		agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);
+		agg_factor = min_t(u32, 4, 65536 / bp->rx_page_size);
 
 	bp->flags &= ~BNXT_FLAG_JUMBO;
 	if (rx_space > PAGE_SIZE && !(bp->flags & BNXT_FLAG_NO_AGG_RINGS)) {
@@ -7054,7 +7055,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 	if (ring_type == HWRM_RING_ALLOC_AGG) {
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
 		req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
-		req->rx_buf_size = cpu_to_le16(BNXT_RX_PAGE_SIZE);
+		req->rx_buf_size = cpu_to_le16(bp->rx_page_size);
 		enables |= RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID;
 	} else {
 		req->rx_buf_size = cpu_to_le16(bp->rx_buf_use_size);
@@ -16631,6 +16632,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bp = netdev_priv(dev);
 	bp->board_idx = ent->driver_data;
 	bp->msg_enable = BNXT_DEF_MSG_ENABLE;
+	bp->rx_page_size = BNXT_RX_PAGE_SIZE;
 	bnxt_set_max_func_irqs(bp, max_irqs);
 
 	if (bnxt_vf_pciid(bp->board_idx))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 741b2d854789..bbf4ff49ac0f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2361,6 +2361,7 @@ struct bnxt {
 	u16			max_tpa;
 	u32			rx_buf_size;
 	u32			rx_buf_use_size;	/* useable size */
+	u16			rx_page_size;
 	u16			rx_offset;
 	u16			rx_dma_offset;
 	enum dma_data_direction	rx_dir;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 3e77a96e5a3e..c23c04007136 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -183,7 +183,7 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 			u16 cons, u8 *data_ptr, unsigned int len,
 			struct xdp_buff *xdp)
 {
-	u32 buflen = BNXT_RX_PAGE_SIZE;
+	u32 buflen = bp->rx_page_size;
 	struct bnxt_sw_rx_bd *rx_buf;
 	struct pci_dev *pdev;
 	dma_addr_t mapping;
@@ -469,7 +469,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 		return NULL;
 
 	xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
-				  BNXT_RX_PAGE_SIZE * num_frags,
+				  bp->rx_page_size * num_frags,
 				  xdp_buff_get_skb_flags(xdp));
 	return skb;
 }
-- 
2.49.0


