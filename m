Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3020033EC60
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Mar 2021 10:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCQJM1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Mar 2021 05:12:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14389 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhCQJMO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Mar 2021 05:12:14 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F0ks74lg2zkbLV;
        Wed, 17 Mar 2021 17:10:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 17:12:06 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 3/5] RDMA/hns: Refactor reset state checking flow
Date:   Wed, 17 Mar 2021 17:09:41 +0800
Message-ID: <1615972183-42510-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1615972183-42510-1-git-send-email-liweihang@huawei.com>
References: <1615972183-42510-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The 'HNS_ROCE_OPC_QUERY_MB_ST' command will response the mailbox complete
status and hardware busy flag, and the complete status is only valid when
the busy flag is 0, so it's better to query these two fields at a time
rather than separately.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c    |  35 +--
 drivers/infiniband/hw/hns/hns_roce_device.h |  11 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 360 +++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  12 +-
 5 files changed, 220 insertions(+), 200 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 339e3fd..5560a62 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -73,7 +73,7 @@ static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 		return ret;
 	}
 
-	return hr_dev->hw->chk_mbox(hr_dev, timeout);
+	return hr_dev->hw->poll_mbox_done(hr_dev, timeout);
 }
 
 static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
@@ -175,33 +175,20 @@ int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 		      unsigned long in_modifier, u8 op_modifier, u16 op,
 		      unsigned int timeout)
 {
-	int ret;
+	bool is_busy;
 
-	if (hr_dev->hw->rst_prc_mbox) {
-		ret = hr_dev->hw->rst_prc_mbox(hr_dev);
-		if (ret == CMD_RST_PRC_SUCCESS)
-			return 0;
-		else if (ret == CMD_RST_PRC_EBUSY)
-			return -EBUSY;
-	}
+	if (hr_dev->hw->chk_mbox_avail)
+		if (!hr_dev->hw->chk_mbox_avail(hr_dev, &is_busy))
+			return is_busy ? -EBUSY : 0;
 
 	if (hr_dev->cmd.use_events)
-		ret = hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param,
-					     in_modifier, op_modifier, op,
-					     timeout);
+		return hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param,
+					      in_modifier, op_modifier, op,
+					      timeout);
 	else
-		ret = hns_roce_cmd_mbox_poll(hr_dev, in_param, out_param,
-					     in_modifier, op_modifier, op,
-					     timeout);
-
-	if (ret == CMD_RST_PRC_EBUSY)
-		return -EBUSY;
-
-	if (ret && (hr_dev->hw->rst_prc_mbox &&
-		    hr_dev->hw->rst_prc_mbox(hr_dev) == CMD_RST_PRC_SUCCESS))
-		return 0;
-
-	return ret;
+		return hns_roce_cmd_mbox_poll(hr_dev, in_param, out_param,
+					      in_modifier, op_modifier, op,
+					      timeout);
 }
 
 int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 30c2c86..f802c9c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -218,12 +218,6 @@ enum {
 	HNS_ROCE_RST_DIRECT_RETURN		= 0,
 };
 
-enum {
-	CMD_RST_PRC_OTHERS,
-	CMD_RST_PRC_SUCCESS,
-	CMD_RST_PRC_EBUSY,
-};
-
 #define HNS_ROCE_CMD_SUCCESS			1
 
 /* The minimum page size is 4K for hardware */
