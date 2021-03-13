Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4849339B44
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Mar 2021 03:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhCMCdH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 21:33:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13916 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhCMCck (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Mar 2021 21:32:40 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dy6B32JQqzkX2r;
        Sat, 13 Mar 2021 10:31:07 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 13 Mar 2021 10:32:31 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 for-rc] RDMA/hns: Fix bug during CMDQ initialization
Date:   Sat, 13 Mar 2021 10:30:11 +0800
Message-ID: <1615602611-7963-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

When reloading driver, the head/tail pointer of CMDQ may be not at position
0. Then during initialization of CMDQ, if head is reset first, the firmware
will start to handle CMDQ because the head is not equal to the tail. The
driver can reset tail first since the firmware will be triggerred only by
head. This bug is introduced by changing macros of head/tail register
without changing the order of initialization.

Fixes: 292b3352bd5b ("RDMA/hns: Adjust fields and variables about CMDQ tail/head")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Changes since v1:
- Only retain the bugfix part for -rc branch.
- Link: https://patchwork.kernel.org/project/linux-rdma/patch/1615541933-35798-1-git-send-email-liweihang@huawei.com/

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c3934ab..ce26f97 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1194,8 +1194,10 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 			   upper_32_bits(dma));
 		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
 			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
-		roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, 0);
+
+		/* Make sure to write tail first and then head */
 		roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, 0);
+		roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, 0);
 	} else {
 		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_L_REG, (u32)dma);
 		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_H_REG,
-- 
2.8.1

