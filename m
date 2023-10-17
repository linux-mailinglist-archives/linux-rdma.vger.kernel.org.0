Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1527CC3BD
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbjJQM4E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 08:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbjJQM4C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 08:56:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312DAFE;
        Tue, 17 Oct 2023 05:55:57 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S8v5C1r9KzVldb;
        Tue, 17 Oct 2023 20:52:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 20:55:53 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 7/7] RDMA/hns: Fix init failure of RoCE VF and HIP08
Date:   Tue, 17 Oct 2023 20:52:39 +0800
Message-ID: <20231017125239.164455-8-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
References: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

During device init, a struct for HW stats will be allocated. As HW
stats are not supported for VF and HIP08, currently
hns_roce_alloc_hw_port_stats() returns NULL in this case. However,
ib-core considers the returned NULL pointer as memory allocation
failure and returns ENOMEM, eventually leading to the failure of VF
and HIP08 init.

In the case where the driver does not support the .alloc_hw_port_stats()
ops, ib-core will return EOPNOTSUPP and ignore this error code in the
upper layer function. So for VF and HIP08, just don't set the HW stats
ops to ib-core.

Fixes: 5a87279591a1 ("RDMA/hns: Support hns HW stats")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index e1a88f2d51b6..4a9cd4d21bc9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -553,10 +553,6 @@ static struct rdma_hw_stats *hns_roce_alloc_hw_port_stats(
 		return NULL;
 	}
 
-	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08 ||
-	    hr_dev->is_vf)
-		return NULL;
-
 	return rdma_alloc_hw_stats_struct(hns_roce_port_stats_descs,
 					  ARRAY_SIZE(hns_roce_port_stats_descs),
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
@@ -576,10 +572,6 @@ static int hns_roce_get_hw_stats(struct ib_device *device,
 	if (port > hr_dev->caps.num_ports)
 		return -EINVAL;
 
-	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08 ||
-	    hr_dev->is_vf)
-		return -EOPNOTSUPP;
-
 	ret = hr_dev->hw->query_hw_counter(hr_dev, stats->value, port,
 					   &num_counters);
 	if (ret) {
@@ -633,8 +625,6 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.query_pkey = hns_roce_query_pkey,
 	.query_port = hns_roce_query_port,
 	.reg_user_mr = hns_roce_reg_user_mr,
-	.alloc_hw_port_stats = hns_roce_alloc_hw_port_stats,
-	.get_hw_stats = hns_roce_get_hw_stats,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, hns_roce_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, hns_roce_cq, ib_cq),
@@ -643,6 +633,11 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, hns_roce_ucontext, ibucontext),
 };
 
+static const struct ib_device_ops hns_roce_dev_hw_stats_ops = {
+	.alloc_hw_port_stats = hns_roce_alloc_hw_port_stats,
+	.get_hw_stats = hns_roce_get_hw_stats,
+};
+
 static const struct ib_device_ops hns_roce_dev_mr_ops = {
 	.rereg_user_mr = hns_roce_rereg_user_mr,
 };
@@ -719,6 +714,10 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
 		ib_set_device_ops(ib_dev, &hns_roce_dev_xrcd_ops);
 
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09 &&
+	    !hr_dev->is_vf)
+		ib_set_device_ops(ib_dev, &hns_roce_dev_hw_stats_ops);
+
 	ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_restrack_ops);
-- 
2.30.0

