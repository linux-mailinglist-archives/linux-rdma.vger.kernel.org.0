Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6263492B6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 14:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCYNGd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 09:06:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58806 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCYNGC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 09:06:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PD5wLC158214;
        Thu, 25 Mar 2021 13:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=PRJ3vYFOq/D1NhI/hgY3RfSAJGSl8p9/ZIeg2lJQ+SE=;
 b=OhczP2QjJz/m6jff020k/DaB4tCUeQ4JZmb40TL/fvsLC+mr0tsDHk4TODnRqvz/xNa5
 8JkItB7Lz0h2WlmSFSC/KfVNz9YHwtdbn6JOOZJ9zJsmTmkPrhE0crDdu5kbbRMw1aEc
 9lAv/vzvKUPGjowZ5kFxFUhIY3B5D5QYwkYCyAOhHMVNq9Jx025bYDRuFE8bhyvYURLs
 yJm4s0NNxvISdFLwDhYOIrCKALgadCdwaz8TVIAHyNAFRNphS/jHKfSu1lj0F6SWnOxe
 ODNPayezZazlQcRsoG7MPe6TWdHWrubO/LrHBRlNfWcL6+kWMTPJ8IE8w4CI8aU7WWyC 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37d90mp5b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 13:05:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PD0Xwd058284;
        Thu, 25 Mar 2021 13:05:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 37dty1vc9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 13:05:57 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12PD5vjW023158;
        Thu, 25 Mar 2021 13:05:57 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Mar 2021 13:05:56 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Date:   Thu, 25 Mar 2021 14:05:47 +0100
Message-Id: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250097
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce the ability for both user-space and kernel ULPs to adjust
the minimum RNR Retry timer. The INIT -> RTR transition executed by
RDMA CM will be used for this adjustment. This avoids an additional
ib_modify_qp() call.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cma.c      | 23 +++++++++++++++++++++++
 drivers/infiniband/core/cma_priv.h |  2 ++
 drivers/infiniband/core/ucma.c     |  7 +++++++
 include/rdma/rdma_cm.h             |  2 ++
 include/uapi/rdma/rdma_user_cm.h   |  3 ++-
 5 files changed, 36 insertions(+), 1 deletion(-)

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
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index da2512c..f183ace 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1282,6 +1282,13 @@ static int ucma_set_option_id(struct ucma_context *ctx, int optname,
 		}
 		ret = rdma_set_ack_timeout(ctx->cm_id, *((u8 *)optval));
 		break;
+	case RDMA_OPTION_ID_RNR_RETRY_TIMER:
+		if (optlen != sizeof(u8)) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = rdma_set_min_rnr_timer(ctx->cm_id, *((u8 *)optval));
+		break;
 	default:
 		ret = -ENOSYS;
 	}
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
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index ed5a514..13b46af 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -313,7 +313,8 @@ enum {
 	RDMA_OPTION_ID_TOS	 = 0,
 	RDMA_OPTION_ID_REUSEADDR = 1,
 	RDMA_OPTION_ID_AFONLY	 = 2,
-	RDMA_OPTION_ID_ACK_TIMEOUT = 3
+	RDMA_OPTION_ID_ACK_TIMEOUT = 3,
+	RDMA_OPTION_ID_RNR_RETRY_TIMER = 4,
 };
 
 enum {
-- 
1.8.3.1

