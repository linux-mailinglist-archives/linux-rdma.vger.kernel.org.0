Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEEDE2D32
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 11:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408818AbfJXJZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 05:25:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390225AbfJXJZi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 05:25:38 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 38F6FDCBD149FB8FF805;
        Thu, 24 Oct 2019 17:25:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 24 Oct 2019 17:25:26 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-rc 1/2] RDMA/hns: Fix to support 64K page for srq
Date:   Thu, 24 Oct 2019 17:21:56 +0800
Message-ID: <1571908917-16220-2-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1571908917-16220-1-git-send-email-liweihang@hisilicon.com>
References: <1571908917-16220-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

SRQ's page size configuration of BA and buffer should depend on current
PAGE_SHIFT, or it can't work in scenario of 64K page.

Fixes: c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7a89d66..d70a784 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6092,11 +6092,11 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_M,
 		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_S,
-		       hr_dev->caps.idx_ba_pg_sz);
+		       hr_dev->caps.idx_ba_pg_sz + PG_SHIFT_OFFSET);
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_M,
 		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_S,
-		       hr_dev->caps.idx_buf_pg_sz);
+		       hr_dev->caps.idx_buf_pg_sz + PG_SHIFT_OFFSET);
 
 	srq_context->idx_nxt_blk_addr =
 		cpu_to_le32(mtts_idx[1] >> PAGE_ADDR_SHIFT);
-- 
2.8.1