@@ -896,8 +890,9 @@ struct hns_roce_hw {
 	int (*post_mbox)(struct hns_roce_dev *hr_dev, u64 in_param,
 			 u64 out_param, u32 in_modifier, u8 op_modifier, u16 op,
 			 u16 token, int event);
-	int (*chk_mbox)(struct hns_roce_dev *hr_dev, unsigned int timeout);
-	int (*rst_prc_mbox)(struct hns_roce_dev *hr_dev);
+	int (*poll_mbox_done)(struct hns_roce_dev *hr_dev,
+			      unsigned int timeout);
+	bool (*chk_mbox_avail)(struct hns_roce_dev *hr_dev, bool *is_busy);
 	int (*set_gid)(struct hns_roce_dev *hr_dev, u8 port, int gid_index,
 		       const union ib_gid *gid, const struct ib_gid_attr *attr);
 	int (*set_mac)(struct hns_roce_dev *hr_dev, u8 phy_port, u8 *addr);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 5346fdc..ae97a23 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4349,7 +4349,7 @@ static const struct hns_roce_hw hns_roce_hw_v1 = {
 	.hw_init = hns_roce_v1_init,
 	.hw_exit = hns_roce_v1_exit,
 	.post_mbox = hns_roce_v1_post_mbox,
-	.chk_mbox = hns_roce_v1_chk_mbox,
+	.poll_mbox_done = hns_roce_v1_chk_mbox,
 	.set_gid = hns_roce_v1_set_gid,
 	.set_mac = hns_roce_v1_set_mac,
 	.set_mtu = hns_roce_v1_set_mtu,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f19f5fb1..e041199 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -48,6 +48,12 @@
 #include "hns_roce_hem.h"
 #include "hns_roce_hw_v2.h"
 
+enum {
+	CMD_RST_PRC_OTHERS,
+	CMD_RST_PRC_SUCCESS,
+	CMD_RST_PRC_EBUSY,
+};
+
 static inline void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
 				   struct ib_sge *sg)
 {
@@ -1029,7 +1035,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	return ret;
 }
 
-static int hns_roce_v2_cmd_hw_reseted(struct hns_roce_dev *hr_dev,
+static u32 hns_roce_v2_cmd_hw_reseted(struct hns_roce_dev *hr_dev,
 				      unsigned long instance_stage,
 				      unsigned long reset_stage)
 {
@@ -1052,7 +1058,7 @@ static int hns_roce_v2_cmd_hw_reseted(struct hns_roce_dev *hr_dev,
 	return CMD_RST_PRC_SUCCESS;
 }
 
-static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
+static u32 hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
 					unsigned long instance_stage,
 					unsigned long reset_stage)
 {
@@ -1080,7 +1086,7 @@ static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
 	return CMD_RST_PRC_SUCCESS;
 }
 
-static int hns_roce_v2_cmd_sw_resetting(struct hns_roce_dev *hr_dev)
+static u32 hns_roce_v2_cmd_sw_resetting(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
@@ -1097,10 +1103,9 @@ static int hns_roce_v2_cmd_sw_resetting(struct hns_roce_dev *hr_dev)
 	return CMD_RST_PRC_EBUSY;
 }
 
-static int hns_roce_v2_rst_process_cmd(struct hns_roce_dev *hr_dev)
+static u32 check_aedev_reset_status(struct hns_roce_dev *hr_dev,
+				    struct hnae3_handle *handle)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
 	unsigned long instance_stage; /* the current instance stage */
 	unsigned long reset_stage; /* the current reset stage */
@@ -1108,9 +1113,6 @@ static int hns_roce_v2_rst_process_cmd(struct hns_roce_dev *hr_dev)
 	bool sw_resetting;
 	bool hw_resetting;
 
-	if (hr_dev->is_reset)
-		return CMD_RST_PRC_SUCCESS;
-
 	/* Get information about reset from NIC driver or RoCE driver itself,
 	 * the meaning of the following variables from NIC driver are described
 	 * as below:
@@ -1121,19 +1123,53 @@ static int hns_roce_v2_rst_process_cmd(struct hns_roce_dev *hr_dev)
 	instance_stage = handle->rinfo.instance_state;
 	reset_stage = handle->rinfo.reset_state;
 	reset_cnt = ops->ae_dev_reset_cnt(handle);
-	hw_resetting = ops->get_cmdq_stat(handle);
-	sw_resetting = ops->ae_dev_resetting(handle);
-
 	if (reset_cnt != hr_dev->reset_cnt)
 		return hns_roce_v2_cmd_hw_reseted(hr_dev, instance_stage,
 						  reset_stage);
-	else if (hw_resetting)
+
+	hw_resetting = ops->get_cmdq_stat(handle);
+	if (hw_resetting)
 		return hns_roce_v2_cmd_hw_resetting(hr_dev, instance_stage,
 						    reset_stage);
-	else if (sw_resetting && instance_stage == HNS_ROCE_STATE_INIT)
+
+	sw_resetting = ops->ae_dev_resetting(handle);
+	if (sw_resetting && instance_stage == HNS_ROCE_STATE_INIT)
 		return hns_roce_v2_cmd_sw_resetting(hr_dev);
 
-	return 0;
+	return CMD_RST_PRC_OTHERS;
+}
+
+static bool check_device_is_in_reset(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hnae3_handle *handle = priv->handle;
+	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+
+	if (hr_dev->reset_cnt != ops->ae_dev_reset_cnt(handle))
+		return true;
+
+	if (ops->get_hw_reset_stat(handle))
+		return true;
+
+	if (ops->ae_dev_resetting(handle))
+		return true;
+
+	return false;
+}
+
+static bool v2_chk_mbox_is_avail(struct hns_roce_dev *hr_dev, bool *busy)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	u32 status;
+
+	if (hr_dev->is_reset)
+		status = CMD_RST_PRC_SUCCESS;
+	else
+		status = check_aedev_reset_status(hr_dev, priv->handle);
+
+	*busy = (status == CMD_RST_PRC_EBUSY);
+
+	return status == CMD_RST_PRC_OTHERS;
 }
 
 static int hns_roce_alloc_cmq_desc(struct hns_roce_dev *hr_dev,
@@ -1349,22 +1385,16 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			     struct hns_roce_cmq_desc *desc, int num)
 {
-	int retval;
+	bool busy;
 	int ret;
 
-	ret = hns_roce_v2_rst_process_cmd(hr_dev);
-	if (ret == CMD_RST_PRC_SUCCESS)
-		return 0;
-	if (ret == CMD_RST_PRC_EBUSY)
-		return -EBUSY;
+	if (!v2_chk_mbox_is_avail(hr_dev, &busy))
+		return busy ? -EBUSY : 0;
 
 	ret = __hns_roce_cmq_send(hr_dev, desc, num);
 	if (ret) {
-		retval = hns_roce_v2_rst_process_cmd(hr_dev);
-		if (retval == CMD_RST_PRC_SUCCESS)
-			return 0;
-		else if (retval == CMD_RST_PRC_EBUSY)
-			return -EBUSY;
+		if (!v2_chk_mbox_is_avail(hr_dev, &busy))
+			return busy ? -EBUSY : 0;
 	}
 
 	return ret;
@@ -1388,91 +1418,89 @@ static int hns_roce_cmq_query_hw_info(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
-static bool hns_roce_func_clr_chk_rst(struct hns_roce_dev *hr_dev)
+static void func_clr_hw_resetting_state(struct hns_roce_dev *hr_dev,
+					struct hnae3_handle *handle)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
-	unsigned long reset_cnt;
-	bool sw_resetting;
-	bool hw_resetting;
+	unsigned long end;
 
-	reset_cnt = ops->ae_dev_reset_cnt(handle);
-	hw_resetting = ops->get_hw_reset_stat(handle);
-	sw_resetting = ops->ae_dev_resetting(handle);
+	hr_dev->dis_db = true;
 
-	if (reset_cnt != hr_dev->reset_cnt || hw_resetting || sw_resetting)
-		return true;
+	dev_warn(hr_dev->dev,
+		 "Func clear is pending, device in resetting state.\n");
+	end = HNS_ROCE_V2_HW_RST_TIMEOUT;
+	while (end) {
+		if (!ops->get_hw_reset_stat(handle)) {
+			hr_dev->is_reset = true;
+			dev_info(hr_dev->dev,
+				 "Func clear success after reset.\n");
+			return;
+		}
+		msleep(HNS_ROCE_V2_HW_RST_COMPLETION_WAIT);
+		end -= HNS_ROCE_V2_HW_RST_COMPLETION_WAIT;
+	}
 
-	return false;
+	dev_warn(hr_dev->dev, "Func clear failed.\n");
 }
 
-static void hns_roce_func_clr_rst_prc(struct hns_roce_dev *hr_dev, int retval,
-				      int flag)
+static void func_clr_sw_resetting_state(struct hns_roce_dev *hr_dev,
+					struct hnae3_handle *handle)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
-	unsigned long instance_stage;
-	unsigned long reset_cnt;
 	unsigned long end;
-	bool sw_resetting;
-	bool hw_resetting;
 
-	instance_stage = handle->rinfo.instance_state;
-	reset_cnt = ops->ae_dev_reset_cnt(handle);
-	hw_resetting = ops->get_hw_reset_stat(handle);
-	sw_resetting = ops->ae_dev_resetting(handle);
+	hr_dev->dis_db = true;
 
-	if (reset_cnt != hr_dev->reset_cnt) {
+	dev_warn(hr_dev->dev,
+		 "Func clear is pending, device in resetting state.\n");
+	end = HNS_ROCE_V2_HW_RST_TIMEOUT;
+	while (end) {
+		if (ops->ae_dev_reset_cnt(handle) !=
+		    hr_dev->reset_cnt) {
+			hr_dev->is_reset = true;
+			dev_info(hr_dev->dev,
+				 "Func clear success after sw reset\n");
+			return;
+		}
+		msleep(HNS_ROCE_V2_HW_RST_COMPLETION_WAIT);
+		end -= HNS_ROCE_V2_HW_RST_COMPLETION_WAIT;
+	}
+
+	dev_warn(hr_dev->dev, "Func clear failed because of unfinished sw reset\n");
+}
+
+static void hns_roce_func_clr_rst_proc(struct hns_roce_dev *hr_dev, int retval,
+				       int flag)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hnae3_handle *handle = priv->handle;
+	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+
+	if (ops->ae_dev_reset_cnt(handle) != hr_dev->reset_cnt) {
 		hr_dev->dis_db = true;
 		hr_dev->is_reset = true;
 		dev_info(hr_dev->dev, "Func clear success after reset.\n");
-	} else if (hw_resetting) {
-		hr_dev->dis_db = true;
+		return;
+	}
 
-		dev_warn(hr_dev->dev,
-			 "Func clear is pending, device in resetting state.\n");
-		end = HNS_ROCE_V2_HW_RST_TIMEOUT;
-		while (end) {
-			if (!ops->get_hw_reset_stat(handle)) {
-				hr_dev->is_reset = true;
-				dev_info(hr_dev->dev,
-					 "Func clear success after reset.\n");
-				return;
-			}
-			msleep(HNS_ROCE_V2_HW_RST_COMPLETION_WAIT);
-			end -= HNS_ROCE_V2_HW_RST_COMPLETION_WAIT;
-		}
+	if (ops->get_hw_reset_stat(handle)) {
+		func_clr_hw_resetting_state(hr_dev, handle);
+		return;
+	}
 
-		dev_warn(hr_dev->dev, "Func clear failed.\n");
-	} else if (sw_resetting && instance_stage == HNS_ROCE_STATE_INIT) {
-		hr_dev->dis_db = true;
+	if (ops->ae_dev_resetting(handle) &&
+	    handle->rinfo.instance_state == HNS_ROCE_STATE_INIT) {
+		func_clr_sw_resetting_state(hr_dev, handle);
+		return;
+	}
 
+	if (retval && !flag)
 		dev_warn(hr_dev->dev,
-			 "Func clear is pending, device in resetting state.\n");
-		end = HNS_ROCE_V2_HW_RST_TIMEOUT;
-		while (end) {
-			if (ops->ae_dev_reset_cnt(handle) !=
-			    hr_dev->reset_cnt) {
-				hr_dev->is_reset = true;
-				dev_info(hr_dev->dev,
-					 "Func clear success after sw reset\n");
-				return;
-			}
-			msleep(HNS_ROCE_V2_HW_RST_COMPLETION_WAIT);
-			end -= HNS_ROCE_V2_HW_RST_COMPLETION_WAIT;
-		}
-
-		dev_warn(hr_dev->dev, "Func clear failed because of unfinished sw reset\n");
-	} else {
-		if (retval && !flag)
-			dev_warn(hr_dev->dev,
-				 "Func clear read failed, ret = %d.\n", retval);
+			 "Func clear read failed, ret = %d.\n", retval);
 
-		dev_warn(hr_dev->dev, "Func clear failed.\n");
-	}
+	dev_warn(hr_dev->dev, "Func clear failed.\n");
 }
+
 static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 {
 	bool fclr_write_fail_flag = false;
@@ -1481,7 +1509,7 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 	unsigned long end;
 	int ret = 0;
 
-	if (hns_roce_func_clr_chk_rst(hr_dev))
+	if (check_device_is_in_reset(hr_dev))
 		goto out;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_FUNC_CLEAR, false);
@@ -1498,7 +1526,7 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 	msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL);
 	end = HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS;
 	while (end) {
-		if (hns_roce_func_clr_chk_rst(hr_dev))
+		if (check_device_is_in_reset(hr_dev))
 			goto out;
 		msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT);
 		end -= HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT;
@@ -1517,7 +1545,7 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 	}
 
 out:
-	hns_roce_func_clr_rst_prc(hr_dev, ret, fclr_write_fail_flag);
+	hns_roce_func_clr_rst_proc(hr_dev, ret, fclr_write_fail_flag);
 }
 
 static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
@@ -2660,36 +2688,6 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 		free_dip_list(hr_dev);
 }
 
-static int hns_roce_query_mbox_status(struct hns_roce_dev *hr_dev)
-{
-	struct hns_roce_cmq_desc desc;
-	struct hns_roce_mbox_status *mb_st =
-				       (struct hns_roce_mbox_status *)desc.data;
-	int status;
-
-	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_MB_ST, true);
-
-	status = hns_roce_cmq_send(hr_dev, &desc, 1);
-	if (status)
-		return status;
-
-	return le32_to_cpu(mb_st->mb_status_hw_run);
-}
-
-static int hns_roce_v2_cmd_pending(struct hns_roce_dev *hr_dev)
-{
-	u32 status = hns_roce_query_mbox_status(hr_dev);
-
-	return status >> HNS_ROCE_HW_RUN_BIT_SHIFT;
-}
-
-static int hns_roce_v2_cmd_complete(struct hns_roce_dev *hr_dev)
-{
-	u32 status = hns_roce_query_mbox_status(hr_dev);
-
-	return status & HNS_ROCE_HW_MB_STATUS_MASK;
-}
-
 static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev, u64 in_param,
 			      u64 out_param, u32 in_modifier, u8 op_modifier,
 			      u16 op, u16 token, int event)
@@ -2709,58 +2707,97 @@ static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev, u64 in_param,
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
-static int hns_roce_v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
-				 u64 out_param, u32 in_modifier, u8 op_modifier,
-				 u16 op, u16 token, int event)
+static int v2_wait_mbox_complete(struct hns_roce_dev *hr_dev, u32 timeout,
+				 u8 *complete_status)
 {
-	struct device *dev = hr_dev->dev;
+	struct hns_roce_mbox_status *mb_st;
+	struct hns_roce_cmq_desc desc;
 	unsigned long end;
-	int ret;
+	int ret = -EBUSY;
+	u32 status;
+	bool busy;
+
+	mb_st = (struct hns_roce_mbox_status *)desc.data;
+	end = msecs_to_jiffies(timeout) + jiffies;
+	while (v2_chk_mbox_is_avail(hr_dev, &busy)) {
+		status = 0;
+		hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_MB_ST,
+					      true);
+		ret = __hns_roce_cmq_send(hr_dev, &desc, 1);
+		if (!ret) {
+			status = le32_to_cpu(mb_st->mb_status_hw_run);
+			/* No pending message exists in ROCEE mbox. */
+			if (!(status & MB_ST_HW_RUN_M))
+				break;
+		} else if (!v2_chk_mbox_is_avail(hr_dev, &busy)) {
+			break;
+		}
 
-	end = msecs_to_jiffies(HNS_ROCE_V2_GO_BIT_TIMEOUT_MSECS) + jiffies;
-	while (hns_roce_v2_cmd_pending(hr_dev)) {
 		if (time_after(jiffies, end)) {
-			dev_dbg(dev, "jiffies=%d end=%d\n", (int)jiffies,
-				(int)end);
-			return -EAGAIN;
+			dev_err_ratelimited(hr_dev->dev,
+					    "failed to wait mbox status 0x%x\n",
+					    status);
+			return -ETIMEDOUT;
 		}
+
 		cond_resched();
+		ret = -EBUSY;
 	}
 
-	ret = hns_roce_mbox_post(hr_dev, in_param, out_param, in_modifier,
-				 op_modifier, op, token, event);
-	if (ret)
-		dev_err(dev, "Post mailbox fail(%d)\n", ret);
+	if (!ret) {
+		*complete_status = (u8)(status & MB_ST_COMPLETE_M);
+	} else if (!v2_chk_mbox_is_avail(hr_dev, &busy)) {
+		/* Ignore all errors if the mbox is unavailable. */
+		ret = 0;
+		*complete_status = MB_ST_COMPLETE_M;
+	}
 
 	return ret;
 }
 
