Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05803A9DA8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhFPOiO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 10:38:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63754 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232825AbhFPOiO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 10:38:14 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GEBTu2008269;
        Wed, 16 Jun 2021 14:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=XsZDZCPdfY4uaCUtLsnzTcSGyRJkFGjb/sGY2KVW0hQ=;
 b=ZvGcYUGD1JllsY0s2VuHC1EnKNant0fvm9cwaELb2wXbFxq3dVTpyYz/7wILxMQNkyLj
 9CsNhEG51PI9yatuvAMvfx7kY4Ixf4EuQ8Hf6AF+SDdhJHBC6URR76tB2FAF8dTrJzFu
 IsIgUE6hDudhZFm6Z/dW4xT0aKea/EHyn/7rGw4kHrsuXefW/jh1Qiy67L5DH4JSj1Nb
 W/DMGXrrJYyRQ57Sq0PJFz7e1xuwhWPHRcxUciUaMhLg6UXNixsLAWc41npJCQA7fzgj
 ya7l8WzFFaX/uAoywJdAgHdiRncY9OfRF+NmTOaEEvnhQPUXn3Yw+1AZgbNmHP7figEa hQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 396tjdteb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 14:36:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GEZUPY111218;
        Wed, 16 Jun 2021 14:36:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 396wawd39v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 14:36:02 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15GEa1Gr027441;
        Wed, 16 Jun 2021 14:36:01 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jun 2021 07:36:01 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Date:   Wed, 16 Jun 2021 16:35:53 +0200
Message-Id: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160084
X-Proofpoint-ORIG-GUID: k4konCyC_SQ_GHrHLEsGMgEHB9nyzBtr
X-Proofpoint-GUID: k4konCyC_SQ_GHrHLEsGMgEHB9nyzBtr
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The struct rdma_id_private contains three bit-fields, tos_set,
timeout_set, and min_rnr_timer_set. These are set by accessor
functions without any synchronization. If two or all accessor
functions are invoked in close proximity in time, there will be
Read-Modify-Write from several contexts to the same variable, and the
result will be intermittent.

Replace with a flag variable and inline functions for set and get.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Hans Westgaard Ry<hans.westgaard.ry@oracle.com>
---
 drivers/infiniband/core/cma.c      | 24 +++++++++++-------------
 drivers/infiniband/core/cma_priv.h | 28 +++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2b9ffc2..fe609e7 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -844,9 +844,7 @@ static void cma_id_put(struct rdma_id_private *id_priv)
 	id_priv->id.event_handler = event_handler;
 	id_priv->id.ps = ps;
 	id_priv->id.qp_type = qp_type;
-	id_priv->tos_set = false;
-	id_priv->timeout_set = false;
-	id_priv->min_rnr_timer_set = false;
+	id_priv->flags = 0;
 	id_priv->gid_type = IB_GID_TYPE_IB;
 	spin_lock_init(&id_priv->lock);
 	mutex_init(&id_priv->qp_mutex);
@@ -1134,10 +1132,10 @@ int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
 		ret = -ENOSYS;
 	}
 
-	if ((*qp_attr_mask & IB_QP_TIMEOUT) && id_priv->timeout_set)
+	if ((*qp_attr_mask & IB_QP_TIMEOUT) && get_TIMEOUT_SET(id_priv->flags))
 		qp_attr->timeout = id_priv->timeout;
 
-	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) && id_priv->min_rnr_timer_set)
+	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) && get_MIN_RNR_TIMER_SET(id_priv->flags))
 		qp_attr->min_rnr_timer = id_priv->min_rnr_timer;
 
 	return ret;
@@ -2472,7 +2470,7 @@ static int cma_iw_listen(struct rdma_id_private *id_priv, int backlog)
 		return PTR_ERR(id);
 
 	id->tos = id_priv->tos;
-	id->tos_set = id_priv->tos_set;
+	id->tos_set = get_TOS_SET(id_priv->flags);
 	id->afonly = id_priv->afonly;
 	id_priv->cm_id.iw = id;
 
