Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757104035F6
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 10:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348064AbhIHIUU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 04:20:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347922AbhIHIUF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 04:20:05 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1888FZL8066502;
        Wed, 8 Sep 2021 04:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=I8hQID+vSl4NuGAz5BcL53/xBmYYHTKXcGDR/m62xHs=;
 b=IHYqrDqCv9N2sXodaEObTicja4e1WXMahY8R5G5EStus4Ex9iz9wQYo5OeSkF49pJHO9
 bl/vpHTMvXhXgBK5bLFivWj/V4Rux4K2Ni9hP/suAJZ2uzW+EiM2B5qr6/aphMrXmE9k
 DiGwJgOKxHDUBBgpzNoL3lpEBSOSqQ1F1AvM9udLjuNvZH6ucPAfhcfSvSPv9Ibs4MIM
 OCyNsEDpg5Ez3I0lcEQQ6uMi2QiwXnubY4SJmD00YQ0sCrHoJmOCbd8adcDuPFzRJ+oh
 OpdDFt66IYrcKGlmJFawAm7+Zmn6OLy+kdAIYud3iXD+oVlphscrIkK8IpW/slW7Mbuw Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axsgh02vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 04:18:55 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1888H171074410;
        Wed, 8 Sep 2021 04:18:55 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axsgh02ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 04:18:55 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1888DELK004077;
        Wed, 8 Sep 2021 08:18:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3axcnpwqh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 08:18:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1888EZMX49086972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 08:14:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2250CAE051;
        Wed,  8 Sep 2021 08:18:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA431AE057;
        Wed,  8 Sep 2021 08:18:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 08:18:49 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH RESEND 1/2] RDMA/mlx5: Fix number of allocated XLT entries
Date:   Wed,  8 Sep 2021 10:18:48 +0200
Message-Id: <20210908081849.7948-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jk9eflSBmvLEUmiylPKxmqx_jE3ENBIu
X-Proofpoint-ORIG-GUID: FrX2j6NT2dd7x53NtNiv85E-63fy18LR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_03:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080047
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

