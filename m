Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602C959BDC3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiHVKpp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiHVKpe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 06:45:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B742BB1C
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 03:45:32 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MB87b115qzlW5f;
        Mon, 22 Aug 2022 18:42:19 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 18:45:30 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 18:45:30 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v2 for-next 6/7] RDMA/hns: Support MR's restrack ops for hns driver
Date:   Mon, 22 Aug 2022 18:44:54 +0800
Message-ID: <20220822104455.2311053-7-liangwenpeng@huawei.com>
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

The MR restrack attributes come from the queue information maintained by
the driver.

For example:

$ rdma res show mr dev hns_0 mrn 6 -dd -jp
[ {
        "ifindex": 4,
        "ifname": "hns_0",
        "mrn": 6,
        "rkey": "300",
        "lkey": "300",
        "mrlen": 131072,
        "pdn": 8,
        "pid": 1524,
        "comm": "ib_send_bw"
    },
    "drv_pbl_hop_num": 2,
    "drv_ba_pg_shift": 14,
    "drv_buf_pg_shift": 12
}

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |  1 +
 drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 30 +++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index e0395870b819..30a67bc70f1a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1228,6 +1228,7 @@ int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq);
 int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq);
 int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp);
 int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp);
+int hns_roce_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
 struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 17bc73c108f2..ff4386b5c064 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -570,6 +570,7 @@ static const struct ib_device_ops hns_roce_dev_restrack_ops = {
 	.fill_res_cq_entry_raw = hns_roce_fill_res_cq_entry_raw,
 	.fill_res_qp_entry = hns_roce_fill_res_qp_entry,
 	.fill_res_qp_entry_raw = hns_roce_fill_res_qp_entry_raw,
+	.fill_res_mr_entry = hns_roce_fill_res_mr_entry,
 };
 
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 9bafc627864b..84f942e19743 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -168,3 +168,33 @@ int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
 
 	return ret;
 }
+
+int hns_roce_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr)
+{
+	struct hns_roce_mr *hr_mr = to_hr_mr(ib_mr);
+	struct nlattr *table_attr;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "pbl_hop_num", hr_mr->pbl_hop_num))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "ba_pg_shift",
+				       hr_mr->pbl_mtr.hem_cfg.ba_pg_shift))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "buf_pg_shift",
+				       hr_mr->pbl_mtr.hem_cfg.buf_pg_shift))
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

