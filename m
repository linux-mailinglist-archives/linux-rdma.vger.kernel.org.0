Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9BA514573
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Apr 2022 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353293AbiD2JfR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Apr 2022 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiD2JfR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Apr 2022 05:35:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46CC4023
        for <linux-rdma@vger.kernel.org>; Fri, 29 Apr 2022 02:31:59 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KqRwB460WzCsVL;
        Fri, 29 Apr 2022 17:27:22 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:31:57 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:31:57 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Add the detection for CMDQ status in the device initialization process
Date:   Fri, 29 Apr 2022 17:31:04 +0800
Message-ID: <20220429093104.26687-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

CMDQ may fail during HNS ROCEE initialization. The following is the log
when the execution fails:

[ 481.424373] hns3 0000:bd:00.2: In reset process RoCE client reinit.
[ 482.120830] hns3 0000:bd:00.2: CMDQ move tail from 840 to 839
[ 482.129220] hns3 0000:bd:00.2 hns_2: failed to set gid, ret = -11!
[ 482.184702] hns3 0000:bd:00.2: CMDQ move tail from 840 to 839
<...>
[ 485.540909] hns3 0000:bd:00.2: CMDQ move tail from 840 to 839
[ 485.579958] hns3 0000:bd:00.2: CMDQ move tail from 840 to 0
[ 495.694616] hns3 0000:bd:00.2: [cmd]token 14e mailbox 20 timeout.
[ 495.700689] hns3 0000:bd:00.2 hns_2: set HEM step 0 failed!
[ 495.706242] hns3 0000:bd:00.2 hns_2: set HEM address to HW failed!
[ 495.712412] hns3 0000:bd:00.2 hns_2: failed to alloc mtpt, ret = -16.
[ 495.718836] infiniband hns_2: Couldn't create ib_mad PD
[ 495.724046] infiniband hns_2: Couldn't open port 1
[ 495.729375] hns3 0000:bd:00.2: Reset done, RoCE client reinit finished.

However, even if ib_mad client registration failed, ib_register_device()
still returns success to the driver.

In the device initialization process, CMDQ execution fails because HW/FW
is abnormal. Therefore, if CMDQ fails, the initialization function should
set CMDQ to a fatal error state and return a failure to the caller.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index bc9f25e79c87..fc2fd4e9e8a6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -525,6 +525,11 @@ struct hns_roce_cmd_context {
 	u16			busy;
 };
 
+enum hns_roce_cmdq_state {
+	HNS_ROCE_CMDQ_STATE_NORMAL,
+	HNS_ROCE_CMDQ_STATE_FATAL_ERR,
+};
+
 struct hns_roce_cmdq {
 	struct dma_pool		*pool;
 	struct semaphore	poll_sem;
@@ -544,6 +549,7 @@ struct hns_roce_cmdq {
 	 * close device, switch into poll mode(non event mode)
 	 */
 	u8			use_events;
+	enum hns_roce_cmdq_state state;
 };
 
 struct hns_roce_cmd_mailbox {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2abed0e3dfd8..329b37de1990 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1265,6 +1265,16 @@ static int hns_roce_cmq_csq_done(struct hns_roce_dev *hr_dev)
 	return tail == priv->cmq.csq.head;
 }
 
+static void update_cmdq_status(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hnae3_handle *handle = priv->handle;
+
+	if (handle->rinfo.reset_state == HNS_ROCE_STATE_RST_INIT ||
+	    handle->rinfo.instance_state == HNS_ROCE_STATE_INIT)
+		hr_dev->cmd.state = HNS_ROCE_CMDQ_STATE_FATAL_ERR;
+}
+
 static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_cmq_desc *desc, int num)
 {
@@ -1319,6 +1329,8 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			 csq->head, tail);
 		csq->head = tail;
 
+		update_cmdq_status(hr_dev);
+
 		ret = -EAGAIN;
 	}
 
@@ -1333,6 +1345,9 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	bool busy;
 	int ret;
 
+	if (hr_dev->cmd.state == HNS_ROCE_CMDQ_STATE_FATAL_ERR)
+		return -EIO;
+
 	if (!v2_chk_mbox_is_avail(hr_dev, &busy))
 		return busy ? -EBUSY : 0;
 
@@ -1531,6 +1546,9 @@ static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
 	int ret;
 	int i;
 
+	if (hr_dev->cmd.state == HNS_ROCE_CMDQ_STATE_FATAL_ERR)
+		return;
+
 	for (i = hr_dev->func_num - 1; i >= 0; i--) {
 		__hns_roce_function_clear(hr_dev, i);
 
@@ -3010,6 +3028,9 @@ static int v2_wait_mbox_complete(struct hns_roce_dev *hr_dev, u32 timeout,
 	mb_st = (struct hns_roce_mbox_status *)desc.data;
 	end = msecs_to_jiffies(timeout) + jiffies;
 	while (v2_chk_mbox_is_avail(hr_dev, &busy)) {
+		if (hr_dev->cmd.state == HNS_ROCE_CMDQ_STATE_FATAL_ERR)
+			return -EIO;
+
 		status = 0;
 		hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_MB_ST,
 					      true);
-- 
2.33.0

