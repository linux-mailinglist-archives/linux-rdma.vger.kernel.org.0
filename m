Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93C245FBD
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfFNN6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 09:58:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728619AbfFNN6D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 09:58:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EDo8Va032448
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 09:58:02 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t4c3va5gf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 09:58:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Fri, 14 Jun 2019 14:57:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 14:57:56 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EDvt7C44105828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 13:57:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AC2042041;
        Fri, 14 Jun 2019 13:57:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 479E442049;
        Fri, 14 Jun 2019 13:57:55 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 13:57:55 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v2 10/11] SIW completion queue methods
Date:   Fri, 14 Jun 2019 15:57:49 +0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190614135750.15874-1-bmt@zurich.ibm.com>
References: <20190614135750.15874-1-bmt@zurich.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061413-0028-0000-0000-0000037A5226
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061413-0029-0000-0000-0000243A4F5A
Message-Id: <20190614135750.15874-11-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=699 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_cq.c | 101 +++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 drivers/infiniband/sw/siw/siw_cq.c

diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
new file mode 100644
index 000000000000..e2a0ee40d5b5
--- /dev/null
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+
+/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
+/* Copyright (c) 2008-2019, IBM Corporation */
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "siw.h"
+
+static int map_wc_opcode[SIW_NUM_OPCODES] = {
+	[SIW_OP_WRITE] = IB_WC_RDMA_WRITE,
+	[SIW_OP_SEND] = IB_WC_SEND,
+	[SIW_OP_SEND_WITH_IMM] = IB_WC_SEND,
+	[SIW_OP_READ] = IB_WC_RDMA_READ,
+	[SIW_OP_READ_LOCAL_INV] = IB_WC_RDMA_READ,
+	[SIW_OP_COMP_AND_SWAP] = IB_WC_COMP_SWAP,
+	[SIW_OP_FETCH_AND_ADD] = IB_WC_FETCH_ADD,
+	[SIW_OP_INVAL_STAG] = IB_WC_LOCAL_INV,
+	[SIW_OP_REG_MR] = IB_WC_REG_MR,
+	[SIW_OP_RECEIVE] = IB_WC_RECV,
+	[SIW_OP_READ_RESPONSE] = -1 /* not used */
+};
+
+static struct {
+	enum siw_opcode siw;
+	enum ib_wc_status ib;
+} map_cqe_status[SIW_NUM_WC_STATUS] = {
+	{ SIW_WC_SUCCESS, IB_WC_SUCCESS },
+	{ SIW_WC_LOC_LEN_ERR, IB_WC_LOC_LEN_ERR },
+	{ SIW_WC_LOC_PROT_ERR, IB_WC_LOC_PROT_ERR },
+	{ SIW_WC_LOC_QP_OP_ERR, IB_WC_LOC_QP_OP_ERR },
+	{ SIW_WC_WR_FLUSH_ERR, IB_WC_WR_FLUSH_ERR },
+	{ SIW_WC_BAD_RESP_ERR, IB_WC_BAD_RESP_ERR },
+	{ SIW_WC_LOC_ACCESS_ERR, IB_WC_LOC_ACCESS_ERR },
+	{ SIW_WC_REM_ACCESS_ERR, IB_WC_REM_ACCESS_ERR },
+	{ SIW_WC_REM_INV_REQ_ERR, IB_WC_REM_INV_REQ_ERR },
+	{ SIW_WC_GENERAL_ERR, IB_WC_GENERAL_ERR }
+};
+
+/*
+ * Reap one CQE from the CQ. Only used by kernel clients
+ * during CQ normal operation. Might be called during CQ
+ * flush for user mapped CQE array as well.
+ */
+int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
+{
+	struct siw_cqe *cqe;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cq->lock, flags);
+
+	cqe = &cq->queue[cq->cq_get % cq->num_cqe];
+	if (READ_ONCE(cqe->flags) & SIW_WQE_VALID) {
+		memset(wc, 0, sizeof(*wc));
+		wc->wr_id = cqe->id;
+		wc->status = map_cqe_status[cqe->status].ib;
+		wc->opcode = map_wc_opcode[cqe->opcode];
+		wc->byte_len = cqe->bytes;
+
+		/*
+		 * During CQ flush, also user land CQE's may get
+		 * reaped here, which do not hold a QP reference
+		 * and do not qualify for memory extension verbs.
+		 */
+		if (likely(cq->kernel_verbs)) {
+			if (cqe->flags & SIW_WQE_REM_INVAL) {
+				wc->ex.invalidate_rkey = cqe->inval_stag;
+				wc->wc_flags = IB_WC_WITH_INVALIDATE;
+			}
+			wc->qp = cqe->base_qp;
+			siw_dbg_cq(cq, "idx %u, type %d, flags %2x, id 0x%p\n",
+				   cq->cq_get % cq->num_cqe, cqe->opcode,
+				   cqe->flags, (void *)cqe->id);
+		}
+		WRITE_ONCE(cqe->flags, 0);
+		cq->cq_get++;
+
+		spin_unlock_irqrestore(&cq->lock, flags);
+
+		return 1;
+	}
+	spin_unlock_irqrestore(&cq->lock, flags);
+
+	return 0;
+}
+
+/*
+ * siw_cq_flush()
+ *
+ * Flush all CQ elements.
+ */
+void siw_cq_flush(struct siw_cq *cq)
+{
+	struct ib_wc wc;
+
+	while (siw_reap_cqe(cq, &wc))
+		;
+}
-- 
2.17.2

