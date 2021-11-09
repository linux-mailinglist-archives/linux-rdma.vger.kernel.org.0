Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D456844ADB7
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 13:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244529AbhKIMsl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 07:48:41 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15377 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245718AbhKIMsX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 07:48:23 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HpSPR5wxpz90wS;
        Tue,  9 Nov 2021 20:45:15 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:30 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:29 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 2/7] libhns: Remove unsupported QP type
Date:   Tue, 9 Nov 2021 20:40:58 +0800
Message-ID: <20211109124103.54326-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109124103.54326-1-liangwenpeng@huawei.com>
References: <20211109124103.54326-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, user space does not support UC type QP.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 providers/hns/hns_roce_u_hw_v1.c | 1 -
 providers/hns/hns_roce_u_hw_v2.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/providers/hns/hns_roce_u_hw_v1.c b/providers/hns/hns_roce_u_hw_v1.c
index 5385d1c4..ef346424 100644
--- a/providers/hns/hns_roce_u_hw_v1.c
+++ b/providers/hns/hns_roce_u_hw_v1.c
@@ -539,7 +539,6 @@ static int hns_roce_u_v1_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			ctrl->flag |= htole32(ps_opcode);
 			wqe  += sizeof(struct hns_roce_wqe_raddr_seg);
 			break;
-		case IBV_QPT_UC:
 		case IBV_QPT_UD:
 		default:
 			break;
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 66ecd84a..1e8df6ef 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -460,8 +460,7 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 					struct hns_roce_qp **cur_qp,
 					struct ibv_wc *wc, uint32_t opcode)
 {
-	if (((*cur_qp)->verbs_qp.qp.qp_type == IBV_QPT_RC ||
-	     (*cur_qp)->verbs_qp.qp.qp_type == IBV_QPT_UC) &&
+	if (((*cur_qp)->verbs_qp.qp.qp_type == IBV_QPT_RC) &&
 	    (opcode == HNS_ROCE_RECV_OP_SEND ||
 	     opcode == HNS_ROCE_RECV_OP_SEND_WITH_IMM ||
 	     opcode == HNS_ROCE_RECV_OP_SEND_WITH_INV) &&
-- 
2.33.0

