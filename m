Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A96876FC
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406188AbfHIKOY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 06:14:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39366 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfHIKOY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Aug 2019 06:14:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79ADYiM069930;
        Fri, 9 Aug 2019 10:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=ZWbEpnhuB30Qt2a9BaYNxLpabBsXHKx4OLlX4Pl7K+4=;
 b=Vd2neWGq8LPqX85WozffXswKiyzWJ9c4RcmrC+cVsfPkla73LlZ2M1KPd+2KnGa0E6xm
 KjSVdMx27GswBthk74MedM8THC9DCFXhHirVmMJiuf1KFTNQdZTzbYu5CZTxk4Tq5Y4w
 W/nyJA8vN+LZ4mWJFVnBJ+wZijIf+1oRszs/ub0B3SuPThfkH62CTqKXbps7/gCDgFbB
 C4hTTu7hnyfSJ3SXVHzWUtWFQkDKUv1QCkyodAvwGRPSnuXXUMs1kL7ZP9VIg/CJnSoa
 hqCeM7wUZ6JjV2L/ojCsL25zRjXxZf2QXxZgrMgu93GEEWFOS+TvcEX2qs1O5WKHpXtv 7w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=ZWbEpnhuB30Qt2a9BaYNxLpabBsXHKx4OLlX4Pl7K+4=;
 b=geBIQjnYeKVGUQ5v55kbLdJxO1U27U9qfOGJHmQexTQxCf79/V0NbQohziiGjLymAxGC
 U/AhKxQbQEixAvCGh6kbZ27cLOThzKQwVEqGMa6+AHzSC/fripTfKXqHYn2txNGub3K1
 aX4NGjX7Tungbk017juSG1CIIpbK2bQ5ozfjd0g1O8c/weljcIL8i0WTrJGNdzL/bMrT
 upgMOwWrQPxySEinazrDP8YTn2hLT+eCoJqQwQDxhLU1E5Fk83o1FNB6o/AGSFj/r7Ii
 Xcfk41FkHwyed0qZNbkq7BFounTOQoW5uNdudxqu43Vd2PLSMxtLzwMhV/hp2dTtwHaQ OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u8hasenms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 10:14:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79ADrvH110134;
        Fri, 9 Aug 2019 10:14:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2u90t7at4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 10:14:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x79ADSkS001789;
        Fri, 9 Aug 2019 10:13:28 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Aug 2019 03:13:28 -0700
Date:   Fri, 9 Aug 2019 13:13:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Mark Zhang <markz@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/core: Fix error code in stat_get_doit_qp()
Message-ID: <20190809101311.GA17867@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908090106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908090106
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We need to set the error codes on these paths.  Currently the only
possible error code is -EMSGSIZE so that's what the patch uses.

Fixes: 83c2c1fcbd08 ("RDMA/nldev: Allow get counter mode through RDMA netlink")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/core/nldev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e287b71a1cfd..cc08218f1ef7 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1952,12 +1952,16 @@ static int stat_get_doit_qp(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (fill_nldev_handle(msg, device) ||
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port) ||
-	    nla_put_u32(msg, RDMA_NLDEV_ATTR_STAT_MODE, mode))
+	    nla_put_u32(msg, RDMA_NLDEV_ATTR_STAT_MODE, mode)) {
+		ret = -EMSGSIZE;
 		goto err_msg;
+	}
 
 	if ((mode == RDMA_COUNTER_MODE_AUTO) &&
-	    nla_put_u32(msg, RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK, mask))
+	    nla_put_u32(msg, RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK, mask)) {
+		ret = -EMSGSIZE;
 		goto err_msg;
+	}
 
 	nlmsg_end(msg, nlh);
 	ib_device_put(device);
-- 
2.20.1

