Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2B5865C5
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 09:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiHAHjT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 03:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHAHjS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 03:39:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270E73A4AA;
        Mon,  1 Aug 2022 00:39:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2717YJ7F029450;
        Mon, 1 Aug 2022 07:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=NsBa7DGC9faUA1dOH811TIzi5P9/Syp89idMZPaQges=;
 b=OQLqSXrxBbpJ1jhbWRTT0y4Zotf/w8m6dcaZQi6MauFtHpRnrouSQ13HUO64U1QEBREy
 EdYij2zQlUTiFPmu1NGAoqNS60+QhMDeh7aW522P51sErPuQwj6b2ccbi8ifrw0mqkF4
 mDLvRlHlPboMtFOTZ0v0ry0dBCwt5OW7tbsHQkhi8WvGfidly+D5XiW0rrbcVCj1jO37
 4nPnoiOd6VQVlSwG1Hi6bmEl8oTWrgap1OJ0Z1IU0JoCp0RD8wTtmtu/qzHVRZ7U5RDi
 Xs4DdNe8g8s5p3RogGSzNKylIBfTiTikp0HyU6s0q0zpTn+Z8Sk/0jKD8dsbshRCPYli ZA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80tt5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 07:39:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2716hlpb001018;
        Mon, 1 Aug 2022 07:39:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57px0b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 07:39:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2717d7Re020359;
        Mon, 1 Aug 2022 07:39:07 GMT
Received: from localhost.us.oracle.com (iret.us.oracle.com [10.135.120.58])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3hp57px0ar-1;
        Mon, 01 Aug 2022 07:39:07 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, rpearsonhpe@gmail.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH] RDMA/rxe: Correct error handling in routines allocating xarray entries
Date:   Mon,  1 Aug 2022 01:38:50 -0600
Message-Id: <20220801073850.841628-1-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_03,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010036
X-Proofpoint-ORIG-GUID: IJT2fa4bPg_zcpmGDNBhEjGBxAqPHKfB
X-Proofpoint-GUID: IJT2fa4bPg_zcpmGDNBhEjGBxAqPHKfB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The current code will report an error if xa_alloc_cyclic() returns
non-zero, but it will return 1 if it wrapped indices before successfully
allocating an entry.

An error should only be reported if the call actually failed (denoted by
a return value < 0.)

Fixes: 3225717f6dfa2 ("RDMA/rxe: Replace red-black trees by xarrays")
Signed-off-by: William Kucharski <william.kucharski@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 19b14826385b..e9f3bbd8d605 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -139,7 +139,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
 			      &pool->next, GFP_KERNEL);
-	if (err)
+	if (err < 0)
 		goto err_free;
 
 	return obj;
@@ -167,7 +167,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 
 	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
 			      &pool->next, GFP_KERNEL);
-	if (err)
+	if (err < 0)
 		goto err_cnt;
 
 	return 0;
-- 
2.37.1

