Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9241CE2E8
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgEKSh5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 14:37:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34546 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbgEKSh4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 14:37:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BIU6VI047513;
        Mon, 11 May 2020 18:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=o2Wd6AVJcjQ9UAZKHtfz3mKNd89I7uzGCOYh5hnOCJ0=;
 b=TGEz8KBR641F9ja3mOp7wXr+YuyMuSq3SPPmvJTu2GxS/dVsW0qCmbl3dtS7wEb/4EyV
 /pDSziajRoLgTqvt/Vv0h5v9HTGuLrFnydAW6e8HP5gOXjo3HW10I9GyPPGn1kZA3kAv
 K1kGo0RM7HuFxOAIY+TUliCh2YYA2svUm0btMlzlSfYRKiYjXk+gnvYEsNpwGTmjMNHY
 sDLWsUBzD3l8SSDz1VuMQOsJ/pA0j8nq7pKZueiIeXHqNNep2qNZYq3YVd6ZnAC1fQS8
 1mZ3hSC2L6yOsHxToNk/y7B49h/7OJpBTXQ2k08UqTHdxMp09whXMBMsDdqxKpHEil+G ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30x3gsetx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 18:37:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BITiHC174467;
        Mon, 11 May 2020 18:37:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30x69rhu59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 18:37:50 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04BIbnnp029714;
        Mon, 11 May 2020 18:37:49 GMT
Received: from mwanda (/10.175.212.140)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 11:37:49 -0700
Date:   Mon, 11 May 2020 21:37:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhu Yanjun <yanjunz@mellanox.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Return -EFAULT if copy_from_user() fails
Message-ID: <20200511183742.GB225608@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110141
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This function used to always return -EINVAL but we updated it to try
preserve the error codes.  Unfortunately the copy_to_user() is returning
the number of bytes remaining to be copied instead of a negative error
code.

Fixes: a3a974b4654d ("RDMA/rxe: Always return ERR_PTR from rxe_create_mmap_info()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_queue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index fef2ab5112de5..245040c3a35d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -50,9 +50,10 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
 			goto err1;
 		}
 
-		err = copy_to_user(outbuf, &ip->info, sizeof(ip->info));
-		if (err)
+		if (copy_to_user(outbuf, &ip->info, sizeof(ip->info))) {
+			err = -EFAULT;
 			goto err2;
+		}
 
 		spin_lock_bh(&rxe->pending_lock);
 		list_add(&ip->pending_mmaps, &rxe->pending_mmaps);
-- 
2.26.2