-static int hns_roce_v2_chk_mbox(struct hns_roce_dev *hr_dev,
-				unsigned int timeout)
+static int v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
+			u64 out_param, u32 in_modifier, u8 op_modifier,
+			u16 op, u16 token, int event)
 {
-	struct device *dev = hr_dev->dev;
-	unsigned long end;
-	u32 status;
-
-	end = msecs_to_jiffies(timeout) + jiffies;
-	while (hns_roce_v2_cmd_pending(hr_dev) && time_before(jiffies, end))
-		cond_resched();
+	u8 status = 0;
+	int ret;
 
-	if (hns_roce_v2_cmd_pending(hr_dev)) {
-		dev_err(dev, "[cmd_poll]hw run cmd TIMEDOUT!\n");
-		return -ETIMEDOUT;
+	/* Waiting for the mbox to be idle */
+	ret = v2_wait_mbox_complete(hr_dev, HNS_ROCE_V2_GO_BIT_TIMEOUT_MSECS,
+				    &status);
+	if (unlikely(ret)) {
+		dev_err_ratelimited(hr_dev->dev,
+				    "failed to check post mbox status = 0x%x, ret = %d.\n",
+				    status, ret);
+		return ret;
 	}
 
-	status = hns_roce_v2_cmd_complete(hr_dev);
-	if (status != 0x1) {
-		if (status == CMD_RST_PRC_EBUSY)
-			return status;
+	/* Post new message to mbox */
+	ret = hns_roce_mbox_post(hr_dev, in_param, out_param, in_modifier,
+				 op_modifier, op, token, event);
+	if (ret)
+		dev_err_ratelimited(hr_dev->dev,
+				    "failed to post mailbox, ret = %d.\n", ret);
+
+	return ret;
+}
+
+static int v2_poll_mbox_done(struct hns_roce_dev *hr_dev, unsigned int timeout)
+{
+	u8 status = 0;
+	int ret;
 
-		dev_err(dev, "mailbox status 0x%x!\n", status);
-		return -EBUSY;
+	ret = v2_wait_mbox_complete(hr_dev, timeout, &status);
+	if (!ret) {
+		if (status != MB_ST_COMPLETE_SUCC)
+			return -EBUSY;
+	} else {
+		dev_err_ratelimited(hr_dev->dev,
+				    "failed to check mbox status = 0x%x, ret = %d.\n",
+				    status, ret);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void copy_gid(void *dest, const union ib_gid *gid)
@@ -6455,6 +6492,8 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	hns_roce_v2_int_mask_enable(hr_dev, eq_num, EQ_DISABLE);
 
 	__hns_roce_free_irq(hr_dev);
+	flush_workqueue(hr_dev->irq_workq);
+	destroy_workqueue(hr_dev->irq_workq);
 
 	for (i = 0; i < eq_num; i++) {
 		hns_roce_v2_destroy_eqc(hr_dev, i);
@@ -6463,9 +6502,6 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	}
 
 	kfree(eq_table->eq);
-
-	flush_workqueue(hr_dev->irq_workq);
-	destroy_workqueue(hr_dev->irq_workq);
 }
 
 static const struct hns_roce_dfx_hw hns_roce_dfx_hw_v2 = {
@@ -6494,9 +6530,9 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.hw_profile = hns_roce_v2_profile,
 	.hw_init = hns_roce_v2_init,
 	.hw_exit = hns_roce_v2_exit,
-	.post_mbox = hns_roce_v2_post_mbox,
-	.chk_mbox = hns_roce_v2_chk_mbox,
-	.rst_prc_mbox = hns_roce_v2_rst_process_cmd,
+	.post_mbox = v2_post_mbox,
+	.poll_mbox_done = v2_poll_mbox_done,
+	.chk_mbox_avail = v2_chk_mbox_is_avail,
 	.set_gid = hns_roce_v2_set_gid,
 	.set_mac = hns_roce_v2_set_mac,
 	.write_mtpt = hns_roce_v2_write_mtpt,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 7e9b777..1d6d89e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1594,6 +1594,13 @@ struct hns_roce_mbox_status {
 	__le32	rsv[5];
 };
 
+#define HNS_ROCE_V2_GO_BIT_TIMEOUT_MSECS 10000
+
+#define MB_ST_HW_RUN_M BIT(31)
+#define MB_ST_COMPLETE_M GENMASK(7, 0)
+
+#define MB_ST_COMPLETE_SUCC 1
+
 struct hns_roce_cfg_bt_attr {
 	__le32 vf_qpc_cfg;
 	__le32 vf_srqc_cfg;
@@ -1891,11 +1898,6 @@ struct hns_roce_cmq_desc {
 	__le32 data[6];
 };
 
-#define HNS_ROCE_V2_GO_BIT_TIMEOUT_MSECS	10000
-
-#define HNS_ROCE_HW_RUN_BIT_SHIFT	31
-#define HNS_ROCE_HW_MB_STATUS_MASK	0xFF
-
 struct hns_roce_v2_cmq_ring {
 	dma_addr_t desc_dma_addr;
 	struct hns_roce_cmq_desc *desc;
-- 
2.8.1

