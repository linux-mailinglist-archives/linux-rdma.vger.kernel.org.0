Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86D5B461D7
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfFNO65 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 10:58:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbfFNO64 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 10:58:56 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 68F6F2DAA3E0FCE04162;
        Fri, 14 Jun 2019 22:58:38 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 22:58:32 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V3 for-next] RDMA/hns: reset function when removing module
Date:   Fri, 14 Jun 2019 22:56:03 +0800
Message-ID: <1560524163-94676-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

During removing the driver, we needs to notify the roce engine to
stop working immediately,and symmetrically recycle the hardware
resources requested during initialization.

The hardware provides a command called function clear that can package
these operations,so that the driver can only focus on releasing
resources that applied from the operating system.
This patch implements the call of this command.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
V2->V3:
1. Remove other reset state operations that are not related to
   function clear
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 44 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 17 ++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e7024b3..5c8551b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1130,6 +1130,47 @@ static int hns_roce_cmq_query_hw_info(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
+static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
+{
+	bool fclr_write_fail_flag = false;
+	struct hns_roce_func_clear *resp;
+	struct hns_roce_cmq_desc desc;
+	unsigned long end;
+	int ret;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_FUNC_CLEAR, false);
+	resp = (struct hns_roce_func_clear *)desc.data;
+
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret) {
+		fclr_write_fail_flag = true;
+		dev_err(hr_dev->dev, "Func clear write failed, ret = %d.\n",
+			 ret);
+		return;
+	}
+
+	msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL);
+	end = HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS;
+	while (end) {
+		msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT);
+		end -= HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT;
+
+		hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_FUNC_CLEAR,
+					      true);
+
+		ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+		if (ret)
+			continue;
+
+		if (roce_get_bit(resp->func_done, FUNC_CLEAR_RST_FUN_DONE_S)) {
+			hr_dev->is_reset = true;
+			return;
+		}
+	}
+
+	dev_err(hr_dev->dev, "Func clear fail.\n");
+}
+
 static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_query_fw_info *resp;
@@ -1894,6 +1935,9 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
+	if (hr_dev->pci_dev->revision == 0x21)
+		hns_roce_function_clear(hr_dev);
+
 	hns_roce_free_link_table(hr_dev, &priv->tpq);
 	hns_roce_free_link_table(hr_dev, &priv->tsq);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index bce21fd..478f5a5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -241,6 +241,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_POST_MB				= 0x8504,
 	HNS_ROCE_OPC_QUERY_MB_ST			= 0x8505,
 	HNS_ROCE_OPC_CFG_BT_ATTR			= 0x8506,
+	HNS_ROCE_OPC_FUNC_CLEAR				= 0x8508,
 	HNS_ROCE_OPC_CLR_SCCC				= 0x8509,
 	HNS_ROCE_OPC_QUERY_SCCC				= 0x850a,
 	HNS_ROCE_OPC_RESET_SCCC				= 0x850b,
@@ -1230,6 +1231,22 @@ struct hns_roce_query_fw_info {
 	__le32 rsv[5];
 };
 
+struct hns_roce_func_clear {
+	__le32 rst_funcid_en;
+	__le32 func_done;
+	__le32 rsv[4];
+};
+
+#define FUNC_CLEAR_RST_FUN_DONE_S 0
+/* Each physical function manages up to 248 virtual functions；
+ * it takes up to 100ms for each function to execute clear；
+ * if an abnormal reset occurs, it is executed twice at most;
+ * so it takes up to 249 * 2 * 100ms.
+ */
+#define HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS	(249 * 2 * 100)
+#define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL	40
+#define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT	20
+
 struct hns_roce_cfg_llm_a {
 	__le32 base_addr_l;
 	__le32 base_addr_h;
-- 
1.9.1

