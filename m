Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A710613F1B9
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 19:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390764AbgAPSao (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 13:30:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37188 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388586AbgAPSan (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 13:30:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GI9Bg5056514;
        Thu, 16 Jan 2020 18:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=W/xYyZuMQPUL8LywibdGc89gLisK7pTjwntsImkArLA=;
 b=BcoFKpG0AhmSGp9T+AI8JFScG9IIIytr2ntC33jVBVN4NeBq5TLiaFnK3DUe2/Rmhkdy
 bHwYJhQshTIdEDpYDX7XpNieDotmeBjXBHBYKKpbfk5HcNUWuzzaJVYZqyxnVQesrfyx
 uJVl5Zt901JcaDsmM2CIXfGp5uDZX4BmsryjCQc9bBJYgJaJBENrq6GJYV29MrX1s5j5
 0bGerW/fjc2dbebgEoqV2R8vi3pJA8wGaYEkalF7SsHmqdL8WssBaRbWPv8v2wY8dfRT
 cexNqUHvIQTlA/7pjteT+IWOL9b+Tc41rKXlAowbX0FdoMDOnZNF4tbw41HrxLUFdLAW Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74sm9ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 18:30:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GI9OLa124401;
        Thu, 16 Jan 2020 18:30:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2xj1ptje0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jan 2020 18:30:31 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id 00GIU9f0190457;
        Thu, 16 Jan 2020 18:30:31 GMT
Received: from ca-dev107.us.oracle.com (ca-dev107.us.oracle.com [10.129.135.36])
        by userp3020.oracle.com with ESMTP id 2xj1ptjdxt-3;
        Thu, 16 Jan 2020 18:30:31 +0000
From:   rao Shoaib <rao.shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, monis@mellanox.com, dledford@redhat.com,
        sean.hefty@intel.com, hal.rosenstock@gmail.com,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH v4 2/2] RDMA/rxe: SGE buffer and max_inline data must have same size
Date:   Thu, 16 Jan 2020 10:30:12 -0800
Message-Id: <1579199412-15741-3-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579199412-15741-1-git-send-email-rao.shoaib@oracle.com>
References: <1579199412-15741-1-git-send-email-rao.shoaib@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160147
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

SGE buffer size and max_inline data should be same. Maximum of the two
values requested is used.

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index e2c6d1c..d29d1a8 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -238,18 +238,22 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->src_port = RXE_ROCE_V2_SPORT +
 		(hash_32_generic(qp_num(qp), 14) & 0x3fff);
 
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
+	/* values for max_send_sge and max_inline_data have already been
+	 * checked in rxe_qp_chk_cap() to make sure they are within limits.
+	 */
+	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
+			 init->cap.max_inline_data);
+	qp->sq.max_sge = wqe_size/sizeof(struct ib_sge);
+	qp->sq.max_inline = wqe_size;
+	init->cap.max_inline_data = qp->sq.max_inline;
+	init->cap.max_send_sge = qp->sq.max_sge;
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

