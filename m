Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC7355512
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 15:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbhDFN2F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 09:28:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15998 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhDFN2E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 09:28:04 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF7Yd2pvRzPnry;
        Tue,  6 Apr 2021 21:25:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 21:27:47 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
        Shengming Shu <shushengming1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 2/6] RDMA/hns: Query the number of functions supported by the PF
Date:   Tue, 6 Apr 2021 21:25:10 +0800
Message-ID: <1617715514-29039-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617715514-29039-1-git-send-email-liweihang@huawei.com>
References: <1617715514-29039-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wei Xu <xuwei5@hisilicon.com>

Query how many functions are supported by the PF from the FW and store it
in the hns_roce_dev structure which will be used to support the
configuration of virtual functions.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Shengming Shu <shushengming1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 9 +++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 55cbbd5..3a5378e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1006,6 +1006,7 @@ struct hns_roce_dev {
 	void			*priv;
 	struct workqueue_struct *irq_workq;
 	const struct hns_roce_dfx_hw *dfx;
+	u32 func_num;
 	u32 cong_algo_tmpl_id;
 };
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0695c2c..5c0d341 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1607,15 +1607,20 @@ static int hns_roce_query_func_info(struct hns_roce_dev *hr_dev)
 	struct hns_roce_cmq_desc desc;
 	int ret;
 
-	if (hr_dev->pci_dev->revision < PCI_REVISION_ID_HIP09)
+	if (hr_dev->pci_dev->revision < PCI_REVISION_ID_HIP09) {
+		hr_dev->func_num = 1;
 		return 0;
+	}
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_FUNC_INFO,
 				      true);
 	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
-	if (ret)
+	if (ret) {
+		hr_dev->func_num = 1;
 		return ret;
+	}
 
+	hr_dev->func_num = le32_to_cpu(desc.func_info.own_func_num);
 	hr_dev->cong_algo_tmpl_id = le32_to_cpu(desc.func_info.own_mac_id);
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 44be39a..535587f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1697,9 +1697,9 @@ struct hns_roce_cmq_desc {
 	union {
 		__le32 data[6];
 		struct {
-			__le32 rsv1;
+			__le32 own_func_num;
 			__le32 own_mac_id;
-			__le32 rsv2[4];
+			__le32 rsv[4];
 		} func_info;
 	};
 
-- 
2.8.1

