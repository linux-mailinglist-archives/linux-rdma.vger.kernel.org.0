Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E2B3B05BC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 15:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFVNXC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 09:23:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28968 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229907AbhFVNXC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 09:23:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MDGDE6024800;
        Tue, 22 Jun 2021 13:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=O5AoJbhpHjSsbIsL2dlGV1Hu5BOSO/YNqGamZT3cIGw=;
 b=CqBxreer0dOJYYyXioSvBZqhw7bE5r4/0boyKHou7K0gqHrRBM0YQJmbxjk8VH/PZSm1
 8ya7zinRQTcb7grNLnq3HZfmtZrz1qC1jkCeqFy2Fj0wzFeKINN4hE2WCJt7A+GNTc1B
 Ex3t5T63/MuAnqRVb3WTr4Z1JE+dz7boTB1pTwTdVJB+h98RIWxfYU121xgb70iAZTOp
 yDWbQSwf9i8g9oUGcZOY2Dp/dj6KOCIx2fD2UAUUgAGWctkdk6VZRUGryZYYq2ZaD29A
 ZwoYorfphK6sVk1UwRjdQ6iCASR7HObNNhXcbL4pfXKLiMVsJhfmM7eXPDe08AC1rLjo fA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39b98v94tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:20:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MDFsNk129799;
        Tue, 22 Jun 2021 13:20:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 399tbspdmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:20:41 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 15MDKe1G017464;
        Tue, 22 Jun 2021 13:20:40 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jun 2021 06:20:39 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH for-next 1/2] RDMA/cma: Remove unnecessary INIT->INIT transition
Date:   Tue, 22 Jun 2021 15:20:29 +0200
Message-Id: <1624368030-23214-2-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624368030-23214-1-git-send-email-haakon.bugge@oracle.com>
References: <1624368030-23214-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220084
X-Proofpoint-ORIG-GUID: GTu6wx0q9KRjCgmiddjcGrOSbqw8eCp3
X-Proofpoint-GUID: GTu6wx0q9KRjCgmiddjcGrOSbqw8eCp3
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
index ab148a6..e3f52c5 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -926,25 +926,12 @@ static int cma_init_ud_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
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
@@ -961,8 +948,6 @@ int rdma_create_qp(struct rdma_cm_id *id, struct ib_pd *pd,
 
 	if (id->qp_type == IB_QPT_UD)
 		ret = cma_init_ud_qp(id_priv, qp);
-	else
-		ret = cma_init_conn_qp(id_priv, qp);
 	if (ret)
 		goto out_destroy;
 
-- 
1.8.3.1

