Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C90B2FF26D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 18:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbhAURub (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 12:50:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34568 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389138AbhAURu3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 12:50:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LHiVUL025764;
        Thu, 21 Jan 2021 17:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=g1RiJfLYb3t7A1iOCvX+EpuuS96sGsVoWA0CHrGekAY=;
 b=M4jUrNYgy+/WTuUPln3lIz6aQaTCuP1e3bDEqD0rEtETCBR+bYPpSFzGLd+qukA1yzqB
 H/KiN+Zy9dbSdspI9qvyZ+W0ijYjLKjBIHVbqLOOtsWqjT/hSnTV+s0PKWdzL3mdM/+9
 NwQ9LZ8PUoedAOd7LdJZmAGRx82YaqxFFmjs/o+sFXds9WCGIngHjxYcVuSDQkJ4y3Le
 LQ6XI8YuQsIJocJ7vO4nMxoGvlbPCjAzYyOu7PQNX3whbTfrFMZHzH/LoW/YIuRLlG+w
 b1VFqKE2C4ScQ714GF/5OC/K5If4yQkTrtMzLyL7AnT7674ExJrgTQvX1mgPAmgR2MXk AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3668qn0j6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 17:49:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LHkFYm168415;
        Thu, 21 Jan 2021 17:47:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3668rg4t8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 17:47:39 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10LHla0q013305;
        Thu, 21 Jan 2021 17:47:37 GMT
Received: from mbpatil-test01.us.oracle.com (/10.211.44.151)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jan 2021 09:47:36 -0800
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        valentinef@mellanox.com, gustavoars@kernel.org
Cc:     haakon.bugge@oracle.com, manjunath.b.patil@oracle.com,
        linux-rdma@vger.kernel.org
Subject: [PATCH] IB/ipoib: improve latency in ipoib/cm connection formation
Date:   Thu, 21 Jan 2021 09:50:03 -0800
Message-Id: <1611251403-12810-1-git-send-email-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210092
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ipoib connected mode presently queries the device[HCA] to get P_Key
table entry during connection formation. This will increase the time
taken to form the connection, especially when limited P_Keys are in use.
This gets worse when multiple connection attempts are done in parallel.
Improve this by using the cached version of ib_find_pkey().

This improved the latency from 500ms to 3ms on an internal setup.

Suggested-by: Haakon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index 8f0b598..013a1d8 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -40,6 +40,7 @@
 #include <linux/moduleparam.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
+#include <rdma/ib_cache.h>
 
 #include "ipoib.h"
 
@@ -1122,7 +1123,8 @@ static int ipoib_cm_modify_tx_init(struct net_device *dev,
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	struct ib_qp_attr qp_attr;
 	int qp_attr_mask, ret;
-	ret = ib_find_pkey(priv->ca, priv->port, priv->pkey, &qp_attr.pkey_index);
+	ret = ib_find_cached_pkey(priv->ca, priv->port, priv->pkey,
+						&qp_attr.pkey_index);
 	if (ret) {
 		ipoib_warn(priv, "pkey 0x%x not found: %d\n", priv->pkey, ret);
 		return ret;
-- 
1.7.1

