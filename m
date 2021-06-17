Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535533AB42C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhFQNBy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 09:01:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53938 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232143AbhFQNBy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 09:01:54 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HCua3U019866;
        Thu, 17 Jun 2021 12:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Zsj+I1NlppUww75NwhdAtw97U2c89KyFtMw2MPUQBnw=;
 b=0WMVGo0QJiLMSNSsLNJGe/WAp7Yf+ZUVipXCWNM06caSVsSXOAdnH7+/6bAZGHPYF/Ey
 s3RCsfGnR2RX8wcWzh80PhXJwHyZe98yn2+hAkhtwkyNcW3zrc7XbXji9CxwDno/JeNx
 3GcsGL0RDmX7CcIgh8oO1+iGXAtJH1F5UbTan4e+X1u79T5xHtQtIdyUr0d/lR86lq9h
 77uiww2qXY6CvSEFhPxoibXoIltO6TKoXX9lwPxQ5l+LEZRiB/SWPSL6HZ6tnnm95hQR
 qHBBZxRqVmXUkKWwiFYYenym5WBSZH++t3lDz6DLYXC8rai5tFy04vtjYBjIIva+OliL 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 396tr0vgc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 12:59:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15HCstjb002519;
        Thu, 17 Jun 2021 12:59:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 396waq4saa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 12:59:41 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15HCtkac004440;
        Thu, 17 Jun 2021 12:59:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 396waq4s7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 12:59:40 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15HCxXFu008487;
        Thu, 17 Jun 2021 12:59:33 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jun 2021 05:59:33 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
Subject: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Date:   Thu, 17 Jun 2021 14:59:25 +0200
Message-Id: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: T1_DOjYoSrFggb8A2tTo6oDpJD9Xgxgm
X-Proofpoint-ORIG-GUID: T1_DOjYoSrFggb8A2tTo6oDpJD9Xgxgm
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The struct rdma_id_private contains three bit-fields, tos_set,
timeout_set, and min_rnr_timer_set. These are set by accessor
functions without any synchronization. If two or all accessor
functions are invoked in close proximity in time, there will be
Read-Modify-Write from several contexts to the same variable, and the
result will be intermittent.

Replace with a flag variable and an inline function for set with
appropriate memory barriers and the use of test_bit().

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Hans Westgaard Ry<hans.westgaard.ry@oracle.com>

---
	v1 -> v2:
	   * Removed define wizardry and replaced with a set function
             with memory barriers. Suggested by Leon.
	   * Removed zero-initialization of flags, due to kzalloc(),
             as suggested by Leon
	   * Review comments from Stefan implicitly adapted due to
             first bullet above
	   * Moved defines and inline function from header file to
             cma.c, as suggested by the undersigned
	   * Renamed enum to cm_id_priv_flag_bits as suggested by the
             undersigned
---
 drivers/infiniband/core/cma.c      | 38 +++++++++++++++++++++++++-------------
 drivers/infiniband/core/cma_priv.h |  4 +---
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2b9ffc2..cc8ad82 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -48,6 +48,21 @@
 #define CMA_IBOE_PACKET_LIFETIME 18
 #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
 
+static void set_bit_mb(unsigned long nr, unsigned long *flags)
+{
+	/* set_bit() does not imply a memory barrier */
+	smp_mb__before_atomic();
+	set_bit(nr, flags);
+	/* set_bit() does not imply a memory barrier */
+	smp_mb__after_atomic();
+}
+
+enum cm_id_priv_flag_bits {
+	TOS_SET,
+	TIMEOUT_SET,
+	MIN_RNR_TIMER_SET,
+};
+
 static const char * const cma_events[] = {
 	[RDMA_CM_EVENT_ADDR_RESOLVED]	 = "address resolved",
 	[RDMA_CM_EVENT_ADDR_ERROR]	 = "address error",
@@ -844,9 +859,6 @@ static void cma_id_put(struct rdma_id_private *id_priv)
 	id_priv->id.event_handler = event_handler;
 	id_priv->id.ps = ps;
 	id_priv->id.qp_type = qp_type;
-	id_priv->tos_set = false;
-	id_priv->timeout_set = false;
-	id_priv->min_rnr_timer_set = false;
 	id_priv->gid_type = IB_GID_TYPE_IB;
 	spin_lock_init(&id_priv->lock);
 	mutex_init(&id_priv->qp_mutex);
@@ -1134,10 +1146,10 @@ int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
 		ret = -ENOSYS;
 	}
 
