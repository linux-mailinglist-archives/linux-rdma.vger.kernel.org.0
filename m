Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB0792503
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Sep 2023 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjIEQAs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Sep 2023 12:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354553AbjIEMhB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Sep 2023 08:37:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5751AD
        for <linux-rdma@vger.kernel.org>; Tue,  5 Sep 2023 05:36:57 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385CDOM0017762;
        Tue, 5 Sep 2023 12:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=l3caQR8dt/naLKQTBXtCQRdFIsIsVrIygMgcZoj+gas=;
 b=IPDxNLEyDexCPWYeKfsk9pz3VlovZBwdydUjQ4hbvlZNcIbOU8Esq4BDVcZOLhxxcnjq
 rT7X9AZNPIhvxhWOzDwt0EGBzYJ3wyQh55mtjDuULVw4YI/HjrBj7n5RDQvFEK4J1pRK
 iOvDw7OekmKc7ZlEBDVr8j6Il6jSiKIdC8seP3N1W54D9dhulYGhX3J9cZtP9epWaHHi
 qv2u7ngYn1utI1pjdF5c+z2a0A1Mr4a8a3oT/cLEiNDsNeNZETzCdTdh4mmrkrh+vrU1
 gPj561rMEfc3mYmiLhn54q08Q9DGzKVmbdoIc8MCPCqCfJrBLxKNXvBylqfrZ/yFUWpU CQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx44wgmfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 12:36:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385ABcQ1006651;
        Tue, 5 Sep 2023 12:05:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvka5um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 12:05:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385C5adO45351414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 12:05:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E54162004B;
        Tue,  5 Sep 2023 12:05:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C22A220040;
        Tue,  5 Sep 2023 12:05:35 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.66])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 12:05:35 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, leon@kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] RDMA/siw: Fix connection failure handling
Date:   Tue,  5 Sep 2023 14:05:25 +0200
Message-Id: <20230905120525.392135-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2w5UYjIdohHNs8H4R-VPW9usKYEFId2T
X-Proofpoint-ORIG-GUID: 2w5UYjIdohHNs8H4R-VPW9usKYEFId2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=647
 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/infiniband/sw/siw/siw_cm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index a2605178f4ed..6e6b03e47e24 100644
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
@@ -1101,8 +1102,10 @@ static void siw_cm_work_handler(struct work_struct *w)
 				 * Socket close before MPA request received.
 				 */
 				siw_dbg_cep(cep, "no mpareq: drop listener\n");
-				siw_cep_put(cep->listen_cep);
-				cep->listen_cep = NULL;
+				if (cep->listen_cep) {
+					siw_cep_put(cep->listen_cep);
+					cep->listen_cep = NULL;
+				}
 			}
 		}
 		release_cep = 1;
@@ -1227,7 +1230,11 @@ static void siw_cm_llp_data_ready(struct sock *sk)
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

