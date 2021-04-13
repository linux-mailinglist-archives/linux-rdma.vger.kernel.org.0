Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCFE35E689
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 20:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347948AbhDMSgO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 14:36:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60316 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346394AbhDMSgO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 14:36:14 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DIPpwi174660;
        Tue, 13 Apr 2021 18:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=0imvL6Jb9rCZI7shRJIprPNbZODwoqXSQzDd1xQxwZc=;
 b=x4Gn1Oy2D8V7hWroAYrBTWRoJrJSxvzibqUouVnTnDIGS5l7KBYsvt5dOvJQ1eR09lm0
 PeUDyRkCOX7Kj9DWnyF5EfLOp66n2C9ZA/P7f0ZLU9dP5EbwWM4qPfesBjD7+ng0php/
 HfMZjfmAuh06iK3VkQLZ/Bgg00b2Ki7UjDZw3/WctYOrnJgfO3ZRM0by66/qefPZZ4wF
 yUmTpsUJwbVSd1MRRRGIlmowkQQ597EJfaIHClsSQDeBwLII8O4ZhGVNSiZZgr9muuhA
 cighuReSjDQdz1+9yqrL5dBhf+rGPRi8KWun6bwqt5Dnfs1GujpLJoghBfxJ9huYLM0Y Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37u1hbg72p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 18:35:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DIQNtB020988;
        Tue, 13 Apr 2021 18:35:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 37unxx7uk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 18:35:48 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13DIZkEJ016555;
        Tue, 13 Apr 2021 18:35:46 GMT
Received: from mbpatil-test01.us.oracle.com (/10.211.44.151)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 11:35:46 -0700
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        valentinef@mellanox.com, gustavoars@kernel.org
Cc:     haakon.bugge@oracle.com, manjunath.b.patil@oracle.com,
        rama.nichanamatlu@oracle.com, linux-rdma@vger.kernel.org
Subject: [PATCH v2] IB/ipoib: improve latency in ipoib/cm connection formation
Date:   Tue, 13 Apr 2021 11:36:05 -0700
Message-Id: <1618338965-16717-1-git-send-email-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130124
X-Proofpoint-GUID: lvkTphTcZ3xntYW0YjmJ7PW9aoPbzDqz
X-Proofpoint-ORIG-GUID: lvkTphTcZ3xntYW0YjmJ7PW9aoPbzDqz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130124
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently ipoib connected mode queries the device[HCA] to get pkey table
entry during connection formation. This will increase the time taken to
form the connection, especially when limited pkeys are in use.  This
gets worse when multiple connection attempts are done in parallel.

Since ipoib interfaces are locked to a single pkey, use the pkey index
that was determined at link up time instead of searching anything.

This improved the latency from 500ms to 1ms on an internal setup.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
v2: v1 used the cached version[ib_find_cached_pkey()] to get the pkey table
entry. Following the Jason's comments for v1, I switched to pkey index that was
determined at link up time in v2.

 drivers/infiniband/ulp/ipoib/ipoib_cm.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index d5d592b..9dbc85a 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1122,12 +1122,8 @@ static int ipoib_cm_modify_tx_init(struct net_device *dev,
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	struct ib_qp_attr qp_attr;
 	int qp_attr_mask, ret;
-	ret = ib_find_pkey(priv->ca, priv->port, priv->pkey, &qp_attr.pkey_index);
-	if (ret) {
-		ipoib_warn(priv, "pkey 0x%x not found: %d\n", priv->pkey, ret);
-		return ret;
-	}
 
+	qp_attr.pkey_index = priv->pkey_index;
 	qp_attr.qp_state = IB_QPS_INIT;
 	qp_attr.qp_access_flags = IB_ACCESS_LOCAL_WRITE;
 	qp_attr.port_num = priv->port;
-- 
1.7.1

