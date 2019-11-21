Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651ED104804
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 02:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfKUBXF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 20:23:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727121AbfKUBXF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 20:23:05 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2D982E0C53144B1BB534;
        Thu, 21 Nov 2019 09:23:04 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 21 Nov 2019 09:22:53 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH rdma-core 7/7] libhns: Return correct value of cqe num when flushing cqe failed
Date:   Thu, 21 Nov 2019 09:19:29 +0800
Message-ID: <1574299169-31457-8-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
References: <1574299169-31457-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

When flushing cqe failed, it will return a error code to
hns_roce_v2_poll_one() and no longer update cqe number which is necessary
for ULPs, that will lead to a process suspension.
Because error code of flush cqe is meaningless for ULPs, so we delete it.

Fixes: 321ec6d04c0b ("libhns: Package for polling cqe function")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u_hw_v2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 64dea8e..a8d3d11 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -287,10 +287,9 @@ static int hns_roce_flush_cqe(struct hns_roce_qp **cur_qp, struct ibv_wc *wc)
 		attr.qp_state = IBV_QPS_ERR;
 		ret = hns_roce_u_v2_modify_qp(&(*cur_qp)->ibv_qp,
 						      &attr, attr_mask);
-		if (ret) {
+		if (ret)
 			fprintf(stderr, PFX "failed to modify qp!\n");
-			return ret;
-		}
+
 		(*cur_qp)->ibv_qp.state = IBV_QPS_ERR;
 	}
 
-- 
2.8.1

