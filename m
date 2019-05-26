Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB4E2A970
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2019 13:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfEZLmf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 May 2019 07:42:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727717AbfEZLme (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 May 2019 07:42:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4QBgXdx140313
        for <linux-rdma@vger.kernel.org>; Sun, 26 May 2019 07:42:34 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sqk0gtpj0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Sun, 26 May 2019 07:42:33 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Sun, 26 May 2019 12:42:30 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 26 May 2019 12:42:29 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4QBgSDx46006282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 May 2019 11:42:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4886AA405F;
        Sun, 26 May 2019 11:42:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 258D7A405C;
        Sun, 26 May 2019 11:42:28 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 26 May 2019 11:42:28 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH for-next v1 11/12] SIW debugging
Date:   Sun, 26 May 2019 13:41:55 +0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190526114156.6827-1-bmt@zurich.ibm.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052611-0028-0000-0000-000003718F08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052611-0029-0000-0000-000024314894
Message-Id: <20190526114156.6827-12-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=745 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905260084
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_debug.c | 102 ++++++++++++++++++++++++++
 drivers/infiniband/sw/siw/siw_debug.h |  35 +++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 drivers/infiniband/sw/siw/siw_debug.c
 create mode 100644 drivers/infiniband/sw/siw/siw_debug.h

diff --git a/drivers/infiniband/sw/siw/siw_debug.c b/drivers/infiniband/sw/siw/siw_debug.c
new file mode 100644
index 000000000000..b96cbe10700c
--- /dev/null
+++ b/drivers/infiniband/sw/siw/siw_debug.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+
+/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
+/* Copyright (c) 2008-2019, IBM Corporation */
+
+#include <linux/types.h>
+#include <linux/printk.h>
+
+#include "siw.h"
+
+#define ddp_data_len(op, mpa_len)                                              \
+	(mpa_len - (iwarp_pktinfo[op].hdr_len - MPA_HDR_SIZE))
+
+char *siw_print_hdr(union iwarp_hdr *hdr, int qp_id, char *string)
+{
+	static char buf[128];
+	enum rdma_opcode op = __rdmap_get_opcode(&hdr->ctrl);
+	u16 mpa_len = be16_to_cpu(hdr->ctrl.mpa_len);
+	u16 ctrl = be16_to_cpu(hdr->ctrl.ddp_rdmap_ctrl);
+
+	switch (op) {
+	case RDMAP_RDMA_WRITE:
+		sprintf(buf,
+			"[QP %u]: %s(WRITE, DDP len %d, ctrl %02x): %08x %016llx",
+			qp_id, string, ddp_data_len(op, mpa_len), ctrl,
+			hdr->rwrite.sink_stag, hdr->rwrite.sink_to);
+		break;
+
+	case RDMAP_RDMA_READ_REQ:
+		sprintf(buf,
+			"[QP %u]: %s(RREQ, DDP len %d, ctrl %02x): %08x %08x %08x %08x %016llx %08x %08x %016llx",
+			qp_id, string, ddp_data_len(op, mpa_len), ctrl,
+			be32_to_cpu(hdr->rreq.ddp_qn),
+			be32_to_cpu(hdr->rreq.ddp_msn),
+			be32_to_cpu(hdr->rreq.ddp_mo),
+			be32_to_cpu(hdr->rreq.sink_stag),
+			be64_to_cpu(hdr->rreq.sink_to),
+			be32_to_cpu(hdr->rreq.read_size),
+			be32_to_cpu(hdr->rreq.source_stag),
+			be64_to_cpu(hdr->rreq.source_to));
+		break;
+
+	case RDMAP_RDMA_READ_RESP:
+		sprintf(buf,
+			"[QP %u]: %s(RRESP, DDP len %d, ctrl %02x): %08x %016llx",
+			qp_id, string, ddp_data_len(op, mpa_len), ctrl,
+			be32_to_cpu(hdr->rresp.sink_stag),
+			be64_to_cpu(hdr->rresp.sink_to));
+		break;
+
+	case RDMAP_SEND:
+		sprintf(buf,
+			"[QP %u]: %s(SEND, DDP len %d, ctrl %02x): %08x %08x %08x",
+			qp_id, string, ddp_data_len(op, mpa_len), ctrl,
+			be32_to_cpu(hdr->send.ddp_qn),
+			be32_to_cpu(hdr->send.ddp_msn),
+			be32_to_cpu(hdr->send.ddp_mo));
+		break;
+
+	case RDMAP_SEND_INVAL:
+		sprintf(buf,
+			"[QP %u]: %s(S_INV, DDP len %d, ctrl %02x): %08x %08x %08x %08x",
+			qp_id, string, ddp_data_len(op, mpa_len), ctrl,
+			be32_to_cpu(hdr->send_inv.inval_stag),
+			be32_to_cpu(hdr->send_inv.ddp_qn),
+			be32_to_cpu(hdr->send_inv.ddp_msn),
+			be32_to_cpu(hdr->send_inv.ddp_mo));
+		break;
+
+	case RDMAP_SEND_SE:
+		sprintf(buf,
+			"[QP %u]: %s(S_SE, DDP len %d, ctrl %02x): %08x %08x %08x",
+			qp_id, string, ddp_data_len(op, mpa_len), ctrl,
+			be32_to_cpu(hdr->send.ddp_qn),
+			be32_to_cpu(hdr->send.ddp_msn),
+			be32_to_cpu(hdr->send.ddp_mo));
+		break;
+
+	case RDMAP_SEND_SE_INVAL:
+		sprintf(buf,
+			"[QP %u]: %s(S_SE_INV, DDP len %d, ctrl %02x): %08x %08x %08x %08x",
+			qp_id, string, ddp_data_len(op, mpa_len), ctrl,
+			be32_to_cpu(hdr->send_inv.inval_stag),
+			be32_to_cpu(hdr->send_inv.ddp_qn),
+			be32_to_cpu(hdr->send_inv.ddp_msn),
+			be32_to_cpu(hdr->send_inv.ddp_mo));
+		break;
+
+	case RDMAP_TERMINATE:
+		sprintf(buf,
+			"[QP %u]: %s(TERM, DDP len %d, ctrl %02x):",
+			qp_id, string, ddp_data_len(op, mpa_len), ctrl);
+		break;
+
+	default:
+		sprintf(buf,
+			"[QP %u]: %s (undefined opcode %d)", qp_id, string,
+			op);
+		break;
+	}
+	return buf;
+}
diff --git a/drivers/infiniband/sw/siw/siw_debug.h b/drivers/infiniband/sw/siw/siw_debug.h
new file mode 100644
index 000000000000..2759028ba446
--- /dev/null
+++ b/drivers/infiniband/sw/siw/siw_debug.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+
+/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
+/* Copyright (c) 2008-2019, IBM Corporation */
+
+#ifndef _SIW_DEBUG_H
+#define _SIW_DEBUG_H
+
+extern char *siw_print_hdr(union iwarp_hdr *hdr, int qp_id, char *string);
+
+#define siw_dbg(ibdev, fmt, ...)                                               \
+	dev_dbg(&(ibdev)->dev, "cpu%2d %s: " fmt, smp_processor_id(),          \
+		__func__, ##__VA_ARGS__)
+
+#define siw_dbg_qp(qp, fmt, ...)                                               \
+	siw_dbg(&qp->sdev->base_dev,                                           \
+		  "[QP %u]: " fmt, qp_id(qp), ##__VA_ARGS__)
+
+#define siw_dbg_cq(cq, fmt, ...)                                               \
+	siw_dbg(cq->base_cq.device, "[CQ %u]: " fmt, cq->id, ##__VA_ARGS__)
+
+#define siw_dbg_pd(pd, fmt, ...)                                               \
+	siw_dbg(pd->device, "[PD %u]: " fmt, pd->res.id, ##__VA_ARGS__)
+
+#define siw_dbg_mem(mem, fmt, ...)                                             \
+	siw_dbg(&mem->sdev->base_dev,                                          \
+		"[MEM 0x%08x]: " fmt, mem->stag, ##__VA_ARGS__)
+
+#define siw_dbg_cep(cep, fmt, ...)                                             \
+	siw_dbg(&cep->sdev->base_dev, "[CEP 0x%p]: " fmt, cep, ##__VA_ARGS__)
+
+#define siw_dbg_pkt(hdr, qp, fmt)                                              \
+	siw_dbg(&qp->sdev->base_dev, "%s ", siw_print_hdr(hdr, qp_id(qp), fmt))
+
+#endif
-- 
2.17.2

