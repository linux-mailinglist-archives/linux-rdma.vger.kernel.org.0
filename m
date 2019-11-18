Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD1100C6E
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKRTyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 14:54:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47242 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKRTyu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 14:54:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIJsRZX085199;
        Mon, 18 Nov 2019 19:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=5x4/Ipw1+guWSxc2mK0wg0mk5cfbSXId1wQN0MkDxjA=;
 b=VaV5BJQdQhxvxJB9tmllMIGktNuQSFEqaMH7x1dIVM/sgF4MpKdSpN6Rg6YASTaLpiwF
 nAl1/Xp7ndgKzP4+zn+McyAKPKgTPgSLU9zQcvgtIlhW8683BuxXV6Eoz9hez15d/5Up
 yYCcYnzQi+8H3hPimSSjjfcrHyb1hSyXM+ioQSTZbZ1GnvY1E9eubEiRh2ep9+hkY0Lw
 DfglRWbsgI4A4JxEIiFyr6vRwkQPjaLZA7a6QJDf3gk1UOJbgz83L4aZCCwPHsgWskVR
 XzAPTY5dn6pN0wXdK95W+LyhYZaVFfg2CYgnxAXWrG0ywGhpE7DcpldQWagcEpeCDLRf qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wa9rqaeqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 19:54:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIJs3ml146954;
        Mon, 18 Nov 2019 19:54:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2wc09w4m1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Nov 2019 19:54:42 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAIJsd7M149983;
        Mon, 18 Nov 2019 19:54:41 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by userp3020.oracle.com with ESMTP id 2wc09w4kxp-3;
        Mon, 18 Nov 2019 19:54:41 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rao.shoaib@oracle.com
Subject: [PATCH v2 2/2] SGE buffer and max_inline data must have same size
Date:   Mon, 18 Nov 2019 11:54:39 -0800
Message-Id: <1574106879-19211-3-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180170
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

SGE buffer size and max_inline data should be same. Maximum of the
two values requested is used.

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 323e43d..1062f60 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -238,18 +238,17 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 		return err;
 	qp->sk->sk->sk_user_data = qp;
 
-	qp->sq.max_wr		= init->cap.max_send_wr;
-	qp->sq.max_sge		= init->cap.max_send_sge;
-	qp->sq.max_inline	= init->cap.max_inline_data;
-
-	wqe_size = max_t(int, sizeof(struct rxe_send_wqe) +
-			 qp->sq.max_sge * sizeof(struct ib_sge),
-			 sizeof(struct rxe_send_wqe) +
-			 qp->sq.max_inline);
-
-	qp->sq.queue = rxe_queue_init(rxe,
-				      &qp->sq.max_wr,
-				      wqe_size);
+	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
+			 init->cap.max_inline_data);
+	qp->sq.max_sge = wqe_size/sizeof(struct ib_sge);
+	qp->sq.max_inline = wqe_size;
+
+	wqe_size += sizeof(struct rxe_send_wqe);
+
+	qp->sq.max_wr = init->cap.max_send_wr;
+
+	qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr, wqe_size);
+
 	if (!qp->sq.queue)
 		return -ENOMEM;
 
-- 
1.8.3.1

