Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6834E4A2B
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410349AbfJYLm1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 07:42:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53822 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfJYLm1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 07:42:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PBcvq1052730;
        Fri, 25 Oct 2019 11:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=O7w+ZyhYIJRus2QkwK5GMAVXf4qiZPD4foyde5oWwpg=;
 b=ZOY5/hfp6zt3ObuTbn54E8Xa9Mzj4utgwY+mEpBiaNKbKDC9KA8QnLkNoM6tDmj3So6Y
 LnpTy0bl+U4A+Byr/P77yyWMqpWdamsp5Hg43Vtlmrsu3q9BMk8qygClCtgvdcn/moUv
 cBZio8iaSfzKKr/vzqT0KgsDFZrSCKlcugbtT9CUB7vvU0gVFzIRtvywhfhvuAmadhex
 M05kXOQGhnhCoCat1jIhsIQNr4z2p/WF8ZxYJiRhLX8cjkrzfHeIaN2LQM7BRRDNOW1i
 /Mvd50L0SkS3YRt5rGz45NomlpqUqjuKSe9B2CA3TwRqxA56XfdO/aMO5xEFP/Jz0cZr GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4ra8kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 11:42:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PBcOAX047222;
        Fri, 25 Oct 2019 11:42:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vug0e4cnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 11:42:09 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9PBg8G4020274;
        Fri, 25 Oct 2019 11:42:08 GMT
Received: from dm-oel.no.oracle.com (/10.172.157.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Oct 2019 04:42:07 -0700
From:   Dag Moxnes <dag.moxnes@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        parav@mellanox.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dag.moxnes@oracle.com
Subject: [PATCH rdma-next] RDMA/cma: Use ACK timeout for RoCE packetLifeTime
Date:   Fri, 25 Oct 2019 13:42:01 +0200
Message-Id: <1572003721-26368-1-git-send-email-dag.moxnes@oracle.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250112
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The cma is currently using a hard-coded value, CMA_IBOE_PACKET_LIFETIME,
for the PacketLifeTime, as it can not be determined from the network.
This value might not be optimal for all networks.

The cma module supports the function rdma_set_ack_timeout to set the
ACK timeout for a QP associated with a connection. As per IBTA 12.7.34
local ACK timeout = (2 * PacketLifeTime + Local CA’s ACK delay).
Assuming a negligible local ACK delay, we can use
PacketLifeTime = local ACK timeout/2
as a reasonable approximation for RoCE networks.

Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
Change-Id: I200eda9d54829184e556c3c55d6a8869558d76b2
---
 drivers/infiniband/core/cma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c8566a4237..2c1b08bde2 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2530,7 +2530,9 @@ EXPORT_SYMBOL(rdma_set_service_type);
  * This function should be called before rdma_connect() on active side,
  * and on passive side before rdma_accept(). It is applicable to primary
  * path only. The timeout will affect the local side of the QP, it is not
- * negotiated with remote side and zero disables the timer.
+ * negotiated with remote side and zero disables the timer. In case it is
+ * set before rdma_resolve_route, the value will also be used to determine
+ * PacketLifeTime for RoCE.
  *
  * Return: 0 for success
  */
@@ -2939,7 +2941,16 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	route->path_rec->rate = iboe_get_rate(ndev);
 	dev_put(ndev);
 	route->path_rec->packet_life_time_selector = IB_SA_EQ;
-	route->path_rec->packet_life_time = CMA_IBOE_PACKET_LIFETIME;
+	/* In case ACK timeout is set, use this value to calculate
+	 * PacketLifeTime.  As per IBTA 12.7.34,
+	 * local ACK timeout = (2 * PacketLifeTime + Local CA’s ACK delay).
+	 * Assuming a negligible local ACK delay, we can use
+	 * PacketLifeTime = local ACK timeout/2
+	 * as a reasonable approximation for RoCE networks.
+	 */
+	route->path_rec->packet_life_time = id_priv->timeout_set ?
+		id_priv->timeout - 1 : CMA_IBOE_PACKET_LIFETIME;
+
 	if (!route->path_rec->mtu) {
 		ret = -EINVAL;
 		goto err2;
-- 
2.20.1

