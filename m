Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E603E7D7B8
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 10:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfHAId3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 04:33:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730596AbfHAId3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 04:33:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 107005685F16BFAE8BB6;
        Thu,  1 Aug 2019 16:33:23 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 16:33:12 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 02/13] RDMA/hns: Optimize hns_roce_modify_qp function
Date:   Thu, 1 Aug 2019 16:29:03 +0800
Message-ID: <1564648154-123172-3-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
References: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
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
V1->V2:
1. Use ibdev prefix print interface
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 131 +++++++++++++++++++-------------
 1 file changed, 80 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 8abd1aa..2eb5b0a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1070,93 +1070,122 @@ int to_hr_qp_type(int qp_type)
 	return transport_type;
 }
 
-int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
-		       int attr_mask, struct ib_udata *udata)
+static int check_mtu_validate(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_qp *hr_qp,
+			      struct ib_qp_attr *attr, int attr_mask)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
-	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	enum ib_qp_state cur_state, new_state;
-	struct device *dev = hr_dev->dev;
-	int ret = -EINVAL;
-	int p;
 	enum ib_mtu active_mtu;
+	int p;
 
-	mutex_lock(&hr_qp->mutex);
-
-	cur_state = attr_mask & IB_QP_CUR_STATE ?
-		    attr->cur_qp_state : (enum ib_qp_state)hr_qp->state;
-	new_state = attr_mask & IB_QP_STATE ?
-		    attr->qp_state : cur_state;
-
-	if (ibqp->uobject &&
-	    (attr_mask & IB_QP_STATE) && new_state == IB_QPS_ERR) {
-		if (hr_qp->sdb_en == 1) {
-			hr_qp->sq.head = *(int *)(hr_qp->sdb.virt_addr);
+	p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
+	    active_mtu = iboe_get_mtu(hr_dev->iboe.netdevs[p]->mtu);
 
-			if (hr_qp->rdb_en == 1)
-				hr_qp->rq.head = *(int *)(hr_qp->rdb.virt_addr);
-		} else {
-			dev_warn(dev, "flush cqe is not supported in userspace!\n");
-			goto out;
-		}
+	if ((hr_dev->caps.max_mtu >= IB_MTU_2048 &&
+	    attr->path_mtu > hr_dev->caps.max_mtu) ||
+	    attr->path_mtu < IB_MTU_256 || attr->path_mtu > active_mtu) {
+		ibdev_err(&hr_dev->ib_dev,
+			"attr path_mtu(%d)invalid while modify qp",
+			attr->path_mtu);
+		return -EINVAL;
 	}
 
-	if (!ib_modify_qp_is_ok(cur_state, new_state, ibqp->qp_type,
-				attr_mask)) {
-		dev_err(dev, "ib_modify_qp_is_ok failed\n");
-		goto out;
-	}
+	return 0;
+}
+
+static int hns_roce_check_qp_attr(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+				  int attr_mask)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	int ret = 0;
+	int p;
 
 	if ((attr_mask & IB_QP_PORT) &&
 	    (attr->port_num == 0 || attr->port_num > hr_dev->caps.num_ports)) {
-		dev_err(dev, "attr port_num invalid.attr->port_num=%d\n",
+		ibdev_err(&hr_dev->ib_dev,
+			"attr port_num invalid.attr->port_num=%d\n",
 			attr->port_num);
-		goto out;
+		return -EINVAL;
 	}
 
 	if (attr_mask & IB_QP_PKEY_INDEX) {
 		p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
 		if (attr->pkey_index >= hr_dev->caps.pkey_table_len[p]) {
-			dev_err(dev, "attr pkey_index invalid.attr->pkey_index=%d\n",
+			ibdev_err(&hr_dev->ib_dev,
+				"attr pkey_index invalid.attr->pkey_index=%d\n",
 				attr->pkey_index);
-			goto out;
+			return -EINVAL;
 		}
 	}
 
 	if (attr_mask & IB_QP_PATH_MTU) {
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
+		ret = check_mtu_validate(hr_dev, hr_qp, attr, attr_mask);
+		if (ret)
+			return ret;
 	}
 
 	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
 	    attr->max_rd_atomic > hr_dev->caps.max_qp_init_rdma) {
-		dev_err(dev, "attr max_rd_atomic invalid.attr->max_rd_atomic=%d\n",
+		ibdev_err(&hr_dev->ib_dev,
+			"attr max_rd_atomic invalid.attr->max_rd_atomic=%d\n",
 			attr->max_rd_atomic);
-		goto out;
+		return -EINVAL;
 	}
 
 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
 	    attr->max_dest_rd_atomic > hr_dev->caps.max_qp_dest_rdma) {
-		dev_err(dev, "attr max_dest_rd_atomic invalid.attr->max_dest_rd_atomic=%d\n",
+		ibdev_err(&hr_dev->ib_dev,
+			"attr max_dest_rd_atomic invalid.attr->max_dest_rd_atomic=%d\n",
 			attr->max_dest_rd_atomic);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+		       int attr_mask, struct ib_udata *udata)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	enum ib_qp_state cur_state, new_state;
+	int ret = -EINVAL;
+
+	mutex_lock(&hr_qp->mutex);
+
+	cur_state = attr_mask & IB_QP_CUR_STATE ?
+		    attr->cur_qp_state : (enum ib_qp_state)hr_qp->state;
+	new_state = attr_mask & IB_QP_STATE ? attr->qp_state : cur_state;
+
+	if (ibqp->uobject &&
+	    (attr_mask & IB_QP_STATE) && new_state == IB_QPS_ERR) {
+		if (hr_qp->sdb_en == 1) {
+			hr_qp->sq.head = *(int *)(hr_qp->sdb.virt_addr);
+
+			if (hr_qp->rdb_en == 1)
+				hr_qp->rq.head = *(int *)(hr_qp->rdb.virt_addr);
+		} else {
+			ibdev_warn(&hr_dev->ib_dev,
+				  "flush cqe is not supported in userspace!\n");
+			goto out;
+		}
+	}
+
+	if (!ib_modify_qp_is_ok(cur_state, new_state, ibqp->qp_type,
+				attr_mask)) {
+		ibdev_err(&hr_dev->ib_dev, "ib_modify_qp_is_ok failed\n");
 		goto out;
 	}
 
+	ret = hns_roce_check_qp_attr(ibqp, attr, attr_mask);
+	if (ret)
+		goto out;
+
 	if (cur_state == new_state && cur_state == IB_QPS_RESET) {
 		if (hr_dev->caps.min_wqes) {
 			ret = -EPERM;
-			dev_err(dev, "cur_state=%d new_state=%d\n", cur_state,
+			ibdev_err(&hr_dev->ib_dev,
+				"cur_state=%d new_state=%d\n", cur_state,
 				new_state);
 		} else {
 			ret = 0;
-- 
1.9.1

