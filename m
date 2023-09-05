Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0D7927B1
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Sep 2023 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjIEQA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Sep 2023 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354843AbjIEO6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Sep 2023 10:58:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E618C
        for <linux-rdma@vger.kernel.org>; Tue,  5 Sep 2023 07:58:31 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385ElaVe009144;
        Tue, 5 Sep 2023 14:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fRMy/8Alh5GmtLn/p+NwaEY+kS5OuoEWOA99xHkFM9A=;
 b=f6+Vtezs6ERdI+4y95IphHW4g6JaPgTtJi2DAx5+HFvMz5qBcJG+cj+hBZXcXnq/lKU2
 MCasVQR17prn/p5kcEJoUIVkI8F5aHMT6kwr2LJPh/gEj0BtK/P9gXzf/ahhvlZouMBQ
 5u2d4dveITcJyZV9UV1bnFoV9vroLUXBISTG4311r5OX6s/Jb/DimOpP5sQhfTnAeSLy
 +vO+a3zAEeCL/ADyv+smqvWTcYkVDKPJ8QBjJ/RI0AdgGFIRwGMFdnGc4tcLc8U/AR7y
 xy//sofSXT8Mow5+6uAeJp65+TOwm8KrBlxoyPaj/JZ56UZyQLToFcfcc5Dhv07TDsVR fQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx6da0919-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 14:58:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385EFeVx021433;
        Tue, 5 Sep 2023 14:58:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfrybmek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 14:58:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385EwOGv20447996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 14:58:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83A0620043;
        Tue,  5 Sep 2023 14:58:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 666C320040;
        Tue,  5 Sep 2023 14:58:24 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.66])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 14:58:24 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, leon@kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v2] RDMA/siw: Fix connection failure handling
Date:   Tue,  5 Sep 2023 16:58:22 +0200
Message-Id: <20230905145822.446263-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1Qb4RWFEXN-lwvAg5kXG3yFaEkmsQ23j
X-Proofpoint-ORIG-GUID: 1Qb4RWFEXN-lwvAg5kXG3yFaEkmsQ23j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=686 clxscore=1015
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In case immediate MPA request processing fails, the newly
created endpoint unlinks the listening endpoint and is
ready to be dropped. This special case was not handled
correctly by the code handling the later TCP socket close,
causing a NULL dereference crash in siw_cm_work_handler()
when dereferencing a NULL listener. We now also cancel
the useless MPA timeout, if immediate MPA request
processing fails.

This patch furthermore simplifies MPA processing in general:
Scheduling a useless TCP socket read in sk_data_ready() upcall
is now surpressed, if the socket is already moved out of
TCP_ESTABLISHED state.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
ChangeLog v1->v2:
- Move debug message to now conditional listener drop
---
 drivers/infiniband/sw/siw/siw_cm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index a2605178f4ed..43e776073f49 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -976,6 +976,7 @@ static void siw_accept_newconn(struct siw_cep *cep)
 			siw_cep_put(cep);
 			new_cep->listen_cep = NULL;
 			if (rv) {
+				siw_cancel_mpatimer(new_cep);
 				siw_cep_set_free(new_cep);
 				goto error;
 			}
@@ -1100,9 +1101,12 @@ static void siw_cm_work_handler(struct work_struct *w)
 				/*
 				 * Socket close before MPA request received.
 				 */
-				siw_dbg_cep(cep, "no mpareq: drop listener\n");
-				siw_cep_put(cep->listen_cep);
-				cep->listen_cep = NULL;
+				if (cep->listen_cep) {
+					siw_dbg_cep(cep,
+						"no mpareq: drop listener\n");
+					siw_cep_put(cep->listen_cep);
+					cep->listen_cep = NULL;
+				}
 			}
 		}
 		release_cep = 1;
@@ -1227,7 +1231,11 @@ static void siw_cm_llp_data_ready(struct sock *sk)
 	if (!cep)
 		goto out;
 
-	siw_dbg_cep(cep, "state: %d\n", cep->state);
+	siw_dbg_cep(cep, "cep state: %d, socket state %d\n",
+		    cep->state, sk->sk_state);
+
+	if (sk->sk_state != TCP_ESTABLISHED)
+		goto out;
 
 	switch (cep->state) {
 	case SIW_EPSTATE_RDMA_MODE:
-- 
2.38.1

