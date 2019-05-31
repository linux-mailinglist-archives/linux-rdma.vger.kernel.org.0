Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36DC30C81
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2019 12:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfEaKZD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 May 2019 06:25:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51474 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbfEaKZD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 May 2019 06:25:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AD0B67CC7122F69BFE37;
        Fri, 31 May 2019 18:25:00 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 31 May 2019 18:24:51 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/2] RDMA/hns: Bugfix for filling the sge of srq
Date:   Fri, 31 May 2019 18:28:03 +0800
Message-ID: <1559298484-63548-2-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559298484-63548-1-git-send-email-oulijun@huawei.com>
References: <1559298484-63548-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When user post recv a srq with multiple sges, the hardware will
get the last correct sge and count the sge numbers according to
the specific identifier with lkey. For example, when the driver
fill the sges with every wr less than the max sge that the user
configured when creating srq, the hardware will stop getting the
sge according to the specific lkey in the sge. However, it will
always end with the first sge in the current post srq recv
interface implementation.

Fixes: c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 135c703..ca319fc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6079,9 +6079,9 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		}
 
 		if (i < srq->max_gs) {
-			dseg->len = 0;
-			dseg->lkey = cpu_to_le32(0x100);
-			dseg->addr = 0;
+			dseg[i].len = 0;
+			dseg[i].lkey = cpu_to_le32(0x100);
+			dseg[i].addr = 0;
 		}
 
 		srq->wrid[wqe_idx] = wr->wr_id;
-- 
1.9.1

