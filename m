Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30C987679
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 11:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406043AbfHIJpd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 05:45:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405773AbfHIJpd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Aug 2019 05:45:33 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C1C37E7F778F3AB9B2A5;
        Fri,  9 Aug 2019 17:45:31 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 17:45:21 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 7/9] RDMA/hns: Remove unuseful member
Date:   Fri, 9 Aug 2019 17:41:04 +0800
Message-ID: <1565343666-73193-8-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

For struct hns_roce_cmdq, toggle is unused and
delete it.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c    | 1 -
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 0cd09bf..ade26fa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -211,7 +211,6 @@ int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
 	mutex_init(&hr_dev->cmd.hcr_mutex);
 	sema_init(&hr_dev->cmd.poll_sem, 1);
 	hr_dev->cmd.use_events = 0;
-	hr_dev->cmd.toggle = 1;
 	hr_dev->cmd.max_cmds = CMD_MAX_NUM;
 	hr_dev->cmd.pool = dma_pool_create("hns_roce_cmd", dev,
 					   HNS_ROCE_MAILBOX_SIZE,
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 8c4b120..32465f5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -617,7 +617,6 @@ struct hns_roce_cmdq {
 	 * close device, switch into poll mode(non event mode)
 	 */
 	u8			use_events;
-	u8			toggle;
 };
 
 struct hns_roce_cmd_mailbox {
-- 
1.9.1

