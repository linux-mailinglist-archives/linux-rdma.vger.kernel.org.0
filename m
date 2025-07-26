Return-Path: <linux-rdma+bounces-12490-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72DCB129A9
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Jul 2025 09:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705A1AC2D2C
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Jul 2025 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185DF21ABB7;
	Sat, 26 Jul 2025 07:53:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44050258A
	for <linux-rdma@vger.kernel.org>; Sat, 26 Jul 2025 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753516431; cv=none; b=fbMeV0FkA/jbSorduX1XlYYBIM5SU+J1N1cwb3Jd7Y+Bk+T6acvMV5EtYLZrS/n7pyYl/RQvQippJO9/cN4WRYrn2EZ/bvpnnaFn+HRbe/XYPi/erDhyxwiDOI4MplqA+//0X1DfIhWrPCq554oonNTYIjRHY5n93WggS7zbZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753516431; c=relaxed/simple;
	bh=sL1xt/xu8FRty9UPt2bUQOH13Yuoo5CavhI1L19HXas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnFHUxkPKd5qRVzufzSdgMBrWxAawIpdd1JWBHcGI+ztG0smGRL2cuRFYfbM3kIjEUAnZg1O4RWuEKt+vEBtucPCOKxu9AOZOBRRYM+XTDM+1OwN7g26ukXpO2Ciuwnp7CfYMhnEsKU0MWT0CUXB2Q497KJ48LTfjqDFCR2cliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bpxhS5xrpzYdcv;
	Sat, 26 Jul 2025 15:49:12 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 38B2714010D;
	Sat, 26 Jul 2025 15:53:46 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Jul 2025 15:53:45 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Fix querying wrong SCC context for DIP algorithm
Date: Sat, 26 Jul 2025 15:53:45 +0800
Message-ID: <20250726075345.846957-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: wenglianfa <wenglianfa@huawei.com>

When using DIP algorithm, all QPs establishing connections with
the same destination IP share the same SCC, which is indexed by
dip_idx, but dip_idx isn't necessarily equal to qpn. Therefore,
dip_idx should be used to query SCC context instead of qpn.

Fixes: 124a9fbe43aa ("RDMA/hns: Append SCC context to the raw dump of QPC")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 4 ++--
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 64bca08f3f1a..244a4780d3a6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5476,7 +5476,7 @@ static int hns_roce_v2_query_srqc(struct hns_roce_dev *hr_dev, u32 srqn,
 	return ret;
 }
 
-static int hns_roce_v2_query_sccc(struct hns_roce_dev *hr_dev, u32 qpn,
+static int hns_roce_v2_query_sccc(struct hns_roce_dev *hr_dev, u32 sccn,
 				  void *buffer)
 {
 	struct hns_roce_v2_scc_context *context;
@@ -5488,7 +5488,7 @@ static int hns_roce_v2_query_sccc(struct hns_roce_dev *hr_dev, u32 qpn,
 		return PTR_ERR(mailbox);
 
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_SCCC,
-				qpn);
+				sccn);
 	if (ret)
 		goto out;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index f637b73b946e..230187dda6a0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -100,6 +100,7 @@ int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
 		struct hns_roce_v2_qp_context qpc;
 		struct hns_roce_v2_scc_context sccc;
 	} context = {};
+	u32 sccn = hr_qp->qpn;
 	int ret;
 
 	if (!hr_dev->hw->query_qpc)
@@ -116,7 +117,13 @@ int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
 	    !hr_dev->hw->query_sccc)
 		goto out;
 
-	ret = hr_dev->hw->query_sccc(hr_dev, hr_qp->qpn, &context.sccc);
+	if (hr_qp->cong_type == CONG_TYPE_DIP) {
+		if (!hr_qp->dip)
+			goto out;
+		sccn = hr_qp->dip->dip_idx;
+	}
+
+	ret = hr_dev->hw->query_sccc(hr_dev, sccn, &context.sccc);
 	if (ret)
 		ibdev_warn_ratelimited(&hr_dev->ib_dev,
 				       "failed to query SCCC, ret = %d.\n",
-- 
2.33.0


