Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8914BB79F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 12:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiBRLF6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Feb 2022 06:05:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiBRLF5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Feb 2022 06:05:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD4828881F
        for <linux-rdma@vger.kernel.org>; Fri, 18 Feb 2022 03:05:40 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K0TJS5FB7zZfn6;
        Fri, 18 Feb 2022 19:00:56 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 19:05:21 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 19:05:21 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 3/8] RDMA/hns: Remove redundant parameter "mailbox" in the mailbox
Date:   Fri, 18 Feb 2022 19:05:14 +0800
Message-ID: <20220218110519.37375-4-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220218110519.37375-1-liangwenpeng@huawei.com>
References: <20220218110519.37375-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The parameter "out_param" of the mailbox is always null when the context is
destroyed. So remove the function parameter "mailbox".

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 -
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 11 +++++------
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  6 ++----
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 2657f4c513ee..f21c7aa43324 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1145,7 +1145,6 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		       unsigned int *sg_offset);
 int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_cmd_mailbox *mailbox,
 			    unsigned long mpt_index);
 unsigned long key_to_hw_index(u32 key);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index bf4ea6bfff84..62a57cae800c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -56,11 +56,10 @@ static int hns_roce_hw_create_mpt(struct hns_roce_dev *hr_dev,
 }
 
 int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_cmd_mailbox *mailbox,
 			    unsigned long mpt_index)
 {
-	return hns_roce_cmd_mbox(hr_dev, 0, mailbox ? mailbox->dma : 0,
-				 mpt_index, HNS_ROCE_CMD_DESTROY_MPT);
+	return hns_roce_cmd_mbox(hr_dev, 0, 0, mpt_index,
+				 HNS_ROCE_CMD_DESTROY_MPT);
 }
 
 static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
@@ -142,7 +141,7 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
 	int ret;
 
 	if (mr->enabled) {
-		ret = hns_roce_hw_destroy_mpt(hr_dev, NULL,
+		ret = hns_roce_hw_destroy_mpt(hr_dev,
 					      key_to_hw_index(mr->key) &
 					      (hr_dev->caps.num_mtpts - 1));
 		if (ret)
@@ -306,7 +305,7 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 	if (ret)
 		goto free_cmd_mbox;
 
-	ret = hns_roce_hw_destroy_mpt(hr_dev, NULL, mtpt_idx);
+	ret = hns_roce_hw_destroy_mpt(hr_dev, mtpt_idx);
 	if (ret)
 		ibdev_warn(ib_dev, "failed to destroy MPT, ret = %d.\n", ret);
 
@@ -477,7 +476,7 @@ static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
 	int ret;
 
 	if (mw->enabled) {
-		ret = hns_roce_hw_destroy_mpt(hr_dev, NULL,
+		ret = hns_roce_hw_destroy_mpt(hr_dev,
 					      key_to_hw_index(mw->rkey) &
 					      (hr_dev->caps.num_mtpts - 1));
 		if (ret)
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 5bb8ccea95a6..1fef5d630485 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -68,11 +68,9 @@ static int hns_roce_hw_create_srq(struct hns_roce_dev *dev,
 }
 
 static int hns_roce_hw_destroy_srq(struct hns_roce_dev *dev,
-				   struct hns_roce_cmd_mailbox *mailbox,
 				   unsigned long srq_num)
 {
-	return hns_roce_cmd_mbox(dev, 0, mailbox ? mailbox->dma : 0, srq_num,
-				 HNS_ROCE_CMD_DESTROY_SRQ);
+	return hns_roce_cmd_mbox(dev, 0, 0, srq_num, HNS_ROCE_CMD_DESTROY_SRQ);
 }
 
 static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
@@ -144,7 +142,7 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
 	int ret;
 
-	ret = hns_roce_hw_destroy_srq(hr_dev, NULL, srq->srqn);
+	ret = hns_roce_hw_destroy_srq(hr_dev, srq->srqn);
 	if (ret)
 		dev_err(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
 			ret, srq->srqn);
-- 
2.33.0

