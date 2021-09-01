Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EEF3FD8AF
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 13:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbhIAL1c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 07:27:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238424AbhIAL12 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Sep 2021 07:27:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 181B9DmU066359;
        Wed, 1 Sep 2021 07:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=I8hQID+vSl4NuGAz5BcL53/xBmYYHTKXcGDR/m62xHs=;
 b=I3khhDdplqvZ5oVogjAD+VmwTrTwEMnLZy1z925LEZRxc6r7ImDJFg2P9xZxoUL/k7Vw
 7Whb5o4NaoQVJfVmbTI22cGlJu90pl4bzl0AxbNWUIzGc4O83aPpgjyebh8fOBduHvb/
 gcQ6MOcwLGVW2xBZDNAieebjybMtMYYEr2BJiFUWZCKoWzJOdKORg4qw+ps2sKnxJza6
 pKetmxh5N38xd9KALuAes/B7WHhBWEfZQHC01Wp5ZjS5jqJs6Mf6xu4ML81MVB+BCNH3
 7RdiQhKZ2XyHp9FnbuuWT0q28nnuSPV26rrGCqXVdlVI+Bn8N377qR4uxT/Rx72Z7mQz AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3at6xm2y2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 07:26:30 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 181BQUVq141314;
        Wed, 1 Sep 2021 07:26:30 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3at6xm2y1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 07:26:30 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 181BLprA003143;
        Wed, 1 Sep 2021 11:26:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3aqcs9sxjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 11:26:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 181BMRJm61669698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 11:22:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F9EDA511A;
        Wed,  1 Sep 2021 11:26:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9216A5118;
        Wed,  1 Sep 2021 11:26:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Sep 2021 11:26:25 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] RDMA/mlx5: Fix number of allocated XLT entries
Date:   Wed,  1 Sep 2021 13:26:24 +0200
Message-Id: <20210901112625.1638072-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SY0JeQrIrJgGNoQ5vIayw0bJxorvpMwJ
X-Proofpoint-ORIG-GUID: jX-96SmZr7F_k7ZprkhKbuYyKLtwNt5E
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_03:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010065
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In commit 8010d74b9965b ("RDMA/mlx5: Split the WR setup out of
mlx5_ib_update_xlt()") the allocation logic was split out of
mlx5_ib_update_xlt() and the logic was changed to enable better OOM
handling. Sadly this change introduced a miscalculation of the number of
entries that were actually allocated when under memory pressure where it
can actually become 0 which on s390 lets dma_map_single() fail.

It can also lead to corruption of the free pages list when the wrong
number of entries is used in the calculation of sg->length which is used
as argument for free_pages().

Fix this by using the allocation size instead of misusing
get_order(size).

Cc: stable@vger.kernel.org
Fixes: 8010d74b9965b ("RDMA/mlx5: Split the WR setup out of mlx5_ib_update_xlt()")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3f1c5a4f158b..19713cdd7b78 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1024,7 +1024,7 @@ static void *mlx5_ib_alloc_xlt(size_t *nents, size_t ent_size, gfp_t gfp_mask)
 
 	if (size > MLX5_SPARE_UMR_CHUNK) {
 		size = MLX5_SPARE_UMR_CHUNK;
-		*nents = get_order(size) / ent_size;
+		*nents = size / ent_size;
 		res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
 					       get_order(size));
 		if (res)
-- 
2.25.1

