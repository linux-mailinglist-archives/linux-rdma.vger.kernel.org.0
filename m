Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42AEB18B6C4
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 14:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgCSN3F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 09:29:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729719AbgCSN3E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 09:29:04 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC39118F67D14A699FEC;
        Thu, 19 Mar 2020 21:28:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Mar 2020 21:28:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 04/11] RDMA/hns: Simplify attribute judgment code
Date:   Thu, 19 Mar 2020 21:24:51 +0800
Message-ID: <1584624298-23841-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584624298-23841-1-git-send-email-liweihang@huawei.com>
References: <1584624298-23841-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Combine attribute flags before masking them.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 94cb2984..518a649 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4281,8 +4281,7 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	}
 
 	/* Not support alternate path and path migration */
-	if ((attr_mask & IB_QP_ALT_PATH) ||
-	    (attr_mask & IB_QP_PATH_MIG_STATE)) {
+	if (attr_mask & (IB_QP_ALT_PATH | IB_QP_PATH_MIG_STATE)) {
 		ibdev_err(ibdev, "RTR2RTS attr_mask (0x%x)error\n", attr_mask);
 		return -EINVAL;
 	}
-- 
2.8.1

