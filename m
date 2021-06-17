Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAD93AB7D9
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhFQPsu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 11:48:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22364 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231593AbhFQPst (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 11:48:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HFb3Gg031894;
        Thu, 17 Jun 2021 15:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=kLImW/R5Kr8wHS/2b9Agg5N8A1Df5JMZqXQJW9fhmKY=;
 b=Uih2nsOdD+zni47dhXVkwUL6aUkPcZe7QuvT7LnL0fJQB9z3BTmo+wST4MnrcDzGdvfQ
 Tgm9vcZONqI2ikZ8zMf+kU5JHdAoIB/w2nfJRhq9zObTBczcX7aMIogb4ET/a07+h3x4
 mCB2W1YfgDMxQqLPN73A+uYzK7Qiva5DYDap12/n+6q07q9sjBwCbKjp2XBsBWZ9QNqh
 +VDDifOLFgS1td1ph7qPD1ZhMsN+ibYA8e5UD/YJgx1JGy9Qs4MLi+ApMczCxUwTW2at
 sG0dcNCvv+5STO/q7YV8VMUmu8VBQwcSnkg6O9x/XVuFGWqQIEn17LYxFYSuQyd677SP rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39770hbmce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 15:46:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15HFjY62081546;
        Thu, 17 Jun 2021 15:46:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 396waxs5e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 15:46:34 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15HFkX13024282;
        Thu, 17 Jun 2021 15:46:33 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jun 2021 08:46:33 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next] RDMA/cma: Remove unnecessary INIT->INIT transition
Date:   Thu, 17 Jun 2021 17:46:23 +0200
Message-Id: <1623944783-9093-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10018 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170100
X-Proofpoint-GUID: 1iO7TQGm2w5UhkLys4vMZexSBVEx4D3M
X-Proofpoint-ORIG-GUID: 1iO7TQGm2w5UhkLys4vMZexSBVEx4D3M
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
 drivers/infiniband/core/cma.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2b9ffc2..937e44e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -925,19 +925,6 @@ static int cma_init_ud_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
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
@@ -960,8 +947,6 @@ int rdma_create_qp(struct rdma_cm_id *id, struct ib_pd *pd,
 
 	if (id->qp_type == IB_QPT_UD)
 		ret = cma_init_ud_qp(id_priv, qp);
-	else
-		ret = cma_init_conn_qp(id_priv, qp);
 	if (ret)
 		goto out_destroy;
 
-- 
1.8.3.1