@@ -2533,7 +2531,7 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	cma_id_get(id_priv);
 	dev_id_priv->internal_id = 1;
 	dev_id_priv->afonly = id_priv->afonly;
-	dev_id_priv->tos_set = id_priv->tos_set;
+	dev_id_priv->flags = id_priv->flags;
 	dev_id_priv->tos = id_priv->tos;
 
 	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
@@ -2582,7 +2580,7 @@ void rdma_set_service_type(struct rdma_cm_id *id, int tos)
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->tos = (u8) tos;
-	id_priv->tos_set = true;
+	set_TOS_SET(id_priv->flags);
 }
 EXPORT_SYMBOL(rdma_set_service_type);
 
@@ -2610,7 +2608,7 @@ int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout)
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->timeout = timeout;
-	id_priv->timeout_set = true;
+	set_TIMEOUT_SET(id_priv->flags);
 
 	return 0;
 }
@@ -2647,7 +2645,7 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	id_priv->min_rnr_timer = min_rnr_timer;
-	id_priv->min_rnr_timer_set = true;
+	set_MIN_RNR_TIMER_SET(id_priv->flags);
 
 	return 0;
 }
@@ -3033,7 +3031,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 
 	u8 default_roce_tos = id_priv->cma_dev->default_roce_tos[id_priv->id.port_num -
 					rdma_start_port(id_priv->cma_dev->device)];
-	u8 tos = id_priv->tos_set ? id_priv->tos : default_roce_tos;
+	u8 tos = get_TOS_SET(id_priv->flags) ? id_priv->tos : default_roce_tos;
 
 
 	work = kzalloc(sizeof *work, GFP_KERNEL);
@@ -3081,7 +3079,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	 * PacketLifeTime = local ACK timeout/2
 	 * as a reasonable approximation for RoCE networks.
 	 */
-	route->path_rec->packet_life_time = id_priv->timeout_set ?
+	route->path_rec->packet_life_time = get_TIMEOUT_SET(id_priv->flags) ?
 		id_priv->timeout - 1 : CMA_IBOE_PACKET_LIFETIME;
 
 	if (!route->path_rec->mtu) {
@@ -4107,7 +4105,7 @@ static int cma_connect_iw(struct rdma_id_private *id_priv,
 		return PTR_ERR(cm_id);
 
 	cm_id->tos = id_priv->tos;
-	cm_id->tos_set = id_priv->tos_set;
+	cm_id->tos_set = get_TOS_SET(id_priv->flags);
 	id_priv->cm_id.iw = cm_id;
 
 	memcpy(&cm_id->local_addr, cma_src_addr(id_priv),
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index 5c463da..2c1694f 100644
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
@@ -127,4 +125,28 @@ int cma_set_default_roce_tos(struct cma_device *dev, u32 port,
 			     u8 default_roce_tos);
 struct ib_device *cma_get_ib_dev(struct cma_device *dev);
 
+#define BIT_ACCESS_FUNCTIONS(b)							\
+	static inline void set_##b(unsigned long flags)				\
+	{									\
+		/* set_bit() does not imply a memory barrier */			\
+		smp_mb__before_atomic();					\
+		set_bit(b, &flags);						\
+		/* set_bit() does not imply a memory barrier */			\
+		smp_mb__after_atomic();						\
+	}									\
+	static inline bool get_##b(unsigned long flags)				\
+	{									\
+		return test_bit(b, &flags);					\
+	}
+
+enum cm_id_flag_bits {
+	TOS_SET,
+	TIMEOUT_SET,
+	MIN_RNR_TIMER_SET,
+};
+
+BIT_ACCESS_FUNCTIONS(TIMEOUT_SET);
+BIT_ACCESS_FUNCTIONS(TOS_SET);
+BIT_ACCESS_FUNCTIONS(MIN_RNR_TIMER_SET);
+
 #endif /* _CMA_PRIV_H */
-- 
1.8.3.1

