Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C903A1219
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 13:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhFILNX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 07:13:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5306 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbhFILNW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 07:13:22 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0PS90JR4z19S63;
        Wed,  9 Jun 2021 19:06:33 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 19:11:25 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 9 Jun 2021 19:11:24 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Clear extended doorbell info before using
Date:   Wed, 9 Jun 2021 19:11:05 +0800
Message-ID: <1623237065-43344-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Both of HIP08 and HIP09 require the extended doorbell information to be
cleared before being used.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 16 ++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fbc45b9..c5d2cfb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1572,6 +1572,20 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 	}
 }
 
+static void hns_roce_clear_extdb_list_info(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_cmq_desc desc;
+	int ret;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CLEAR_EXTDB_LIST_INFO,
+				      false);
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret)
+		ibdev_warn(&hr_dev->ib_dev,
+			   "failed to clear extended doorbell info, ret = %d.\n",
+			   ret);
+}
+
 static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_query_fw_info *resp;
@@ -2684,6 +2698,8 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 	if (ret)
 		return ret;
 
+	/* The hns ROCEE requires the extdb info to be cleared before using */
+	hns_roce_clear_extdb_list_info(hr_dev);
 	if (hr_dev->is_vf)
 		return 0;
 
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

