Return-Path: <linux-rdma+bounces-4795-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C7896EFD0
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 11:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1441F257C1
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814B1C9EC2;
	Fri,  6 Sep 2024 09:40:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350621C9DD6;
	Fri,  6 Sep 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615642; cv=none; b=t9CDu7cH5hGew9W3oPqpE39xXS/7SZSMe79cbfloYbKQV0JIssDTBTecrBarofR5PihunsemaeC1i84ZAncQzywuBTP0nOXLVoBTHz5XUYuzrRq/NHsZpkU4nqFFMzt8ZPTIra1eogRxw5AhKfjHegin29H+BF9f95BUNnj21fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615642; c=relaxed/simple;
	bh=ZjPqaBwu7RvD+3YUl82Ow46SEq2hMngd6puah2z3ik0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyF+bX5H+PGFIAUiyxlsETRTggQeTZDro+1B1GdXhlo64W6AzdduNG/wsn96SvSA81GLTteXjn1xbOslGXKDwwQEThJs3TfUR49NAcFRaMDTKpsbZxrY8XHed3/CLcCD4V6FooyFRTPZfgFhLR0+3jGmYvAcJKZLN9lERAwjiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X0WRK0dVJzyRZM;
	Fri,  6 Sep 2024 17:39:57 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 4804E14011A;
	Fri,  6 Sep 2024 17:40:37 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 17:40:36 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 6/9] RDMA/hns: Fix VF triggering PF reset in abnormal interrupt handler
Date: Fri, 6 Sep 2024 17:34:41 +0800
Message-ID: <20240906093444.3571619-7-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)

In abnormal interrupt handler, a PF reset will be triggered even if
the device is a VF. It should be a VF reset.

Fixes: 2b9acb9a97fe ("RDMA/hns: Add the process of AEQ overflow for hip08")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index adcadd2495ab..74bab07c10e5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6201,6 +6201,7 @@ static irqreturn_t abnormal_interrupt_basic(struct hns_roce_dev *hr_dev,
 	struct pci_dev *pdev = hr_dev->pci_dev;
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
 	const struct hnae3_ae_ops *ops = ae_dev->ops;
+	enum hnae3_reset_type reset_type;
 	irqreturn_t int_work = IRQ_NONE;
 	u32 int_en;
 
@@ -6212,10 +6213,12 @@ static irqreturn_t abnormal_interrupt_basic(struct hns_roce_dev *hr_dev,
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_ST_REG,
 			   1 << HNS_ROCE_V2_VF_INT_ST_AEQ_OVERFLOW_S);
 
+		reset_type = hr_dev->is_vf ?
+			     HNAE3_VF_FUNC_RESET : HNAE3_FUNC_RESET;
+
 		/* Set reset level for reset_event() */
 		if (ops->set_default_reset_request)
-			ops->set_default_reset_request(ae_dev,
-						       HNAE3_FUNC_RESET);
+			ops->set_default_reset_request(ae_dev, reset_type);
 		if (ops->reset_event)
 			ops->reset_event(pdev, NULL);
 
-- 
2.33.0


