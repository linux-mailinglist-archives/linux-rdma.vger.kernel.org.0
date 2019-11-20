Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380CD103B34
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 14:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfKTNXI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 08:23:08 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:48440 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730146AbfKTNXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 08:23:07 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKDLUOb000412;
        Wed, 20 Nov 2019 05:23:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=I8WotPkBXAy/27+KakBfYjKQw40op12FsfifnddDoKk=;
 b=UuKcAcuH4nk4XxLBAkhFs/jOw1z4u6nMbaXemG8o6LdSGTlcEKpJF8dVqN9slQdI1DNk
 LpTzq3JkRq7ZRsFzZqb/3hAuKu7+7osOPiMcdMBvaujP6+FKPp8BrWtNLjSy5Dcr++H6
 dyekKy8KXmombwUeAS8dgmm+xKvkZPcY0APMZae8uCQrXqMLViFhLyY22iCIkn2YBCra
 qL7iJD5i3t9FkGBv1yvjtuciRaRnKT5eJYiqmEu8s+rfslJtP6cnVMV9lNl/Pwl6xHd2
 hq5eGdU9ws1ac6ub0EDgc6GAD0TOM0UgByXLkfXjxPJChWYzm9mB3qbg7rIvC2MhMHDS Uw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wd090sgk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 05:23:02 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Nov
 2019 05:23:01 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 20 Nov 2019 05:23:01 -0800
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id AEA3B3F703F;
        Wed, 20 Nov 2019 05:22:59 -0800 (PST)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA/qedr: Add kernel capability flags for dpm enabled mode
Date:   Wed, 20 Nov 2019 15:20:09 +0200
Message-ID: <20191120132009.14107-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_03:2019-11-15,2019-11-20 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HW/FW support two types of latency enhancement features.
Until now user-space implemented only edpm (enhanced dpm).
We add kernel capability flags to differentiate between current
FW in kernel that supports both ldpm and edpm.
Since edpm is not yet supported for iWARP we add different flags
for iWARP + RoCE.
We also fix bad practice of defining sizes in rdma-core and pass
initialization to kernel, for forward compatibility.

The capability flags are added for backward-forward compatibility
between kernel and rdma-core for qedr.

Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
rdma-core changes in pr #622 https://github.com/linux-rdma/rdma-core/pull/622
---
 drivers/infiniband/hw/qedr/verbs.c | 13 ++++++++++++-
 include/uapi/rdma/qedr-abi.h       | 18 ++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 8096b8fcab4e..54cce8969594 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -312,7 +312,18 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	}
 	ctx->db_mmap_entry = &entry->rdma_entry;
 
-	uresp.dpm_enabled = dev->user_dpm_enabled;
+	if (!dev->user_dpm_enabled)
+		uresp.dpm_flags = 0;
+	else if (rdma_protocol_iwarp(&dev->ibdev, 1))
+		uresp.dpm_flags = QEDR_DPM_TYPE_IWARP_LEGACY;
+	else
+		uresp.dpm_flags = QEDR_DPM_TYPE_ROCE_ENHANCED |
+				  QEDR_DPM_TYPE_ROCE_LEGACY;
+
+	uresp.dpm_flags |= QEDR_DPM_SIZES_SET;
+	uresp.ldpm_limit_size = QEDR_LDPM_MAX_SIZE;
+	uresp.edpm_trans_size = QEDR_EDPM_TRANS_SIZE;
+
 	uresp.wids_enabled = 1;
 	uresp.wid_count = oparams.wid_count;
 	uresp.db_pa = rdma_user_mmap_get_offset(ctx->db_mmap_entry);
diff --git a/include/uapi/rdma/qedr-abi.h b/include/uapi/rdma/qedr-abi.h
index c022ee26089b..a0b83c9d4498 100644
--- a/include/uapi/rdma/qedr-abi.h
+++ b/include/uapi/rdma/qedr-abi.h
@@ -48,6 +48,18 @@ struct qedr_alloc_ucontext_req {
 	__u32 reserved;
 };
 
+#define QEDR_LDPM_MAX_SIZE	(8192)
+#define QEDR_EDPM_TRANS_SIZE	(64)
+
+enum qedr_rdma_dpm_type {
+	QEDR_DPM_TYPE_NONE		= 0,
+	QEDR_DPM_TYPE_ROCE_ENHANCED	= 1 << 0,
+	QEDR_DPM_TYPE_ROCE_LEGACY	= 1 << 1,
+	QEDR_DPM_TYPE_IWARP_LEGACY	= 1 << 2,
+	QEDR_DPM_TYPE_RESERVED		= 1 << 3,
+	QEDR_DPM_SIZES_SET		= 1 << 4,
+};
+
 struct qedr_alloc_ucontext_resp {
 	__aligned_u64 db_pa;
 	__u32 db_size;
@@ -59,10 +71,12 @@ struct qedr_alloc_ucontext_resp {
 	__u32 sges_per_recv_wr;
 	__u32 sges_per_srq_wr;
 	__u32 max_cqes;
-	__u8 dpm_enabled;
+	__u8 dpm_flags;
 	__u8 wids_enabled;
 	__u16 wid_count;
-	__u32 reserved;
+	__u16 ldpm_limit_size;
+	__u8 edpm_trans_size;
+	__u8 reserved;
 };
 
 struct qedr_alloc_pd_ureq {
-- 
2.14.5

