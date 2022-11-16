Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2562B14E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 03:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKPCbP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 21:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKPCbO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 21:31:14 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE71729379
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 18:31:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VUvYizQ_1668565871;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VUvYizQ_1668565871)
          by smtp.aliyun-inc.com;
          Wed, 16 Nov 2022 10:31:11 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 2/3] RDMA/erdma: Implement the lifecycle of reflushing work for each QP
Date:   Wed, 16 Nov 2022 10:31:06 +0800
Message-Id: <20221116023107.82835-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20221116023107.82835-1-chengyou@linux.alibaba.com>
References: <20221116023107.82835-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Each QP has a work for reflushing purpose. In the work, driver will
report the latest pi to hardware.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h    |  8 ++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 18 ++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 1b2e2b70678f..ab371fec610c 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -145,6 +145,7 @@ enum CMDQ_RDMA_OPCODE {
 	CMDQ_OPCODE_MODIFY_QP = 3,
 	CMDQ_OPCODE_CREATE_CQ = 4,
 	CMDQ_OPCODE_DESTROY_CQ = 5,
+	CMDQ_OPCODE_REFLUSH = 6,
 	CMDQ_OPCODE_REG_MR = 8,
 	CMDQ_OPCODE_DEREG_MR = 9
 };
@@ -301,6 +302,13 @@ struct erdma_cmdq_destroy_qp_req {
 	u32 qpn;
 };
 
+struct erdma_cmdq_reflush_req {
+	u64 hdr;
+	u32 qpn;
+	u32 sq_pi;
+	u32 rq_pi;
+};
+
 /* cap qword 0 definition */
 #define ERDMA_CMD_DEV_CAP_MAX_CQE_MASK GENMASK_ULL(47, 40)
 #define ERDMA_CMD_DEV_CAP_FLAGS_MASK GENMASK_ULL(31, 24)
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index d843ce1f35f3..5dab1e87975b 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -379,6 +379,21 @@ int erdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	return 0;
 }
 
+static void erdma_flush_worker(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct erdma_qp *qp =
+		container_of(dwork, struct erdma_qp, reflush_dwork);
+	struct erdma_cmdq_reflush_req req;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
+				CMDQ_OPCODE_REFLUSH);
+	req.qpn = QP_ID(qp);
+	req.sq_pi = qp->kern_qp.sq_pi;
+	req.rq_pi = qp->kern_qp.rq_pi;
+	erdma_post_cmd_wait(&qp->dev->cmdq, &req, sizeof(req), NULL, NULL);
+}
+
 static int erdma_qp_validate_cap(struct erdma_dev *dev,
 				 struct ib_qp_init_attr *attrs)
 {
@@ -735,6 +750,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	qp->attrs.max_send_sge = attrs->cap.max_send_sge;
 	qp->attrs.max_recv_sge = attrs->cap.max_recv_sge;
 	qp->attrs.state = ERDMA_QP_STATE_IDLE;
+	INIT_DELAYED_WORK(&qp->reflush_dwork, erdma_flush_worker);
 
 	ret = create_qp_cmd(dev, qp);
 	if (ret)
@@ -1028,6 +1044,8 @@ int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	erdma_modify_qp_internal(qp, &qp_attrs, ERDMA_QP_ATTR_STATE);
 	up_write(&qp->state_lock);
 
+	cancel_delayed_work_sync(&qp->reflush_dwork);
+
 	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
 				CMDQ_OPCODE_DESTROY_QP);
 	req.qpn = QP_ID(qp);
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index a5574f0252bb..9f341d032069 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -197,6 +197,8 @@ struct erdma_qp {
 	struct erdma_cep *cep;
 	struct rw_semaphore state_lock;
 
+	struct delayed_work reflush_dwork;
+
 	union {
 		struct erdma_kqp kern_qp;
 		struct erdma_uqp user_qp;
-- 
2.27.0

