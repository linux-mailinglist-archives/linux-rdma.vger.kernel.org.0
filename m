Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33558104800
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 02:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKUBXC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 20:23:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbfKUBXB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 20:23:01 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2250979BAD328B91C0E2;
        Thu, 21 Nov 2019 09:22:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 21 Nov 2019 09:22:53 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH rdma-core 6/7] libhns: Avoid null pointer operation
Date:   Thu, 21 Nov 2019 09:19:28 +0800
Message-ID: <1574299169-31457-7-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
References: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

When recv cq or send cq doesn't exist, clean cq will lead to a null pointer
error in hns_roce_u_v2_destroy_qp().

Fixes: 6fe30a1a705f ("libhns: Introduce QP operations referred to hip08 RoCE device")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u_hw_v2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 7f5a2ce..64dea8e 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -1181,10 +1181,11 @@ static int hns_roce_u_v2_destroy_qp(struct ibv_qp *ibqp)
 
 	hns_roce_lock_cqs(ibqp);
 
-	__hns_roce_v2_cq_clean(to_hr_cq(ibqp->recv_cq), ibqp->qp_num,
-			       ibqp->srq ? to_hr_srq(ibqp->srq) : NULL);
+	if (ibqp->recv_cq)
+		__hns_roce_v2_cq_clean(to_hr_cq(ibqp->recv_cq), ibqp->qp_num,
+				       ibqp->srq ? to_hr_srq(ibqp->srq) : NULL);
 
-	if (ibqp->send_cq != ibqp->recv_cq)
+	if (ibqp->send_cq && ibqp->send_cq != ibqp->recv_cq)
 		__hns_roce_v2_cq_clean(to_hr_cq(ibqp->send_cq), ibqp->qp_num,
 				       NULL);
 
-- 
2.8.1

