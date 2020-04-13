Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3701A6323
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 08:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgDMGk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 02:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgDMGk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Apr 2020 02:40:57 -0400
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E626C008676
        for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2020 23:40:56 -0700 (PDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 526814EE8C9ED1605265;
        Mon, 13 Apr 2020 14:40:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 14:40:41 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/6] RDMA/hns: Optimize hns_roce_config_link_table()
Date:   Mon, 13 Apr 2020 14:40:37 +0800
Message-ID: <1586760042-40516-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
References: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

Remove the unnecessary memset operation and adjust style of some lines in
hns_roce_config_link_table().

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 53 ++++++++++++------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c331667..a580de9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2040,8 +2040,6 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 
 	page_num = link_tbl->npages;
 	entry = link_tbl->table.buf;
-	memset(req_a, 0, sizeof(*req_a));
-	memset(req_b, 0, sizeof(*req_b));
 
 	for (i = 0; i < 2; i++) {
 		hns_roce_cmq_setup_basic_desc(&desc[i], opcode, false);
@@ -2050,39 +2048,30 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 			desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 		else
 			desc[i].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-
-		if (i == 0) {
-			req_a->base_addr_l =
-				cpu_to_le32(link_tbl->table.map & 0xffffffff);
-			req_a->base_addr_h =
-				cpu_to_le32(link_tbl->table.map >> 32);
-			roce_set_field(req_a->depth_pgsz_init_en,
-				       CFG_LLM_QUE_DEPTH_M, CFG_LLM_QUE_DEPTH_S,
-				       link_tbl->npages);
-			roce_set_field(req_a->depth_pgsz_init_en,
-				       CFG_LLM_QUE_PGSZ_M, CFG_LLM_QUE_PGSZ_S,
-				       link_tbl->pg_sz);
-			req_a->head_ba_l = cpu_to_le32(entry[0].blk_ba0);
-			req_a->head_ba_h_nxtptr =
-				cpu_to_le32(entry[0].blk_ba1_nxt_ptr);
-			roce_set_field(req_a->head_ptr, CFG_LLM_HEAD_PTR_M,
-				       CFG_LLM_HEAD_PTR_S, 0);
-		} else {
-			req_b->tail_ba_l =
-				cpu_to_le32(entry[page_num - 1].blk_ba0);
-			roce_set_field(req_b->tail_ba_h, CFG_LLM_TAIL_BA_H_M,
-				       CFG_LLM_TAIL_BA_H_S,
-				       entry[page_num - 1].blk_ba1_nxt_ptr &
-					       HNS_ROCE_LINK_TABLE_BA1_M);
-			roce_set_field(req_b->tail_ptr, CFG_LLM_TAIL_PTR_M,
-				       CFG_LLM_TAIL_PTR_S,
-				       (entry[page_num - 2].blk_ba1_nxt_ptr &
-					HNS_ROCE_LINK_TABLE_NXT_PTR_M) >>
-					       HNS_ROCE_LINK_TABLE_NXT_PTR_S);
-		}
 	}
+
+	req_a->base_addr_l = cpu_to_le32(link_tbl->table.map & 0xffffffff);
+	req_a->base_addr_h = cpu_to_le32(link_tbl->table.map >> 32);
+	roce_set_field(req_a->depth_pgsz_init_en, CFG_LLM_QUE_DEPTH_M,
+		       CFG_LLM_QUE_DEPTH_S, link_tbl->npages);
+	roce_set_field(req_a->depth_pgsz_init_en, CFG_LLM_QUE_PGSZ_M,
+		       CFG_LLM_QUE_PGSZ_S, link_tbl->pg_sz);
 	roce_set_field(req_a->depth_pgsz_init_en, CFG_LLM_INIT_EN_M,
 		       CFG_LLM_INIT_EN_S, 1);
+	req_a->head_ba_l = cpu_to_le32(entry[0].blk_ba0);
+	req_a->head_ba_h_nxtptr = cpu_to_le32(entry[0].blk_ba1_nxt_ptr);
+	roce_set_field(req_a->head_ptr, CFG_LLM_HEAD_PTR_M, CFG_LLM_HEAD_PTR_S,
+		       0);
+
+	req_b->tail_ba_l = cpu_to_le32(entry[page_num - 1].blk_ba0);
+	roce_set_field(req_b->tail_ba_h, CFG_LLM_TAIL_BA_H_M,
+		       CFG_LLM_TAIL_BA_H_S,
+		       entry[page_num - 1].blk_ba1_nxt_ptr &
+		       HNS_ROCE_LINK_TABLE_BA1_M);
+	roce_set_field(req_b->tail_ptr, CFG_LLM_TAIL_PTR_M, CFG_LLM_TAIL_PTR_S,
+		       (entry[page_num - 2].blk_ba1_nxt_ptr &
+			HNS_ROCE_LINK_TABLE_NXT_PTR_M) >>
+			HNS_ROCE_LINK_TABLE_NXT_PTR_S);
 
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
-- 
2.8.1

