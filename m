Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406D760DE6B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Oct 2022 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiJZJv5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 05:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiJZJvy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 05:51:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23549B7F48
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 02:51:52 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4My3qj4210z15M3Q;
        Wed, 26 Oct 2022 17:46:57 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 17:51:50 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 17:51:49 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [PATCH v2 for-rc 3/5] RDMA/hns: Remove enable rq inline in kernel and add compatibility handling
Date:   Wed, 26 Oct 2022 17:50:52 +0800
Message-ID: <20221026095054.2384620-4-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
References: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
user space and kernel space. Change the HNS_ROCE_CAP_FLAG_RQ_INLINE
to a new bit to prevent old kernel spaces / spaced from enabling
rq inline.

Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 +++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 28 +++++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_main.c   |  5 ++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 +-
 include/uapi/rdma/hns-abi.h                 |  2 ++
 5 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index f701cc86896b..9ce053fe737d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -132,7 +132,8 @@ enum hns_roce_event {
 enum {
 	HNS_ROCE_CAP_FLAG_REREG_MR		= BIT(0),
 	HNS_ROCE_CAP_FLAG_ROCE_V1_V2		= BIT(1),
-	HNS_ROCE_CAP_FLAG_RQ_INLINE		= BIT(2),
+	/* discard this bit, reserved for compatibility */
+	HNS_ROCE_CAP_FLAG_DISCARD		= BIT(2),
 	HNS_ROCE_CAP_FLAG_CQ_RECORD_DB		= BIT(3),
 	HNS_ROCE_CAP_FLAG_QP_RECORD_DB		= BIT(4),
 	HNS_ROCE_CAP_FLAG_SRQ			= BIT(5),
@@ -144,6 +145,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_DIRECT_WQE		= BIT(12),
 	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
 	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
+	HNS_ROCE_CAP_FLAG_RQ_INLINE		= BIT(20),
 };
 
 #define HNS_ROCE_DB_TYPE_COUNT			2
@@ -887,7 +889,7 @@ struct hns_roce_hw {
 			 u32 step_idx);
 	int (*modify_qp)(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			 int attr_mask, enum ib_qp_state cur_state,
-			 enum ib_qp_state new_state);
+			 enum ib_qp_state new_state, struct ib_udata *udata);
 	int (*qp_flow_control_init)(struct hns_roce_dev *hr_dev,
 			 struct hns_roce_qp *hr_qp);
 	void (*dereg_mr)(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 65875b4cff13..b936bf6e58cc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4327,10 +4327,6 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	hr_reg_write(context, QPC_RQ_DB_RECORD_ADDR_H,
 		     upper_32_bits(hr_qp->rdb.dma));
 
-	if (ibqp->qp_type != IB_QPT_UD && ibqp->qp_type != IB_QPT_GSI)
-		hr_reg_write_bool(context, QPC_RQIE,
-			     hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE);
-
 	hr_reg_write(context, QPC_RX_CQN, get_cqn(ibqp->recv_cq));
 
 	if (ibqp->srq) {
@@ -4521,8 +4517,11 @@ static inline enum ib_mtu get_mtu(struct ib_qp *ibqp,
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
@@ -4642,6 +4641,14 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	hr_reg_write(context, QPC_LP_SGEN_INI, 3);
 	hr_reg_clear(qpc_mask, QPC_LP_SGEN_INI);
 
+	if (udata && (ibqp->qp_type == IB_QPT_RC) &&
+	    (uctx->config & HNS_ROCE_RQ_INLINE_FLAGS)) {
+		hr_reg_write_bool(context, QPC_RQIE,
+				  hr_dev->caps.flags &
+				  HNS_ROCE_CAP_FLAG_RQ_INLINE);
+		hr_reg_clear(qpc_mask, QPC_RQIE);
+	}
+
 	return 0;
 }
 
@@ -4989,7 +4996,8 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 				      enum ib_qp_state cur_state,
 				      enum ib_qp_state new_state,
 				      struct hns_roce_v2_qp_context *context,
-				      struct hns_roce_v2_qp_context *qpc_mask)
+				      struct hns_roce_v2_qp_context *qpc_mask,
+				      struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	int ret = 0;
@@ -5006,7 +5014,7 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 		modify_qp_init_to_init(ibqp, attr, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		ret = modify_qp_init_to_rtr(ibqp, attr, attr_mask, context,
-					    qpc_mask);
+					    qpc_mask, udata);
 	} else if (cur_state == IB_QPS_RTR && new_state == IB_QPS_RTS) {
 		ret = modify_qp_rtr_to_rts(ibqp, attr, attr_mask, context,
 					   qpc_mask);
@@ -5211,7 +5219,7 @@ static void v2_set_flushed_fields(struct ib_qp *ibqp,
 static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 				 const struct ib_qp_attr *attr,
 				 int attr_mask, enum ib_qp_state cur_state,
-				 enum ib_qp_state new_state)
+				 enum ib_qp_state new_state, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
@@ -5234,7 +5242,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	memset(qpc_mask, 0xff, hr_dev->caps.qpc_sz);
 
 	ret = hns_roce_v2_set_abs_fields(ibqp, attr, attr_mask, cur_state,
-					 new_state, context, qpc_mask);
+					 new_state, context, qpc_mask, udata);
 	if (ret)
 		goto out;
 
@@ -5435,7 +5443,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	if (modify_qp_is_ok(hr_qp)) {
 		/* Modify qp to reset before destroying qp */
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
-					    hr_qp->state, IB_QPS_RESET);
+					    hr_qp->state, IB_QPS_RESET, udata);
 		if (ret)
 			ibdev_err(ibdev,
 				  "failed to modify QP to RST, ret = %d.\n",
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 8ba68ac12388..ea1ef395f60f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -379,6 +379,11 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 		resp.max_inline_data = hr_dev->caps.max_sq_inline;
 	}
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) {
+		context->config |= ucmd.config & HNS_ROCE_RQ_INLINE_FLAGS;
+		resp.config |= HNS_ROCE_RSP_RQ_INLINE_FLAGS;
+	}
+
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
 		goto error_fail_uar_alloc;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7354c9e61502..e65b899ce82f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1411,7 +1411,7 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		goto out;
 
 	ret = hr_dev->hw->modify_qp(ibqp, attr, attr_mask, cur_state,
-				    new_state);
+				    new_state, udata);
 
 out:
 	mutex_unlock(&hr_qp->mutex);
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 017da74f56af..9375ac3de059 100644
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
 
 
-- 
2.30.0

