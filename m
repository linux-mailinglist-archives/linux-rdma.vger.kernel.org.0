Return-Path: <linux-rdma+bounces-5762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02179BCC79
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 13:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B221F232E0
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 12:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE7E1D516E;
	Tue,  5 Nov 2024 12:15:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFE1D460E;
	Tue,  5 Nov 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808910; cv=none; b=e1Ahec9oJjySTizeW0HEl9tFzoymdSQ+eLSaNUBOsmno+4196go5XxiTJtpx4ZVVv1TSgCbvIHF10fQnTMpp7WOuqNuDE9hXfiten6oQziVxPsz6lH6rOdWykFs62XDrtwtRVAuOYT4OnMP34rdTAFHF3M5/5WD69ABJGakZSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808910; c=relaxed/simple;
	bh=iXEKC62juvToWzOz9505gScfU3Uf65xMr1hlof+jCq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Flb8//efWa8NTeJ4uUZB4GUI76TVQbAivFkce4hzO6LECUCYdouqVr7XHPuBDZ2pCk7KO7jV9OBd+wXosCS2+MTaA7rf7kLckJGEQ+iq3fQPGZONmpdTHdmJzZl7sOsjCkFeHT7k9/NYVj/OUYvNkpXg68kSREcd8J0lngjcatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XjS0h6FMpz2Fbqc;
	Tue,  5 Nov 2024 20:13:24 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id B68511402E2;
	Tue,  5 Nov 2024 20:15:04 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Nov 2024 20:15:04 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>,
	<huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 2/2] RDMA: Delete NULL pointer checks for sg_offset in .map_mr_sg ops
Date: Tue, 5 Nov 2024 20:08:41 +0800
Message-ID: <20241105120841.860068-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241105120841.860068-1-huangjunxian6@hisilicon.com>
References: <20241105120841.860068-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Since we can now ensure that the sg_offset/data_sg_offset/meta_sg_offset
arguments are valid pointer, NULL pointer checks in drivers are no longer
needed.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/mlx5/mr.c         | 18 ++++++------------
 drivers/infiniband/sw/rdmavt/trace_mr.h |  2 +-
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 45d9dc9c6c8f..f119078ca671 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -2545,17 +2545,13 @@ mlx5_ib_map_pa_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist *data_sg,
 	if (data_sg_nents == 1) {
 		n++;
 		mr->mmkey.ndescs = 1;
-		if (data_sg_offset)
-			sg_offset = *data_sg_offset;
+		sg_offset = *data_sg_offset;
 		mr->data_length = sg_dma_len(data_sg) - sg_offset;
 		mr->data_iova = sg_dma_address(data_sg) + sg_offset;
 		if (meta_sg_nents == 1) {
 			n++;
 			mr->meta_ndescs = 1;
-			if (meta_sg_offset)
-				sg_offset = *meta_sg_offset;
-			else
-				sg_offset = 0;
+			sg_offset = *meta_sg_offset;
 			mr->meta_length = sg_dma_len(meta_sg) - sg_offset;
 			mr->pi_iova = sg_dma_address(meta_sg) + sg_offset;
 		}
@@ -2576,7 +2572,7 @@ mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr,
 {
 	struct scatterlist *sg = sgl;
 	struct mlx5_klm *klms = mr->descs;
-	unsigned int sg_offset = sg_offset_p ? *sg_offset_p : 0;
+	unsigned int sg_offset = *sg_offset_p;
 	u32 lkey = mr->ibmr.pd->local_dma_lkey;
 	int i, j = 0;
 
@@ -2594,15 +2590,14 @@ mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr,
 		sg_offset = 0;
 	}
 
-	if (sg_offset_p)
-		*sg_offset_p = sg_offset;
+	*sg_offset_p = sg_offset;
 
 	mr->mmkey.ndescs = i;
 	mr->data_length = mr->ibmr.length;
 
 	if (meta_sg_nents) {
 		sg = meta_sgl;
-		sg_offset = meta_sg_offset_p ? *meta_sg_offset_p : 0;
+		sg_offset = *meta_sg_offset_p;
 		for_each_sg(meta_sgl, sg, meta_sg_nents, j) {
 			if (unlikely(i + j >= mr->max_descs))
 				break;
@@ -2615,8 +2610,7 @@ mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr,
 
 			sg_offset = 0;
 		}
-		if (meta_sg_offset_p)
-			*meta_sg_offset_p = sg_offset;
+		*meta_sg_offset_p = sg_offset;
 
 		mr->meta_ndescs = j;
 		mr->meta_length = mr->ibmr.length - mr->data_length;
diff --git a/drivers/infiniband/sw/rdmavt/trace_mr.h b/drivers/infiniband/sw/rdmavt/trace_mr.h
index 0cb8e0a0565e..6f4c70480d34 100644
--- a/drivers/infiniband/sw/rdmavt/trace_mr.h
+++ b/drivers/infiniband/sw/rdmavt/trace_mr.h
@@ -159,7 +159,7 @@ TRACE_EVENT(
 		__entry->user_base = to_imr(ibmr)->mr.user_base;
 		__entry->ibmr_length = to_imr(ibmr)->mr.length;
 		__entry->sg_nents = sg_nents;
-		__entry->sg_offset = sg_offset ? *sg_offset : 0;
+		__entry->sg_offset = *sg_offset;
 	),
 	TP_printk(
 		"[%s] ibmr_iova %llx iova %llx user_base %llx length %llx sg_nents %d sg_offset %u",
-- 
2.33.0


