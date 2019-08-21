Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F26A97AF2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfHUNdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:33:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52000 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfHUNdv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:33:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0191EF4E59B479245D73;
        Wed, 21 Aug 2019 21:17:54 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 21:17:47 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 6/9] RDMA/hns: Add reset process for function-clear
Date:   Wed, 21 Aug 2019 21:14:33 +0800
Message-ID: <1566393276-42555-7-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

If the hardware is resetting, the driver should not perform
the mailbox operation.Function-clear needs to add relevant judgment.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 98 +++++++++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 +
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7730983..ecd0283 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1125,26 +1125,118 @@ static int hns_roce_cmq_query_hw_info(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
+static bool hns_roce_func_clr_chk_rst(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hnae3_handle *handle = priv->handle;
+	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	unsigned long reset_cnt;
+	bool sw_resetting;
+	bool hw_resetting;
+
+	reset_cnt = ops->ae_dev_reset_cnt(handle);
+	hw_resetting = ops->get_hw_reset_stat(handle);
+	sw_resetting = ops->ae_dev_resetting(handle);
+
+	if (reset_cnt != hr_dev->reset_cnt || hw_resetting || sw_resetting)
+		return true;
+
+	return false;
+}
+
+static void hns_roce_func_clr_rst_prc(struct hns_roce_dev *hr_dev, int retval,
+				      int flag)
+{
+	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
+	struct hnae3_handle *handle = priv->handle;
+	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	unsigned long instance_stage;
+	unsigned long reset_cnt;
+	unsigned long end;
+	bool sw_resetting;
+	bool hw_resetting;
+
+	instance_stage = handle->rinfo.instance_state;
+	reset_cnt = ops->ae_dev_reset_cnt(handle);
+	hw_resetting = ops->get_hw_reset_stat(handle);
+	sw_resetting = ops->ae_dev_resetting(handle);
+
+	if (reset_cnt != hr_dev->reset_cnt) {
+		hr_dev->dis_db = true;
+		hr_dev->is_reset = true;
+		dev_info(hr_dev->dev, "Func clear success after reset.\n");
+	} else if (hw_resetting) {
+		hr_dev->dis_db = true;
+
+		dev_warn(hr_dev->dev,
+			 "Func clear is pending, device in resetting state.\n");
+		end = HNS_ROCE_V2_HW_RST_TIMEOUT;
+		while (end) {
+			if (!ops->get_hw_reset_stat(handle)) {
+				hr_dev->is_reset = true;
+				dev_info(hr_dev->dev,
+					 "Func clear success after reset.\n");
+				return;
+			}
+			msleep(HNS_ROCE_V2_HW_RST_COMPLETION_WAIT);
+			end -= HNS_ROCE_V2_HW_RST_COMPLETION_WAIT;
+		}
+
+		dev_warn(hr_dev->dev, "Func clear failed.\n");
+	} else if (sw_resetting && instance_stage == HNS_ROCE_STATE_INIT) {
+		hr_dev->dis_db = true;
+
+		dev_warn(hr_dev->dev,
+			 "Func clear is pending, device in resetting state.\n");
+		end = HNS_ROCE_V2_HW_RST_TIMEOUT;
+		while (end) {
+			if (ops->ae_dev_reset_cnt(handle) !=
+			    hr_dev->reset_cnt) {
+				hr_dev->is_reset = true;
+				dev_info(hr_dev->dev,
+					 "Func clear success after sw reset\n");
+				return;
+			}
+			msleep(HNS_ROCE_V2_HW_RST_COMPLETION_WAIT);
+			end -= HNS_ROCE_V2_HW_RST_COMPLETION_WAIT;
+		}
+
+		dev_warn(hr_dev->dev, "Func clear failed because of unfinished sw reset\n");
+	} else {
+		if (retval && !flag)
+			dev_warn(hr_dev->dev,
+				 "Func clear read failed, ret = %d.\n", retval);
+
+		dev_warn(hr_dev->dev, "Func clear failed.\n");
+	}
+}
 static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 {
+	bool fclr_write_fail_flag = false;
 	struct hns_roce_func_clear *resp;
 	struct hns_roce_cmq_desc desc;
 	unsigned long end;
-	int ret;
+	int ret = 0;
+
+	if (hns_roce_func_clr_chk_rst(hr_dev))
+		goto out;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_FUNC_CLEAR, false);
 	resp = (struct hns_roce_func_clear *)desc.data;
 
 	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
 	if (ret) {
+		fclr_write_fail_flag = true;
 		dev_err(hr_dev->dev, "Func clear write failed, ret = %d.\n",
 			 ret);
-		return;
+		goto out;
 	}
 
 	msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL);
 	end = HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS;
 	while (end) {
+		if (hns_roce_func_clr_chk_rst(hr_dev))
+			goto out;
 		msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT);
 		end -= HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT;
 
@@ -1161,7 +1253,9 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 		}
 	}
 
+out:
 	dev_err(hr_dev->dev, "Func clear fail.\n");
+	hns_roce_func_clr_rst_prc(hr_dev, ret, fclr_write_fail_flag);
 }
 
 static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 1301629..43219d2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -99,6 +99,8 @@
 #define HNS_ROCE_V2_HW_RST_TIMEOUT		1000
 #define HNS_ROCE_V2_HW_RST_UNINT_DELAY		100
 
+#define HNS_ROCE_V2_HW_RST_COMPLETION_WAIT	20
+
 #define HNS_ROCE_CONTEXT_HOP_NUM		1
 #define HNS_ROCE_SCCC_HOP_NUM			1
 #define HNS_ROCE_MTT_HOP_NUM			1
-- 
2.8.1

