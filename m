Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E825219F82C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2020 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgDFOpx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 10:45:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36414 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgDFOpx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Apr 2020 10:45:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036Ei0lI191916;
        Mon, 6 Apr 2020 14:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ab8FOoGvscaNUTYvuGpjgKfb/QVDTTSXEum2QrPCJOo=;
 b=zQPtherjzDTAHx6jrK422oZNX+ADlxhn7uIGGYxSLELnPnEaM4njd61ZSOhg1tbau6v5
 jom8GMyJI0zvWL4EKurD0Rtx4Gth2Xv/b0a2aX6klgkqUQQIB/FcTMhJXP8H49Sjf2V8
 FbyRBexg1ysHvnNIMbxujwcnRIG2cmt1qi7VlKxKpkgHs6JuLvF+5QXVWbCP9Kl4G/yz
 2uKi7rDKcPYJpjhYDcokFQvxqSNx0E4cgkhdZaBUKarStjLHCplEb8AfFAtvATdo5bNC
 kDFUAKN3Ac2tMFGE17zRB2igpRAv2GRckxp3Pn4IInx4jPWY3PNazMlRiafJRdcI4tHg 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 306hnqyaet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 14:45:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036EgP0h029960;
        Mon, 6 Apr 2020 14:43:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30839q6kfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 14:43:45 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036Ehhej022159;
        Mon, 6 Apr 2020 14:43:43 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 07:43:43 -0700
Date:   Mon, 6 Apr 2020 17:43:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/cm: Fix an error check in cm_alloc_id_priv()
Message-ID: <20200406144335.GD68494@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060122
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The xa_alloc_cyclic_irq() function returns either 0 or 1 on success and
negatives on error.  This code treats 1 as an error and returns
ERR_PTR(1) which will cause an Oops in the caller.

Fixes: e8dc4e885c45 ("RDMA/cm: Fix ordering of xa_alloc_cyclic() in ib_create_cm_id()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The Fixes tag may not be correct.  That's the patch which introduces an
Oops but we may want to backport this further back.

 drivers/infiniband/core/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 4794113ecd59..f7ac5974176f 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -862,7 +862,7 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
 
 	ret = xa_alloc_cyclic_irq(&cm.local_id_table, &id, NULL, xa_limit_32b,
 				  &cm.local_id_next, GFP_KERNEL);
-	if (ret)
+	if (ret < 0)
 		goto error;
 	cm_id_priv->id.local_id = (__force __be32)id ^ cm.random_id_operand;
 
-- 
2.25.1

