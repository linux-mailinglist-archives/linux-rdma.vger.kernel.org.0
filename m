Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A491DE793
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 15:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgEVND3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 09:03:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729292AbgEVND2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 May 2020 09:03:28 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D3EFDCC83B7AB3BDFD6E;
        Fri, 22 May 2020 21:03:26 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 22 May 2020 21:03:16 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 4/4] RDMA/hns: Make the end of sge process more clear
Date:   Fri, 22 May 2020 21:02:59 +0800
Message-ID: <1590152579-32364-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1590152579-32364-1-git-send-email-liweihang@huawei.com>
References: <1590152579-32364-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

Instead of i with the sge number of wr will make the comparision more
clear, that is, when the sge number in wr is small than the maximum
supported sge number in the queue, then a stop sge needed to be filled at
the end of sges in wr.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e02afd2..d8b3d86 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -646,7 +646,7 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 			dseg++;
 		}
 
-		if (i < hr_qp->rq.max_gs) {
+		if (wr->num_sge < hr_qp->rq.max_gs) {
 			dseg->lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
 			dseg->addr = 0;
 			dseg->len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
@@ -782,7 +782,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 			dseg[i].addr = cpu_to_le64(wr->sg_list[i].addr);
 		}
 
-		if (i < srq->max_gs) {
+		if (wr->num_sge < srq->max_gs) {
 			dseg[i].len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
 			dseg[i].lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
 			dseg[i].addr = 0;
-- 
2.8.1

