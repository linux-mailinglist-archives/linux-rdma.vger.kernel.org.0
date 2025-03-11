Return-Path: <linux-rdma+bounces-8568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A08A5BB42
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 09:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA883AAB8A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 08:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C081DED63;
	Tue, 11 Mar 2025 08:56:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00822ACC6
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683397; cv=none; b=R7DkR1o2igKkvCEw5VlSrd6cWDaPT48y17RCArSbhJiKDsMAj6GxPXXetbrRo025VqPUMTlawzVvXf6STrJOgjXnU9Vr6qtvmKJ4s7es3Znnyhx02s3Jpk2KDynsG1fhCPAA8bo8i4aloQ2T9KhWt5Isq0m7LrBzenzP5dnQAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683397; c=relaxed/simple;
	bh=Uyc37aniQPQqKblIKGGmSmBNpPCKtRHo+LQS+emFIwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdgTWVY4i2E4ts2mWEuizHPpURMdFJesfjRQWskSGiq870OpMM1LvfCoiJDZiic3itBSptyP+8f+U7dSotHsU9GVmBEciTKPYZI8mav66+SznMyiQBakjRSxGl/k6iZ1HEok7a0G6PIve2bkjciBV89CQbPyUhbikez0xWrd1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZBndf5gg0zqVWK;
	Tue, 11 Mar 2025 16:55:02 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 42FBF14037E;
	Tue, 11 Mar 2025 16:56:32 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 16:56:31 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 1/7] RDMA/hns: Inappropriate format characters cleanup
Date: Tue, 11 Mar 2025 16:48:51 +0800
Message-ID: <20250311084857.3803665-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
References: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
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

From: Guofeng Yue <yueguofeng@h-partners.com>

Use %u for unsigned type and %d for enum.

Signed-off-by: Guofeng Yue <yueguofeng@h-partners.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c  | 2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c  | 2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 55b9283bfc6f..09da3496843b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -998,7 +998,7 @@ static bool is_buf_attr_valid(struct hns_roce_dev *hr_dev,
 	if (attr->region_count > ARRAY_SIZE(attr->region) ||
 	    attr->region_count < 1 || attr->page_shift < HNS_HW_PAGE_SHIFT) {
 		ibdev_err(ibdev,
-			  "invalid buf attr, region count %d, page shift %u.\n",
+			  "invalid buf attr, region count %u, page shift %u.\n",
 			  attr->region_count, attr->page_shift);
 		return false;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9e2e76c59406..ccfef673a976 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1319,7 +1319,7 @@ int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 
 	ret = hns_roce_create_qp_common(hr_dev, init_attr, udata, hr_qp);
 	if (ret)
-		ibdev_err(ibdev, "create QP type 0x%x failed(%d)\n",
+		ibdev_err(ibdev, "create QP type %d failed(%d)\n",
 			  init_attr->qp_type, ret);
 
 err_out:
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 70c06ef65603..1090051f493b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -51,7 +51,7 @@ static void hns_roce_ib_srq_event(struct hns_roce_srq *srq,
 			break;
 		default:
 			dev_err(hr_dev->dev,
-			   "hns_roce:Unexpected event type 0x%x on SRQ %06lx\n",
+			   "hns_roce:Unexpected event type %d on SRQ %06lx\n",
 			   event_type, srq->srqn);
 			return;
 		}
-- 
2.33.0


