Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364B83A3BF4
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 08:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFKGRK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 02:17:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3954 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFKGRJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 02:17:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G1VqT4DPVz6xdk;
        Fri, 11 Jun 2021 14:12:05 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 14:15:10 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 11 Jun 2021 14:15:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v3 for-next] RDMA/hns: Clear extended doorbell info before using
Date:   Fri, 11 Jun 2021 14:14:49 +0800
Message-ID: <1623392089-35639-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Both of HIP08 and HIP09 require the extended doorbell information to be
cleared before being used.

Fixes: 6b63597d3540 ("RDMA/hns: Add TSQ link table support")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Changes since v2:
- Clear ext doorbell list info before get_hem_table().
- Link: https://patchwork.kernel.org/project/linux-rdma/patch/1623323990-62343-1-git-send-email-liweihang@huawei.com/

Changes since v1:
- Add fixes tag.
- Add check for return value of hns_roce_clear_extdb_list_info().
- Link: https://patchwork.kernel.org/project/linux-rdma/patch/1623237065-43344-1-git-send-email-liweihang@huawei.com/

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 21 +++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fbc45b9..d3fe9ee 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1572,6 +1572,22 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 	}
 }
 
+static int hns_roce_clear_extdb_list_info(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_cmq_desc desc;
+	int ret;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO,
+				      false);
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret)
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to clear extended doorbell info, ret = %d.\n",
+			  ret);
+
+	return ret;
+}
+
 static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_query_fw_info *resp;
@@ -2680,6 +2696,11 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 {
 	int ret;
 
+	/* The hns ROCEE requires the extdb info to be cleared before using */
+	ret = hns_roce_clear_extdb_list_info(hr_dev);
+	if (ret)
+		return ret;
+
 	ret = get_hem_table(hr_dev);
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index cd361c0..073e835 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -250,6 +250,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_CLR_SCCC				= 0x8509,
 	HNS_ROCE_OPC_QUERY_SCCC				= 0x850a,
 	HNS_ROCE_OPC_RESET_SCCC				= 0x850b,
+	HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO		= 0x850d,
 	HNS_ROCE_OPC_QUERY_VF_RES			= 0x850e,
 	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
 	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
-- 
2.7.4

