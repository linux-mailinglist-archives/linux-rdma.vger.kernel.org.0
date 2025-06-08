Return-Path: <linux-rdma+bounces-11059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08281AD11C2
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 11:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD997A29D5
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77294202C26;
	Sun,  8 Jun 2025 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeZTRRmq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3898EEAA
	for <linux-rdma@vger.kernel.org>; Sun,  8 Jun 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749376764; cv=none; b=NHOi1KnknjsNNxvnlI3GNyDaNHzt2/jYAvWc+CX61o8CA3hmfkJnjnL9yegApldtUaNnf8/GM3Hir+YTgUpijnAL+M5n0Slii7BiE/if4BTBReYEfkMmaPe4h6jwUvlr+2BCAxQJ72ruXSyXZSO58CjbxNoCH4pgPOOW0xFmhis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749376764; c=relaxed/simple;
	bh=sU9SuUEKcUyKLRi9+OB2CW7MrxbUdp7b3WiiADJwJ4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SL8XjhnzyvN1CsyGklyXqo4d+Mq1vg27ihUliv7EIARip9VIIz2kfISsHzWFPuXF0r+Za5E5hGbGPU3aeK9i3odAwhJDeFFbfUnYe2bloDsPUpya5PfY5cWj+OnTXwO6lcv+LBlEBz3yLBcL1cYLDjZBqgsAu4VS94B9f3k+IqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeZTRRmq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b1fd59851baso1878178a12.0
        for <linux-rdma@vger.kernel.org>; Sun, 08 Jun 2025 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749376762; x=1749981562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNTaU6mV/FLBqH1O3LrpbmR9sqV7O5lCCzDAsyAeMIw=;
        b=aeZTRRmqaSwajU/A4cNQBzVjXIPAVkek1hcDB4jSigEujwy3ka+xBstda7Ovbn5NAq
         OilbWyfUjsgsFOkIkI+Q044cVc7LlIn+/fObqdEOSAtE5SGB9Zd3uNI1Mau0bjrS5zgs
         lajf9/2VE/u1JFA50Mtu+N1/xVFT6FRhHTVqG5IMCCh1vU/fyVmDI87N0TpUVLjttYS3
         ggAlHs4fMt/JtTlhPjPnzMojh+QSHqnX9dOHVz+nxhEqgXwNEstrYD4rOHznDrg0Jc4y
         qHrXmd86vd7qO7XODqkHV6SxdQ6W8zJ/jhwuOnQT7mXEWgrIqdY4VSHsBTLGc5Qyie8f
         9v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749376762; x=1749981562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNTaU6mV/FLBqH1O3LrpbmR9sqV7O5lCCzDAsyAeMIw=;
        b=VHMNIIipWA9J/PUPSRFSTLWOgRPZATqCf2LcsawbJLB+vXJcELD/Awk7PzHCBgfCQc
         Q8J1q8C5mYwV0N1ValCKL3De+GKVBKecGHGAx9QbnCYajOCw6R1g8DCyfsxq23ULVllj
         gr5Paag262d0CEoBHrRgR+ogCRBLvSTpJC33IWvbUsT6v6syY4Fs0MsQoRbiQUTE9a2r
         wGJjUj2P/PR16LUefTLfwUqI7CP13EDVlm87u33niEMpagiEs3vDo33sRsRIpcgVo7d7
         24Ess3XO25zNFI7PMRM89smStiARw8ZhvrCT+1oG2cGQCFleBFbpu1Eme1Nj6Bp8SQ/3
         uOkw==
X-Gm-Message-State: AOJu0YwYn4LkjzWc/53DSMP1285CL3SVm+zrZMqL6T0nYb/FDoPajiGc
	Hizdw7jn1PcbR9NF4IJcuqUbmL6w6VN+5pf8ENUeOgzRsJ19zW6kJ6EQNnLGcQ==
X-Gm-Gg: ASbGncsY49zE/PS54K3QekPiCG9HbOss9rQllu3L2jRofI/zhdz2eX+9uC0V0TzlK80
	xdgTSEHtPEWMVzGjpsULiOVsBR5r1yGKpFjwsKVHus4noTEFxLxWrZdCmqrcy20hKKzMOYONRzO
	sV6vQzIDm9USpRhHz0m0ANi9qbPWj55RSgSGHW3wUCYPA2iFQyh3HiWpIFS/+3azqT6R51n+c1m
	oFYUse5wPMxUW3emIL64C5oBR+O7hSZxaTIGXzBr0GURQRZ/OLafIvCRqhz3t3iIM+K1/ym/ENI
	sZtKmc26sN0WSmyXkyUmiICwXA4zJbHCHgvIozP1AV+LXT4jujav/bgdivL7dRdg7Zqz95IMVcG
	l4rHOvTVKWhWqgNo3
X-Google-Smtp-Source: AGHT+IEoAJtilVsJJZ/nMNaBaytotJ67012eL2Q6izkxvGpMqpdIKuiiNHI+87ZbKVYYWWzcoX0OCA==
X-Received: by 2002:a05:6a21:4cc7:b0:21d:a9d:ba3b with SMTP id adf61e73a8af0-21ee26447e9mr12256211637.39.1749376762121;
        Sun, 08 Jun 2025 02:59:22 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f7852b1sm3539302a12.58.2025.06.08.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:59:21 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v2] RDMA/rxe: Remove redundant page presence check
Date: Sun,  8 Jun 2025 09:59:16 +0000
Message-ID: <20250608095916.6313-1-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hmm_pfn_to_page() does not return NULL. ib_umem_odp_map_dma_and_lock()
should return an error in case the target pages cannot be mapped until
timeout, so these checks can safely be removed.

Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index dbc5a5600eb7..02841346e30c 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -203,8 +203,6 @@ static int __rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 
 		page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
 		user_va = kmap_local_page(page);
-		if (!user_va)
-			return -EFAULT;
 
 		src = (dir == RXE_TO_MR_OBJ) ? addr : user_va;
 		dest = (dir == RXE_TO_MR_OBJ) ? user_va : addr;
@@ -286,8 +284,6 @@ static enum resp_states rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
 	idx = rxe_odp_iova_to_index(umem_odp, iova);
 	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
 	page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
-	if (!page)
-		return RESPST_ERR_RKEY_VIOLATION;
 
 	if (unlikely(page_offset & 0x7)) {
 		rxe_dbg_mr(mr, "iova not aligned\n");
@@ -352,10 +348,6 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
 		page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
 
 		page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
-		if (!page) {
-			mutex_unlock(&umem_odp->umem_mutex);
-			return -EFAULT;
-		}
 
 		bytes = min_t(unsigned int, length,
 			      mr_page_size(mr) - page_offset);
@@ -398,10 +390,7 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
 	index = rxe_odp_iova_to_index(umem_odp, iova);
 	page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
-	if (!page) {
-		mutex_unlock(&umem_odp->umem_mutex);
-		return RESPST_ERR_RKEY_VIOLATION;
-	}
+
 	/* See IBA A19.4.2 */
 	if (unlikely(page_offset & 0x7)) {
 		mutex_unlock(&umem_odp->umem_mutex);
-- 
2.43.0


