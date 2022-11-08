Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E0E621287
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Nov 2022 14:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiKHNjy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Nov 2022 08:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiKHNjw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Nov 2022 08:39:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE11AE0;
        Tue,  8 Nov 2022 05:39:50 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N68Mw6vB0zHvfc;
        Tue,  8 Nov 2022 21:39:24 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 21:39:48 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 21:39:48 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH v3 for-rc 1/2] RDMA/hns: Fix ext_sge num error when post send
Date:   Tue, 8 Nov 2022 21:38:46 +0800
Message-ID: <20221108133847.2304539-2-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221108133847.2304539-1-xuhaoyue1@hisilicon.com>
References: <20221108133847.2304539-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

In the HNS ROCE driver, The sge is divided into standard sge and extended sge.
There are 2 standard sge in RC/XRC, and the UD standard sge is 0.
In the scenario of RC SQ inline, if the data does not exceed 32bytes,
the standard sge will be used. If it exceeds, only the extended sge will
be used to fill the data. Currently, when filling the extended sge,
max_gs is directly used as the number of the extended sge,
which did not subtract the number of standard sge.
There is a logical error. The new algorithm subtracts the number of
standard sge from max_gs to get the actual number of extended sge.

Fixes: 30b707886aeb ("RDMA/hns: Support inline data in extented sge space for RC")
Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1435fe2ea176..0937db738be7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -187,20 +187,29 @@ static void set_atomic_seg(const struct ib_send_wr *wr,
 	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_SGE_NUM, valid_num_sge);
 }
 
+static unsigned int get_std_sge_num(struct hns_roce_qp *qp)
+{
+	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_UD)
+		return 0;
+
+	return HNS_ROCE_SGE_IN_WQE;
+}
+
 static int fill_ext_sge_inl_data(struct hns_roce_qp *qp,
 				 const struct ib_send_wr *wr,
 				 unsigned int *sge_idx, u32 msg_len)
 {
 	struct ib_device *ibdev = &(to_hr_dev(qp->ibqp.device))->ib_dev;
-	unsigned int ext_sge_sz = qp->sq.max_gs * HNS_ROCE_SGE_SIZE;
 	unsigned int left_len_in_pg;
 	unsigned int idx = *sge_idx;
+	unsigned int std_sge_num;
 	unsigned int i = 0;
 	unsigned int len;
 	void *addr;
 	void *dseg;
 
-	if (msg_len > ext_sge_sz) {
+	std_sge_num = get_std_sge_num(qp);
+	if (msg_len > (qp->sq.max_gs - std_sge_num) * HNS_ROCE_SGE_SIZE) {
 		ibdev_err(ibdev,
 			  "no enough extended sge space for inline data.\n");
 		return -EINVAL;
-- 
2.30.0

