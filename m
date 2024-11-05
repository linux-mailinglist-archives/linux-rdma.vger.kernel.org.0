Return-Path: <linux-rdma+bounces-5764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E69BCC7D
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 13:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFF31C22CC5
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569C51D5AB5;
	Tue,  5 Nov 2024 12:15:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2E1CEAD3;
	Tue,  5 Nov 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808911; cv=none; b=VsdNnL5wfEFdY5zOnFobNIOD3j/ihOh8WeC/RQoYYivG37qpmUl5CTYNGFGesa9alLmcgh2r6zp/O8txjTRBf9HaDNyBG9pLBPyTX16/2LIbglltLTamTVXsF+mAG8STVkm7MqzwEEPGmpqnUff37cBEFKmWNt+DUaD7qDObJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808911; c=relaxed/simple;
	bh=g8W2mxWXStiowo6LQz1Q8e/wZEmAKNtw5//26LeEZuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqBfr8V5BSIvorMtcAD2hzRI6H+mrbGM2d2AN0FHWcWnFc2HZU8LYyQesVdZGjht0CTF3HWTOIoZc/CViWB+YILVt0ZFVuLXUmccMdWWme7DTYPSbXNPoFawBCRBjCGzjXZwE8hSDVIV5PScmFAyIVtH2yqKSZieOY7hi/RH28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XjS0Q0JJ9zpY1W;
	Tue,  5 Nov 2024 20:13:10 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D53518009B;
	Tue,  5 Nov 2024 20:15:04 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Nov 2024 20:15:03 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>,
	<huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 1/2] RDMA/core: Add dummy sg_offset pointer for ib_map_mr_sg() and ib_map_mr_sg_pi()
Date: Tue, 5 Nov 2024 20:08:40 +0800
Message-ID: <20241105120841.860068-2-huangjunxian6@hisilicon.com>
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

ib_map_mr_sg() and ib_map_mr_sg_pi() allow ULPs to specify NULL as the
sg_offset/data_sg_offset/meta_sg_offset arguments. In these cases,
pass a dummy pointer to drivers so they don't have to add NULL pointer
checks.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/core/verbs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 473ee0831307..27060554dde2 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2670,6 +2670,9 @@ int ib_map_mr_sg_pi(struct ib_mr *mr, struct scatterlist *data_sg,
 		    struct scatterlist *meta_sg, int meta_sg_nents,
 		    unsigned int *meta_sg_offset, unsigned int page_size)
 {
+	unsigned int data_dummy = 0;
+	unsigned int meta_dummy = 0;
+
 	if (unlikely(!mr->device->ops.map_mr_sg_pi ||
 		     WARN_ON_ONCE(mr->type != IB_MR_TYPE_INTEGRITY)))
 		return -EOPNOTSUPP;
@@ -2677,8 +2680,9 @@ int ib_map_mr_sg_pi(struct ib_mr *mr, struct scatterlist *data_sg,
 	mr->page_size = page_size;
 
 	return mr->device->ops.map_mr_sg_pi(mr, data_sg, data_sg_nents,
-					    data_sg_offset, meta_sg,
-					    meta_sg_nents, meta_sg_offset);
+					    data_sg_offset ? : &data_dummy,
+					    meta_sg, meta_sg_nents,
+					    meta_sg_offset ? : &meta_dummy);
 }
 EXPORT_SYMBOL(ib_map_mr_sg_pi);
 
@@ -2711,12 +2715,14 @@ EXPORT_SYMBOL(ib_map_mr_sg_pi);
 int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
 		 unsigned int *sg_offset, unsigned int page_size)
 {
+	unsigned int dummy = 0;
+
 	if (unlikely(!mr->device->ops.map_mr_sg))
 		return -EOPNOTSUPP;
 
 	mr->page_size = page_size;
 
-	return mr->device->ops.map_mr_sg(mr, sg, sg_nents, sg_offset);
+	return mr->device->ops.map_mr_sg(mr, sg, sg_nents, sg_offset ? : &dummy);
 }
 EXPORT_SYMBOL(ib_map_mr_sg);
 
-- 
2.33.0


