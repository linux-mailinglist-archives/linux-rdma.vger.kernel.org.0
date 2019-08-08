Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC5864ED
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfHHO6T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 10:58:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733153AbfHHO6T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 10:58:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6BC31CDFCD9BCC2D1291;
        Thu,  8 Aug 2019 22:58:17 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 8 Aug 2019 22:58:08 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V4 for-next 14/14] RDMA/hns: Use the new APIs for printing log
Date:   Thu, 8 Aug 2019 22:53:54 +0800
Message-ID: <1565276034-97329-15-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
References: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here uses the new APIs instead of some dev print interfaces in
some functions.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  8 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 45 +++++++++++++++++-------------
 2 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 567be0a..87a1574 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4560,7 +4560,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 					 struct ib_udata *udata)
 {
 	struct hns_roce_cq *send_cq, *recv_cq;
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_RC && hr_qp->state != IB_QPS_RESET) {
@@ -4568,7 +4568,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET);
 		if (ret) {
-			dev_err(dev, "modify QP to Reset failed.\n");
+			ibdev_err(ibdev, "modify QP to Reset failed.\n");
 			return ret;
 		}
 	}
@@ -4637,8 +4637,8 @@ static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
 	if (ret) {
-		dev_err(&hr_dev->dev, "Destroy qp 0x%06lx failed(%d)\n",
-			hr_qp->qpn, ret);
+		ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx failed(%d)\n",
+			  hr_qp->qpn, ret);
 		return ret;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index f803209..b729f8e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -335,13 +335,13 @@ static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
 	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
 	     ucmd->log_sq_stride > max_sq_stride ||
 	     ucmd->log_sq_stride < HNS_ROCE_IB_MIN_SQ_STRIDE) {
-		dev_err(hr_dev->dev, "check SQ size error!\n");
+		ibdev_err(&hr_dev->ib_dev, "check SQ size error!\n");
 		return -EINVAL;
 	}
 
 	if (cap->max_send_sge > hr_dev->caps.max_sq_sg) {
-		dev_err(hr_dev->dev, "SQ sge error! max_send_sge=%d\n",
-			cap->max_send_sge);
+		ibdev_err(&hr_dev->ib_dev, "SQ sge error! max_send_sge=%d\n",
+			  cap->max_send_sge);
 		return -EINVAL;
 	}
 
@@ -988,7 +988,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 				 struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_sqp *hr_sqp;
 	struct hns_roce_qp *hr_qp;
 	int ret;
@@ -1002,8 +1002,8 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata, 0,
 						hr_qp);
 		if (ret) {
-			dev_err(dev, "Create RC QP 0x%06lx failed(%d)\n",
-				hr_qp->qpn, ret);
+			ibdev_err(ibdev, "Create RC QP 0x%06lx failed(%d)\n",
+				  hr_qp->qpn, ret);
 			kfree(hr_qp);
 			return ERR_PTR(ret);
 		}
@@ -1015,7 +1015,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 	case IB_QPT_GSI: {
 		/* Userspace is not allowed to create special QPs: */
 		if (udata) {
-			dev_err(dev, "not support usr space GSI\n");
+			ibdev_err(ibdev, "not support usr space GSI\n");
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -1037,7 +1037,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata,
 						hr_qp->ibqp.qp_num, hr_qp);
 		if (ret) {
-			dev_err(dev, "Create GSI QP failed!\n");
+			ibdev_err(ibdev, "Create GSI QP failed!\n");
 			kfree(hr_sqp);
 			return ERR_PTR(ret);
 		}
@@ -1045,7 +1045,8 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		break;
 	}
 	default:{
-		dev_err(dev, "not support QP type %d\n", init_attr->qp_type);
+		ibdev_err(ibdev, "not support QP type %d\n",
+			  init_attr->qp_type);
 		return ERR_PTR(-EINVAL);
 	}
 	}
