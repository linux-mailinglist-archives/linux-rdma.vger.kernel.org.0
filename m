Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB951FB251
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgFPNkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 09:40:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54406 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbgFPNkO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 09:40:14 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 30CD69563536617106AF;
        Tue, 16 Jun 2020 21:40:11 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 21:40:04 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix an cmd queue issue when resetting
Date:   Tue, 16 Jun 2020 21:39:38 +0800
Message-ID: <1592314778-52822-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

If a IMP reset caused by some hardware errors and hns RoCE driver reset
occurred at the same time, there is a possiblity that the IMP will stop
dealing with command and users can't use the hardware. The logs are as
follows:

[17223.382506] hns3 0000:fd:00.1: cleaned 0, need to clean 1
[17223.382515] hns3 0000:fd:00.1: firmware version query failed -11
[17223.382516] hns3 0000:fd:00.1: Cmd queue init failed
[17223.382523] hns3 0000:fd:00.1: Upgrade reset level
[17223.382529] hns3 0000:fd:00.1: global reset interrupt

The hns NIC driver divides the reset process into 3 status: initialization,
hardware resetting and softwaring restting. RoCE driver gets reset status
by interfaces provided by NIC driver and commands will not be sent to the
IMP if the driver is in any above status. The main reason for this issue is
that there is a time gap between status 1 and 2, if the RoCE driver sends
commands to the IMP during this gap, the IMP will stop working because it
is not ready.

To eliminate the time gap, the hns NIC driver has added a new interface in
commit a4de02287abb9 ("net: hns3: provide .get_cmdq_stat interface for the
client"), so RoCE driver can ensure that no commands will be sent during
resetting.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index bb86754c..dd01a51 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -910,7 +910,7 @@ static int hns_roce_v2_rst_process_cmd(struct hns_roce_dev *hr_dev)
 	instance_stage = handle->rinfo.instance_state;
 	reset_stage = handle->rinfo.reset_state;
 	reset_cnt = ops->ae_dev_reset_cnt(handle);
-	hw_resetting = ops->get_hw_reset_stat(handle);
+	hw_resetting = ops->get_cmdq_stat(handle);
 	sw_resetting = ops->ae_dev_resetting(handle);
 
 	if (reset_cnt != hr_dev->reset_cnt)
-- 
2.8.1

