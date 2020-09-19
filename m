Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EE0270CC2
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 12:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgISKEo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 06:04:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13725 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgISKEo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 06:04:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B3606931FF623F377A0D;
        Sat, 19 Sep 2020 18:04:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 18:04:33 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 2/8] RDMA/hns: Add interception for resizing SRQs
Date:   Sat, 19 Sep 2020 18:03:16 +0800
Message-ID: <1600509802-44382-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
References: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

HIP08 doesn't support modifying the maximum number of outstanding WR in an
SRQ. However, the driver does not return a failure message, and users may
mistakenly think that the resizing is executed successfully. So the driver
needs to intercept this operation.

Fixes: ffb1308b88b6 ("RDMA/hns: Move SRQ code to the reasonable place")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6a217f9..715e0b9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5036,6 +5036,10 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 	struct hns_roce_cmd_mailbox *mailbox;
 	int ret;
 
+	/* Resizing SRQs is not supported yet */
+	if (srq_attr_mask & IB_SRQ_MAX_WR)
+		return -EINVAL;
+
 	if (srq_attr_mask & IB_SRQ_LIMIT) {
 		if (srq_attr->srq_limit >= srq->wqe_cnt)
 			return -EINVAL;
-- 
2.8.1

