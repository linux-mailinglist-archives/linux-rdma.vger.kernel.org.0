Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715DB104801
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 02:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKUBXC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 20:23:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727113AbfKUBXB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 20:23:01 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4F8C9D96115A2BE551D7;
        Thu, 21 Nov 2019 09:22:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 21 Nov 2019 09:22:52 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH rdma-core 3/7] libhns: Bugfix for assigning sl
Date:   Thu, 21 Nov 2019 09:19:25 +0800
Message-ID: <1574299169-31457-4-git-send-email-liweihang@hisilicon.com>
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

Only the field that corresponding mask is set can be modified, or its
original value may be covered.

Fixes: c24583975044 ("libhns: Add verbs of qp support")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u_hw_v2.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 931f59d..b473f07 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -1103,8 +1103,10 @@ static int hns_roce_u_v2_modify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 		pthread_spin_unlock(&hr_qp->sq.lock);
 	}
 
-	if (!ret && (attr_mask & IBV_QP_STATE) &&
-	    attr->qp_state == IBV_QPS_RESET) {
+	if (ret)
+		return ret;
+
+	if ((attr_mask & IBV_QP_STATE) && attr->qp_state == IBV_QPS_RESET) {
 		hns_roce_v2_cq_clean(to_hr_cq(qp->recv_cq), qp->qp_num,
 				     qp->srq ? to_hr_srq(qp->srq) : NULL);
 		if (qp->send_cq != qp->recv_cq)
@@ -1114,10 +1116,11 @@ static int hns_roce_u_v2_modify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 		hns_roce_init_qp_indices(to_hr_qp(qp));
 	}
 
-	if (!ret && (attr_mask & IBV_QP_PORT))
+	if (attr_mask & IBV_QP_PORT)
 		hr_qp->port_num = attr->port_num;
 
-	hr_qp->sl = attr->ah_attr.sl;
+	if (attr_mask & IBV_QP_AV)
+		hr_qp->sl = attr->ah_attr.sl;
 
 	return ret;
 }
-- 
2.8.1

