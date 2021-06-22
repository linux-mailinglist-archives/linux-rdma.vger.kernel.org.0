Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070483B05FB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFVNmd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 09:42:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62614 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231301AbhFVNmc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 09:42:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MDaGWV028984;
        Tue, 22 Jun 2021 13:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=aYtZf3IMmKHP1GJxZtQfwD7DeJ/N/J8BvyzSgdRjlrs=;
 b=FrMyyHhkDVNhRJ0J0XyvNLFxuDER/mlwbVFHuHVksaJ4Q0z/Ji1uZzs5A7a8gAhvgyvL
 8YwzNrTIc8wkySGp6argBKKJKLsv3Gvr9EVc2D+hUvPjx1bvA8W/zAcmqyPuw3KGZGXG
 FkFERCtDDUAiCqatbtIuhlzHCxHCLlvIBLPurgQ6YESXHFJ3uAMycUNJLe622DLmOLxH
 18ibDvLiQK41pt1DiJWaEKpla5p4WnIkm/URO/v6DSxhoszcOdyYgIOLt79MvIPk5Ngu
 cZ8bX9DQF4yxnLhPHhY75Lr0HrGhVUf3kAKrlRIRp8+di3Q432cqQtTd1S5J6qW3Nb3W fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39bf94r8r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:40:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MDZs0o028509;
        Tue, 22 Jun 2021 13:40:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 399tbsqpq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:40:09 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15MDe88E004249;
        Tue, 22 Jun 2021 13:40:08 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jun 2021 06:40:08 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH for-next v2 2/2] RDMA/cma: Protect RMW with qp_mutex
Date:   Tue, 22 Jun 2021 15:39:57 +0200
Message-Id: <1624369197-24578-3-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624369197-24578-1-git-send-email-haakon.bugge@oracle.com>
References: <1624369197-24578-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220085
X-Proofpoint-ORIG-GUID: yc2yjik4Jlk9POmX2lWLDzypJ6rZ62kb
X-Proofpoint-GUID: yc2yjik4Jlk9POmX2lWLDzypJ6rZ62kb
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The struct rdma_id_private contains three bit-fields, tos_set,
timeout_set, and min_rnr_timer_set. These are set by accessor
functions without any synchronization. If two or all accessor
functions are invoked in close proximity in time, there will be
Read-Modify-Write from several contexts to the same variable, and the
result will be intermittent.

Fixed by protecting the bit-fields by the qp_mutex in the accessor
functions.

The consumer of timeout_set and min_rnr_timer_set is in
rdma_init_qp_attr(), which is called with qp_mutex held for connected
QPs. Explicit locking is added for the consumers of tos and tos_set.

This commit depends on ("RDMA/cma: Remove unnecessary INIT->INIT
transition"), since the call to rdma_init_qp_attr() from
cma_init_conn_qp() does not hold the qp_mutex.

Fixes: 2c1619edef61 ("IB/cma: Define option to set ack timeout and pack tos_set")
Fixes: 3aeffc46afde ("IB/cma: Introduce rdma_set_min_rnr_timer()")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

	v1 -> v2
	    * Added mutex exclusion in cma_resolve_iboe_route()
              protecting timeout/timeout_set
---
 drivers/infiniband/core/cma.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 20c155c..c44a0c4 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2456,8 +2456,10 @@ static int cma_iw_listen(struct rdma_id_private *id_priv, int backlog)
 	if (IS_ERR(id))
 		return PTR_ERR(id);
 
+	mutex_lock(&id_priv->qp_mutex);
 	id->tos = id_priv->tos;
 	id->tos_set = id_priv->tos_set;
+	mutex_unlock(&id_priv->qp_mutex);
 	id->afonly = id_priv->afonly;
 	id_priv->cm_id.iw = id;
 
@@ -2518,8 +2520,10 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	cma_id_get(id_priv);
 	dev_id_priv->internal_id = 1;
 	dev_id_priv->afonly = id_priv->afonly;
+	mutex_lock(&id_priv->qp_mutex);
 	dev_id_priv->tos_set = id_priv->tos_set;
 	dev_id_priv->tos = id_priv->tos;
+	mutex_unlock(&id_priv->qp_mutex);
 
 	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
 	if (ret)
@@ -2566,8 +2570,10 @@ void rdma_set_service_type(struct rdma_cm_id *id, int tos)
 	struct rdma_id_private *id_priv;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
+	mutex_lock(&id_priv->qp_mutex);
 	id_priv->tos = (u8) tos;
 	id_priv->tos_set = true;
+	mutex_unlock(&id_priv->qp_mutex);
 }
 EXPORT_SYMBOL(rdma_set_service_type);
 
@@ -2594,8 +2600,10 @@ int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout)
 		return -EINVAL;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
+	mutex_lock(&id_priv->qp_mutex);
 	id_priv->timeout = timeout;
 	id_priv->timeout_set = true;
+	mutex_unlock(&id_priv->qp_mutex);
 
 	return 0;
 }
@@ -2631,8 +2639,10 @@ int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
 		return -EINVAL;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
+	mutex_lock(&id_priv->qp_mutex);
 	id_priv->min_rnr_timer = min_rnr_timer;
 	id_priv->min_rnr_timer_set = true;
+	mutex_unlock(&id_priv->qp_mutex);
 
 	return 0;
 }
@@ -3018,8 +3028,11 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 
 	u8 default_roce_tos = id_priv->cma_dev->default_roce_tos[id_priv->id.port_num -
 					rdma_start_port(id_priv->cma_dev->device)];
-	u8 tos = id_priv->tos_set ? id_priv->tos : default_roce_tos;
+	u8 tos;
 
+	mutex_lock(&id_priv->qp_mutex);
+	tos = id_priv->tos_set ? id_priv->tos : default_roce_tos;
+	mutex_unlock(&id_priv->qp_mutex);
 
 	work = kzalloc(sizeof *work, GFP_KERNEL);
 	if (!work)
@@ -3066,8 +3079,10 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	 * PacketLifeTime = local ACK timeout/2
 	 * as a reasonable approximation for RoCE networks.
 	 */
+	mutex_lock(&id_priv->qp_mutex);
 	route->path_rec->packet_life_time = id_priv->timeout_set ?
 		id_priv->timeout - 1 : CMA_IBOE_PACKET_LIFETIME;
+	mutex_unlock(&id_priv->qp_mutex);
 
 	if (!route->path_rec->mtu) {
 		ret = -EINVAL;
@@ -4091,8 +4106,11 @@ static int cma_connect_iw(struct rdma_id_private *id_priv,
 	if (IS_ERR(cm_id))
 		return PTR_ERR(cm_id);
 
+	mutex_lock(&id_priv->qp_mutex);
 	cm_id->tos = id_priv->tos;
 	cm_id->tos_set = id_priv->tos_set;
+	mutex_unlock(&id_priv->qp_mutex);
+
 	id_priv->cm_id.iw = cm_id;
 
 	memcpy(&cm_id->local_addr, cma_src_addr(id_priv),
-- 
1.8.3.1

