Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E16D7A4FBC
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 18:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjIRQvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjIRQvv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 12:51:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC2AC;
        Mon, 18 Sep 2023 09:51:45 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rq4tY02syzVk3Y;
        Mon, 18 Sep 2023 21:11:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 21:14:11 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH RFC for-next 1/3] RDMA/core: Add dedicated SRQ resource tracker function
Date:   Mon, 18 Sep 2023 21:11:08 +0800
Message-ID: <20230918131110.3987498-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230918131110.3987498-1-huangjunxian6@hisilicon.com>
References: <20230918131110.3987498-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: wenglianfa <wenglianfa@huawei.com>

Add a dedicated callback function for SRQ resource tracker.

Signed-off-by: wenglianfa <wenglianfa@huawei.com>
---
 drivers/infiniband/core/device.c | 1 +
 drivers/infiniband/core/nldev.c  | 9 ++++++++-
 include/rdma/ib_verbs.h          | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a666847bd714..05b37050e842 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2651,6 +2651,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, fill_res_mr_entry_raw);
 	SET_DEVICE_OP(dev_ops, fill_res_qp_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_qp_entry_raw);
+	SET_DEVICE_OP(dev_ops, fill_res_srq_entry);
 	SET_DEVICE_OP(dev_ops, fill_stat_mr_entry);
 	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
 	SET_DEVICE_OP(dev_ops, get_dma_mr);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index d5d3e4f0de77..bebe6adeb533 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -818,6 +818,7 @@ static int fill_res_srq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			      struct rdma_restrack_entry *res, uint32_t port)
 {
 	struct ib_srq *srq = container_of(res, struct ib_srq, res);
+	struct ib_device *dev = srq->device;
 
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_SRQN, srq->res.id))
 		goto err;
@@ -837,7 +838,13 @@ static int fill_res_srq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (fill_res_srq_qps(msg, srq))
 		goto err;
 
-	return fill_res_name_pid(msg, res);
+	if (fill_res_name_pid(msg, res))
+		goto err;
+
+	if (dev->ops.fill_res_srq_entry)
+		return dev->ops.fill_res_srq_entry(msg, srq);
+
+	return 0;
 
 err:
 	return -EMSGSIZE;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 533ab92684d8..3cbb6141a9ce 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2608,6 +2608,7 @@ struct ib_device_ops {
 	int (*fill_res_qp_entry)(struct sk_buff *msg, struct ib_qp *ibqp);
 	int (*fill_res_qp_entry_raw)(struct sk_buff *msg, struct ib_qp *ibqp);
 	int (*fill_res_cm_id_entry)(struct sk_buff *msg, struct rdma_cm_id *id);
+	int (*fill_res_srq_entry)(struct sk_buff *msg, struct ib_srq *ib_srq);
 
 	/* Device lifecycle callbacks */
 	/*
-- 
2.30.0

