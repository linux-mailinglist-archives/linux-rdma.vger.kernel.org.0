Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C216F43845A
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Oct 2021 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhJWQsp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Oct 2021 12:48:45 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:21282 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229901AbhJWQsp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 23 Oct 2021 12:48:45 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19NFULLj001216;
        Sat, 23 Oct 2021 09:46:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=CspJnlx/4s7FlTIJhOjVdfjbZzcDdj+NKJesK81XBv8=;
 b=QghvLVQ9CRUkIlkutzwgE3rZHz4YPHHeYe2OoD6iDitKwvdviHQMyHUncw6lOEHdd9vB
 ioY2a4PP3rOmeQViZhuN6OPl2ot5RBUNZLQIiBFGHk0Remkr19uiOMiXbxue3kHYhWZK
 BeJot3waP2t+7/Szukh2+czDRG27+CpbZwaJ5wSRCMAxel/5oYZFXOlbbNYq5p4KowQ2
 eAlUbDjnnfXRQX42Ayq7TWpIV9cAretIf/srEM5YuzZkDX11gILKfB+946q3H/HQyMjF
 UCV/1a+hKhs5Jw7xSt7QjiJZDCpFz88bAB3NYs7q70TSV3g2S+S0bYeLdzWtvy81RbkE MA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bvfrqs0yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 23 Oct 2021 09:46:21 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 23 Oct
 2021 09:46:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sat, 23 Oct 2021 09:46:20 -0700
Received: from alpha-dell-r720.punelab.qlogic.com032qlogic.org032qlogic.com032mv.qlogic.com032av.na032marvell.com (unknown [10.30.46.139])
        by maili.marvell.com (Postfix) with ESMTP id 1FF8A3F707D;
        Sat, 23 Oct 2021 09:46:16 -0700 (PDT)
From:   Alok Prasad <palok@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>
CC:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <linux-rdma@vger.kernel.org>, <smalin@marvell.com>,
        <aelior@marvell.com>, <palok@marvell.com>,
        <alok.prasad7@gmail.com>, Michal Kalderon <mkalderon@marvell.com>
Subject: [v2,for-rc] RDMA/qedr: qedr crash while running rdma-tool
Date:   Sat, 23 Oct 2021 16:45:57 +0000
Message-ID: <20211023164557.7921-1-palok@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: tPa241cXzzsZKUd_hXqd0MZjVK9w9V6l
X-Proofpoint-ORIG-GUID: tPa241cXzzsZKUd_hXqd0MZjVK9w9V6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-23_03,2021-10-22_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch fixes crash caused by querying qp.
Also corrects the state of gsi qp.

Below call trace is generated while using iproute2 utility
"rdma res show -dd qp" on rdma interface.
==========================================================================
[  302.569794] BUG: kernel NULL pointer dereference, address: 0000000000000034
..
[  302.570378] Hardware name: Dell Inc. PowerEdge R720/0M1GCR, BIOS 1.2.6 05/10/2012
[  302.570500] RIP: 0010:qed_rdma_query_qp+0x33/0x1a0 [qed]
[  302.570861] RSP: 0018:ffffba560a08f580 EFLAGS: 00010206
[  302.570979] RAX: 0000000200000000 RBX: ffffba560a08f5b8 RCX: 0000000000000000
[  302.571100] RDX: ffffba560a08f5b8 RSI: 0000000000000000 RDI: ffff9807ee458090
[  302.571221] RBP: ffffba560a08f5a0 R08: 0000000000000000 R09: ffff9807890e7048
[  302.571342] R10: ffffba560a08f658 R11: 0000000000000000 R12: 0000000000000000
[  302.571462] R13: ffff9807ee458090 R14: ffff9807f0afb000 R15: ffffba560a08f7ec
[  302.571583] FS:  00007fbbf8bfe740(0000) GS:ffff980aafa00000(0000) knlGS:0000000000000000
[  302.571729] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  302.571847] CR2: 0000000000000034 CR3: 00000001720ba001 CR4: 00000000000606f0
[  302.571968] Call Trace:
[  302.572083]  qedr_query_qp+0x82/0x360 [qedr]
[  302.572211]  ib_query_qp+0x34/0x40 [ib_core]
[  302.572361]  ? ib_query_qp+0x34/0x40 [ib_core]
[  302.572503]  fill_res_qp_entry_query.isra.26+0x47/0x1d0 [ib_core]
[  302.572670]  ? __nla_put+0x20/0x30
[  302.572788]  ? nla_put+0x33/0x40
[  302.572901]  fill_res_qp_entry+0xe3/0x120 [ib_core]
[  302.573058]  res_get_common_dumpit+0x3f8/0x5d0 [ib_core]
[  302.573213]  ? fill_res_cm_id_entry+0x1f0/0x1f0 [ib_core]
[  302.573377]  nldev_res_get_qp_dumpit+0x1a/0x20 [ib_core]
[  302.573529]  netlink_dump+0x156/0x2f0
[  302.573648]  __netlink_dump_start+0x1ab/0x260
[  302.573765]  rdma_nl_rcv+0x1de/0x330 [ib_core]
[  302.573918]  ? nldev_res_get_cm_id_dumpit+0x20/0x20 [ib_core]
[  302.574074]  netlink_unicast+0x1b8/0x270
[  302.574191]  netlink_sendmsg+0x33e/0x470
[  302.574307]  sock_sendmsg+0x63/0x70
[  302.574421]  __sys_sendto+0x13f/0x180
[  302.574536]  ? setup_sgl.isra.12+0x70/0xc0
[  302.574655]  __x64_sys_sendto+0x28/0x30
[  302.574769]  do_syscall_64+0x3a/0xb0
[  302.574884]  entry_SYSCALL_64_after_hwframe+0x44/0xae
==========================================================================
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Alok Prasad <palok@marvell.com>
---
v2 (from [1]):
	- Change description.
	- Corrected enum type.
[1] https://patchwork.kernel.org/project/linux-rdma/patch/20210821074339.16614-1-palok@marvell.com/
---
 drivers/infiniband/hw/qedr/verbs.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index dcb3653db72d..85baa4f730df 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2744,15 +2744,20 @@ int qedr_query_qp(struct ib_qp *ibqp,
 	int rc = 0;
 
 	memset(&params, 0, sizeof(params));
+	memset(qp_attr, 0, sizeof(*qp_attr));
+	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
 
-	rc = dev->ops->rdma_query_qp(dev->rdma_ctx, qp->qed_qp, &params);
+	if (qp->qed_qp)
+		rc = dev->ops->rdma_query_qp(dev->rdma_ctx,
+					     qp->qed_qp, &params);
 	if (rc)
 		goto err;
 
-	memset(qp_attr, 0, sizeof(*qp_attr));
-	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
+	if (qp->qp_type == IB_QPT_GSI)
+		qp_attr->qp_state = qedr_get_ibqp_state(QED_ROCE_QP_STATE_RTS);
+	else
+		qp_attr->qp_state = qedr_get_ibqp_state(params.state);
 
-	qp_attr->qp_state = qedr_get_ibqp_state(params.state);
 	qp_attr->cur_qp_state = qedr_get_ibqp_state(params.state);
 	qp_attr->path_mtu = ib_mtu_int_to_enum(params.mtu);
 	qp_attr->path_mig_state = IB_MIG_MIGRATED;
-- 
2.17.1

