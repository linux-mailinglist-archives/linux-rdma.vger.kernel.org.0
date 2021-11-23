Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64306459E9A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Nov 2021 09:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhKWI4I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 03:56:08 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28091 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhKWIzy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Nov 2021 03:55:54 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HyyWm6W52z1DJSy;
        Tue, 23 Nov 2021 16:50:12 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:52:43 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:52:43 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix the problem of mailbox being blocked in the reset scene
Date:   Tue, 23 Nov 2021 16:48:09 +0800
Message-ID: <20211123084809.37318-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

is_reset is used to indicate whether the hardware starts to reset. When
hns_roce_hw_v2_reset_notify_down() is called, the hardware has not yet
started to reset. If is_reset is set at this time, all mailbox operations
of resource destroy actions will be intercepted by driver. When the driver
cleans up resources, but the hardware is still accessed, the following
errors will appear:

[382663.191495] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
[382663.336320] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000350100000010
[382663.349860] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x000002088000003f
[382663.362217] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x00000000a50e0800
[382663.370690] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000000000000000
[382663.385557] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
[382663.487465] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000350100000010
[382663.534555] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x000002088000043e
[382663.546569] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x00000000a50a0800
[382663.554642] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000000000000000
[382663.565023] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
[382663.575860] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000350100000010
[382663.585248] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000020880000436
[382663.595860] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x00000000a50a0880
[382663.804870] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000000000000000
[382663.942132] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
[382663.962770] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000350100000010
[382664.100535] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x000002088000043a
[382664.178632] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x00000000a50e0840
[382664.218997] hns3 0000:35:00.0: INT status: CMDQ(0x0) HW errors(0x0) other(0x0)
[382664.223572] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000000000000000
[382664.257988] hns3 0000:35:00.0: received unknown or unhandled event of vector0
[382664.271027] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
[382664.546592] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000350100000010
[382664.555942] {34}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 7

is_reset will be set correctly in check_aedev_reset_status(), so the
setting in hns_roce_hw_v2_reset_notify_down() should be deleted.

Fixes: 726be12f5ca0 ("RDMA/hns: Set reset flag when hw resetting")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 9bfbaddd1763..ae14329c619c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6387,10 +6387,8 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 	if (!hr_dev)
 		return 0;
 
-	hr_dev->is_reset = true;
 	hr_dev->active = false;
 	hr_dev->dis_db = true;
-
 	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
 
 	return 0;
-- 
2.33.0

