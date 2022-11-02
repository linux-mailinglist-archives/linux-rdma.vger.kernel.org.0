Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA8615FC7
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 10:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKBJc3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKBJc3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 05:32:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2865F6
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 02:32:28 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A28Vccq001458;
        Wed, 2 Nov 2022 09:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=L6PtZ0NgEUr4bs+JpCJQFIgTqQDIZEN+gTaXazygSEs=;
 b=srLooNKFQ2+s0KV4bpUUVUwA6RzduZ8quuaveCzpYOyghY9r+bz2OlyesAAhFJCRoFlS
 GWDavo9vLMUtXErJc1+2JnEU4MQMTN0LLwVTuv1enealG5OnUAs60bb4UniYg7BgGZNw
 53IeeunkPGgBDiMrbXSq78bOfXSsJQ51QubeKn129jz94KXjBb9W0rGRFIDN72Gj5VMq
 akaB8S7tzkSlavaFQ19izgy+82sk3srZVUhyqufTbODGDfMUKCODsu67kOG+qTtVkkoD
 Q004flmhi/ORBzWUUnee3X2bI5MvJtLEqXAmw0z1FP/AilMdHQsdHOKWLatX3EC2YVqG ug== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkn45huhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:32:23 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A29LTnL016754;
        Wed, 2 Nov 2022 09:32:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3kguehxe99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:32:20 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A29WId060948798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 09:32:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9624211C050;
        Wed,  2 Nov 2022 09:32:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5964611C04A;
        Wed,  2 Nov 2022 09:32:18 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.56])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 09:32:18 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>
Subject: [PATCH v2] RDMA/siw: Fix immediate work request flush to completion queue.
Date:   Wed,  2 Nov 2022 10:31:10 +0100
Message-Id: <20221102093110.661109-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ofeHT9Q7F4kXywS4Aw4MMigktShSpK_W
X-Proofpoint-ORIG-GUID: ofeHT9Q7F4kXywS4Aw4MMigktShSpK_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0 mlxlogscore=991
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Correctly set send queue element opcode during immediate work request
flushing in post sendqueue operation, if the QP is in ERROR state.
An undefined ocode value results in out-of-bounds access to an array
for mapping the opcode between siw internal and RDMA core representation
in work completion generation. It resulted in a KASAN BUG report
of type 'global-out-of-bounds' during NFSoRDMA testing.
This patch further fixes a potential case of a malicious user which may
write undefined values for completion queue elements status or opcode,
if the CQ is memory mapped to user land. It avoids the same out-of-bounds
access to arrays for status and opcode mapping as described above.

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Fixes: b0fff7317bb4 ("rdma/siw: completion queue methods")

Reported-by: Olga Kornievskaia <kolga@netapp.com>
Reviewed-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>

----
v1 -> v2:
	Change return code of siw_sq_flush_wr() to -EINVAL
	for unexpected opcodes.

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_cq.c    | 24 ++++++++++++++--
 drivers/infiniband/sw/siw/siw_verbs.c | 40 ++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
index d68e37859e73..acc7bcd538b5 100644
--- a/drivers/infiniband/sw/siw/siw_cq.c
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -56,8 +56,6 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
 	if (READ_ONCE(cqe->flags) & SIW_WQE_VALID) {
 		memset(wc, 0, sizeof(*wc));
 		wc->wr_id = cqe->id;
-		wc->status = map_cqe_status[cqe->status].ib;
-		wc->opcode = map_wc_opcode[cqe->opcode];
 		wc->byte_len = cqe->bytes;
 
 		/*
@@ -71,10 +69,32 @@ int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc)
 				wc->wc_flags = IB_WC_WITH_INVALIDATE;
 			}
 			wc->qp = cqe->base_qp;
+			wc->opcode = map_wc_opcode[cqe->opcode];
+			wc->status = map_cqe_status[cqe->status].ib;
 			siw_dbg_cq(cq,
 				   "idx %u, type %d, flags %2x, id 0x%pK\n",
 				   cq->cq_get % cq->num_cqe, cqe->opcode,
 				   cqe->flags, (void *)(uintptr_t)cqe->id);
+		} else {
+			/*
+			 * A malicious user may set invalid opcode or
+			 * status in the user mmapped CQE array.
+			 * Sanity check and correct values in that case
+			 * to avoid out-of-bounds access to global arrays
+			 * for opcode and status mapping.
+			 */
+			u8 opcode = cqe->opcode;
+			u16 status = cqe->status;
+
+			if (opcode >= SIW_NUM_OPCODES) {
+				opcode = 0;
+				status = IB_WC_GENERAL_ERR;
+			} else if (status >= SIW_NUM_WC_STATUS) {
+				status = IB_WC_GENERAL_ERR;
+			}
+			wc->opcode = map_wc_opcode[opcode];
+			wc->status = map_cqe_status[status].ib;
+
 		}
 		WRITE_ONCE(cqe->flags, 0);
 		cq->cq_get++;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 3e814cfb298c..906fde1a2a0d 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -676,13 +676,45 @@ static int siw_copy_inline_sgl(const struct ib_send_wr *core_wr,
 static int siw_sq_flush_wr(struct siw_qp *qp, const struct ib_send_wr *wr,
 			   const struct ib_send_wr **bad_wr)
 {
-	struct siw_sqe sqe = {};
 	int rv = 0;
 
 	while (wr) {
-		sqe.id = wr->wr_id;
-		sqe.opcode = wr->opcode;
-		rv = siw_sqe_complete(qp, &sqe, 0, SIW_WC_WR_FLUSH_ERR);
+		struct siw_sqe sqe = {};
+
+		switch (wr->opcode) {
+		case IB_WR_RDMA_WRITE:
+			sqe.opcode = SIW_OP_WRITE;
+			break;
+		case IB_WR_RDMA_READ:
+			sqe.opcode = SIW_OP_READ;
+			break;
+		case IB_WR_RDMA_READ_WITH_INV:
+			sqe.opcode = SIW_OP_READ_LOCAL_INV;
+			break;
+		case IB_WR_SEND:
+			sqe.opcode = SIW_OP_SEND;
+			break;
+		case IB_WR_SEND_WITH_IMM:
+			sqe.opcode = SIW_OP_SEND_WITH_IMM;
+			break;
+		case IB_WR_SEND_WITH_INV:
+			sqe.opcode = SIW_OP_SEND_REMOTE_INV;
+			break;
+		case IB_WR_LOCAL_INV:
+			sqe.opcode = SIW_OP_INVAL_STAG;
+			break;
+		case IB_WR_REG_MR:
+			sqe.opcode = SIW_OP_REG_MR;
+			break;
+		default:
+			rv = -EINVAL;
+			break;
+		}
+		if (!rv) {
+			sqe.id = wr->wr_id;
+			rv = siw_sqe_complete(qp, &sqe, 0,
+					      SIW_WC_WR_FLUSH_ERR);
+		}
 		if (rv) {
 			if (bad_wr)
 				*bad_wr = wr;
-- 
2.32.0

