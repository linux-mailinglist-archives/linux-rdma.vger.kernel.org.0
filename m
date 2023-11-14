Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307DB7EAFF3
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Nov 2023 13:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjKNMiW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Nov 2023 07:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNMiV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Nov 2023 07:38:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7875D1;
        Tue, 14 Nov 2023 04:38:17 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SV5Rk1DlwzWhN2;
        Tue, 14 Nov 2023 20:37:54 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 20:38:15 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Fix inappropriate err code for unsupported operations
Date:   Tue, 14 Nov 2023 20:34:47 +0800
Message-ID: <20231114123449.1106162-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231114123449.1106162-1-huangjunxian6@hisilicon.com>
References: <20231114123449.1106162-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

EOPNOTSUPP is more situable than EINVAL for allocating XRCD while XRC
is not supported and unsupported resizing SRQ.

Fixes: 32548870d438 ("RDMA/hns: Add support for XRC on HIP09")
Fixes: 221109e64316 ("RDMA/hns: Add interception for resizing SRQs")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0cd2612a4987..c01307be06ab 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5666,7 +5666,7 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 
 	/* Resizing SRQs is not supported yet */
 	if (srq_attr_mask & IB_SRQ_MAX_WR)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (srq_attr_mask & IB_SRQ_LIMIT) {
 		if (srq_attr->srq_limit > srq->wqe_cnt)
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 783e71852c50..bd1fe89ca205 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -150,7 +150,7 @@ int hns_roce_alloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata)
 	int ret;
 
 	if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	ret = hns_roce_xrcd_alloc(hr_dev, &xrcd->xrcdn);
 	if (ret)
-- 
2.30.0

