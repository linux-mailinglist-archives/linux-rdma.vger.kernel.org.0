Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80F96559CA
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Dec 2022 11:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiLXKXN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Dec 2022 05:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiLXKXJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Dec 2022 05:23:09 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC2BE27;
        Sat, 24 Dec 2022 02:23:07 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NfKln3wl7zJpP6;
        Sat, 24 Dec 2022 18:19:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 24 Dec 2022 18:23:05 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 2/3] RDMA/hns: Add compatibility handling for only support userspace rq inline
Date:   Sat, 24 Dec 2022 18:22:00 +0800
Message-ID: <20221224102201.3114536-3-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221224102201.3114536-1-xuhaoyue1@hisilicon.com>
References: <20221224102201.3114536-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Luoyouming <luoyouming@huawei.com>

The rq inline makes some changes as follows, Firstly, it is only
used in user space. Secondly, it should notify hardware in QP RTR
status. Thirdly, Add compatibility processing between different
user space and kernel space.

Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 30 ++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_main.c   |  6 +++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 +-
 include/uapi/rdma/hns-abi.h                 |  2 ++
 5 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index b73307d0e210..e9957fc51ffc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -871,7 +871,7 @@ struct hns_roce_hw {
 			 u32 step_idx);
 	int (*modify_qp)(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			 int attr_mask, enum ib_qp_state cur_state,
-			 enum ib_qp_state new_state);
+			 enum ib_qp_state new_state, struct ib_udata *udata);
 	int (*qp_flow_control_init)(struct hns_roce_dev *hr_dev,
 			 struct hns_roce_qp *hr_qp);
 	void (*dereg_mr)(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c0c57b9ba452..c0b487bcd349 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2837,7 +2837,7 @@ static int free_mr_modify_rsv_qp(struct hns_roce_dev *hr_dev,
 	attr->port_num = 1;
 	attr->qp_access_flags = IB_ACCESS_REMOTE_WRITE;
 	ret = hr_dev->hw->modify_qp(&hr_qp->ibqp, attr, mask, IB_QPS_INIT,
-				    IB_QPS_INIT);
+				    IB_QPS_INIT, NULL);
 	if (ret) {
 		ibdev_err(ibdev, "failed to modify qp to init, ret = %d.\n",
 			  ret);
@@ -2859,7 +2859,7 @@ static int free_mr_modify_rsv_qp(struct hns_roce_dev *hr_dev,
 	rdma_ah_set_sl(&attr->ah_attr, (u8)sl_num);
 
 	ret = hr_dev->hw->modify_qp(&hr_qp->ibqp, attr, mask, IB_QPS_INIT,
-				    IB_QPS_RTR);
+				    IB_QPS_RTR, NULL);
 	hr_dev->loop_idc = loopback;
 	if (ret) {
 		ibdev_err(ibdev, "failed to modify qp to rtr, ret = %d.\n",
@@ -2874,7 +2874,7 @@ static int free_mr_modify_rsv_qp(struct hns_roce_dev *hr_dev,
 	attr->retry_cnt = HNS_ROCE_FREE_MR_USED_QP_RETRY_CNT;
 	attr->timeout = HNS_ROCE_FREE_MR_USED_QP_TIMEOUT;
 	ret = hr_dev->hw->modify_qp(&hr_qp->ibqp, attr, mask, IB_QPS_RTR,
-				    IB_QPS_RTS);
+				    IB_QPS_RTS, NULL);
 	if (ret)
 		ibdev_err(ibdev, "failed to modify qp to rts, ret = %d.\n",
 			  ret);
@@ -4572,8 +4572,11 @@ static inline enum ib_mtu get_mtu(struct ib_qp *ibqp,
 static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 				 const struct ib_qp_attr *attr, int attr_mask,
 				 struct hns_roce_v2_qp_context *context,
-				 struct hns_roce_v2_qp_context *qpc_mask)
+				 struct hns_roce_v2_qp_context *qpc_mask,
+				 struct ib_udata *udata)
 {
+	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(udata,
+					  struct hns_roce_ucontext, ibucontext);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
@@ -4693,6 +4696,14 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	hr_reg_write(context, QPC_LP_SGEN_INI, 3);
 	hr_reg_clear(qpc_mask, QPC_LP_SGEN_INI);
 
+	if (udata && ibqp->qp_type == IB_QPT_RC &&
+	    (uctx->config & HNS_ROCE_RQ_INLINE_FLAGS)) {
+		hr_reg_write_bool(context, QPC_RQIE,
+				  hr_dev->caps.flags &
+				  HNS_ROCE_CAP_FLAG_RQ_INLINE);
+		hr_reg_clear(qpc_mask, QPC_RQIE);
+	}
+
 	return 0;
 }
 
@@ -5040,7 +5051,8 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 				      enum ib_qp_state cur_state,
 				      enum ib_qp_state new_state,
 				      struct hns_roce_v2_qp_context *context,
-				      struct hns_roce_v2_qp_context *qpc_mask)
+				      struct hns_roce_v2_qp_context *qpc_mask,
+				      struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	int ret = 0;
@@ -5057,7 +5069,7 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 		modify_qp_init_to_init(ibqp, attr, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		ret = modify_qp_init_to_rtr(ibqp, attr, attr_mask, context,
-					    qpc_mask);
+					    qpc_mask, udata);
 	} else if (cur_state == IB_QPS_RTR && new_state == IB_QPS_RTS) {
 		ret = modify_qp_rtr_to_rts(ibqp, attr, attr_mask, context,
 					   qpc_mask);
@@ -5262,7 +5274,7 @@ static void v2_set_flushed_fields(struct ib_qp *ibqp,
 static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 				 const struct ib_qp_attr *attr,
 				 int attr_mask, enum ib_qp_state cur_state,
-				 enum ib_qp_state new_state)
+				 enum ib_qp_state new_state, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
@@ -5285,7 +5297,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	memset(qpc_mask, 0xff, hr_dev->caps.qpc_sz);
 
 	ret = hns_roce_v2_set_abs_fields(ibqp, attr, attr_mask, cur_state,
-					 new_state, context, qpc_mask);
+					 new_state, context, qpc_mask, udata);
 	if (ret)
 		goto out;
 
@@ -5488,7 +5500,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	if (modify_qp_is_ok(hr_qp)) {
 		/* Modify qp to reset before destroying qp */
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
-					    hr_qp->state, IB_QPS_RESET);
+					    hr_qp->state, IB_QPS_RESET, udata);
 		if (ret)
 			ibdev_err(ibdev,
 				  "failed to modify QP to RST, ret = %d.\n",
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 8ba68ac12388..e414d05cc564 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -379,6 +379,12 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 		resp.max_inline_data = hr_dev->caps.max_sq_inline;
 	}
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) {
+		context->config |= ucmd.config & HNS_ROCE_RQ_INLINE_FLAGS;
+		if (context->config & HNS_ROCE_RQ_INLINE_FLAGS)
+			resp.config |= HNS_ROCE_RSP_RQ_INLINE_FLAGS;
+	}
+
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
 		goto error_fail_uar_alloc;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 53121422a915..d855a917f4cf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1346,7 +1346,7 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		goto out;
 
 	ret = hr_dev->hw->modify_qp(ibqp, attr, attr_mask, cur_state,
-				    new_state);
+				    new_state, udata);
 
 out:
 	mutex_unlock(&hr_qp->mutex);
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 745790ce3c26..6c0940837d93 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -87,10 +87,12 @@ struct hns_roce_ib_create_qp_resp {
 
 enum {
 	HNS_ROCE_EXSGE_FLAGS = 1 << 0,
+	HNS_ROCE_RQ_INLINE_FLAGS = 1 << 1,
 };
 
 enum {
 	HNS_ROCE_RSP_EXSGE_FLAGS = 1 << 0,
+	HNS_ROCE_RSP_RQ_INLINE_FLAGS = 1 << 1,
 };
 
 struct hns_roce_ib_alloc_ucontext_resp {
-- 
2.30.0

