Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDAEA129F03
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2019 09:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfLXIdE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Dec 2019 03:33:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbfLXIdE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Dec 2019 03:33:04 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 77297572CD44CBE6B03C;
        Tue, 24 Dec 2019 16:33:01 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 16:32:52 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <bmt@zurich.ibm.com>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 4/5] RDMA/mlx4: use true,false for bool variable
Date:   Tue, 24 Dec 2019 16:40:11 +0800
Message-ID: <1577176812-2238-5-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
References: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes coccicheck warning:

drivers/infiniband/hw/mlx4/qp.c:852:2-14: WARNING: Assignment of 0/1 to bool variable
drivers/infiniband/hw/mlx4/qp.c:3087:3-10: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 85f57b7..8d240bc 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -849,7 +849,7 @@ static void mlx4_ib_release_wqn(struct mlx4_ib_ucontext *context,
 	 * reused for further WQN allocations.
 	 * The next created WQ will allocate a new range.
 	 */
-		range->dirty = 1;
+		range->dirty = true;
 	}

 	mutex_unlock(&context->wqn_ranges_mutex);
@@ -3084,7 +3084,7 @@ static int build_mlx_header(struct mlx4_ib_sqp *sqp, const struct ib_ud_wr *wr,
 		}
 		if (ah->av.eth.vlan != cpu_to_be16(0xffff)) {
 			vlan = be16_to_cpu(ah->av.eth.vlan) & 0x0fff;
-			is_vlan = 1;
+			is_vlan = true;
 		}
 	}
 	err = ib_ud_header_init(send_size, !is_eth, is_eth, is_vlan, is_grh,
--
2.7.4

