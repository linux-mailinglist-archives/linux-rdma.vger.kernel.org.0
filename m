Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544092C6977
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 17:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbgK0QdV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 11:33:21 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:14132 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730603AbgK0QdV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Nov 2020 11:33:21 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARGV751005391;
        Fri, 27 Nov 2020 08:33:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=edH7yror7E0yEjryvccCCPyQpRQ6ieeYKf5Ww4gUSVs=;
 b=Pyeyp3qAYlmz/C4+uh6jaDf13U+jSUHTlp7SqgzCvpe6Pgo0h2R8N8lLN/XCRqqVD9Tz
 5pfdRIwv4xvu1pXHcsNdpIo03s/etV53RBdw1TyHo4G27CdVdNSmKTJNsvPEQHX8pTp8
 uCH5wgPyXX2XIOfllOgqfpXyvTSVm8g/T7j2Ec2edEBF3vID5bEXbuhxjViE/8eXW1pA
 m/m4962AcEXwy9dH36Jf7C+cbJ3ucy2ZBSCLqs2x1Y3G0T/0vw7PrhalKUOr4GjeVWNm
 0JHoo4llmox9uhzi8tAfIPytA+tTM0z/8VOgFgxcWGQEhIX9v7cnehyIJV19S8aQE8rb Qw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 351muf8qwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 08:33:18 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Nov
 2020 08:33:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 08:33:17 -0800
Received: from alpha-dell-r720.punelab.qlogic.com032qlogic.org032qlogic.com032mv.qlogic.com032av.na032marvell.com (unknown [10.30.45.91])
        by maili.marvell.com (Postfix) with ESMTP id 042133F703F;
        Fri, 27 Nov 2020 08:33:14 -0800 (PST)
From:   Alok Prasad <palok@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>
CC:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <linux-rdma@vger.kernel.org>, Alok Prasad <palok@marvell.com>,
        "Michal Kalderon" <mkalderon@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>
Subject: [PATCH v2,for-rc] RDMA/qedr: iWARP invalid(zero) doorbell address fix.
Date:   Fri, 27 Nov 2020 16:32:51 +0000
Message-ID: <20201127163251.14533-1-palok@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_10:2020-11-26,2020-11-27 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch fixes issue introduced by a previous commit
where iWARP doorbell address wasn't initialized, causing
call trace when any RDMA application wants to use this
interface.

Below call trace is generated which using rping with the
iWARP interface.

==========================================================
[  325.698218] Illegal doorbell address: 0000000000000000. Legal range for doorbell addresses is [0000000011431e08..00000000ec3799d3]
[  325.752691] WARNING: CPU: 11 PID: 11990 at drivers/net/ethernet/qlogic/qed/qed_dev.c:93 qed_db_rec_sanity.isra.12+0x48/0x70 [qed]
....
[  325.807824]  hpsa scsi_transport_sas [last unloaded: crc8]
[  326.263195] CPU: 11 PID: 11990 Comm: rping Tainted: G S                5.10.0-rc1 #29
[  326.299616] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 01/22/2018
[  326.337657] RIP: 0010:qed_db_rec_sanity.isra.12+0x48/0x70 [qed]
...
[  326.451186] RSP: 0018:ffffafc28458fa88 EFLAGS: 00010286
[  326.475309] RAX: 0000000000000000 RBX: ffff8d0d4c620000 RCX: 0000000000000000
[  326.508079] RDX: ffff8d10afde7d50 RSI: ffff8d10afdd8b40 RDI: ffff8d10afdd8b40
[  326.540849] RBP: ffffafc28458fe38 R08: 0000000000000003 R09: 0000000000007fff
[  326.573671] R10: 0000000000000001 R11: ffffafc28458f888 R12: 0000000000000000
[  326.606521] R13: 0000000000000000 R14: ffff8d0d43ccbbd0 R15: ffff8d0d48dae9c0
[  326.639406] FS:  00007fbd5267e740(0000) GS:ffff8d10afdc0000(0000) knlGS:0000000000000000
[  326.677896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  326.704634] CR2: 00007fbd4f258fb8 CR3: 0000000108d96003 CR4: 00000000001706e0
[  326.737465] Call Trace:
[  326.748839]  qed_db_recovery_add+0x6d/0x1f0 [qed]
[  326.770705]  qedr_create_user_qp+0x57e/0xd30 [qedr]
[  326.793350]  qedr_create_qp+0x5f3/0xab0 [qedr]
[  326.813750]  ? lookup_get_idr_uobject.part.12+0x45/0x90 [ib_uverbs]
[  326.842565]  create_qp+0x45d/0xb30 [ib_uverbs]
[  326.862998]  ? ib_uverbs_cq_event_handler+0x30/0x30 [ib_uverbs]
[  326.890237]  ib_uverbs_create_qp+0xb9/0xe0 [ib_uverbs]
[  326.913855]  ib_uverbs_write+0x3f9/0x570 [ib_uverbs]
[  326.936679]  ? security_mmap_file+0x62/0xe0
[  326.955889]  vfs_write+0xb7/0x200
[  326.971088]  ksys_write+0xaf/0xd0
[  326.986314]  ? syscall_trace_enter.isra.25+0x152/0x200
[  327.009948]  do_syscall_64+0x2d/0x40
[  327.026752]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
==============================================================

Fixes: 06e8d1df46ed ("RDMA/qedr: Add support for user mode XRC-SRQ's")
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Alok Prasad <palok@marvell.com>
---
v2 (from [1]):
 - Added call trace in commit message.
[1] https://patchwork.kernel.org/project/linux-rdma/patch/20201127090832.11191-1-palok@marvell.com/
---
 drivers/infiniband/hw/qedr/verbs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 019642ff24a7..511c95bb3d01 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1936,6 +1936,15 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	}
 
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
+		qp->urq.db_rec_db2_addr = ctx->dpi_addr + uresp.rq_db2_offset;
+
+		/* calculate the db_rec_db2 data since it is constant so no
+		 * need to reflect from user
+		 */
+		qp->urq.db_rec_db2_data.data.icid = cpu_to_le16(qp->icid);
+		qp->urq.db_rec_db2_data.data.value =
+			cpu_to_le16(DQ_TCM_IWARP_POST_RQ_CF_CMD);
+
 		rc = qedr_db_recovery_add(dev, qp->urq.db_rec_db2_addr,
 					  &qp->urq.db_rec_db2_data,
 					  DB_REC_WIDTH_32B,
-- 
2.27.0

