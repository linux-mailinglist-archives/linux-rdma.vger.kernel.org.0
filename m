Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79335E9BB6
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 13:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJ3Mo1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Oct 2019 08:44:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44064 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfJ3Mo1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Oct 2019 08:44:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UChUtj062928;
        Wed, 30 Oct 2019 12:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=hjXJQzJc4al81yxlwcOSrDOdSsG+1fpvdzD3Lp+qPLY=;
 b=T5Mt/3WrukGnIB1hwM6uGkqF2if+FV9fHPH74L8xEEx15DWM/FN86yJBrde+QPyfVU/k
 Z4Rems3OX+6/VHKYFfLFc/Dz2qe3/QomC/onqQBMDhuXmmRZrCfVZKdg8rdSmVfwBUwX
 JbT9fUleXSA0p61Dqjsi5t3YI9a126LRmIUTnt8DH71G2kglccUgGhiEyv5HTkskpvgR
 rXqnAt/xT1cl7Jjq9NHs1KJav+uZXjEN/o3albcAhKfwVI2ibW6ehKnHMtaypW98l0wC
 IK8Jgf2recr6wFl/AhUxgwfuFevPVF97pxY0Ka3aXHaiJ9k7CVLdarBsIMXpnulyO+sN gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vxwhfbxkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 12:44:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UChkch007847;
        Wed, 30 Oct 2019 12:44:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vxwhw07eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 12:44:10 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9UCi881024861;
        Wed, 30 Oct 2019 12:44:08 GMT
Received: from dm-oel.no.oracle.com (/10.172.157.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 05:44:08 -0700
From:   Dag Moxnes <dag.moxnes@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        parav@mellanox.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dag.moxnes@oracle.com
Subject: [PATCH rdma-next v2] RDMA/cma: Use ACK timeout for RoCE packetLifeTime
Date:   Wed, 30 Oct 2019 13:44:00 +0100
Message-Id: <1572439440-17416-1-git-send-email-dag.moxnes@oracle.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300125
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

