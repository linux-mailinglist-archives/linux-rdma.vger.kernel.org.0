Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DE15A478F
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiH2KvD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 06:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiH2KvC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 06:51:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A654D44543
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 03:51:00 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGRw91kSLzkWTf;
        Mon, 29 Aug 2022 18:47:21 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 18:50:58 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 18:50:57 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 2/4] RDMA/hns: Fix wrong fixed value of qp->rq.wqe_shift
Date:   Mon, 29 Aug 2022 18:50:19 +0800
Message-ID: <20220829105021.1427804-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220829105021.1427804-1-liangwenpeng@huawei.com>
References: <20220829105021.1427804-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

The value of qp->rq.wqe_shift of HIP08 is always determined by the number
of sge. So delete the wrong branch.

Fixes: cfc85f3e4b7f ("RDMA/hns: Add profile support for hip08 driver")
Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 48d3616a6d71..7bee7f6c5e70 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -462,11 +462,8 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 	hr_qp->rq.max_gs = roundup_pow_of_two(max(1U, cap->max_recv_sge) +
 					      hr_qp->rq.rsv_sge);
 
-	if (hr_dev->caps.max_rq_sg <= HNS_ROCE_SGE_IN_WQE)
-		hr_qp->rq.wqe_shift = ilog2(hr_dev->caps.max_rq_desc_sz);
-	else
-		hr_qp->rq.wqe_shift = ilog2(hr_dev->caps.max_rq_desc_sz *
-					    hr_qp->rq.max_gs);
+	hr_qp->rq.wqe_shift = ilog2(hr_dev->caps.max_rq_desc_sz *
+				    hr_qp->rq.max_gs);
 
 	hr_qp->rq.wqe_cnt = cnt;
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE &&
-- 
2.30.0

