Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3DC3AE988
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhFUNA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 09:00:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48974 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229651AbhFUNA6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 09:00:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LCpJxu032722;
        Mon, 21 Jun 2021 12:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=BmBeXbaS3uMvaa4ooI87CkOg2RhliAhH/9eZUZLnEgY=;
 b=rcXSINDhNsjq3gnEPkyMXvOz7Rhu7tFlItRQr2ikc1OZ3Y2x9zWKcs98Kv+k+bEyHn64
 r+YsKXAQt0ScNiUOXmvz5D5wFCXLs8r/ly9ntm539YD6WI+WkJXbYaQHyX7GQHUs7w5/
 M5v4GJ4hvayFWxU1oPOkGqfJ3lG73Dd8K3gEWy0P4bI/UXFzlKLWyyVQdiAfbcSquHZ+
 rOq+ctaxszoxX5XnT2iGftzlcirw90mdVJ76hzhaG/zZ8p5v+8w3W0lHqZqWtLvWJjsL
 lKuOsljU9P6deb2DCw9HUIdDBBNkvZ90ZmUrycucsE1CHe/ZVYW6PYg47kxGFEvtKiyS 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ap66gp75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:58:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LCtYW2187300;
        Mon, 21 Jun 2021 12:58:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3996mbw5wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:58:39 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15LCwcud003881;
        Mon, 21 Jun 2021 12:58:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3996mbw5w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:58:38 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15LCwbbT000831;
        Mon, 21 Jun 2021 12:58:37 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jun 2021 12:58:37 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
Subject: [PATCH for-next v3] RDMA/cma: Replace RMW with atomic bit-ops
Date:   Mon, 21 Jun 2021 14:58:25 +0200
Message-Id: <1624280305-4233-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VzvXDp-vNroZ9KWZ8EmRQEOe0AuPZtFh
X-Proofpoint-GUID: VzvXDp-vNroZ9KWZ8EmRQEOe0AuPZtFh
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The struct rdma_id_private contains three bit-fields, tos_set,
timeout_set, and min_rnr_timer_set. These are set by accessor
functions without any synchronization. If two or all accessor
functions are invoked in close proximity in time, there will be
Read-Modify-Write from several contexts to the same variable, and the
result will be intermittent.

Replace with a flag variable and a function for set with appropriate
memory barriers and the use of test_bit().

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

	v2 -> v3:
	   * Fixed lines longer than 80 chars
	   * s/an inline function/a function/ in commit message
---
 drivers/infiniband/core/cma.c      | 42 ++++++++++++++++++++++++++------------
 drivers/infiniband/core/cma_priv.h |  4 +---
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2b9ffc2..6759889 100644
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
@@ -1134,10 +1146,12 @@ int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
 		ret = -ENOSYS;
 	}
 
-	if ((*qp_attr_mask & IB_QP_TIMEOUT) && id_priv->timeout_set)
+	if ((*qp_attr_mask & IB_QP_TIMEOUT) &&
+	    test_bit(TIMEOUT_SET, &id_priv->flags))
 		qp_attr->timeout = id_priv->timeout;
 
-	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) && id_priv->min_rnr_timer_set)
+	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) &&
+	    test_bit(MIN_RNR_TIMER_SET, &id_priv->flags))
 		qp_attr->min_rnr_timer = id_priv->min_rnr_timer;
 
 	return ret;
@@ -2472,7 +2486,7 @@ static int cma_iw_listen(struct rdma_id_private *id_priv, int backlog)
 		return PTR_ERR(id);
 
 	id->tos = id_priv->tos;
-	id->tos_set = id_priv->tos_set;
+	id->tos_set = test_bit(TOS_SET, &id_priv->flags);
 	id->afonly = id_priv->afonly;
 	id_priv->cm_id.iw = id;
 
@@ -2533,7 +2547,7 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	cma_id_get(id_priv);
 	dev_id_priv->internal_id = 1;
 	dev_id_priv->afonly = id_priv->afonly;
-	dev_id_priv->tos_set = id_priv->tos_set;
+	dev_id_priv->flags = id_priv->flags;
 	dev_id_priv->tos = id_priv->tos;
 
 	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
@@ -2582,7 +2596,7 @@ void rdma_set_service_type(struct rdma_cm_id *id, int tos)
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->tos = (u8) tos;
-	id_priv->tos_set = true;
+	set_bit_mb(TOS_SET, &id_priv->flags);
 }
 EXPORT_SYMBOL(rdma_set_service_type);
 
@@ -2610,7 +2624,7 @@ int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout)
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->timeout = timeout;
-	id_priv->timeout_set = true;
+	set_bit_mb(TIMEOUT_SET, &id_priv->flags);
 
 	return 0;
 }
@@ -2647,7 +2661,7 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->min_rnr_timer = min_rnr_timer;
-	id_priv->min_rnr_timer_set = true;
+	set_bit_mb(MIN_RNR_TIMER_SET, &id_priv->flags);
 
 	return 0;
 }
@@ -3033,7 +3047,8 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 
 	u8 default_roce_tos = id_priv->cma_dev->default_roce_tos[id_priv->id.port_num -
 					rdma_start_port(id_priv->cma_dev->device)];
-	u8 tos = id_priv->tos_set ? id_priv->tos : default_roce_tos;
+	u8 tos = test_bit(TOS_SET, &id_priv->flags) ?
+		id_priv->tos : default_roce_tos;
 
 
 	work = kzalloc(sizeof *work, GFP_KERNEL);
@@ -3081,7 +3096,8 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	 * PacketLifeTime = local ACK timeout/2
 	 * as a reasonable approximation for RoCE networks.
 	 */
-	route->path_rec->packet_life_time = id_priv->timeout_set ?
+	route->path_rec->packet_life_time =
+		test_bit(TIMEOUT_SET, &id_priv->flags) ?
 		id_priv->timeout - 1 : CMA_IBOE_PACKET_LIFETIME;
 
 	if (!route->path_rec->mtu) {
@@ -4107,7 +4123,7 @@ static int cma_connect_iw(struct rdma_id_private *id_priv,
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

