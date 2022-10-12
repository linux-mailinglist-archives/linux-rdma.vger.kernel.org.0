Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073DA5FC71A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Oct 2022 16:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJLOQ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Oct 2022 10:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJLOQ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Oct 2022 10:16:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8A669F7A
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 07:16:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CE3qY0012248;
        Wed, 12 Oct 2022 14:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=Oe/Kys43RAnTQ9BFdjyHBdz07vfOf8ZqyTFl0oxIJPI=;
 b=sPyCihOCOAA4xW/bgCVRDMOmG31cyiyJy5b/IBQBXcvGcrdRqXwOyMz5ph+IPCXHHhbT
 lWxlP4RE7j+meFFZ+pNd7umsLJ+oVY5NpP+uS74mxG2niT0lY3OWKMlV0mrQO3qvzgjC
 UkNqzwsd4pMalf+PqfSAONtifXTX3LBKGtCcEh8v1TRGMrCxCLjKyAuUFFpoyuNRtydB
 uGr/1XFa29KSJ0IxmZAa3MfJRWzDcZjy3AtyV6U8ZvL3BwHJ02ef+dks3QEOVGKR8Qy+
 ofXUcwa37tBNVSWa3PvTji0pLLiARA1O6YE4b1RPWXDDes8G2AXqpbGPVRl5/3wuZuRB 9A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3003244v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 14:16:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CDVISu008518;
        Wed, 12 Oct 2022 14:16:45 GMT
Received: from lab02.no.oracle.com (lab02.no.oracle.com [10.172.144.56])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3k2yn4w99v-1;
        Wed, 12 Oct 2022 14:16:44 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/cma: Use output interface for net_dev check
Date:   Wed, 12 Oct 2022 16:15:42 +0200
Message-Id: <20221012141542.16925-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_06,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210120094
X-Proofpoint-ORIG-GUID: lJ6kqLz25I6vX_KAIe0IeMMUUgV-JL1H
X-Proofpoint-GUID: lJ6kqLz25I6vX_KAIe0IeMMUUgV-JL1H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 27cfde795a96 ("RDMA/cma: Fix arguments order in net device
validation") swapped the src and dst addresses in the call to
validate_net_dev().

As a consequence, the test in validate_ipv4_net_dev() to see if the
net_dev is the right one, is incorrect for port 1 <-> 2 communication
when the ports are on the same sub-net. This is fixed by denoting the
flowi4_oif as the device instead of the incoming one.

The bug has not been observed using IPv6 addresses.

Fixes: 27cfde795a96 ("RDMA/cma: Fix arguments order in net device validation")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 925e1e7d1f1f3..2f95e12296fa2 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1634,7 +1634,7 @@ static bool validate_ipv4_net_dev(struct net_device *net_dev,
 		return false;
 
 	memset(&fl4, 0, sizeof(fl4));
-	fl4.flowi4_iif = net_dev->ifindex;
+	fl4.flowi4_oif = net_dev->ifindex;
 	fl4.daddr = daddr;
 	fl4.saddr = saddr;
 
-- 
2.16.2

