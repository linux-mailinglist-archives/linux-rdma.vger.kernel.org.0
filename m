Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5735B7A4FEA
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjIRQ4r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 12:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjIRQ4q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 12:56:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD343AC;
        Mon, 18 Sep 2023 09:56:39 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rq4sq3Nk8zMl6t;
        Mon, 18 Sep 2023 21:10:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 21:14:12 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH RFC for-next 2/3] RDMA/core: Add support to dump SRQ resource in RAW format
Date:   Mon, 18 Sep 2023 21:11:09 +0800
Message-ID: <20230918131110.3987498-3-huangjunxian6@hisilicon.com>
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

Add support to dump SRQ resource in raw format. It enable drivers to
return the entire device specific SRQ context without setting each
field separately.

Example:
$ rdma res show srq -r
dev hns3 149000...

$ rdma res show srq -j -r
[{"ifindex":0,"ifname":"hns3","data":[149,0,0,...]}]

Signed-off-by: wenglianfa <wenglianfa@huawei.com>
---
 drivers/infiniband/core/device.c |  1 +
 drivers/infiniband/core/nldev.c  | 17 +++++++++++++++++
 include/rdma/ib_verbs.h          |  1 +
 include/uapi/rdma/rdma_netlink.h |  2 ++
 4 files changed, 21 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 05b37050e842..0cb5459d2c6c 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2652,6 +2652,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, fill_res_qp_entry);
 	SET_DEVICE_OP(dev_ops, fill_res_qp_entry_raw);
 	SET_DEVICE_OP(dev_ops, fill_res_srq_entry);
+	SET_DEVICE_OP(dev_ops, fill_res_srq_entry_raw);
 	SET_DEVICE_OP(dev_ops, fill_stat_mr_entry);
 	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
 	SET_DEVICE_OP(dev_ops, get_dma_mr);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index bebe6adeb533..456545007c14 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -850,6 +850,17 @@ static int fill_res_srq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	return -EMSGSIZE;
 }
 
+static int fill_res_srq_raw_entry(struct sk_buff *msg, bool has_cap_net_admin,
+				 struct rdma_restrack_entry *res, uint32_t port)
+{
+	struct ib_srq *srq = container_of(res, struct ib_srq, res);
+	struct ib_device *dev = srq->device;
+
+	if (!dev->ops.fill_res_srq_entry_raw)
+		return -EINVAL;
+	return dev->ops.fill_res_srq_entry_raw(msg, srq);
+}
+
 static int fill_stat_counter_mode(struct sk_buff *msg,
 				  struct rdma_counter *counter)
 {
@@ -1659,6 +1670,7 @@ RES_GET_FUNCS(mr_raw, RDMA_RESTRACK_MR);
 RES_GET_FUNCS(counter, RDMA_RESTRACK_COUNTER);
 RES_GET_FUNCS(ctx, RDMA_RESTRACK_CTX);
 RES_GET_FUNCS(srq, RDMA_RESTRACK_SRQ);
+RES_GET_FUNCS(srq_raw, RDMA_RESTRACK_SRQ);
 
 static LIST_HEAD(link_ops);
 static DECLARE_RWSEM(link_ops_rwsem);
@@ -2564,6 +2576,11 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.dump = nldev_res_get_mr_raw_dumpit,
 		.flags = RDMA_NL_ADMIN_PERM,
 	},
+	[RDMA_NLDEV_CMD_RES_SRQ_GET_RAW] = {
+		.doit = nldev_res_get_srq_raw_doit,
+		.dump = nldev_res_get_srq_raw_dumpit,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
 	[RDMA_NLDEV_CMD_STAT_GET_STATUS] = {
 		.doit = nldev_stat_get_counter_status_doit,
 	},
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3cbb6141a9ce..e36c0d9aad27 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2609,6 +2609,7 @@ struct ib_device_ops {
 	int (*fill_res_qp_entry_raw)(struct sk_buff *msg, struct ib_qp *ibqp);
 	int (*fill_res_cm_id_entry)(struct sk_buff *msg, struct rdma_cm_id *id);
 	int (*fill_res_srq_entry)(struct sk_buff *msg, struct ib_srq *ib_srq);
+	int (*fill_res_srq_entry_raw)(struct sk_buff *msg, struct ib_srq *ib_srq);
 
 	/* Device lifecycle callbacks */
 	/*
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index e50c357367db..2830695c3556 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -299,6 +299,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_STAT_GET_STATUS,
 
+	RDMA_NLDEV_CMD_RES_SRQ_GET_RAW,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
-- 
2.30.0

