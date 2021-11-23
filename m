Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28D459FC0
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Nov 2021 11:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhKWKJ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 05:09:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2900 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231838AbhKWKJz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Nov 2021 05:09:55 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN9ZD6r015025;
        Tue, 23 Nov 2021 10:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=BO0kWya7306wJ+rzkm3GIsyvqkUbe4imrcoIutB9xq8=;
 b=Ubbvks6YVKdbrA+87Xk7MgO5GPPOfS0GHGEZcmS6muDevJbiEqN3uT31oUgck6LlrOYb
 3w5zmNnLjshoyCqIFpUEWYv3ehZo9urvEhHRo6J626ueJ4Z02HAiua3VhfhlsD9cgtMw
 y4+G7v7R09b/eJg8CpVWLfnInecGHjSQl/IMtFpOjKTY7pLGCc50hN3TodSqnzfGZ5K2
 l50XhQTE2yaWxLS3SZXdlrxn4h+Y0XyA+ThLIGN26wpChW3LYZhfmryOvWWaYtPYJQ1h
 5JEh38i9QIadaOZGyexLmy+ZG172sNyweTfGMcZzZLGf0A2d7v25k+C/P6uWnRMBFEDH Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg5gj87bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 10:06:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANA18xZ038229;
        Tue, 23 Nov 2021 10:06:21 GMT
Received: from lab02.no.oracle.com (lab02.no.oracle.com [10.172.144.56])
        by aserp3020.oracle.com with ESMTP id 3ceru4webk-1;
        Tue, 23 Nov 2021 10:06:20 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH for-rc v2] RDMA/cma: Remove open coding of overflow checking for private_data_len
Date:   Tue, 23 Nov 2021 11:06:18 +0100
Message-Id: <1637661978-18770-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230054
X-Proofpoint-GUID: cxIOd2VMhpAGdsGUqcVxsuAvPdez1R6D
X-Proofpoint-ORIG-GUID: cxIOd2VMhpAGdsGUqcVxsuAvPdez1R6D
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The existing tests are a little hard to comprehend. Use
check_add_overflow() instead.

Fixes: 04ded1672402 ("RDMA/cma: Verify private data length")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

v1 -> v2:

   * Also fixed same issue in cma_resolve_ib_udp() as pointed out
     by Leon
---
 drivers/infiniband/core/cma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 835ac54..8a98aa9 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4033,8 +4033,7 @@ static int cma_resolve_ib_udp(struct rdma_id_private *id_priv,
 
 	memset(&req, 0, sizeof req);
 	offset = cma_user_data_offset(id_priv);
-	req.private_data_len = offset + conn_param->private_data_len;
-	if (req.private_data_len < conn_param->private_data_len)
+	if (check_add_overflow(offset, conn_param->private_data_len, &req.private_data_len))
 		return -EINVAL;
 
 	if (req.private_data_len) {
@@ -4093,8 +4092,7 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 
 	memset(&req, 0, sizeof req);
 	offset = cma_user_data_offset(id_priv);
-	req.private_data_len = offset + conn_param->private_data_len;
-	if (req.private_data_len < conn_param->private_data_len)
+	if (check_add_overflow(offset, conn_param->private_data_len, &req.private_data_len))
 		return -EINVAL;
 
 	if (req.private_data_len) {
-- 
1.8.3.1