@@ -1075,7 +1076,6 @@ static int check_mtu_validate(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_qp *hr_qp,
 			      struct ib_qp_attr *attr, int attr_mask)
 {
-	struct device *dev = hr_dev->dev;
 	enum ib_mtu active_mtu;
 	int p;
 
@@ -1085,7 +1085,8 @@ static int check_mtu_validate(struct hns_roce_dev *hr_dev,
 	if ((hr_dev->caps.max_mtu >= IB_MTU_2048 &&
 	    attr->path_mtu > hr_dev->caps.max_mtu) ||
 	    attr->path_mtu < IB_MTU_256 || attr->path_mtu > active_mtu) {
-		dev_err(dev, "attr path_mtu(%d)invalid while modify qp",
+		ibdev_err(&hr_dev->ib_dev,
+			"attr path_mtu(%d)invalid while modify qp",
 			attr->path_mtu);
 		return -EINVAL;
 	}
@@ -1098,12 +1099,12 @@ static int hns_roce_check_qp_attr(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	struct device *dev = hr_dev->dev;
 	int p;
 
 	if ((attr_mask & IB_QP_PORT) &&
 	    (attr->port_num == 0 || attr->port_num > hr_dev->caps.num_ports)) {
-		dev_err(dev, "attr port_num invalid.attr->port_num=%d\n",
+		ibdev_err(&hr_dev->ib_dev,
+			"attr port_num invalid.attr->port_num=%d\n",
 			attr->port_num);
 		return -EINVAL;
 	}
@@ -1111,7 +1112,8 @@ static int hns_roce_check_qp_attr(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (attr_mask & IB_QP_PKEY_INDEX) {
 		p = attr_mask & IB_QP_PORT ? (attr->port_num - 1) : hr_qp->port;
 		if (attr->pkey_index >= hr_dev->caps.pkey_table_len[p]) {
-			dev_err(dev, "attr pkey_index invalid.attr->pkey_index=%d\n",
+			ibdev_err(&hr_dev->ib_dev,
+				"attr pkey_index invalid.attr->pkey_index=%d\n",
 				attr->pkey_index);
 			return -EINVAL;
 		}
@@ -1119,14 +1121,16 @@ static int hns_roce_check_qp_attr(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC &&
 	    attr->max_rd_atomic > hr_dev->caps.max_qp_init_rdma) {
-		dev_err(dev, "attr max_rd_atomic invalid.attr->max_rd_atomic=%d\n",
+		ibdev_err(&hr_dev->ib_dev,
+			"attr max_rd_atomic invalid.attr->max_rd_atomic=%d\n",
 			attr->max_rd_atomic);
 		return -EINVAL;
 	}
 
 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC &&
 	    attr->max_dest_rd_atomic > hr_dev->caps.max_qp_dest_rdma) {
-		dev_err(dev, "attr max_dest_rd_atomic invalid.attr->max_dest_rd_atomic=%d\n",
+		ibdev_err(&hr_dev->ib_dev,
+			"attr max_dest_rd_atomic invalid.attr->max_dest_rd_atomic=%d\n",
 			attr->max_dest_rd_atomic);
 		return -EINVAL;
 	}
@@ -1143,7 +1147,6 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	enum ib_qp_state cur_state, new_state;
-	struct device *dev = hr_dev->dev;
 	int ret = -EINVAL;
 
 	mutex_lock(&hr_qp->mutex);
@@ -1160,14 +1163,15 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			if (hr_qp->rdb_en == 1)
 				hr_qp->rq.head = *(int *)(hr_qp->rdb.virt_addr);
 		} else {
-			dev_warn(dev, "flush cqe is not supported in userspace!\n");
+			ibdev_warn(&hr_dev->ib_dev,
+				  "flush cqe is not supported in userspace!\n");
 			goto out;
 		}
 	}
 
 	if (!ib_modify_qp_is_ok(cur_state, new_state, ibqp->qp_type,
 				attr_mask)) {
-		dev_err(dev, "ib_modify_qp_is_ok failed\n");
+		ibdev_err(&hr_dev->ib_dev, "ib_modify_qp_is_ok failed\n");
 		goto out;
 	}
 
@@ -1178,7 +1182,8 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
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

