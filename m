Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D3B7A4FBF
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjIRQvx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 12:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjIRQvw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 12:51:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BB8B6;
        Mon, 18 Sep 2023 09:51:45 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rq4vY3rwrz15MP3;
        Mon, 18 Sep 2023 21:12:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 21:14:12 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH RFC for-next 3/3] RDMA/hns: Support SRQ restrack ops for hns driver
Date:   Mon, 18 Sep 2023 21:11:10 +0800
Message-ID: <20230918131110.3987498-4-huangjunxian6@hisilicon.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: wenglianfa <wenglianfa@huawei.com>

The SRQ restrack attributes come from the context maintained by ROCEE.

Example:
$ rdma res show srq -jp -dd
[ {
        "ifindex": 0,
        "ifname": "hns_0",
        "srqn": 0,
        "type": "BASIC",
        "lqpn": [ "14-15","22-23" ],
        "pdn": 2,
        "pid": 1224,
        "comm": "ib_send_bw",{
            "drv_srqn": 0,
            "drv_wqe_cnt": 512,
            "drv_max_gs": 2,
            "drv_xrcdn": 0
        }
    } ]

$ rdma res show srq link hns_0 -jpr
[ {
        "ifindex": 0,
        "ifname": "hns_0",
        "data": [ 149,0,0,0,0,0,0,0,0,0,0,0,119,101,120,99,0,
		  46,62,31,0,0,0,0,3,0,0,1,0,58,62,31,0,0,0,0,
		  30,159,15,0,0,0,64,5,0,0,0,0,0,0,0,0,0,0,0,
		  9,0,0,0,0,0,0,0,0 ]
    } ]

Signed-off-by: wenglianfa <wenglianfa@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |  3 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 25 ++++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c     |  2 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 49 +++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 7f0d0288beb1..2059d90f8f78 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -908,6 +908,7 @@ struct hns_roce_hw {
 	int (*query_cqc)(struct hns_roce_dev *hr_dev, u32 cqn, void *buffer);
 	int (*query_qpc)(struct hns_roce_dev *hr_dev, u32 qpn, void *buffer);
 	int (*query_mpt)(struct hns_roce_dev *hr_dev, u32 key, void *buffer);
+	int (*query_srqc)(struct hns_roce_dev *hr_dev, u32 srqn, void *buffer);
 	int (*query_hw_counter)(struct hns_roce_dev *hr_dev,
 				u64 *stats, u32 port, int *hw_counters);
 	const struct ib_device_ops *hns_roce_dev_ops;
@@ -1239,6 +1240,8 @@ int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp);
 int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp);
 int hns_roce_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 int hns_roce_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr);
+int hns_roce_fill_res_srq_entry(struct sk_buff *msg, struct ib_srq *ib_srq);
+int hns_roce_fill_res_srq_entry_raw(struct sk_buff *msg, struct ib_srq *ib_srq);
 struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d82daff2d9bd..3b481e493a6e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5272,6 +5272,30 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev, u32 qpn,
 	return ret;
 }
 
+static int hns_roce_v2_query_srqc(struct hns_roce_dev *hr_dev, u32 srqn,
+				 void *buffer)
+{
+	struct hns_roce_srq_context *context;
+	struct hns_roce_cmd_mailbox *mailbox;
+	int ret;
+
+	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+
+	context  = mailbox->buf;
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_SRQC,
+				srqn);
+	if (ret)
+		goto out;
+
+	memcpy(buffer, context, sizeof(*context));
+
+out:
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+	return ret;
+}
+
 static u8 get_qp_timeout_attr(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_v2_qp_context *context)
 {
@@ -6632,6 +6656,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.query_cqc = hns_roce_v2_query_cqc,
 	.query_qpc = hns_roce_v2_query_qpc,
 	.query_mpt = hns_roce_v2_query_mpt,
+	.query_srqc = hns_roce_v2_query_srqc,
 	.query_hw_counter = hns_roce_hw_v2_query_counter,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index d9d546cdef52..cb07c3030124 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -681,6 +681,8 @@ static const struct ib_device_ops hns_roce_dev_restrack_ops = {
 	.fill_res_qp_entry_raw = hns_roce_fill_res_qp_entry_raw,
 	.fill_res_mr_entry = hns_roce_fill_res_mr_entry,
 	.fill_res_mr_entry_raw = hns_roce_fill_res_mr_entry_raw,
+	.fill_res_srq_entry = hns_roce_fill_res_srq_entry,
+	.fill_res_srq_entry_raw = hns_roce_fill_res_srq_entry_raw,
 };
 
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 081a01de3055..f7f3c4cc7426 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -160,3 +160,52 @@ int hns_roce_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr)
 
 	return ret;
 }
+
+int hns_roce_fill_res_srq_entry(struct sk_buff *msg, struct ib_srq *ib_srq)
+{
+	struct hns_roce_srq *hr_srq = to_hr_srq(ib_srq);
+	struct nlattr *table_attr;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "srqn", hr_srq->srqn))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "wqe_cnt", hr_srq->wqe_cnt))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "max_gs", hr_srq->max_gs))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "xrcdn", hr_srq->xrcdn))
+		goto err;
+
+	nla_nest_end(msg, table_attr);
+
+	return 0;
+
+err:
+	nla_nest_cancel(msg, table_attr);
+	return -EMSGSIZE;
+}
+
+int hns_roce_fill_res_srq_entry_raw(struct sk_buff *msg, struct ib_srq *ib_srq)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_srq->device);
+	struct hns_roce_srq *hr_srq = to_hr_srq(ib_srq);
+	struct hns_roce_srq_context context;
+	int ret;
+
+	if (!hr_dev->hw->query_srqc)
+		return -EINVAL;
+
+	ret = hr_dev->hw->query_srqc(hr_dev, hr_srq->srqn, &context);
+	if (ret)
+		return ret;
+
+	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, sizeof(context), &context);
+
+	return ret;
+}
-- 
2.30.0

