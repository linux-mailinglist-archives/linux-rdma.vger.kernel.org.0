Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37C145A5A5
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Nov 2021 15:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhKWObq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 09:31:46 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28095 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhKWObq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Nov 2021 09:31:46 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Hz5zK4F46z1DJPv;
        Tue, 23 Nov 2021 22:26:05 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 22:28:36 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 22:28:36 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix the error of destroying resources in hw reseting phase
Date:   Tue, 23 Nov 2021 22:24:02 +0800
Message-ID: <20211123142402.26936-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

When hns_roce_v2_destroy_qp() is called, the brief calling process of the
driver is as follows:

......
hns_roce_v2_destroy_qp
hns_roce_v2_qp_modify
	   hns_roce_cmd_mbox
hns_roce_qp_destroy

If hns_roce_cmd_mbox() detects that the hardware is being reset during
the execution of the hns_roce_cmd_mbox(), the driver will not be able
to get the return value from the hardware (the firmware cannot respond
to the driver's mailbox during the hardware reset phase). The driver
needs to wait for the hardware reset to complete before continuing to
execute hns_roce_qp_destroy(), otherwise it may happen that the driver
releases the resources but the hardware is still accessing. In order to
fix this problem, HNS RoCE needs to add a piece of code to wait for the
hardware reset to complete.

The original interface get_hw_reset_stat() is the instantaneous state
of the hardware reset, which cannot accurately reflect whether the
hardware reset is completed, so it needs to be replaced with the
ae_dev_reset_cnt interface.

The sign that the hardware reset is complete is that the return value
of the ae_dev_reset_cnt interface is greater than the original value
reset_cnt recorded by the driver.

Fixes: 6a04aed6afae ("RDMA/hns: Fix the chip hanging caused by sending mailbox&CMQ during reset")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ae14329c619c..bbfa1332dedc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -33,6 +33,7 @@
 #include <linux/acpi.h>
 #include <linux/etherdevice.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <net/addrconf.h>
@@ -1050,9 +1051,14 @@ static u32 hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
 					unsigned long instance_stage,
 					unsigned long reset_stage)
 {
+#define HW_RESET_TIMEOUT_US 1000000
+#define HW_RESET_SLEEP_US 1000
+
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
+	unsigned long val;
+	int ret;
 
 	/* When hardware reset is detected, we should stop sending mailbox&cmq&
 	 * doorbell to hardware. If now in .init_instance() function, we should
@@ -1064,7 +1070,11 @@ static u32 hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
 	 * again.
 	 */
 	hr_dev->dis_db = true;
-	if (!ops->get_hw_reset_stat(handle))
+
+	ret = read_poll_timeout(ops->ae_dev_reset_cnt, val,
+				val > hr_dev->reset_cnt, HW_RESET_SLEEP_US,
+				HW_RESET_TIMEOUT_US, false, handle);
+	if (!ret)
 		hr_dev->is_reset = true;
 
 	if (!hr_dev->is_reset || reset_stage == HNS_ROCE_STATE_RST_INIT ||
-- 
2.33.0

