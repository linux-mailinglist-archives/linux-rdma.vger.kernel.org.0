Return-Path: <linux-rdma+bounces-8569-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6525A5BB45
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 09:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C371896437
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7455F22CBE9;
	Tue, 11 Mar 2025 08:56:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D822ACDC
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683398; cv=none; b=evZ7SvyYrzIFbMWHj3O4eiYfDd4fYPiaVCkqCwSa0aYKLnhA7XXlkWJ0fmTZRMdoh1Pa1892yL+j4tn5nz1Ho9/o6yJA9cbBXIOhZNpjN6lOsBZSSKTrcDwOc8iSVm54X4SGZzcKwGGs/xXkrc40h66zjEIEtQu4ZonKCJKeZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683398; c=relaxed/simple;
	bh=TO1Q8vT8+yhGMcwMDgOP7WVVe6y6Gzr9tzJOfl24xeg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EX81X9JHhVr59RIbjyk3+fQwmD4BiRE7qeoqKIXWRbPl+PAU24fUvXWNEmNoL96+M6ICds8VxpenpNj9Ya9Sf6/x3Jmnk0mYhmifjtavvzMKektKL/DHTK3rOxhNQLqojZImgqFSLIDbNY11TZQLb6dHjSZHAfZOt6nyxnGmqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZBnbk28Wyz2CcGj;
	Tue, 11 Mar 2025 16:53:22 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E96D140109;
	Tue, 11 Mar 2025 16:56:32 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 16:56:32 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 2/7] RDMA/hns: Fix soft lockup during bt pages loop
Date: Tue, 11 Mar 2025 16:48:52 +0800
Message-ID: <20250311084857.3803665-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
References: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Driver runs a for-loop when allocating bt pages and mapping them with
buffer pages. When a large buffer (e.g. MR over 100GB) is being allocated,
it may require a considerable loop count. This will lead to soft lockup:

        watchdog: BUG: soft lockup - CPU#27 stuck for 22s!
        ...
        Call trace:
         hem_list_alloc_mid_bt+0x124/0x394 [hns_roce_hw_v2]
         hns_roce_hem_list_request+0xf8/0x160 [hns_roce_hw_v2]
         hns_roce_mtr_create+0x2e4/0x360 [hns_roce_hw_v2]
         alloc_mr_pbl+0xd4/0x17c [hns_roce_hw_v2]
         hns_roce_reg_user_mr+0xf8/0x190 [hns_roce_hw_v2]
         ib_uverbs_reg_mr+0x118/0x290

        watchdog: BUG: soft lockup - CPU#35 stuck for 23s!
        ...
        Call trace:
         hns_roce_hem_list_find_mtt+0x7c/0xb0 [hns_roce_hw_v2]
         mtr_map_bufs+0xc4/0x204 [hns_roce_hw_v2]
         hns_roce_mtr_create+0x31c/0x3c4 [hns_roce_hw_v2]
         alloc_mr_pbl+0xb0/0x160 [hns_roce_hw_v2]
         hns_roce_reg_user_mr+0x108/0x1c0 [hns_roce_hw_v2]
         ib_uverbs_reg_mr+0x120/0x2bc

Add a cond_resched() to fix soft lockup during these loops. In order not
to affect the allocation performance of normal-size buffer, set the loop
count of a 100GB MR as the threshold to call cond_resched().

Fixes: 38389eaa4db1 ("RDMA/hns: Add mtr support for mixed multihop addressing")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 605562122ecc..ca0798224e56 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1361,6 +1361,11 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+/* This is the bottom bt pages number of a 100G MR on 4K OS, assuming
+ * the bt page size is not expanded by cal_best_bt_pg_sz()
+ */
+#define RESCHED_LOOP_CNT_THRESHOLD_ON_4K 12800
+
 /* construct the base address table and link them by address hop config */
 int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_hem_list *hem_list,
@@ -1369,6 +1374,7 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 {
 	const struct hns_roce_buf_region *r;
 	int ofs, end;
+	int loop;
 	int unit;
 	int ret;
 	int i;
@@ -1386,7 +1392,10 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			continue;
 
 		end = r->offset + r->count;
-		for (ofs = r->offset; ofs < end; ofs += unit) {
+		for (ofs = r->offset, loop = 1; ofs < end; ofs += unit, loop++) {
+			if (!(loop % RESCHED_LOOP_CNT_THRESHOLD_ON_4K))
+				cond_resched();
+
 			ret = hem_list_alloc_mid_bt(hr_dev, r, unit, ofs,
 						    hem_list->mid_bt[i],
 						    &hem_list->btm_bt);
@@ -1443,9 +1452,14 @@ void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 	struct list_head *head = &hem_list->btm_bt;
 	struct hns_roce_hem_item *hem, *temp_hem;
 	void *cpu_base = NULL;
+	int loop = 1;
 	int nr = 0;
 
 	list_for_each_entry_safe(hem, temp_hem, head, sibling) {
+		if (!(loop % RESCHED_LOOP_CNT_THRESHOLD_ON_4K))
+			cond_resched();
+		loop++;
+
 		if (hem_list_page_is_in_range(hem, offset)) {
 			nr = offset - hem->start;
 			cpu_base = hem->addr + nr * BA_BYTE_LEN;
-- 
2.33.0


