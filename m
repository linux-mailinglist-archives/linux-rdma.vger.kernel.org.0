Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286EB3AE9E5
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhFUNV1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 09:21:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61328 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229651AbhFUNV1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 09:21:27 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LDBFJp027577;
        Mon, 21 Jun 2021 13:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Giiurc5vc+anUpSSqLP6Nk2zMi5r91umjyohWE//DOA=;
 b=nCOEn6BUlVUpJxzKez4DXqIwipyJx/ro0LswXtqnBdz9XzB2YC6zGnDEPFUKq3YudJX8
 RcjaRViFkZxPAOvZ+RElMAavPpg+9QMtf/vcMQzsuSIO3+f6+d/zVBzjJxKWzYmm+ZM8
 Om12fJF5L/Wh02p9cGcaWBpfrLPvAnkGLtkmXNp3d0eZM3fBtnQqMw1LSL2UD1ljOo+6
 I1zHuJCzHdP4hXrxc4VUGBiW76oxOZH24ejyWiWlwof6xzbMsYPjXztmn8rG6mJafR0r
 niB5q9TeN/YeLxtdpQn7wW+/9tIteK2LYekE+oZ5wohrWH+zjRGJb7WH4lEJll0IpzF2 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39as86r9ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 13:19:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LDBNtc158564;
        Mon, 21 Jun 2021 13:19:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3998d5uu2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 13:19:09 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15LDF9os173322;
        Mon, 21 Jun 2021 13:19:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3998d5uu2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 13:19:08 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15LDJ7hG011366;
        Mon, 21 Jun 2021 13:19:07 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jun 2021 13:19:06 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
Subject: [PATCH for-next] RDMA/cma: Fix incorrect Packet Lifetime calculation
Date:   Mon, 21 Jun 2021 15:18:57 +0200
Message-Id: <1624281537-5573-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rpY4RU_btvast_eKkFlwxDTIrUlNtsr4
X-Proofpoint-GUID: rpY4RU_btvast_eKkFlwxDTIrUlNtsr4
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

An approximation for the PacketLifeTime is half the local ACK timeout.
The encoding for both timers are logarithmic. The PacketLifeTime
calculation is wrong when local ACK timeout is zero. In that case,
PacketLifeTime is set to the incorrect value 255.

Fixed by explicitly testing for timeout being zero.

Fixes: e1ee1e62bec4 ("RDMA/cma: Use ACK timeout for RoCE packetLifeTime")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

	* Note: This commit must be merged after ("RDMA/cma: Replace
          RMW with atomic bit-ops")
---
 drivers/infiniband/core/cma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 6759889..b1512ca 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3096,9 +3096,11 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	 * PacketLifeTime = local ACK timeout/2
 	 * as a reasonable approximation for RoCE networks.
 	 */
-	route->path_rec->packet_life_time =
-		test_bit(TIMEOUT_SET, &id_priv->flags) ?
-		id_priv->timeout - 1 : CMA_IBOE_PACKET_LIFETIME;
+	if (test_bit(TIMEOUT_SET, &id_priv->flags))
+		route->path_rec->packet_life_time =
+			id_priv->timeout ? id_priv->timeout - 1 : 0;
+	else
+		route->path_rec->packet_life_time = CMA_IBOE_PACKET_LIFETIME;
 
 	if (!route->path_rec->mtu) {
 		ret = -EINVAL;
-- 
1.8.3.1

