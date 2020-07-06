Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6E215F66
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 21:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgGFTcc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 15:32:32 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5078 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725895AbgGFTcc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 15:32:32 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066JU97h002839;
        Mon, 6 Jul 2020 12:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=Es1Zm2bKqBQFvks1HP50LMLzi0K+zrOOg5bpWO79ru8=;
 b=DlOzceuW/AjZcw+B+UykFxgVZcHCyNhJgKDw5UNHn22p9+mltDLJ22XLIPZZbJGk8I6O
 CUj8lqLNk/326nZGsQgRQNwM0ke0+2jBajZgt06X8FD3ECEkKoflOjbnDz+jZqoXQQ0W
 lWue0iURZl4AE19npyIQqm6tlSvi6EipgDE+RKeB0A0bvKgh9fFDaUOkEh0pE9K0g2wB
 cArR3M943YiT7hRWtBl4MtfLTWJ3htDKcJSIqekvwUvgfCDCJ0xkpQHx35yX+bqpn/jh
 VPWpghjOsM9k0higTiKa0b/vkXhBbNYHv+deQo5qAJw4fA/LLFERZ9/Q/2MPRGlCYrIz Ew== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 322s9n7rf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 12:32:30 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 Jul
 2020 12:32:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 12:32:28 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id A12343F703F;
        Mon,  6 Jul 2020 12:32:26 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>, <aelior@marvell.com>,
        <ybason@marvell.com>, <mkalderon@marvell.com>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v2 rdma-next 2/2] RDMA/qedr: Add EDPM max size to alloc ucontext response
Date:   Mon, 6 Jul 2020 22:32:14 +0300
Message-ID: <20200706193214.19942-3-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200706193214.19942-1-michal.kalderon@marvell.com>
References: <20200706193214.19942-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_19:2020-07-06,2020-07-06 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

User space should receive the maximum edpm size from kernel
driver, similar to other edpm/ldpm related limits.
Add an additional parameter to the alloc_ucontext_resp
structure for the edpm maximum size.

In addition, pass an indication from user-space to kernel
(and not just kernel to user) that the DPM sizes are supported.

This is for supporting backward-forward compatibility between driver and
lib for everything related to DPM transaction and limit sizes.

This should have been part of commit mentioned in Fixes tag.
Fixes: 93a3d05f9d68 ("RDMA/qedr: Add kernel capability flags for dpm
enabled mode")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 9 ++++++---
 include/uapi/rdma/qedr-abi.h       | 6 +++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index fbb0c66c7f2c..f03178866b50 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -320,9 +320,12 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 				  QEDR_DPM_TYPE_ROCE_LEGACY |
 				  QEDR_DPM_TYPE_ROCE_EDPM_MODE;
 
-	uresp.dpm_flags |= QEDR_DPM_SIZES_SET;
-	uresp.ldpm_limit_size = QEDR_LDPM_MAX_SIZE;
-	uresp.edpm_trans_size = QEDR_EDPM_TRANS_SIZE;
+	if (!!(ureq.context_flags & QEDR_SUPPORT_DPM_SIZES)) {
+		uresp.dpm_flags |= QEDR_DPM_SIZES_SET;
+		uresp.ldpm_limit_size = QEDR_LDPM_MAX_SIZE;
+		uresp.edpm_trans_size = QEDR_EDPM_TRANS_SIZE;
+		uresp.edpm_limit_size = QEDR_EDPM_MAX_SIZE;
+	}
 
 	uresp.wids_enabled = 1;
 	uresp.wid_count = oparams.wid_count;
diff --git a/include/uapi/rdma/qedr-abi.h b/include/uapi/rdma/qedr-abi.h
index b261c9fca07b..bf7333b2b5d7 100644
--- a/include/uapi/rdma/qedr-abi.h
+++ b/include/uapi/rdma/qedr-abi.h
@@ -40,7 +40,8 @@
 /* user kernel communication data structures. */
 enum qedr_alloc_ucontext_flags {
 	QEDR_ALLOC_UCTX_EDPM_MODE	= 1 << 0,
-	QEDR_ALLOC_UCTX_DB_REC		= 1 << 1
+	QEDR_ALLOC_UCTX_DB_REC		= 1 << 1,
+	QEDR_SUPPORT_DPM_SIZES		= 1 << 2,
 };
 
 struct qedr_alloc_ucontext_req {
@@ -50,6 +51,7 @@ struct qedr_alloc_ucontext_req {
 
 #define QEDR_LDPM_MAX_SIZE	(8192)
 #define QEDR_EDPM_TRANS_SIZE	(64)
+#define QEDR_EDPM_MAX_SIZE	(ROCE_REQ_MAX_INLINE_DATA_SIZE)
 
 enum qedr_rdma_dpm_type {
 	QEDR_DPM_TYPE_NONE		= 0,
@@ -77,6 +79,8 @@ struct qedr_alloc_ucontext_resp {
 	__u16 ldpm_limit_size;
 	__u8 edpm_trans_size;
 	__u8 reserved;
+	__u16 edpm_limit_size;
+	__u8 padding[6];
 };
 
 struct qedr_alloc_pd_ureq {
-- 
2.14.5

