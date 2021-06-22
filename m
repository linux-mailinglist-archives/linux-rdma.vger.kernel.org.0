Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BD3B072A
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFVOQF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 10:16:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50736 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231849AbhFVOQB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 10:16:01 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MEBQXX011528;
        Tue, 22 Jun 2021 14:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=eSU+WTx6On6FU4V7C5YtSQPKLMMsG6jwPy6mgPWY6ts=;
 b=E5Jb+YUo0p8dJDLCie3/OnTLfkyLM1KLbGqCezBN+g/IMUieu7RA0LWPFInp+Mtwfwns
 9B12EMvca3QQ+PDbn0dz4LwhOgZwqt9TyJu/MrkYxoZXDpaHwr0685dLo5l7hpf7+5Q2
 GJf6vpDdWd4lX3FGio7GYNsQP1lOiyDlquTDmRjUHSQHnoa6mU2tqfSOBE3QsETD2+0M
 MzfRWqDdL3GOQZNEmTKHBkvS39wfKaW23ekkp3w0dLSz8T/6/bk7i1EqrFOTFQFhZSW4
 djus5yo3ZwpmKD7QAN/vOp/6Ow8DlNXdO9bSM/Yuq4oTHkLPvg1DkylUrFgZt9fvnc+k 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvu9wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:13:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MEDXwl090282;
        Tue, 22 Jun 2021 14:13:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3998d7j28u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 14:13:39 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15MEDZoW027097;
        Tue, 22 Jun 2021 14:13:36 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jun 2021 07:13:35 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2] RDMA/cma: Fix incorrect Packet Lifetime calculation
Date:   Tue, 22 Jun 2021 16:13:27 +0200
Message-Id: <1624371207-26710-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10023 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220089
X-Proofpoint-ORIG-GUID: xC0EGpIjrtVqz2agXwFJqeoTvWyp4VwT
X-Proofpoint-GUID: xC0EGpIjrtVqz2agXwFJqeoTvWyp4VwT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

An approximation for the PacketLifeTime is half the local ACK timeout.
The encoding for both timers are logarithmic.

If the local ACK timeout is set, but zero, it means the timer is
disabled. In this case, we choose the CMA_IBOE_PACKET_LIFETIME value,
since 50% of infinite makes no sense.

Before this commit, the PacketLifeTime became 255 if local ACK
timeout was zero (not running).

Fixed by explicitly testing for timeout being zero.

Fixes: e1ee1e62bec4 ("RDMA/cma: Use ACK timeout for RoCE packetLifeTime")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

---

	v1 -> v2:
	   * Rebased on tip of for-next with ("RDMA/cma: Protect RMW
	     with qp_mutex") included
	   * A local ACK timeout of zero now sets PacketLifeTime to
             CMA_IBOE_PACKET_LIFETIME
	   * Added Leon's r-b
---
 drivers/infiniband/core/cma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c44a0c4..35fe300 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3080,8 +3080,10 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	 * as a reasonable approximation for RoCE networks.
 	 */
 	mutex_lock(&id_priv->qp_mutex);
-	route->path_rec->packet_life_time = id_priv->timeout_set ?
-		id_priv->timeout - 1 : CMA_IBOE_PACKET_LIFETIME;
+	if (id_priv->timeout_set && id_priv->timeout)
+		route->path_rec->packet_life_time = id_priv->timeout - 1;
+	else
+		route->path_rec->packet_life_time = CMA_IBOE_PACKET_LIFETIME;
 	mutex_unlock(&id_priv->qp_mutex);
 
 	if (!route->path_rec->mtu) {
-- 
1.8.3.1

