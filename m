Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32AB680F0E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jan 2023 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbjA3Ncs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 08:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjA3Ncr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 08:32:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4BD17143
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 05:32:46 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UCWQIB007816;
        Mon, 30 Jan 2023 13:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=DMQyCxR3cf/K1yVEKyECdekVijTClR5+SSw7s4/PGnM=;
 b=P4bptLej87EnRSpuJCs+iH2yyIXV5cL468S4Y1IIXPonIqsyMcFIOhNhpJxbAfALU9WV
 +BWN7pooiaLFnfc5tCfVk7nXFEPX6PaABgQzRtZdvpbOduiXegOR9NuidHklepa4unG3
 h03Qljt8F8X8R0vbNbpHhgHvLJBjkZjAFoo40oM1IRVOR60CSmFaaGEya62miwFjhyKC
 jS9jFhCo38PJoCBQ+e09ClyV7Gt4hN/ANFJRbexxFoAYG4l61v0AHz/+leibl8eEtzfC
 6Oa+E9Qu2/xKJffV8LGQG2kTvZ/AneIwYOmmRWO3/UsZ34w2QfXhvxkB57yf652SgagQ cA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nedyuscwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:32:43 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30U5e6QZ013445;
        Mon, 30 Jan 2023 13:32:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtya9np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:32:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UDWbG022348310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 13:32:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EDE220043;
        Mon, 30 Jan 2023 13:32:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 294BF20040;
        Mon, 30 Jan 2023 13:32:37 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.56])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 13:32:37 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com, apopple@nvidia.com,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] RDMA/siw: Fix user page pinning accounting
Date:   Mon, 30 Jan 2023 14:32:35 +0100
Message-Id: <20230130133235.223440-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bpB3-kiLra8tzegD36fXxQGiG8YMLTVx
X-Proofpoint-ORIG-GUID: bpB3-kiLra8tzegD36fXxQGiG8YMLTVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_12,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=836 malwarescore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To avoid racing with other user memory reservations, immediately
account full amount of pages to be pinned.

Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_mem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index b2b33dd3b4fa..7afdbe3f2266 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -398,7 +398,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 
 	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-	if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
+	if (atomic64_add_return(num_pages, &mm_s->pinned_vm) > mlock_limit) {
 		rv = -ENOMEM;
 		goto out_sem_up;
 	}
@@ -429,7 +429,6 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 				goto out_sem_up;
 
 			umem->num_pages += rv;
-			atomic64_add(rv, &mm_s->pinned_vm);
 			first_page_va += rv * PAGE_SIZE;
 			nents -= rv;
 			got += rv;
@@ -442,6 +441,10 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 	if (rv > 0)
 		return umem;
 
+	/* Adjust accounting for pages not pinned */
+	if (num_pages)
+		atomic64_sub(num_pages, &mm_s->pinned_vm);
+
 	siw_umem_release(umem, false);
 
 	return ERR_PTR(rv);
-- 
2.32.0

