Return-Path: <linux-rdma+bounces-3797-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A1A92D329
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5F3284574
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58F0194148;
	Wed, 10 Jul 2024 13:42:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C244194088;
	Wed, 10 Jul 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618953; cv=none; b=tGwh3A1iErqkTiC1y0JuN2Cxg6vDxLK57DTFi3VCRj1WH+mUEEWBzRu8WrSUDtqVohAYGvHiyCeli28AX4h6ndQ3jy+YqtQG2DpG7PNb48FpwRe3kiCLp+WrOFr1WTeSla34atidGe63sHex4yBDHeBGp/swYXvF7+dwWIpH1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618953; c=relaxed/simple;
	bh=0bhKmbWEhTQZaRCWuVo53XMfLGkm79/LUryaLp70VAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osw8A4EW7y46Sp00J6PMZUG6EW9QQ0EHJ9QLuplskk4wZeEVk7yA4mzrIVNkO8bYjQ+2L1Ff/e8qNEExASYEko4e3GDTLB40wWQka8lV5bUQwCN9Zm7Jcobh9EphbzhzQp2tseYmPsSmTsqjxe80eiRp3rr2YK7Ie9UrwLi57y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WJzSP4gfTz1T633;
	Wed, 10 Jul 2024 21:37:41 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 58C54180ADC;
	Wed, 10 Jul 2024 21:42:24 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jul 2024 21:42:23 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-rc 4/8] RDMA/hns: Fix missing pagesize and alignment check in FRMR
Date: Wed, 10 Jul 2024 21:37:01 +0800
Message-ID: <20240710133705.896445-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
References: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

The offset requires 128B alignment and the page size ranges from
4K to 128M.

Fixes: 68a997c5d28c ("RDMA/hns: Add FRMR support for hip08")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 4 ++++
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index f8451e5ab107..7d5931872f8a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -83,6 +83,7 @@
 #define MR_TYPE_DMA				0x03
 
 #define HNS_ROCE_FRMR_MAX_PA			512
+#define HNS_ROCE_FRMR_ALIGN_SIZE		128
 
 #define PKEY_ID					0xffff
 #define NODE_DESC_SIZE				64
@@ -189,6 +190,9 @@ enum {
 #define HNS_HW_PAGE_SHIFT			12
 #define HNS_HW_PAGE_SIZE			(1 << HNS_HW_PAGE_SHIFT)
 
+#define HNS_HW_MAX_PAGE_SHIFT			27
+#define HNS_HW_MAX_PAGE_SIZE			(1 << HNS_HW_MAX_PAGE_SHIFT)
+
 struct hns_roce_uar {
 	u64		pfn;
 	unsigned long	index;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 1a61dceb3319..846da8c78b8b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -443,6 +443,11 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
 	int ret, sg_num = 0;
 
+	if (!IS_ALIGNED(*sg_offset, HNS_ROCE_FRMR_ALIGN_SIZE) ||
+	    ibmr->page_size < HNS_HW_PAGE_SIZE ||
+	    ibmr->page_size > HNS_HW_MAX_PAGE_SIZE)
+		return sg_num;
+
 	mr->npages = 0;
 	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
 				 sizeof(dma_addr_t), GFP_KERNEL);
-- 
2.33.0


