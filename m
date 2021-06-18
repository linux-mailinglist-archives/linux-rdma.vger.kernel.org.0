Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB15C3AC31D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 08:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhFRGKX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 02:10:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57058 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232270AbhFRGKW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Jun 2021 02:10:22 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I60upp004015;
        Fri, 18 Jun 2021 06:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=fnKMNVIlCGtOtYsBIw5EFVSBoCcmHjqZ3zudQyGQLiQ=;
 b=TGRwQ/42c+RUpxBISV+KMNl+HUwkdM6B/OQVHOWZYv/6jeqJDVy7Ti6uZNpOtRAnn8RB
 B449QQUVD2ob2BiXMALyJTFYPM3Qz3YoZ5CLH4is1pvH00gzt1BjpuY0cE4sTLnqsILU
 6uRisAIkobEfrmP0a9iMtQU5FCbkaa6lw4ULrNcmc7OXsjqV/V8HJZdfW5RSCtc9Winn
 dtfs7gA/qDlKmc7OKnC+i1ozBhgZ+F/QV7zPIkbLKYfla/FICkma1MIONsssE4eUdyO5
 RoTo37Ovv0p1pVIlao7mBAB4U+kfg77cW8AFrCWmSEBf66Y4JWRkmqUUtXG35s11w7hI Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39770hcpka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 06:08:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15I65bix120882;
        Fri, 18 Jun 2021 06:08:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 396wayh7q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 06:08:07 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15I686b7011612;
        Fri, 18 Jun 2021 06:08:06 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jun 2021 23:08:06 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2] RDMA/cma: Remove unnecessary INIT->INIT transition
Date:   Fri, 18 Jun 2021 08:07:55 +0200
Message-Id: <1623996475-23986-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10018 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180034
X-Proofpoint-GUID: NNTeQba-yJPMzOonqgU9X02kkEOYcJZS
X-Proofpoint-ORIG-GUID: NNTeQba-yJPMzOonqgU9X02kkEOYcJZS
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

