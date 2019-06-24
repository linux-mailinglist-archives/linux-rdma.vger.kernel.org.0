Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB88D50A1A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 13:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfFXLuw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 07:50:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729356AbfFXLuw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 07:50:52 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF3DB62BC3E0F44F59DE;
        Mon, 24 Jun 2019 19:50:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 19:50:42 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 6/8] RDMA/hns: Use %pK format pointer print
Date:   Mon, 24 Jun 2019 19:47:50 +0800
Message-ID: <1561376872-111496-7-git-send-email-oulijun@huawei.com>
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

From: Lang Cheng <chenglang@huawei.com>

The format specifier \"%p\" can leak kernel addresses.
Use \"%pK\" instead.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 5517f34..27377a5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -3902,7 +3902,8 @@ static int hns_roce_v1_aeq_int(struct hns_roce_dev *hr_dev,
 		 */
 		dma_rmb();
 
-		dev_dbg(dev, "aeqe = %p, aeqe->asyn.event_type = 0x%lx\n", aeqe,
+		dev_dbg(dev, "aeqe = %pK, aeqe->asyn.event_type = 0x%lx\n",
+			aeqe,
 			roce_get_field(aeqe->asyn,
 				       HNS_ROCE_AEQE_U32_4_EVENT_TYPE_M,
 				       HNS_ROCE_AEQE_U32_4_EVENT_TYPE_S));
-- 
1.9.1

