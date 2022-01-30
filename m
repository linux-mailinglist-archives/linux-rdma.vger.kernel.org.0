Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2F4A37D1
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jan 2022 18:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiA3RIu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jan 2022 12:08:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355705AbiA3RIt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Jan 2022 12:08:49 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20UGbUGL013796;
        Sun, 30 Jan 2022 17:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=k8Fz9tEGyRIzij1vL1kL2YHzvUBQh2gQhX+fJ/P3hso=;
 b=lOU9thId0gkcb+lZ7aBJB6k+Bv93+SLvbMUpUhC+fECGmB4WQCqM/qqYwAqQtpvi4C2I
 TFIfitZBohDWkH2xd8iV6cUYUYmD+wDEHlY0cfiV7h1hSIM3ixyDpna16SX6XwfTATdM
 Ea+CMO0ZdL0bDWtviBVh3taNR0RpXWPJEwhyL0b7keLJmubAW55imMm5Mvt2sRia0vAF
 LuCxfzBkArdXaUk1Su873SA1szgUuPpeg4OolHPXQkrys+WwKZbO23IdDVjz7C1+8iiT
 uDDtbehPd0GAniZDZjSF1c9c+NjFGDYtvCv2cV2E0d/Nv1leqegQ+HTq2Gj0W7jlGcKW +g== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dwv2w9s6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Jan 2022 17:08:45 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20UH8hpR018093;
        Sun, 30 Jan 2022 17:08:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3dvw78ngv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Jan 2022 17:08:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20UGwu9u45482366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jan 2022 16:58:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADD9EA405C;
        Sun, 30 Jan 2022 17:08:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D643A4054;
        Sun, 30 Jan 2022 17:08:40 +0000 (GMT)
Received: from Pescara.zurich.ibm.com (unknown [9.171.42.39])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 30 Jan 2022 17:08:40 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, jgg@ziepe.ca,
        leon@kernel.org, jared.holzman@excelero.com
Subject: [PATCH] RDMA/siw: Fix broken RDMA Read Fence/Resume logic.
Date:   Sun, 30 Jan 2022 18:08:15 +0100
Message-Id: <20220130170815.1940-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QsnW9zeSTcWFN2mlbOBzkweb1C8hEDUD
X-Proofpoint-GUID: QsnW9zeSTcWFN2mlbOBzkweb1C8hEDUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-30_05,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=708 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201300123
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Code unconditionally resumed fenced SQ processing after next RDMA
Read completion, even if other RDMA Read responses are still
outstanding, or ORQ is full. Also adds comments for better readability
of fence processing, and removes orq_get_tail() helper, which is not
needed anymore.

Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
Fixes: a531975279f3 ("rdma/siw: main include file")
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

