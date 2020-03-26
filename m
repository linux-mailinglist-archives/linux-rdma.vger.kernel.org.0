Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB83519371E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 04:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCZDoQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Mar 2020 23:44:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34436 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727612AbgCZDoQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Mar 2020 23:44:16 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9B247BB87929A98B9A4D;
        Thu, 26 Mar 2020 11:44:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Mar 2020 11:44:03 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Reduce PFC frames in congestion scenarios
Date:   Thu, 26 Mar 2020 11:40:16 +0800
Message-ID: <1585194018-4381-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1585194018-4381-1-git-send-email-liweihang@huawei.com>
References: <1585194018-4381-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jihua Tao <taojihua4@huawei.com>

The original value means sending 16 packets at a time, and it should be
configured to 0 which means sending 1 packet instead. It is modified to
reduce the number of PFC frames to make sure the performance meets
expectations when flow control is enabled on hip08.

Signed-off-by: Jihua Tao <taojihua4@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 9bd8fbf..943f88c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4188,7 +4188,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 
 	/* mtu*(2^LP_PKTN_INI) should not bigger than 1 message length 64kb */
 	roce_set_field(context->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
-		       V2_QPC_BYTE_56_LP_PKTN_INI_S, 4);
+		       V2_QPC_BYTE_56_LP_PKTN_INI_S, 0);
 	roce_set_field(qpc_mask->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
 		       V2_QPC_BYTE_56_LP_PKTN_INI_S, 0);
 
-- 
2.8.1

