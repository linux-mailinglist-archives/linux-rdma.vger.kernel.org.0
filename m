Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44216A3F2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 11:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgBXKc3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 05:32:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48382 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXKc3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 05:32:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OASVtJ169490;
        Mon, 24 Feb 2020 10:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=cOngrNXmwHyG3MgkxmY2eZm2qcfLv8K7aRQ5kjlNfzw=;
 b=yylI7/naky65SIRW0/TnwkVpGeE9WShWWFIPK4EbsVbo94+s8pFpJqDtCDJFEGeiP4UL
 6L3o5gcenpfjYj1ocZmmecc/+aS2Zg84/Q9NgLtcC5xm18otWH/cI9LGeZsb432tGSf3
 CRih74SYgaPaJTz4mGhOgq6gH4alWDuxhN7meMXa6vnDOBkQjP6x/R3Q6WI3HC90//u1
 CJkVs1sdvIDPSYF5U50JBtsm5H39TxL3xzNjgjJwRKitGhiGE8oM6ylskTP3bg+/35tX
 ErLQkA3NQrlkhBNMvyxjzN82MX0H7tIobi35iMX/wKnxJiz7y9fadhnn/HRwGeEdKCCm Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yavxredw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 10:32:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OAWRHe163000;
        Mon, 24 Feb 2020 10:32:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 2ybdsgbw6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 10:32:27 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01OAWQ1D162987;
        Mon, 24 Feb 2020 10:32:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ybdsgbw5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 10:32:26 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OAWPHE032559;
        Mon, 24 Feb 2020 10:32:25 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 02:32:24 -0800
Date:   Mon, 24 Feb 2020 13:32:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, kernel-janitors@vger.kernel.org
Subject: [PATCH] net/rds: Fix a debug message
Message-ID: <20200224103215.utw3zaa6nmcb5vrz@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240090
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This should display the error code but instead it just prints "1".

Fixes: 2eafa1746f17 ("net/rds: Handle ODP mr registration/unregistration")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/rds/ib_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index b34b24e237f8..82a25bf280e3 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -587,8 +587,8 @@ void *rds_ib_get_mr(struct scatterlist *sg, unsigned long nents,
 				       access_flags);
 
 		if (IS_ERR(ib_mr)) {
-			rdsdebug("rds_ib_get_user_mr returned %d\n",
-				 IS_ERR(ib_mr));
+			rdsdebug("rds_ib_get_user_mr returned %ld\n",
+				 PTR_ERR(ib_mr));
 			ret = PTR_ERR(ib_mr);
 			goto out;
 		}
-- 
2.11.0

