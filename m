Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE71756FB
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 10:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCBJ0Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 04:26:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbgCBJ0P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Mar 2020 04:26:15 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4DBD3858E8D5798F4FF9;
        Mon,  2 Mar 2020 17:25:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Mon, 2 Mar 2020 17:25:50 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Support to set mininum depth of qp to 0
Date:   Mon, 2 Mar 2020 17:22:17 +0800
Message-ID: <1583140937-2223-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Minimum depth of qp should be allowed to be set to 0 according to the
firmware configuration. And when qp is changed from reset to reset, the
capability of minimum qp depth was used to identify hardware of hip06,
it should be changed into a more readable form.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 2a75355..10c4354 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -382,10 +382,10 @@ static int set_rq_size(struct hns_roce_dev *hr_dev,
 			return -EINVAL;
 		}
 
-		if (hr_dev->caps.min_wqes)
+		if (cap->max_recv_wr)
 			max_cnt = max(cap->max_recv_wr, hr_dev->caps.min_wqes);
 		else
-			max_cnt = cap->max_recv_wr;
+			max_cnt = 0;
 
 		hr_qp->rq.wqe_cnt = roundup_pow_of_two(max_cnt);
 
@@ -652,10 +652,10 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 
 	hr_qp->sq.wqe_shift = ilog2(hr_dev->caps.max_sq_desc_sz);
 
-	if (hr_dev->caps.min_wqes)
+	if (cap->max_send_wr)
 		max_cnt = max(cap->max_send_wr, hr_dev->caps.min_wqes);
 	else
-		max_cnt = cap->max_send_wr;
+		max_cnt = 0;
 
 	hr_qp->sq.wqe_cnt = roundup_pow_of_two(max_cnt);
 	if ((u32)hr_qp->sq.wqe_cnt > hr_dev->caps.max_wqes) {
@@ -1394,11 +1394,10 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		goto out;
 
 	if (cur_state == new_state && cur_state == IB_QPS_RESET) {
-		if (hr_dev->caps.min_wqes) {
+		if (hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
 			ret = -EPERM;
 			ibdev_err(&hr_dev->ib_dev,
-				"cur_state=%d new_state=%d\n", cur_state,
-				new_state);
+				  "Unsupport to modify qp from reset to reset\n");
 		} else {
 			ret = 0;
 		}
-- 
2.8.1

