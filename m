Return-Path: <linux-rdma+bounces-8570-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD5A5BB43
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 09:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20A13AAE73
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F9822DF8B;
	Tue, 11 Mar 2025 08:56:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D322B8B2
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683398; cv=none; b=oWlcswrLMPBDq9amTWXl/S2Z+yv3R0a1VYOnvF3aZr8rLJ60CWJcesEVp8CGTprjfoZKzP9iQw5F+o8obN7dtKfHWobyz2mBntXU6MeKhZkIVCQ5mYnE5+edJw5A3oh7Fr0Bc/TuZWNQMOg826EgApDPgMZ8bc6iylKyHkwC31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683398; c=relaxed/simple;
	bh=CVc/anywap1JTmTUJ2Ssh/0i75Te5nBBpkuVY1/dj9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7xr1Riye1SVWGWYJZKN1HstzpKzxHvA8m1DA3qfoPTk8p6jF6fVzCkbj1f934PuA8sG8FFmC/mbtoqzllsWDAmrGK86Qm+rAo3lCShu7CbNUTxlIs0ntbXsXdEWc3P4ZJtDWobxq7+Lgc0gAj7gq8cAgtR6L1JLaN7Us0vLNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZBndS4nWyz1R6MR;
	Tue, 11 Mar 2025 16:54:52 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 58840140109;
	Tue, 11 Mar 2025 16:56:33 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 16:56:32 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 4/7] RDMA/hns: Fix invalid sq params not being blocked
Date: Tue, 11 Mar 2025 16:48:54 +0800
Message-ID: <20250311084857.3803665-5-huangjunxian6@hisilicon.com>
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

SQ params from userspace are checked in by set_user_sq_size(). But
when the check fails, the function doesn't return but instead keep
running and overwrite 'ret'. As a result, the invalid params will
not get blocked actually.

Add a return right after the failed check. Besides, although the
check result of kernel sq params will not be overwritten, to keep
coding style unified, move default_congest_type() before
set_kernel_sq_size().

Fixes: 6ec429d5887a ("RDMA/hns: Support userspace configuring congestion control algorithm with QP granularity")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 70a38bf2bd86..18bf3761a64e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1121,24 +1121,23 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 						 ibucontext);
 		hr_qp->config = uctx->config;
 		ret = set_user_sq_size(hr_dev, &init_attr->cap, hr_qp, ucmd);
-		if (ret)
+		if (ret) {
 			ibdev_err(ibdev,
 				  "failed to set user SQ size, ret = %d.\n",
 				  ret);
+			return ret;
+		}
 
 		ret = set_congest_param(hr_dev, hr_qp, ucmd);
-		if (ret)
-			return ret;
 	} else {
 		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
 			hr_qp->config = HNS_ROCE_EXSGE_FLAGS;
+		default_congest_type(hr_dev, hr_qp);
 		ret = set_kernel_sq_size(hr_dev, &init_attr->cap, hr_qp);
 		if (ret)
 			ibdev_err(ibdev,
 				  "failed to set kernel SQ size, ret = %d.\n",
 				  ret);
-
-		default_congest_type(hr_dev, hr_qp);
 	}
 
 	return ret;
-- 
2.33.0


