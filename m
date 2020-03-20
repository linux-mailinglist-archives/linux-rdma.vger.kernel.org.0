Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21218CECB
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 14:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCTN05 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 09:26:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42178 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTN05 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 09:26:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KDEgYC107227;
        Fri, 20 Mar 2020 13:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=DlTqZ5VPFMu8PptUe+6BymhQykmmJXV/MZhQepjEmZw=;
 b=e7wSiYRsTWTzQKaPON+TeIzdIBPOccESo4AFPAfSx5FUMpHUHU7Sc7BhtDtMB4qQqs0n
 BOZXXAXXGEa3xp8VLAtTpzHaskl9XZCEXdncJs02hYlVvVDu6oF0y0SOtgZJ98X8PRfS
 b+KcKkYuJUL3h5a0MHZZUiCQn0QfSyZvca1nepxkj0Fl6btAc4TzVeSpeTTUTL3mDry3
 VwWGO3aUnu6Qe5fH+1Beg9tKSoMxjXb8VwHEAav9OgJEhf/IPCBAJEAfGp+DUtrscb5y
 8FbhE0GUBtvMZFgsp3lq9Po+FY37AkW4TOkp7n9yWC1GDBfPlxRQEchj59zHyKjCDiHm LA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yub27dgvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 13:26:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KDKlYZ080606;
        Fri, 20 Mar 2020 13:26:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ys906sk64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 13:26:50 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02KDQnJP011929;
        Fri, 20 Mar 2020 13:26:49 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Mar 2020 06:26:48 -0700
Date:   Fri, 20 Mar 2020 16:26:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] IB/mlx5: Fix a NULL vs IS_ERR() check
Message-ID: <20200320132641.GF95012@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200057
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The kzalloc() function returns NULL, not error pointers.

Fixes: 30f2fe40c72b ("IB/mlx5: Introduce UAPIs to manage packet pacing")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/mlx5/qos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qos.c b/drivers/infiniband/hw/mlx5/qos.c
index f822b06e7c9e..cac878a70edb 100644
--- a/drivers/infiniband/hw/mlx5/qos.c
+++ b/drivers/infiniband/hw/mlx5/qos.c
@@ -46,8 +46,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_PP_OBJ_ALLOC)(
 
 	dev = to_mdev(c->ibucontext.device);
 	pp_entry = kzalloc(sizeof(*pp_entry), GFP_KERNEL);
-	if (IS_ERR(pp_entry))
-		return PTR_ERR(pp_entry);
+	if (!pp_entry)
+		return -ENOMEM;
 
 	in_ctx = uverbs_attr_get_alloced_ptr(attrs,
 					     MLX5_IB_ATTR_PP_OBJ_ALLOC_CTX);
-- 
2.25.1

