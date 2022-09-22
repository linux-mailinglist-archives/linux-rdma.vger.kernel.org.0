Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6355E627D
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiIVMeW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 08:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiIVMeO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 08:34:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4A4E720D
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 05:34:11 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYF3Y0xc4z14S30;
        Thu, 22 Sep 2022 20:30:01 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:34:09 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:34:03 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 06/12] RDMA/hns: Remove redundant 'use_lowmem' argument from hns_roce_init_hem_table()
Date:   Thu, 22 Sep 2022 20:33:09 +0800
Message-ID: <20220922123315.3732205-7-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
References: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

From: Yunsheng Lin <linyunsheng@huawei.com>

As hns_roce_init_hem_table() is always called with use_lowmem
being '1', and table->lowmem is set according to that argument,
so remove table->lowmem too.

Also, as the table->lowmem is used to indicate a dma buffer
is allocated with GFP_HIGHUSER or GFP_KERNEL, and calling
dma_alloc_coherent() with GFP_KERNEL seems like a common
pattern.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 -
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 12 +++---------
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  3 +--
 drivers/infiniband/hw/hns/hns_roce_main.c   | 20 ++++++++++----------
 4 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 6fb6080d2506..32cc116b3a6d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -240,7 +240,6 @@ struct hns_roce_hem_table {
 	/* Single obj size */
 	unsigned long	obj_size;
 	unsigned long	table_chunk_size;
-	int		lowmem;
 	struct mutex	mutex;
 	struct hns_roce_hem **hem;
 	u64		**bt_l1;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index e7c73ff14ae0..e8acd2839d7d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -455,7 +455,7 @@ static int alloc_mhop_hem(struct hns_roce_dev *hr_dev,
 	 * alloc bt space chunk for MTT/CQE.
 	 */
 	size = table->type < HEM_TYPE_MTT ? mhop->buf_chunk_size : bt_size;
-	flag = (table->lowmem ? GFP_KERNEL : GFP_HIGHUSER) | __GFP_NOWARN;
+	flag = GFP_KERNEL | __GFP_NOWARN;
 	table->hem[index->buf] = hns_roce_alloc_hem(hr_dev, size >> PAGE_SHIFT,
 						    size, flag);
 	if (!table->hem[index->buf]) {
@@ -588,8 +588,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	table->hem[i] = hns_roce_alloc_hem(hr_dev,
 				       table->table_chunk_size >> PAGE_SHIFT,
 				       table->table_chunk_size,
-				       (table->lowmem ? GFP_KERNEL :
-					GFP_HIGHUSER) | __GFP_NOWARN);
+				       GFP_KERNEL | __GFP_NOWARN);
 	if (!table->hem[i]) {
 		ret = -ENOMEM;
 		goto out;
@@ -725,9 +724,6 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 	int length;
 	int i, j;
 
-	if (!table->lowmem)
-		return NULL;
-
 	mutex_lock(&table->mutex);
 
 	if (!hns_roce_check_whether_mhop(hr_dev, table->type)) {
@@ -783,8 +779,7 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 
 int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_hem_table *table, u32 type,
-			    unsigned long obj_size, unsigned long nobj,
-			    int use_lowmem)
+			    unsigned long obj_size, unsigned long nobj)
 {
 	unsigned long obj_per_chunk;
 	unsigned long num_hem;
@@ -861,7 +856,6 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 	table->type = type;
 	table->num_hem = num_hem;
 	table->obj_size = obj_size;
-	table->lowmem = use_lowmem;
 	mutex_init(&table->mutex);
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 2d84a6b3f05d..6b888049e9a0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -111,8 +111,7 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 			  dma_addr_t *dma_handle);
 int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_hem_table *table, u32 type,
-			    unsigned long obj_size, unsigned long nobj,
-			    int use_lowmem);
+			    unsigned long obj_size, unsigned long nobj);
 void hns_roce_cleanup_hem_table(struct hns_roce_dev *hr_dev,
 				struct hns_roce_hem_table *table);
 void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 82948ae3e52b..498d7c28c56c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -659,7 +659,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 
 	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->mr_table.mtpt_table,
 				      HEM_TYPE_MTPT, hr_dev->caps.mtpt_entry_sz,
