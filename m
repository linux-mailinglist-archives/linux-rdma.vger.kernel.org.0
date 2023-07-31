Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3306E7698EC
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjGaOFQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 10:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjGaOEo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 10:04:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223A87D96;
        Mon, 31 Jul 2023 06:59:40 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RF0Bx3cFXzXdTy;
        Mon, 31 Jul 2023 21:56:09 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 21:59:29 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <xuhaoyue1@hisilicon.com>, <huangjunxian6@hisilicon.com>,
        <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] RDMA/hns: Remove unused function declarations
Date:   Mon, 31 Jul 2023 21:59:16 +0800
Message-ID: <20230731135916.32392-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

commit b16f8188472e ("RDMA/hns: Refactor eq code for hip06")
left behind hns_roce_cleanup_eq_table().
And commit 773f841ab1ae ("RDMA/hns: Avoid filling sgid index when modifying QP to RTR")
leave hns_get_gid_index() unused.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 6084c1649000..34e099efaae3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1111,7 +1111,6 @@ int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev);
 
-void hns_roce_cleanup_eq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev);
 
@@ -1205,7 +1204,6 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type);
 void flush_cqe(struct hns_roce_dev *dev, struct hns_roce_qp *qp);
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type);
 void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type);
-u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u32 port, int gid_index);
 void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
-- 
2.34.1

