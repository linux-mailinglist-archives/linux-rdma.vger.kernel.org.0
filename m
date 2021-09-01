Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29C83FD8B4
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbhIAL2a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 07:28:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238424AbhIAL23 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Sep 2021 07:28:29 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 181B6E4h115861;
        Wed, 1 Sep 2021 07:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Mu5M7I9i5hra9BhSffiyO46jtV05C+BWthO2WT+CvIc=;
 b=fn76XqdMktbpzOSNSzO2c/J+tMW9JBj01Q0cKjAmKNgIGwu7fCr2CzqmyPjye3qHwvsS
 1WgkU26tlt7w35IDkN6RuswrDk014zs+IrxqQ1RwJpZ/NoHHoTBHox+IfsivOl4hPEOv
 I0lvNwy87vYMVNx6IVCYEtDX9ikPwlnJxDJRoMv4hvwTk6e95YU/4Bq7HiiupgsLTZ76
 NrWOzj5jFqd2vBHruUmUnJ1W4ZB666Ox0vQba+C9Imz735ZdHOn34FR3aOET4Ua0/EQi
 pSeQv7SGiVShxIClREhaxuyDQtKGVlHCkub2sqhp9xelvlS67UezhdbpRsD4GK2vIL0i EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3at7tkscvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 07:27:31 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 181B6Ut5117221;
        Wed, 1 Sep 2021 07:27:31 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3at7tkscv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 07:27:31 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 181BMvjD008500;
        Wed, 1 Sep 2021 11:26:29 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3aqcs989hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 11:26:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 181BMRn629688086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 11:22:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DCF6A5117;
        Wed,  1 Sep 2021 11:26:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A69FA5118;
        Wed,  1 Sep 2021 11:26:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Sep 2021 11:26:26 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] RDMA/mlx5: Fix xlt_chunk_align calculation
Date:   Wed,  1 Sep 2021 13:26:25 +0200
Message-Id: <20210901112625.1638072-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901112625.1638072-1-schnelle@linux.ibm.com>
References: <20210901112625.1638072-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q2qq2Y89jy_GCC0JHzySqiOxQR6Hwsu4
X-Proofpoint-ORIG-GUID: 3auItYpflAPU4kzSIl6nqNRRXIksQV7Q
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_03:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010065
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The XLT chunk alignment depends on ent_size not sizeof(ent_size) aka
sizeof(size_t).

Cc: stable@vger.kernel.org
Fixes: 8010d74b9965b ("RDMA/mlx5: Split the WR setup out of mlx5_ib_update_xlt()")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 19713cdd7b78..061dbee55cac 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -995,7 +995,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 static void *mlx5_ib_alloc_xlt(size_t *nents, size_t ent_size, gfp_t gfp_mask)
 {
 	const size_t xlt_chunk_align =
-		MLX5_UMR_MTT_ALIGNMENT / sizeof(ent_size);
+		MLX5_UMR_MTT_ALIGNMENT / ent_size;
 	size_t size;
 	void *res = NULL;
 
-- 
2.25.1

