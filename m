Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4CF64F101
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Dec 2022 19:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiLPScu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 13:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiLPScc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 13:32:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D61876150
        for <linux-rdma@vger.kernel.org>; Fri, 16 Dec 2022 10:32:30 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGIOXLc022323;
        Fri, 16 Dec 2022 18:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3VYgwHILKJIGQJ7iXyVh6SE1IvngdutFSY57pJpeIbQ=;
 b=EfJnvJuWuIx1SCN0a8DABBgJWGGaqV/rFfWsXk5El2xxJ4bEMRGDJbN46Rmnimh5LOf3
 tn0fvhQ5HhS+Zgz0kUaGY2krTCF77xlm07KBEAwNNAEAx+LzZgxI9X+0cMRqf0Lh5q4J
 jpqqZD54E+xMs2nIZo+aOx+0bDyH5BlZ9w/xBT/k5HtGAnClz1q5bV8uoLxgEQZptXv5
 gc2Or8fLIu05QXX1bZjkTwJgH+MdIi9L9GI3lvvNAvg05715/sp6vjqKd3tXejRlugbl
 vbdO3Uh0/TEpbI6ezUgcuW4nZ22rDVd8q/Bvhm775Dihz0AyUtQ09iCk/T1cUBwOagxF dw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgwx7g596-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 18:32:25 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGFoD1C026978;
        Fri, 16 Dec 2022 18:32:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3meyjbmtya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 18:32:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BGIWKou48038354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 18:32:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 598A620043;
        Fri, 16 Dec 2022 18:32:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3735520040;
        Fri, 16 Dec 2022 18:32:20 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.56])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 16 Dec 2022 18:32:20 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com, David.Laight@ACULAB.COM,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] RDMA/siw: Fix missing permission check in user buffer registration
Date:   Fri, 16 Dec 2022 19:32:09 +0100
Message-Id: <20221216183209.21183-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jWEamfJsBp-CDBdU7zXrHwLIpnNYmM58
X-Proofpoint-GUID: jWEamfJsBp-CDBdU7zXrHwLIpnNYmM58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_12,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=586 suspectscore=0 malwarescore=0 clxscore=1011 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

User communication buffer registration lacks check of access
rights for provided address range. Using pin_user_pages_fast()
instead of pin_user_pages() during user page pinning implicitely
introduces the necessary check. It furthermore tries to avoid
grabbing the mmap_read_lock.

Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index b2b33dd3b4fa..ba28a5d94fc1 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -423,8 +423,8 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 		while (nents) {
 			struct page **plist = &umem->page_chunk[i].plist[got];
 
-			rv = pin_user_pages(first_page_va, nents, foll_flags,
-					    plist, NULL);
+			rv = pin_user_pages_fast(first_page_va, nents,
+						 foll_flags, plist);
 			if (rv < 0)
 				goto out_sem_up;
 
-- 
2.32.0

