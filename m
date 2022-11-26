Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDAA639554
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Nov 2022 11:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKZKaP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Nov 2022 05:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKZKaK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 26 Nov 2022 05:30:10 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EDA2871E;
        Sat, 26 Nov 2022 02:30:09 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NK7FN3KnGzJnp2;
        Sat, 26 Nov 2022 18:26:48 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 18:30:07 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 18:30:07 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 6/6] RDMA/hns: Fix XRC caps on HIP08
Date:   Sat, 26 Nov 2022 18:29:11 +0800
Message-ID: <20221126102911.2921820-7-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221126102911.2921820-1-xuhaoyue1@hisilicon.com>
References: <20221126102911.2921820-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

From: Chengchang Tang <tangchengchang@huawei.com>

XRC caps has been set by default. But in fact, XRC is not supported
in HIP08.

Fixes: 32548870d438 ("RDMA/hns: Add support for XRC on HIP09")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f32100c6f1d9..2716852f5e92 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2051,13 +2051,14 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 
 	caps->flags |= HNS_ROCE_CAP_FLAG_ATOMIC | HNS_ROCE_CAP_FLAG_MW |
 		       HNS_ROCE_CAP_FLAG_SRQ | HNS_ROCE_CAP_FLAG_FRMR |
-		       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL | HNS_ROCE_CAP_FLAG_XRC;
+		       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL;
 
 	caps->gid_table_len[0] = HNS_ROCE_V2_GID_INDEX_NUM;
 
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
 		caps->flags |= HNS_ROCE_CAP_FLAG_STASH |
-			       HNS_ROCE_CAP_FLAG_DIRECT_WQE;
+			       HNS_ROCE_CAP_FLAG_DIRECT_WQE |
+			       HNS_ROCE_CAP_FLAG_XRC;
 		caps->max_sq_inline = HNS_ROCE_V3_MAX_SQ_INLINE;
 	} else {
 		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INLINE;
-- 
2.30.0

