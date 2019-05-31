Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532CD30C7F
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2019 12:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfEaKZD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 May 2019 06:25:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51472 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfEaKZD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 May 2019 06:25:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A8A6EFC293BAF4E22476;
        Fri, 31 May 2019 18:25:00 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Fri, 31 May 2019 18:24:51 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Consider the bitmap full situation
Date:   Fri, 31 May 2019 18:28:04 +0800
Message-ID: <1559298484-63548-3-git-send-email-oulijun@huawei.com>
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

We use a fifo queue to store srq wqe index and use bimap to just
use the corresponding srq index. When bitmap is full, the
srq wqe is more than the max number of srqwqe and it should
return error and notify the user.

It will fix the patch("RDMA/hns: Bugfix for posting multiple srq work request")

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ca319fc..e7024b3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6014,7 +6014,7 @@ static int find_empty_entry(struct hns_roce_idx_que *idx_que,
 	int wqe_idx;
 
 	if (unlikely(bitmap_full(idx_que->bitmap, size)))
-		bitmap_zero(idx_que->bitmap, size);
+		return -ENOSPC;
 
 	wqe_idx = find_first_zero_bit(idx_que->bitmap, size);
 
@@ -6067,6 +6067,11 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		}
 
 		wqe_idx = find_empty_entry(&srq->idx_que, srq->max);
+		if (wqe_idx < 0) {
+			ret = -ENOMEM;
+			*bad_wr = wr;
+			break;
+		}
 
 		fill_idx_queue(&srq->idx_que, ind, wqe_idx);
 		wqe = get_srq_wqe(srq, wqe_idx);
-- 
1.9.1

