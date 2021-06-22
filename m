Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C33B05FA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhFVNma (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 09:42:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59098 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhFVNma (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 09:42:30 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MDZv32032610;
        Tue, 22 Jun 2021 13:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=H6aVwCDeE4KSOagZb29Z3WCqo4Z9rMrJYFFa2Ag4oxo=;
 b=vuhIiF/GvAaXr7AKerQVJlK5vsQ9tZCUtgUv9Zs8HroN8Ees7Fg+wtGppDCFlkLpZ/M+
 1dHuH/ns55LWPrCn/eEVcubBJnnSWD+jW/d0fvvzHPHwPAlwZ5wn/yIleNPUWhY4ImpB
 F64FFwYj4iOo2lCc7z3PvjkD6tNWZe6/gkXa6xyNAsQdp5KV83KvAIqIwIh9mr0V5r6E
 0R7pqlLzhR7qngKIlkFkMb7uxcKATtDvQknU5ZqBlFP4IG0kmfdnnhrQwyUIni2zfHIq
 sqKgQ+AtT5oxlc+xah7Qx/bkPRY9/IIc1G3LYhRIKM39OVwFFnlWvtNLHQCnUlgUINWX JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ap66kch1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:40:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MDZrbU028482;
        Tue, 22 Jun 2021 13:40:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 399tbsqpm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:40:08 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15MDe7dG032416;
        Tue, 22 Jun 2021 13:40:07 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jun 2021 06:40:07 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH for-next v2 1/2] RDMA/cma: Remove unnecessary INIT->INIT transition
Date:   Tue, 22 Jun 2021 15:39:56 +0200
Message-Id: <1624369197-24578-2-git-send-email-haakon.bugge@oracle.com>
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
X-Proofpoint-ORIG-GUID: HCAZjCRhOLnx4uitSgi6CcIKvQOvRBtJ
X-Proofpoint-GUID: HCAZjCRhOLnx4uitSgi6CcIKvQOvRBtJ
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rdma_create_qp(), a connected QP will be transitioned to the INIT
state.

Afterwards, the QP will be transitioned to the RTR state by the
cma_modify_qp_rtr() function. But this function starts by performing
an ib_modify_qp() to the INIT state again, before another
ib_modify_qp() is performed to transition the QP to the RTR state.

Hence, there is no need to transition the QP to the INIT state in
rdma_create_qp().

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

---

	v1 -> v2:
	   * Fixed uninitialized ret variable as:
	     Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/infiniband/core/cma.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2b9ffc2..20c155c 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -925,25 +925,12 @@ static int cma_init_ud_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
 	return ret;
 }
 
-static int cma_init_conn_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
-{
-	struct ib_qp_attr qp_attr;
-	int qp_attr_mask, ret;
-
-	qp_attr.qp_state = IB_QPS_INIT;
-	ret = rdma_init_qp_attr(&id_priv->id, &qp_attr, &qp_attr_mask);
-	if (ret)
-		return ret;
-
-	return ib_modify_qp(qp, &qp_attr, qp_attr_mask);
-}
-
 int rdma_create_qp(struct rdma_cm_id *id, struct ib_pd *pd,
 		   struct ib_qp_init_attr *qp_init_attr)
 {
 	struct rdma_id_private *id_priv;
 	struct ib_qp *qp;
-	int ret;
+	int ret = 0;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	if (id->device != pd->device) {
@@ -960,8 +947,6 @@ int rdma_create_qp(struct rdma_cm_id *id, struct ib_pd *pd,
 
 	if (id->qp_type == IB_QPT_UD)
 		ret = cma_init_ud_qp(id_priv, qp);
-	else
-		ret = cma_init_conn_qp(id_priv, qp);
 	if (ret)
 		goto out_destroy;
 
-- 
1.8.3.1

