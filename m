Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E9568659E
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 12:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBALzz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Feb 2023 06:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBALzx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Feb 2023 06:55:53 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FA41BCB
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 03:55:52 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311AHsdM027765;
        Wed, 1 Feb 2023 11:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=4TK/j9fyH6rr4tqfeeVo7CayhCbU+Um+kYIAH/VfIBo=;
 b=K1Z6jyCo+AMEWbb1Y6cJ56+uQ/U0eZd7MuO0qJUMT7Fme0IqBkDs/1L+D3N+H91cWNZG
 bAMnqGhCHOfhtXTgO4o1Xzj6uUqY+kWOMTfXSysNHxFXHIL0sJqDO+dzq7D4bDexY/qN
 PFdrL6E8lTzYmflSSeuVh0GmTZfXGZ729M1XLgJcrknqeaKWFTVRPN1bSk/qeeZ+I3B5
 9LLVziXju7MJgUSDGtGIGLyyCxDgYP8X88scsWW7KD/e2YF/BRMSaMfbDbM5s/bLKW52
 MLZSwgdwXQDC08JB114BoBFtA+n5DnU43l6aKsSMNvPxODcMMoY4MaBCAa3culiu38Tz 2A== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfnuh2qa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 11:55:49 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3114LhfU020640;
        Wed, 1 Feb 2023 11:55:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ncvv6befv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 11:55:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 311Btj7g48300330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Feb 2023 11:55:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A37C20043;
        Wed,  1 Feb 2023 11:55:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AD1B20040;
        Wed,  1 Feb 2023 11:55:45 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.56])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Feb 2023 11:55:45 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com, apopple@nvidia.com,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] RDMA/siw: Fix user page pinning accounting
Date:   Wed,  1 Feb 2023 12:55:40 +0100
Message-Id: <20230201115540.360353-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XXmw6H8nrkO99xMmYMTI9DgEAGVJ1jP-
X-Proofpoint-GUID: XXmw6H8nrkO99xMmYMTI9DgEAGVJ1jP-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=669 impostorscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010100
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
 drivers/infiniband/sw/siw/siw_mem.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index b2b33dd3b4fa..f51ab2ccf151 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -398,7 +398,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 
 	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-	if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
+	if (atomic64_add_return(num_pages, &mm_s->pinned_vm) > mlock_limit) {
 		rv = -ENOMEM;
 		goto out_sem_up;
 	}
@@ -411,30 +411,27 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 		goto out_sem_up;
 	}
 	for (i = 0; num_pages; i++) {
-		int got, nents = min_t(int, num_pages, PAGES_PER_CHUNK);
-
-		umem->page_chunk[i].plist =
+		int nents = min_t(int, num_pages, PAGES_PER_CHUNK);
+		struct page **plist =
 			kcalloc(nents, sizeof(struct page *), GFP_KERNEL);
-		if (!umem->page_chunk[i].plist) {
+
+		if (!plist) {
 			rv = -ENOMEM;
 			goto out_sem_up;
 		}
-		got = 0;
+		umem->page_chunk[i].plist = plist;
 		while (nents) {
-			struct page **plist = &umem->page_chunk[i].plist[got];
-
 			rv = pin_user_pages(first_page_va, nents, foll_flags,
 					    plist, NULL);
 			if (rv < 0)
 				goto out_sem_up;
 
 			umem->num_pages += rv;
-			atomic64_add(rv, &mm_s->pinned_vm);
 			first_page_va += rv * PAGE_SIZE;
+			plist += rv;
 			nents -= rv;
-			got += rv;
+			num_pages -= rv;
 		}
-		num_pages -= got;
 	}
 out_sem_up:
 	mmap_read_unlock(mm_s);
@@ -442,6 +439,10 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
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

