Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02543527B6
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 11:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhDBJA7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 05:00:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16327 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhDBJA6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 05:00:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBYr86FcQz9vsb;
        Fri,  2 Apr 2021 16:58:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 17:00:48 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
        Shengming Shu <shushengming1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 4/6] RDMA/hns: Set parameters of all the functions belong to a PF
Date:   Fri, 2 Apr 2021 16:58:14 +0800
Message-ID: <1617353896-40727-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617353896-40727-1-git-send-email-liweihang@huawei.com>
References: <1617353896-40727-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wei Xu <xuwei5@hisilicon.com>

Switch parameters of all functions belong to a PF should be set including
VFs.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Shengming Shu <shushengming1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4cc08aa..860e74b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1693,7 +1693,8 @@ static int hns_roce_query_pf_timer_resource(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
-static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev, int vf_id)
+static int __hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
+					  u32 vf_id)
 {
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_vf_switch *swt;
@@ -1718,6 +1719,19 @@ static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev, int vf_id)
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
+static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev)
+{
+	u32 vf_id;
+	int ret;
+
+	for (vf_id = 0; vf_id < hr_dev->func_num; vf_id++) {
+		ret = __hns_roce_set_vf_switch_param(hr_dev, vf_id);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static int __hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev, int vf_id)
 {
 	struct hns_roce_cmq_desc desc[2];
@@ -2319,7 +2333,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		return ret;
 	}
 
-	ret = hns_roce_set_vf_switch_param(hr_dev, 0);
+	ret = hns_roce_set_vf_switch_param(hr_dev);
 	if (ret) {
 		dev_err(hr_dev->dev,
 			"failed to set function switch param, ret = %d.\n",
-- 
2.8.1

