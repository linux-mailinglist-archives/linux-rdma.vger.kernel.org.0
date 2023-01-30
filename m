Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CED0680EDC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jan 2023 14:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjA3N2X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 08:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjA3N2V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 08:28:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89DD18154
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 05:28:19 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UD7VRF029940;
        Mon, 30 Jan 2023 13:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/0uXrw+TBpRHywcJYSfNFFpqOYll+3y1+ysG9BSUw1E=;
 b=aPDyxUBmIdNZeO+0km1qlUWuPKyjmpf3uru1CfyKb9/ZPPKNoFiomZC9D9L8QhCgGTSp
 lb24fPIwhhfxk05WbW8+Ovb3VBZiJjHXIAQBLF5+5opeblRyHpMuAdlpT/3GNHhpo1yX
 qY4nYGFkuSJ1GK5/1qyhFs/4IFZKDgwAKwrGBD1N9Ldj57YBT944cEKQMvN2TnbRIV+P
 2p4x9rA2j56KR++2gp3DPAzhvy4K3Aj2FilDIkt0FCijLyxcCxjQbVjECMpkpVufhmnT
 zqNE0Uu2taXwc9PjEO+FdMtRgi0ADCi60rbsikuNmEXQBZdJqldQFH9gJMeY+dbLRuFd nw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3neeg8re4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:28:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30U51EtM026867;
        Mon, 30 Jan 2023 13:28:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ncvs7j9n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:28:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UDSDOj46858690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 13:28:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EB4D20043;
        Mon, 30 Jan 2023 13:28:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDA4220040;
        Mon, 30 Jan 2023 13:28:12 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.56])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 13:28:12 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com, apopple@nvidia.com,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] RDMA/siw: Fix user page pinning accounting
Date:   Mon, 30 Jan 2023 14:28:04 +0100
Message-Id: <20230130132804.223144-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lbStiBVCe0_J-C1o7Lv9U0AYlJLH6uRB
X-Proofpoint-ORIG-GUID: lbStiBVCe0_J-C1o7Lv9U0AYlJLH6uRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_12,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=869 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300126
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
 drivers/infiniband/sw/siw/siw_mem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index b2b33dd3b4fa..7cf4d927bbab 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -398,7 +398,8 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 
 	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-	if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
+	if (num_pages + atomic64_add_return(num_pages, &mm_s->pinned_vm) >
+	    mlock_limit) {
 		rv = -ENOMEM;
 		goto out_sem_up;
 	}
@@ -429,7 +430,6 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 				goto out_sem_up;
 
 			umem->num_pages += rv;
-			atomic64_add(rv, &mm_s->pinned_vm);
 			first_page_va += rv * PAGE_SIZE;
 			nents -= rv;
 			got += rv;
@@ -442,6 +442,10 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
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

