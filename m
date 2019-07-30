Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20F47A391
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfG3JBA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 05:01:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730702AbfG3JA7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 05:00:59 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A24418AD0A9052649456;
        Tue, 30 Jul 2019 17:00:53 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 30 Jul 2019 17:00:45 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 02/13] RDMA/hns: Optimize hns_roce_modify_qp function
Date:   Tue, 30 Jul 2019 16:56:39 +0800
Message-ID: <1564477010-29804-3-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here mainly packages some code into some new functions in order to
reduce code compelexity.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 118 +++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 35ef7e2..8b2d10f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1070,6 +1070,76 @@ int to_hr_qp_type(int qp_type)
 	return transport_type;
 }
 
+static int check_mtu_validate(struct hns_roce_dev *hr_dev,
+                             struct hns_roce_qp *hr_qp,
+                             struct ib_qp_attr *attr, int attr_mask)
+{
+       struct device *dev = hr_dev->dev;
+       enum ib_mtu active_mtu;
+       int p;
+
+       p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
+           active_mtu = iboe_get_mtu(hr_dev->iboe.netdevs[p]->mtu);
+
+       if ((hr_dev->caps.max_mtu >= IB_MTU_2048 &&
+            attr->path_mtu > hr_dev->caps.max_mtu) ||
+            attr->path_mtu < IB_MTU_256 || attr->path_mtu > active_mtu) {
+               dev_err(dev, "attr path_mtu(%d)invalid while modify qp",
+                       attr->path_mtu);
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
+static int hns_roce_check_qp_attr(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+                                 int attr_mask)
+{
+       struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+       struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+       struct device *dev = hr_dev->dev;
+       int ret = 0;
+       int p;
+
+       if ((attr_mask & IB_QP_PORT) &&
+           (attr->port_num == 0 || attr->port_num > hr_dev->caps.num_ports)) {
+               dev_err(dev, "attr port_num invalid.attr->port_num=%d\n",
+                       attr->port_num);
+               return -EINVAL;
+       }
+
+       if (attr_mask & IB_QP_PKEY_INDEX) {
+               p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
+               if (attr->pkey_index >= hr_dev->caps.pkey_table_len[p]) {
+                       dev_err(dev, "attr pkey_index invalid.attr->pkey_index=%d\n",
+                               attr->pkey_index);
+                       return -EINVAL;
+               }
+       }
+
+       if (attr_mask & IB_QP_PATH_MTU) {
+               ret = check_mtu_validate(hr_dev, hr_qp, attr, attr_mask);
+               if (ret)
+                       return ret;
+       }
+
+       if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
+           attr->max_rd_atomic > hr_dev->caps.max_qp_init_rdma) {
+               dev_err(dev, "attr max_rd_atomic invalid.attr->max_rd_atomic=%d\n",
+                       attr->max_rd_atomic);
+               return -EINVAL;
+       }
+
+       if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
+           attr->max_dest_rd_atomic > hr_dev->caps.max_qp_dest_rdma) {
+               dev_err(dev, "attr max_dest_rd_atomic invalid.attr->max_dest_rd_atomic=%d\n",
+                       attr->max_dest_rd_atomic);
+               return -EINVAL;
+       }
+
+       return ret;
+}
+
 int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		       int attr_mask, struct ib_udata *udata)
 {
@@ -1078,8 +1148,6 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	enum ib_qp_state cur_state, new_state;
 	struct device *dev = hr_dev->dev;
 	int ret = -EINVAL;
-	int p;
-	enum ib_mtu active_mtu;
 
 	mutex_lock(&hr_qp->mutex);
 
@@ -1107,51 +1175,9 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		goto out;
 	}
 
-	if ((attr_mask & IB_QP_PORT) &&
-	    (attr->port_num == 0 || attr->port_num > hr_dev->caps.num_ports)) {
-		dev_err(dev, "attr port_num invalid.attr->port_num=%d\n",
-			attr->port_num);
-		goto out;
-	}
-
-	if (attr_mask & IB_QP_PKEY_INDEX) {
-		p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
-		if (attr->pkey_index >= hr_dev->caps.pkey_table_len[p]) {
-			dev_err(dev, "attr pkey_index invalid.attr->pkey_index=%d\n",
-				attr->pkey_index);
-			goto out;
-		}
-	}
-
-	if (attr_mask & IB_QP_PATH_MTU) {
-		p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
-		active_mtu = iboe_get_mtu(hr_dev->iboe.netdevs[p]->mtu);
-
-		if ((hr_dev->caps.max_mtu == IB_MTU_4096 &&
-		    attr->path_mtu > IB_MTU_4096) ||
-		    (hr_dev->caps.max_mtu == IB_MTU_2048 &&
-		    attr->path_mtu > IB_MTU_2048) ||
-		    attr->path_mtu < IB_MTU_256 ||
-		    attr->path_mtu > active_mtu) {
-			dev_err(dev, "attr path_mtu(%d)invalid while modify qp",
-				attr->path_mtu);
-			goto out;
-		}
-	}
-
-	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
-	    attr->max_rd_atomic > hr_dev->caps.max_qp_init_rdma) {
-		dev_err(dev, "attr max_rd_atomic invalid.attr->max_rd_atomic=%d\n",
-			attr->max_rd_atomic);
-		goto out;
-	}
-
-	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
-	    attr->max_dest_rd_atomic > hr_dev->caps.max_qp_dest_rdma) {
-		dev_err(dev, "attr max_dest_rd_atomic invalid.attr->max_dest_rd_atomic=%d\n",
-			attr->max_dest_rd_atomic);
+	ret = hns_roce_check_qp_attr(ibqp, attr, attr_mask);
+	if (ret)
 		goto out;
-	}
 
 	if (cur_state == new_state && cur_state == IB_QPS_RESET) {
 		if (hr_dev->caps.min_wqes) {
-- 
1.9.1

