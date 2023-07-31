Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AE17690D9
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 10:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjGaIyA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 04:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjGaIxM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 04:53:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3DE1A4
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 01:51:57 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RDsPy1rJQzVjqT;
        Mon, 31 Jul 2023 16:50:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 16:51:55 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <selvin.xavier@broadcom.com>,
        <mkalderon@marvell.com>, <aelior@marvell.com>, <trix@redhat.com>,
        <linux-rdma@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] RDMA: Remove unnecessary ternary operators
Date:   Mon, 31 Jul 2023 16:51:18 +0800
Message-ID: <20230731085118.394443-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ther are a little ternary operators, the true or false judgement
of which is unnecessary in C language semantics.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/infiniband/core/netlink.c           | 2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
 drivers/infiniband/hw/qedr/verbs.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/netlink.c b/drivers/infiniband/core/netlink.c
index 1b2cc9e45ade..ae2db0c70788 100644
--- a/drivers/infiniband/core/netlink.c
+++ b/drivers/infiniband/core/netlink.c
@@ -75,7 +75,7 @@ static bool is_nl_msg_valid(unsigned int type, unsigned int op)
 	if (type >= RDMA_NL_NUM_CLIENTS)
 		return false;
 
-	return (op < max_num_ops[type]) ? true : false;
+	return op < max_num_ops[type];
 }
 
 static const struct rdma_nl_cbs *
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 879acfa64a35..4dd1af37ccab 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2252,7 +2252,7 @@ static int bnxt_re_build_qp1_send_v2(struct bnxt_re_qp *qp,
 	}
 
 	is_eth = true;
-	is_vlan = (vlan_id && (vlan_id < 0x1000)) ? true : false;
+	is_vlan = vlan_id && (vlan_id < 0x1000);
 
 	ib_ud_header_init(payload_size, !is_eth, is_eth, is_vlan, is_grh,
 			  ip_version, is_udp, 0, &qp->qp1_hdr);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 58f994341e9a..c849fdbd4c99 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1277,7 +1277,7 @@ static void ocrdma_set_qp_init_params(struct ocrdma_qp *qp,
 	qp->sq.max_sges = attrs->cap.max_send_sge;
 	qp->rq.max_sges = attrs->cap.max_recv_sge;
 	qp->state = OCRDMA_QPS_RST;
-	qp->signaled = (attrs->sq_sig_type == IB_SIGNAL_ALL_WR) ? true : false;
+	qp->signaled = attrs->sq_sig_type == IB_SIGNAL_ALL_WR;
 }
 
 static void ocrdma_store_gsi_qp_cq(struct ocrdma_dev *dev,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index d745ce9dc88a..7887a6786ed4 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1358,7 +1358,7 @@ static void qedr_set_common_qp_params(struct qedr_dev *dev,
 
 	qp->prev_wqe_size = 0;
 
-	qp->signaled = (attrs->sq_sig_type == IB_SIGNAL_ALL_WR) ? true : false;
+	qp->signaled = attrs->sq_sig_type == IB_SIGNAL_ALL_WR;
 	qp->dev = dev;
 	if (qedr_qp_has_sq(qp)) {
 		qedr_reset_qp_hwq_info(&qp->sq);
-- 
2.34.1

