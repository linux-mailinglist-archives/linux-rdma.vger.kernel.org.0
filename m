Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3877850A19
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 13:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfFXLuw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 07:50:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49324 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbfFXLuw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 07:50:52 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D17C3A845EE4C891969C;
        Mon, 24 Jun 2019 19:50:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 19:50:42 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 7/8] RDMA/hns: Fixs hw access invalid dma memory error
Date:   Mon, 24 Jun 2019 19:47:51 +0800
Message-ID: <1561376872-111496-8-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
References: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

When smmu is enable, if execute the perftest command and then use
'kill -9' to exit, follow this operation repeatedly, the kernel
will have a high probability to print the following smmu event:

[  173.183547] arm-smmu-v3 arm-smmu-v3.1.auto: event 0x10 received:
[  173.191862] arm-smmu-v3 arm-smmu-v3.1.auto:  0x00007d0000000010
[  173.200551] arm-smmu-v3 arm-smmu-v3.1.auto:  0x0000020900000080
[  173.209235] arm-smmu-v3 arm-smmu-v3.1.auto:  0x00000000f47cf000
[  173.217918] arm-smmu-v3 arm-smmu-v3.1.auto:  0x00000000f47cf000

This is because the hw will periodically refresh the qpc cache until
the next reset.

This patch fixed it by removing the action that release qpc memory in
the 'hns_roce_qp_free' function.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index d56c03d..9320773 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -257,7 +257,6 @@ void hns_roce_qp_free(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 			hns_roce_table_put(hr_dev, &qp_table->trrl_table,
 					   hr_qp->qpn);
 		hns_roce_table_put(hr_dev, &qp_table->irrl_table, hr_qp->qpn);
-		hns_roce_table_put(hr_dev, &qp_table->qp_table, hr_qp->qpn);
 	}
 }
 EXPORT_SYMBOL_GPL(hns_roce_qp_free);
-- 
1.9.1

