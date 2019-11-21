Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0674A105178
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 12:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfKULc4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 06:32:56 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53934 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726170AbfKULcz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 06:32:55 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALBURJt021453;
        Thu, 21 Nov 2019 03:32:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=LjOA9XpJJVbAIJpLOdFdZtBym/eOwFyvOmlar6alpj0=;
 b=NOOokDwgWqd9CrWQgDKZcXZmAqkBTJT+GzBFkCan88lF1QMvtg547FNXAL/eY49OBmY3
 +3Nq00GEH3RKSpWyHGH1LwSRWqY3dparsxlAg3L/DXzcvQfIiJRWzlj9Njy8CI38O/bI
 1wWAIK3pOSdm+LLl5+v/yz009a15zEwCivvukgiXv4+Z7DJhEFQzV5nE4GKXhwX71mLP
 Or1uiXx/NvU32stMGS3gVFt5UtwWmuM67riKbaP+dWN5/t3lIgYFLNbj8yPaeLtGnCW8
 cYdh2vcZTsXB/JJS+5OWhzLshZ90mMs47gQYV9Twb9UF9Ske+VV3PIopti8jOjlTq+dB XA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wd090xead-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 03:32:52 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 21 Nov
 2019 03:32:50 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 21 Nov 2019 03:32:50 -0800
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 125EA3F703F;
        Thu, 21 Nov 2019 03:32:48 -0800 (PST)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v2 rdma-next] RDMA/qedr: Add kernel capability flags for dpm enabled mode
Date:   Thu, 21 Nov 2019 13:29:57 +0200
Message-ID: <20191121112957.25162-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_02:2019-11-21,2019-11-21 signatures=0
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
Before this change there was a field called dpm_enabled which could
hold either 0 or 1 value, this indicated whether RoCE edpm was
enabled or not. We modified this field to be dpm_flags, and bit 1
still holds the same meaning of RoCE edpm being enabled or not.

Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
rdma-core changes in pr #622 https://github.com/linux-rdma/rdma-core/pull/622
Changes from V1:
	Add better description in commit message of how
backward-compatibility is maintained
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

