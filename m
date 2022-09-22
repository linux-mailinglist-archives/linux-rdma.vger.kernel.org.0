Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D515E627A
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiIVMeV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiIVMeO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 08:34:14 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A081E7222
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 05:34:11 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYF5p5rQPzHpsK;
        Thu, 22 Sep 2022 20:31:58 +0800 (CST)
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
Subject: [PATCH for-next 07/12] RDMA/hns: Remove redundant 'phy_addr' in hns_roce_hem_list_find_mtt()
Date:   Thu, 22 Sep 2022 20:33:10 +0800
Message-ID: <20220922123315.3732205-8-xuhaoyue1@hisilicon.com>
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

From: Chengchang Tang <tangchengchang@huawei.com>

This parameter has never been used. Remove it to simplify the function.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 7 +------
 drivers/infiniband/hw/hns/hns_roce_hem.h | 2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c  | 4 ++--
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index e8acd2839d7d..d0b75a2234d3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1462,19 +1462,17 @@ void hns_roce_hem_list_init(struct hns_roce_hem_list *hem_list)
 
 void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_hem_list *hem_list,
-				 int offset, int *mtt_cnt, u64 *phy_addr)
+				 int offset, int *mtt_cnt)
 {
 	struct list_head *head = &hem_list->btm_bt;
 	struct hns_roce_hem_item *hem, *temp_hem;
 	void *cpu_base = NULL;
-	u64 phy_base = 0;
 	int nr = 0;
 
 	list_for_each_entry_safe(hem, temp_hem, head, sibling) {
 		if (hem_list_page_is_in_range(hem, offset)) {
 			nr = offset - hem->start;
 			cpu_base = hem->addr + nr * BA_BYTE_LEN;
-			phy_base = hem->dma_addr + nr * BA_BYTE_LEN;
 			nr = hem->end + 1 - offset;
 			break;
 		}
@@ -1483,8 +1481,5 @@ void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 	if (mtt_cnt)
 		*mtt_cnt = nr;
 
-	if (phy_addr)
-		*phy_addr = phy_base;
-
 	return cpu_base;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 6b888049e9a0..7d23d3c51da4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -131,7 +131,7 @@ void hns_roce_hem_list_release(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_hem_list *hem_list);
 void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_hem_list *hem_list,
-				 int offset, int *mtt_cnt, u64 *phy_addr);
+				 int offset, int *mtt_cnt);
 
 static inline void hns_roce_hem_first(struct hns_roce_hem *hem,
 				      struct hns_roce_hem_iter *iter)
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 867972c2a894..a36afc77b3ae 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -586,7 +586,7 @@ static int mtr_map_region(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	while (offset < end && npage < max_count) {
 		count = 0;
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
-						  offset, &count, NULL);
+						  offset, &count);
 		if (!mtts)
 			return -ENOBUFS;
 
@@ -835,7 +835,7 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		mtt_count = 0;
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
 						  start_index + total,
-						  &mtt_count, NULL);
+						  &mtt_count);
 		if (!mtts || !mtt_count)
 			goto done;
 
-- 
2.30.0

