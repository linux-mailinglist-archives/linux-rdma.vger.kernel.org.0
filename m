Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A785E49504E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351466AbiATOew (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 09:34:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1351156AbiATOew (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jan 2022 09:34:52 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KEAW7t013986;
        Thu, 20 Jan 2022 14:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KA+T4G0/xkYmsi2GnuN3+egMAgeTxTgVUycRpBBvl0Y=;
 b=H/rdbZlYwqgDiaaDf06AgYhdE7FcrJbRdoUDoF+epdYajDOJ2YcAYf9kK9Kcnk91F/aG
 Fhfr58JMK1n/TxJHNmagMEGnUhOnNGngK2IQWzvJ3QZKS7sk389qndjllTuIdUcJpx2N
 iPVs75Ztgpxp3LwQliWrRbkUF+ii5rfY0hlkhbHSt7Qmjq9/OHMsLGudAloFKsMCo6eW
 jLCGdYBqANcAWwgMs8Rt7E98gbSx97AoTN6eDqQmsJ3bfQq60Xb3eRQY672vLSYq+zM9
 Mz6dyWIbYNuLopbBznZf2gokOcJjjrDWnIpS+nJRz2affGSkgv3so+8cYgO5+5JBBxyN QQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dq8g89jtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 14:34:49 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20KEW8ho031587;
        Thu, 20 Jan 2022 14:34:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3dnm6rs9ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 14:34:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20KEYjuG46727548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 14:34:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EFA6A4054;
        Thu, 20 Jan 2022 14:34:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CC6AA4060;
        Thu, 20 Jan 2022 14:34:45 +0000 (GMT)
Received: from Pescara.zurich.ibm.com (unknown [9.171.95.207])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jan 2022 14:34:44 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, jgg@ziepe.ca,
        leon@kernel.org, jared.holzman@excelero.com
Subject: [PATCH] RDMA/siw: Fix broken RDMA Read Fence/Resume logic.
Date:   Thu, 20 Jan 2022 15:34:34 +0100
Message-Id: <20220120143434.2332-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vqFe3zZbdLexsmrcSlY8Ziqs8PyLWBE7
X-Proofpoint-GUID: vqFe3zZbdLexsmrcSlY8Ziqs8PyLWBE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_04,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxlogscore=772 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200076
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Code unconditionally resumed fenced SQ processing after next RDMA
Read completion, even if other RDMA Read responses are still
outstanding, or ORQ is full. Also adds comments for better readability
of fence processing, and removes orq_get_tail() helper, which is not
needed anymore.

Reported-by: Jared Holzman <jared.holzman@excelero.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       |  7 +------
 drivers/infiniband/sw/siw/siw_qp_rx.c | 20 +++++++++++---------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 368959ae9a8c..df03d84c6868 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -644,14 +644,9 @@ static inline struct siw_sqe *orq_get_current(struct siw_qp *qp)
 	return &qp->orq[qp->orq_get % qp->attrs.orq_size];
 }
 
-static inline struct siw_sqe *orq_get_tail(struct siw_qp *qp)
-{
-	return &qp->orq[qp->orq_put % qp->attrs.orq_size];
-}
-
 static inline struct siw_sqe *orq_get_free(struct siw_qp *qp)
 {
-	struct siw_sqe *orq_e = orq_get_tail(qp);
+	struct siw_sqe *orq_e = &qp->orq[qp->orq_put % qp->attrs.orq_size];
 
 	if (READ_ONCE(orq_e->flags) == 0)
 		return orq_e;
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 60116f20653c..875ea6f1b04a 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -1153,11 +1153,12 @@ static int siw_check_tx_fence(struct siw_qp *qp)
 
 	spin_lock_irqsave(&qp->orq_lock, flags);
 
-	rreq = orq_get_current(qp);
-
 	/* free current orq entry */
+	rreq = orq_get_current(qp);
 	WRITE_ONCE(rreq->flags, 0);
 
+	qp->orq_get++;
+
 	if (qp->tx_ctx.orq_fence) {
 		if (unlikely(tx_waiting->wr_status != SIW_WR_QUEUED)) {
 			pr_warn("siw: [QP %u]: fence resume: bad status %d\n",
@@ -1165,10 +1166,12 @@ static int siw_check_tx_fence(struct siw_qp *qp)
 			rv = -EPROTO;
 			goto out;
 		}
-		/* resume SQ processing */
+		/* resume SQ processing, if possible */
 		if (tx_waiting->sqe.opcode == SIW_OP_READ ||
 		    tx_waiting->sqe.opcode == SIW_OP_READ_LOCAL_INV) {
-			rreq = orq_get_tail(qp);
+
+			/* SQ processing was stopped because of a full ORQ */
+			rreq = orq_get_free(qp);
 			if (unlikely(!rreq)) {
 				pr_warn("siw: [QP %u]: no ORQE\n", qp_id(qp));
 				rv = -EPROTO;
@@ -1181,15 +1184,14 @@ static int siw_check_tx_fence(struct siw_qp *qp)
 			resume_tx = 1;
 
 		} else if (siw_orq_empty(qp)) {
+			/*
+			 * SQ processing was stopped by fenced work request.
+			 * Resume since all previous Read's are now completed.
+			 */
 			qp->tx_ctx.orq_fence = 0;
 			resume_tx = 1;
-		} else {
-			pr_warn("siw: [QP %u]: fence resume: orq idx: %d:%d\n",
-				qp_id(qp), qp->orq_get, qp->orq_put);
-			rv = -EPROTO;
 		}
 	}
-	qp->orq_get++;
 out:
 	spin_unlock_irqrestore(&qp->orq_lock, flags);
 
-- 
2.34.1

