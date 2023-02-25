Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B85E6A28B5
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Feb 2023 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjBYKEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Feb 2023 05:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBYKEX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Feb 2023 05:04:23 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E3F11E9A
        for <linux-rdma@vger.kernel.org>; Sat, 25 Feb 2023 02:04:22 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PP2Qm4yxPzrS2Z;
        Sat, 25 Feb 2023 18:03:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 25 Feb 2023 18:04:19 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [RFC PATCH for-next 1/1] RDMA/hns: Add SVE DIRECT WQE flag to support libhns
Date:   Sat, 25 Feb 2023 18:02:51 +0800
Message-ID: <20230225100253.3993383-2-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
References: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Added SVE DWQE flag to control libhns SVE DWQE function.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 3 +++
 include/uapi/rdma/hns-abi.h                 | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 84239b907de2..bd503276f262 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -142,6 +142,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
 	HNS_ROCE_CAP_FLAG_DIRECT_WQE		= BIT(12),
+	HNS_ROCE_CAP_FLAG_SVE_DIRECT_WQE	= BIT(13),
 	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
 	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
 	HNS_ROCE_CAP_FLAG_CQE_INLINE		= BIT(19),
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index d855a917f4cf..efc4b71d5b8b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -749,6 +749,9 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DIRECT_WQE)
 		hr_qp->en_flags |= HNS_ROCE_QP_CAP_DIRECT_WQE;
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SVE_DIRECT_WQE)
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_SVE_DIRECT_WQE;
+
 	return 0;
 
 err_inline:
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 2e68a8b0c92c..a6c7abe0c225 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
 	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
+	HNS_ROCE_QP_CAP_SVE_DIRECT_WQE = 1 << 3,
 	HNS_ROCE_QP_CAP_DIRECT_WQE = 1 << 5,
 };
 
-- 
2.30.0

