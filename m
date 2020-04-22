Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52851B3B2A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2020 11:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgDVJYn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Apr 2020 05:24:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52878 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDVJYn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Apr 2020 05:24:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03M9IrnL176412;
        Wed, 22 Apr 2020 09:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ea4Xx2uOESGSTPL7fA9IjvUV0VptHdwXwCFtrgPNjUU=;
 b=ajetrHf9lZFg8wT1u2sn2/2qXuyMnXz1aPILUFurvTE7HLHzv5KIfuyZHW6jh1EkwyqM
 EK8G0ZJWtI0qHDkt25wozZwotcw3OMhGxjHBYRnMWDP9pyA2YJQ5WVX+aUcDhpiWRmFp
 5fafSWvO7FtZA+fDAKEw6UgClloLN0UzYSvQdUM1978DbP6lBx2+lw0+hey4h/R75M81
 PNJK+vSfBo9/5sE2HTwi+wvGQAK5cLCopXID62ssSPbQts1L2EIz8PVnMbgc9sepBwMW
 WrEY/X3ysKTI2yeAT2s5vBmLJGktS2OKCDQJpJs3pc/KoCFo113oJxxhxUkQseZfUnsf vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30jhyc0gca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 09:24:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03M9IJjl118960;
        Wed, 22 Apr 2020 09:22:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30gb1j45ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 09:22:20 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03M9MIxX023060;
        Wed, 22 Apr 2020 09:22:18 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Apr 2020 02:22:18 -0700
Date:   Wed, 22 Apr 2020 12:22:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Faisal Latif <faisal.latif@intel.com>
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Shannon Nelson <shannon.nelson@intel.com>,
        Anjali Singhai Jain <anjali.singhai@intel.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] i40iw: Fix error handling in i40iw_manage_arp_cache()
Message-ID: <20200422092211.GA195357@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 clxscore=1011 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220075
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The i40iw_arp_table() function can return -EOVERFLOW if
i40iw_alloc_resource() fails so we can't just test for "== -1".

Fixes: 4e9042e647ff ("i40iw: add hw and utils files")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/i40iw/i40iw_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_hw.c b/drivers/infiniband/hw/i40iw/i40iw_hw.c
index 55a1fbf0e670..ae8b97c30665 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_hw.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_hw.c
@@ -534,7 +534,7 @@ void i40iw_manage_arp_cache(struct i40iw_device *iwdev,
 	int arp_index;
 
 	arp_index = i40iw_arp_table(iwdev, ip_addr, ipv4, mac_addr, action);
-	if (arp_index == -1)
+	if (arp_index < 0)
 		return;
 	cqp_request = i40iw_get_cqp_request(&iwdev->cqp, false);
 	if (!cqp_request)
-- 
2.25.1

