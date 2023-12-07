Return-Path: <linux-rdma+bounces-307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF38086F1
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 12:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4ADF1F22741
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E106381D7;
	Thu,  7 Dec 2023 11:46:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C117DD4A;
	Thu,  7 Dec 2023 03:46:10 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SmC6L1hJVzShwn;
	Thu,  7 Dec 2023 19:41:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 19:46:08 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 1/5] RDMA/hns: Rename the interrupts
Date: Thu, 7 Dec 2023 19:42:27 +0800
Message-ID: <20231207114231.2872104-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
References: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected

From: Chengchang Tang <tangchengchang@huawei.com>

Now, different devices may have the same interrupt name, which
makes it difficult for users to distinguish between these
interrupts.

Modify the naming style to be consistent with our network devices.
Before:
"hns-aeq-0"
"hns-ceq-0"
...

Now:
"hns-0000:35:00.0-aeq-0"
"hns-0000:35:00.0-ceq-0"
...

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5d0a7a1394fc..4258b6daaded 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6473,15 +6473,16 @@ static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
 	/* irq contains: abnormal + AEQ + CEQ */
 	for (j = 0; j < other_num; j++)
 		snprintf((char *)hr_dev->irq_names[j], HNS_ROCE_INT_NAME_LEN,
-			 "hns-abn-%d", j);
+			 "hns-%s-abn-%d", pci_name(hr_dev->pci_dev), j);
 
 	for (j = other_num; j < (other_num + aeq_num); j++)
 		snprintf((char *)hr_dev->irq_names[j], HNS_ROCE_INT_NAME_LEN,
-			 "hns-aeq-%d", j - other_num);
+			 "hns-%s-aeq-%d", pci_name(hr_dev->pci_dev), j - other_num);
 
 	for (j = (other_num + aeq_num); j < irq_num; j++)
 		snprintf((char *)hr_dev->irq_names[j], HNS_ROCE_INT_NAME_LEN,
-			 "hns-ceq-%d", j - other_num - aeq_num);
+			 "hns-%s-ceq-%d", pci_name(hr_dev->pci_dev),
+			 j - other_num - aeq_num);
 
 	for (j = 0; j < irq_num; j++) {
 		if (j < other_num)
-- 
2.30.0


