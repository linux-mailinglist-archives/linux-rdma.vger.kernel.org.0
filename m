Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7136262B24
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 10:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgIII64 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 04:58:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729992AbgIII6x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 04:58:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A097F9918155E5C4F55E;
        Wed,  9 Sep 2020 16:58:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 16:58:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 6/9] RDMA/hns: Solve the overflow of the calc_pg_sz()
Date:   Wed, 9 Sep 2020 16:57:31 +0800
Message-ID: <1599641854-23160-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jiaran Zhang <zhangjiaran@huawei.com>

calc_pg_sz() may gets a data calculation overflow if the PAGE_SIZE is 64 KB
and hop_num is 2. It is because that all variables involved in calculation
are defined in type of int. So change the type of bt_chunk_size,
buf_chunk_size and obj_per_chunk_default to u64.

Fixes: ba6bb7e97421 ("RDMA/hns: Add interfaces to get pf capabilities from firmware")
Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 01aabb7..af2dea1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1804,9 +1804,9 @@ static void calc_pg_sz(int obj_num, int obj_size, int hop_num, int ctx_bt_num,
 		       int *buf_page_size, int *bt_page_size, u32 hem_type)
 {
 	u64 obj_per_chunk;
-	int bt_chunk_size = 1 << PAGE_SHIFT;
-	int buf_chunk_size = 1 << PAGE_SHIFT;
-	int obj_per_chunk_default = buf_chunk_size / obj_size;
+	u64 bt_chunk_size = 1 << PAGE_SHIFT;
+	u64 buf_chunk_size = 1 << PAGE_SHIFT;
+	u64 obj_per_chunk_default = buf_chunk_size / obj_size;
 
 	*buf_page_size = 0;
 	*bt_page_size = 0;
-- 
2.8.1

