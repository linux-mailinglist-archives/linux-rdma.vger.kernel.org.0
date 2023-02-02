Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD416879E9
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 11:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjBBKPN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 05:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjBBKPN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 05:15:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0127981
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 02:15:11 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3129v4hm000895;
        Thu, 2 Feb 2023 10:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=k8EZPwbNwc8OhIyMzZQs00I626CKr3TiJk2qT4TNS+E=;
 b=mhXAAE77B0Fh5sQ6U0Ntd3DsZWlXbnVEv1PJDqhrOL4hyYmayi4JqRLdg00RHh5j90oD
 6f41RskBUDCIKABzhd11n7pz1XlD/J7fHgWbuAiy0/DHDkxEvyEIHQM0W4HwQJpygOdS
 XlCAsGSuKBPC5Dj89/mT4pSMzOrc+DjCHoUv+xS6J2mUj0+z1gITdimbjFRNIAnxIgq8
 /09XacxjrQdjyQ/BJC/G+6iK0axKnlU8ThFgZsOnlGW0JfrJZ/P/6ggqIyU7lwuBqrEf
 2hM7YGnqurYIA2Zan80ejt/DOCcF4vB3XeesC2VWO8/lqBdFr5FKu8yOY9LsPdNz1Ndb WA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngb088cgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 10:15:08 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 311LgQWu003400;
        Thu, 2 Feb 2023 10:10:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ncvv6ca1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 10:10:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312AA30542074622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 10:10:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D52FB20049;
        Thu,  2 Feb 2023 10:10:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEB282004F;
        Thu,  2 Feb 2023 10:10:03 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.56])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Feb 2023 10:10:03 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com, apopple@nvidia.com,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] RDMA/siw: Fix user page pinning accounting
Date:   Thu,  2 Feb 2023 11:10:00 +0100
Message-Id: <20230202101000.402990-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Sjl9m4eF05KHdmPhDkUm4Bv_sCq9cglm
X-Proofpoint-GUID: Sjl9m4eF05KHdmPhDkUm4Bv_sCq9cglm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 mlxscore=0 mlxlogscore=698
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302020088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Alistair Popple <apopple@nvidia.com>
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