-	if ((*qp_attr_mask & IB_QP_TIMEOUT) && id_priv->timeout_set)
+	if ((*qp_attr_mask & IB_QP_TIMEOUT) && test_bit(TIMEOUT_SET, &id_priv->flags))
 		qp_attr->timeout = id_priv->timeout;
 
-	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) && id_priv->min_rnr_timer_set)
+	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) && test_bit(MIN_RNR_TIMER_SET, &id_priv->flags))
 		qp_attr->min_rnr_timer = id_priv->min_rnr_timer;
 
 	return ret;
@@ -2472,7 +2484,7 @@ static int cma_iw_listen(struct rdma_id_private *id_priv, int backlog)
 		return PTR_ERR(id);
 
 	id->tos = id_priv->tos;
-	id->tos_set = id_priv->tos_set;
+	id->tos_set = test_bit(TOS_SET, &id_priv->flags);
 	id->afonly = id_priv->afonly;
 	id_priv->cm_id.iw = id;
 
@@ -2533,7 +2545,7 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	cma_id_get(id_priv);
 	dev_id_priv->internal_id = 1;
 	dev_id_priv->afonly = id_priv->afonly;
-	dev_id_priv->tos_set = id_priv->tos_set;
+	dev_id_priv->flags = id_priv->flags;
 	dev_id_priv->tos = id_priv->tos;
 
 	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
@@ -2582,7 +2594,7 @@ void rdma_set_service_type(struct rdma_cm_id *id, int tos)
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->tos = (u8) tos;
-	id_priv->tos_set = true;
+	set_bit_mb(TOS_SET, &id_priv->flags);
 }
 EXPORT_SYMBOL(rdma_set_service_type);
 
@@ -2610,7 +2622,7 @@ int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout)
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->timeout = timeout;
-	id_priv->timeout_set = true;
+	set_bit_mb(TIMEOUT_SET, &id_priv->flags);
 
 	return 0;
 }
@@ -2647,7 +2659,7 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->min_rnr_timer = min_rnr_timer;
-	id_priv->min_rnr_timer_set = true;
+	set_bit_mb(MIN_RNR_TIMER_SET, &id_priv->flags);
 
 	return 0;
 }
@@ -3033,7 +3045,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 
 	u8 default_roce_tos = id_priv->cma_dev->default_roce_tos[id_priv->id.port_num -
 					rdma_start_port(id_priv->cma_dev->device)];
-	u8 tos = id_priv->tos_set ? id_priv->tos : default_roce_tos;
+	u8 tos = test_bit(TOS_SET, &id_priv->flags) ? id_priv->tos : default_roce_tos;
 
 
 	work = kzalloc(sizeof *work, GFP_KERNEL);
@@ -3081,7 +3093,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	 * PacketLifeTime = local ACK timeout/2
 	 * as a reasonable approximation for RoCE networks.
 	 */
-	route->path_rec->packet_life_time = id_priv->timeout_set ?
+	route->path_rec->packet_life_time = test_bit(TIMEOUT_SET, &id_priv->flags) ?
 		id_priv->timeout - 1 : CMA_IBOE_PACKET_LIFETIME;
 
 	if (!route->path_rec->mtu) {
@@ -4107,7 +4119,7 @@ static int cma_connect_iw(struct rdma_id_private *id_priv,
 		return PTR_ERR(cm_id);
 
 	cm_id->tos = id_priv->tos;
-	cm_id->tos_set = id_priv->tos_set;
+	cm_id->tos_set = test_bit(TOS_SET, &id_priv->flags);
 	id_priv->cm_id.iw = cm_id;
 
 	memcpy(&cm_id->local_addr, cma_src_addr(id_priv),
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index 5c463da..5d3d0db 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -82,11 +82,9 @@ struct rdma_id_private {
 	u32			qkey;
 	u32			qp_num;
 	u32			options;
+	unsigned long		flags;
 	u8			srq;
 	u8			tos;
-	u8			tos_set:1;
-	u8                      timeout_set:1;
-	u8			min_rnr_timer_set:1;
 	u8			reuseaddr;
 	u8			afonly;
 	u8			timeout;
-- 
1.8.3.1