-				      hr_dev->caps.num_mtpts, 1);
+				      hr_dev->caps.num_mtpts);
 	if (ret) {
 		dev_err(dev, "Failed to init MTPT context memory, aborting.\n");
 		return ret;
@@ -667,7 +667,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 
 	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->qp_table.qp_table,
 				      HEM_TYPE_QPC, hr_dev->caps.qpc_sz,
-				      hr_dev->caps.num_qps, 1);
+				      hr_dev->caps.num_qps);
 	if (ret) {
 		dev_err(dev, "Failed to init QP context memory, aborting.\n");
 		goto err_unmap_dmpt;
@@ -677,7 +677,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 				      HEM_TYPE_IRRL,
 				      hr_dev->caps.irrl_entry_sz *
 				      hr_dev->caps.max_qp_init_rdma,
-				      hr_dev->caps.num_qps, 1);
+				      hr_dev->caps.num_qps);
 	if (ret) {
 		dev_err(dev, "Failed to init irrl_table memory, aborting.\n");
 		goto err_unmap_qp;
@@ -689,7 +689,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 					      HEM_TYPE_TRRL,
 					      hr_dev->caps.trrl_entry_sz *
 					      hr_dev->caps.max_qp_dest_rdma,
-					      hr_dev->caps.num_qps, 1);
+					      hr_dev->caps.num_qps);
 		if (ret) {
 			dev_err(dev,
 				"Failed to init trrl_table memory, aborting.\n");
@@ -699,7 +699,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 
 	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->cq_table.table,
 				      HEM_TYPE_CQC, hr_dev->caps.cqc_entry_sz,
-				      hr_dev->caps.num_cqs, 1);
+				      hr_dev->caps.num_cqs);
 	if (ret) {
 		dev_err(dev, "Failed to init CQ context memory, aborting.\n");
 		goto err_unmap_trrl;
@@ -709,7 +709,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->srq_table.table,
 					      HEM_TYPE_SRQC,
 					      hr_dev->caps.srqc_entry_sz,
-					      hr_dev->caps.num_srqs, 1);
+					      hr_dev->caps.num_srqs);
 		if (ret) {
 			dev_err(dev,
 				"Failed to init SRQ context memory, aborting.\n");
@@ -722,7 +722,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 					      &hr_dev->qp_table.sccc_table,
 					      HEM_TYPE_SCCC,
 					      hr_dev->caps.sccc_sz,
-					      hr_dev->caps.num_qps, 1);
+					      hr_dev->caps.num_qps);
 		if (ret) {
 			dev_err(dev,
 				"Failed to init SCC context memory, aborting.\n");
@@ -734,7 +734,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->qpc_timer_table,
 					      HEM_TYPE_QPC_TIMER,
 					      hr_dev->caps.qpc_timer_entry_sz,
-					      hr_dev->caps.num_qpc_timer, 1);
+					      hr_dev->caps.num_qpc_timer);
 		if (ret) {
 			dev_err(dev,
 				"Failed to init QPC timer memory, aborting.\n");
@@ -746,7 +746,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->cqc_timer_table,
 					      HEM_TYPE_CQC_TIMER,
 					      hr_dev->caps.cqc_timer_entry_sz,
-					      hr_dev->caps.cqc_timer_bt_num, 1);
+					      hr_dev->caps.cqc_timer_bt_num);
 		if (ret) {
 			dev_err(dev,
 				"Failed to init CQC timer memory, aborting.\n");
@@ -758,7 +758,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->gmv_table,
 					      HEM_TYPE_GMV,
 					      hr_dev->caps.gmv_entry_sz,
-					      hr_dev->caps.gmv_entry_num, 1);
+					      hr_dev->caps.gmv_entry_num);
 		if (ret) {
 			dev_err(dev,
 				"failed to init gmv table memory, ret = %d\n",
-- 
2.30.0

