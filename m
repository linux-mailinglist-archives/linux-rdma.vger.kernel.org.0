Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269E5104803
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 02:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKUBXC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 20:23:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7157 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727121AbfKUBXC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 20:23:02 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 31D192F67568348E7670;
        Thu, 21 Nov 2019 09:22:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 21 Nov 2019 09:22:52 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH rdma-core 5/7] libhns: Bugfix for updating qp params
Date:   Thu, 21 Nov 2019 09:19:27 +0800
Message-ID: <1574299169-31457-6-git-send-email-liweihang@hisilicon.com>
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

From: Lijun Ou <oulijun@huawei.com>

In hns_roce_u_create_qp(), it's necessary to update rq params after
ibv_cmd_create_qp() running successfully, and then we will use it when
posting work request.

Fixes: b6cd213b276f ("libhns: Refactor for creating qp")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u_verbs.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 0acfd9a..a9c78f8 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -771,19 +771,14 @@ static void hns_roce_set_qp_params(struct ibv_pd *pd,
 	}
 
 	/* limit by the context queried during alloc context */
-	qp->rq.max_post = min(ctx->max_qp_wr, qp->rq.wqe_cnt);
 	qp->sq.max_post = min(ctx->max_qp_wr, qp->sq.wqe_cnt);
 	qp->sq.max_gs = min(ctx->max_sge, qp->sq.max_gs);
-	qp->rq.max_gs = min(ctx->max_sge, qp->rq.max_gs);
 
 	qp->sq_signal_bits = attr->sq_sig_all ? 0 : 1;
-	qp->max_inline_data  = HNS_ROCE_MAX_INLINE_DATA_LEN;
+	qp->max_inline_data = HNS_ROCE_MAX_INLINE_DATA_LEN;
 
 	/* update attr for creating qp */
 	attr->cap.max_send_wr = qp->sq.max_post;
-	attr->cap.max_recv_wr = qp->rq.max_post;
-	attr->cap.max_send_sge = qp->sq.max_gs;
-	attr->cap.max_recv_sge = qp->rq.max_gs;
 	attr->cap.max_inline_data = qp->max_inline_data;
 }
 
@@ -906,7 +901,14 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 	}
 	pthread_mutex_unlock(&context->qp_table_mutex);
 
-	qp->flags	= resp.cap_flags;
+	/* adjust rq maxima to not exceed reported device maxima */
+	attr->cap.max_recv_wr = min(context->max_qp_wr, attr->cap.max_recv_wr);
+	attr->cap.max_recv_sge = min(context->max_sge, attr->cap.max_recv_sge);
+	qp->rq.wqe_cnt = attr->cap.max_recv_wr;
+	qp->rq.max_gs = attr->cap.max_recv_sge;
+	qp->rq.max_post = attr->cap.max_recv_wr;
+
+	qp->flags = resp.cap_flags;
 
 	return &qp->ibv_qp;
 
-- 
2.8.1

