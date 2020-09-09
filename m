Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4647F262B1F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 10:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgIII6v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 04:58:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728617AbgIII6u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 04:58:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8A4F8672690132ECE28F;
        Wed,  9 Sep 2020 16:58:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 16:58:41 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 3/9] RDMA/hns: Add interception for resizing SRQs
Date:   Wed, 9 Sep 2020 16:57:28 +0800
Message-ID: <1599641854-23160-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

HIP08 doesn't support modifying the maximum number of outstanding WR in an
SRQ. However, the driver does not return a failure message, and users may
mistakenly think that the resizing is executed successfully. So the driver
needs to intercept this operation.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7f6c707..2643972 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5047,6 +5047,10 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
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

