Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067C7139E6E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 01:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgANAlv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 19:41:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41182 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgANAlr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jan 2020 19:41:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E0cNcu101197;
        Tue, 14 Jan 2020 00:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=zVxnaaKeWVK8xTlHdQcAlC/MGkBhYpWpwvLSipskm4I=;
 b=DSyB6CaJFK9jRq/AIJe4lLP4CADSMKhAXdf72SGP56oP4vkNNcaQ5Uu594u9fjYE8fzt
 NL4lCy+wfvJr3pD1GsFsKbl7xAvhm4tb/AWjfQJJaaKoXhRRU+cMyxaaQ5tYhiqJgmaO
 CKY4hDuH9fCXyASNk+NQ1lclXwL4lr3LNT7NSOsIRp45yu78dL9GFdVPbUBnJKQXWw4k
 XK0HJfyktvHDjrAFinKfo6PivbcOUVpiJJFuUCM4hdyr4HWj2m8Ow0DosjqDHZGGnoli
 39/c9THN//hXn5huN5djhH/iircOtsJD+S7ZK5fT+btratRwEWDyZXi2w14EeBjgmCtN DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74s2h37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 00:41:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E0d5HQ057174;
        Tue, 14 Jan 2020 00:41:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2xfrgjmaey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jan 2020 00:41:39 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id 00E0fbfl067024;
        Tue, 14 Jan 2020 00:41:38 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by userp3020.oracle.com with ESMTP id 2xfrgjmae0-3;
        Tue, 14 Jan 2020 00:41:38 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, monis@mellanox.com, dledford@redhat.com,
        sean.hefty@intel.com, hal.rosenstock@gmail.com,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH v3 2/2] SGE buffer and max_inline data must have same size
Date:   Mon, 13 Jan 2020 16:41:20 -0800
Message-Id: <1578962480-17814-3-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578962480-17814-1-git-send-email-rao.shoaib@oracle.com>
References: <1578962480-17814-1-git-send-email-rao.shoaib@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140003
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
index aeea994..41c669c 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -235,18 +235,17 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
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

