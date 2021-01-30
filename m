Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A44309345
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhA3JYI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:24:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12364 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhA3JXA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:23:00 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSSnF4Pm7z7c8w;
        Sat, 30 Jan 2021 16:59:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:25 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 12/12] RDMA/hns: Add verification of QP type when post_recv
Date:   Sat, 30 Jan 2021 16:58:10 +0800
Message-ID: <1611997090-48820-13-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
References: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The post_recv only supports QP types of RC, GSI and UD.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d5a63e4..3adb77d7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -721,9 +721,21 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 static int check_recv_valid(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp)
 {
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct ib_qp *ibqp = &hr_qp->ibqp;
+
+	if (unlikely(ibqp->qp_type != IB_QPT_RC &&
+		     ibqp->qp_type != IB_QPT_GSI &&
+		     ibqp->qp_type != IB_QPT_UD)) {
+		ibdev_err(ibdev, "unsupported qp type, qp_type = %d.\n",
+			  ibqp->qp_type);
+		return -EOPNOTSUPP;
+	}
+
 	if (unlikely(hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN))
 		return -EIO;
-	else if (hr_qp->state == IB_QPS_RESET)
+
+	if (hr_qp->state == IB_QPS_RESET)
 		return -EINVAL;
 
 	return 0;
-- 
2.8.1

