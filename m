Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75971BF589
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD3Kbv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 06:31:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbgD3Kbv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 06:31:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2CF724B4EC816DC9419B;
        Thu, 30 Apr 2020 18:31:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 18:31:39 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Remove redundant assignment of caps
Date:   Thu, 30 Apr 2020 18:31:31 +0800
Message-ID: <1588242691-12913-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588242691-12913-1-git-send-email-liweihang@huawei.com>
References: <1588242691-12913-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

These caps are assigned in query_pf_caps() or set_default_caps(), and
should not be assigned out of these two functions.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7643b06..ad9a11a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2079,11 +2079,6 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	hr_dev->vendor_part_id = hr_dev->pci_dev->device;
 	hr_dev->sys_image_guid = be64_to_cpu(hr_dev->ib_dev.node_guid);
 
-	caps->num_mtt_segs	= HNS_ROCE_V2_MAX_MTT_SEGS;
-	caps->num_cqe_segs	= HNS_ROCE_V2_MAX_CQE_SEGS;
-	caps->num_srqwqe_segs	= HNS_ROCE_V2_MAX_SRQWQE_SEGS;
-	caps->num_idx_segs	= HNS_ROCE_V2_MAX_IDX_SEGS;
-
 	caps->pbl_ba_pg_sz	= HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
 	caps->pbl_buf_pg_sz	= 0;
 	caps->pbl_hop_num	= HNS_ROCE_PBL_HOP_NUM;
-- 
2.8.1

