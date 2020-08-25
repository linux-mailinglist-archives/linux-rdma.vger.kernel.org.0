Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840AF25171D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 13:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgHYLJR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 07:09:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729956AbgHYLJQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 07:09:16 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5A84A760B7AB97BFBDEE;
        Tue, 25 Aug 2020 19:09:02 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 25 Aug 2020 19:08:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next] RDMA/hns: Add a check for current state before modifying QP
Date:   Tue, 25 Aug 2020 19:07:54 +0800
Message-ID: <1598353674-24270-1-git-send-email-liweihang@huawei.com>
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

It should be considered as an illegal operation if the ULP attempts to
modify a QP from another state to the current hardware state. Otherwise,
the ULP can modify some fields of QPC at any time. For example, for a QP in
state of RTS, modify it from RTR to RTS can change the PSN, which is always
not as expected.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Changes since v1:
- Add a fixes line as Jason suggested.

 drivers/infiniband/hw/hns/hns_roce_qp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index e94ca13..bb87e5fc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1162,8 +1162,10 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	mutex_lock(&hr_qp->mutex);
 
-	cur_state = attr_mask & IB_QP_CUR_STATE ?
-		    attr->cur_qp_state : (enum ib_qp_state)hr_qp->state;
+	if (attr_mask & IB_QP_CUR_STATE && attr->cur_qp_state != hr_qp->state)
+		goto out;
+
+	cur_state = hr_qp->state;
 	new_state = attr_mask & IB_QP_STATE ? attr->qp_state : cur_state;
 
 	if (ibqp->uobject &&
-- 
2.8.1

