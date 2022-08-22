Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444C359BDC6
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiHVKpp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiHVKpe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 06:45:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BF42BB29
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 03:45:31 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MB87G69XZz1N7VK;
        Mon, 22 Aug 2022 18:42:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 18:45:30 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 18:45:29 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v2 for-next 4/7] RDMA/hns: Support QP's restrack ops for hns driver
Date:   Mon, 22 Aug 2022 18:44:52 +0800
Message-ID: <20220822104455.2311053-5-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220822104455.2311053-1-liangwenpeng@huawei.com>
References: <20220822104455.2311053-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The QP restrack attributes come from the queue information maintained by
the driver.

For example:

$ rdma res show qp link hns_0 lqpn 41 -jp -dd
[ {
        "ifindex": 4,
        "ifname": "hns_0",
        "port": 1,
        "lqpn": 41,
        "rqpn": 40,
        "type": "RC",
        "state": "RTR",
        "rq-psn": 12474738,
        "sq-psn": 0,
        "path-mig-state": "ARMED",
        "pdn": 9,
        "pid": 1523,
        "comm": "ib_send_bw"
    },
    "drv_sq_wqe_cnt": 128,
    "drv_sq_max_gs": 1,
    "drv_rq_wqe_cnt": 512,
    "drv_rq_max_gs": 2,
    "drv_ext_sge_sge_cnt": 0
}

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |  1 +
 drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 34 +++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c73adc0d3555..7578c0c6313b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1225,6 +1225,7 @@ int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq);
 int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq);
+int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp);
 struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1b66ed45350e..87442027b808 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -568,6 +568,7 @@ static const struct ib_device_ops hns_roce_dev_xrcd_ops = {
 static const struct ib_device_ops hns_roce_dev_restrack_ops = {
 	.fill_res_cq_entry = hns_roce_fill_res_cq_entry,
 	.fill_res_cq_entry_raw = hns_roce_fill_res_cq_entry_raw,
+	.fill_res_qp_entry = hns_roce_fill_res_qp_entry,
 };
 
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 3f9c2f9dfdf6..e8fef37f810d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -78,3 +78,37 @@ int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq)
 
 	return ret;
 }
+
+int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp)
+{
+	struct hns_roce_qp *hr_qp = to_hr_qp(ib_qp);
+	struct nlattr *table_attr;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "sq_wqe_cnt", hr_qp->sq.wqe_cnt))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "sq_max_gs", hr_qp->sq.max_gs))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "rq_wqe_cnt", hr_qp->rq.wqe_cnt))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "rq_max_gs", hr_qp->rq.max_gs))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "ext_sge_sge_cnt", hr_qp->sge.sge_cnt))
+		goto err;
+
+	nla_nest_end(msg, table_attr);
+
+	return 0;
+
+err:
+	nla_nest_cancel(msg, table_attr);
+
+	return -EMSGSIZE;
+}
-- 
2.30.0

