Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637BB350434
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCaQKC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 12:10:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56490 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbhCaQJu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 12:09:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VG4r5B136809;
        Wed, 31 Mar 2021 16:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=tgIsOigXcVcpvNbNBmqaaA0KpMA4iy/t8h8x16T4fes=;
 b=rFPoQ0T5LNHve186JVIeqcJ589HJHGq74LOWwLq163CpoH79kLYf/sgx9A+8zAzQpUdl
 GiqYna+pv0rWutFIPlIa9CnZWizS5tK/AMwi5Q/o3tA7pwgPDHX+JmtkoA4NPy3j1w0K
 mO1HsPMU7fA7QJafki7Di4AM4eEqxMku1CohhcB/C+hrg7hup2Racgqb6Avx76XXeS97
 m9wbi5EGLfK0yNfKhG0VkFDutskfgVJTy+FzC2o3vGEDCclenL5CaKoQFJw3kr7Ez5I4
 Ngf8nZxqO+I7C1bn+XEEIk0+EXAo2aDIqBdKunLL3LZW5rqB9doHKkybYTHJ84kvP/lM 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37mafv2t7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 16:09:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VG6sdo060340;
        Wed, 31 Mar 2021 16:09:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 37mac5pc0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 16:09:44 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12VG9h9K008909;
        Wed, 31 Mar 2021 16:09:43 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Mar 2021 09:09:42 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2] IB/cma: Introduce rdma_set_min_rnr_timer()
Date:   Wed, 31 Mar 2021 18:09:33 +0200
Message-Id: <1617206973-1044-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310110
X-Proofpoint-ORIG-GUID: S7TJQdJx_rmZFWRZeIQtTzuyK189Cvvq
X-Proofpoint-GUID: S7TJQdJx_rmZFWRZeIQtTzuyK189Cvvq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce the ability for kernel ULPs to adjust the minimum RNR Retry
timer. The INIT -> RTR transition executed by RDMA CM will be used for
this adjustment. This avoids an additional ib_modify_qp() call.

rdma_set_min_rnr_timer() must be called before the call to
rdma_connect() on the active side and before the call to rdma_accept()
on the passive side.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cma.c      | 23 +++++++++++++++++++++++
 drivers/infiniband/core/cma_priv.h |  2 ++
 include/rdma/rdma_cm.h             |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 9409651..f50dc30 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -852,6 +852,7 @@ static void cma_id_put(struct rdma_id_private *id_priv)
 	id_priv->id.qp_type = qp_type;
 	id_priv->tos_set = false;
 	id_priv->timeout_set = false;
+	id_priv->min_rnr_timer_set = false;
 	id_priv->gid_type = IB_GID_TYPE_IB;
 	spin_lock_init(&id_priv->lock);
 	mutex_init(&id_priv->qp_mutex);
@@ -1141,6 +1142,9 @@ int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
 	if ((*qp_attr_mask & IB_QP_TIMEOUT) && id_priv->timeout_set)
 		qp_attr->timeout = id_priv->timeout;
 
+	if ((*qp_attr_mask & IB_QP_MIN_RNR_TIMER) && id_priv->min_rnr_timer_set)
+		qp_attr->min_rnr_timer = id_priv->min_rnr_timer;
+
 	return ret;
 }
 EXPORT_SYMBOL(rdma_init_qp_attr);
@@ -2615,6 +2619,25 @@ int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout)
 }
 EXPORT_SYMBOL(rdma_set_ack_timeout);
 
+int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer)
+{
+	struct rdma_id_private *id_priv;
+
+	/* It is a five-bit value */
+	if (min_rnr_timer & 0xe0)
+		return -EINVAL;
+
+	if (id->qp_type != IB_QPT_RC && id->qp_type != IB_QPT_XRC_TGT)
+		return -EINVAL;
+
+	id_priv = container_of(id, struct rdma_id_private, id);
+	id_priv->min_rnr_timer = min_rnr_timer;
+	id_priv->min_rnr_timer_set = true;
+
+	return 0;
+}
+EXPORT_SYMBOL(rdma_set_min_rnr_timer);
+
 static void cma_query_handler(int status, struct sa_path_rec *path_rec,
 			      void *context)
 {
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index caece96..bf83d32 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -86,9 +86,11 @@ struct rdma_id_private {
 	u8			tos;
 	u8			tos_set:1;
 	u8                      timeout_set:1;
+	u8			min_rnr_timer_set:1;
 	u8			reuseaddr;
 	u8			afonly;
 	u8			timeout;
+	u8			min_rnr_timer;
 	enum ib_gid_type	gid_type;
 
 	/*
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 32a67af..8b0f66e 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -331,6 +331,8 @@ int rdma_join_multicast(struct rdma_cm_id *id, struct sockaddr *addr,
 int rdma_set_afonly(struct rdma_cm_id *id, int afonly);
 
 int rdma_set_ack_timeout(struct rdma_cm_id *id, u8 timeout);
+
+int rdma_set_min_rnr_timer(struct rdma_cm_id *id, u8 min_rnr_timer);
  /**
  * rdma_get_service_id - Return the IB service ID for a specified address.
  * @id: Communication identifier associated with the address.
-- 
1.8.3.1

