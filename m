Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76DFA22818
	for <lists+linux-rdma@lfdr.de>; Sun, 19 May 2019 19:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfESRxw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 May 2019 13:53:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56760 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfESRxw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 May 2019 13:53:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4JFO4r9149869;
        Sun, 19 May 2019 15:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=7/nqNQOwig6qQvWt/j2tvlQdXo0ZiBsiHluNfaEHcCs=;
 b=azIr4NuZlG7wPTYOk7q7XqmxWOJOC2RNu5IndXEqRO003xQbdCeFhvi8IyWhj2rDO0FA
 cq61LNVEyGcAc9yeJ+FAjHIcjlpNIIjF6d4wzWrCTH17qnCeG/KXNRTpDRKhpxm+3q3a
 wTH64NB/0T1KUxr2F4p4pn1L4JtTYT+IieI9sus1C8YjiMsekimIOGZdjovyk4ujwcoE
 d0Bz+94nZnBG+G39oH8qBMge0XhZiPOAzkUEo9BFrJrG5iAROiTficEbO2lUi87Dg/Jw
 lBZxLSE/lLkz9QpMKn67eiAwZW4oiGqhBw5xd2tvn1zWcI/7wpRkvQDWdzDKFnH3fA4G tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2sjapq387k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 May 2019 15:31:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4JFVUwm077610;
        Sun, 19 May 2019 15:31:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2sjwqqwqm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 May 2019 15:31:42 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4JFVcib015149;
        Sun, 19 May 2019 15:31:38 GMT
Received: from host4.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 19 May 2019 15:31:38 +0000
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     yishaih@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, jgg@mellanox.com
Cc:     Yuval Shaia <yuval.shaia@oracle.com>
Subject: [PATCH] IB/mlx4: Delete unused func arg
Date:   Sun, 19 May 2019 18:31:27 +0300
Message-Id: <20190519153128.17071-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905190112
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905190112
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The function argument virt_addr is not in use - delete it.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 drivers/infiniband/hw/mlx4/mr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 355205a28544..2e132883848b 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -368,8 +368,7 @@ int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va,
 }
 
 static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
-					u64 length, u64 virt_addr,
-					int access_flags)
+					u64 length, int access_flags)
 {
 	/*
 	 * Force registering the memory as writable if the underlying pages
@@ -415,8 +414,7 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	mr->umem =
-		mlx4_get_umem_mr(udata, start, length, virt_addr, access_flags);
+	mr->umem = mlx4_get_umem_mr(udata, start, length, access_flags);
 	if (IS_ERR(mr->umem)) {
 		err = PTR_ERR(mr->umem);
 		goto err_free;
@@ -505,7 +503,7 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,
 
 		mlx4_mr_rereg_mem_cleanup(dev->dev, &mmr->mmr);
 		ib_umem_release(mmr->umem);
-		mmr->umem = mlx4_get_umem_mr(udata, start, length, virt_addr,
+		mmr->umem = mlx4_get_umem_mr(udata, start, length,
 					     mr_access_flags);
 		if (IS_ERR(mmr->umem)) {
 			err = PTR_ERR(mmr->umem);
-- 
2.20.1

