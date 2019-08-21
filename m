Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6197CBA
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfHUOYM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:24:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40478 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfHUOYM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:24:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENU1Q086653;
        Wed, 21 Aug 2019 14:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=eBT243lfDQ3yxgXSEgGiXjsS3ep2rvLt4aWX7krSYkc=;
 b=e9fJ1yqE0DAs++cUFWEMM0nkzNXd5aggl5iAxzBEggtcDdcuWfvZtWSjUXTAOj0qpmtr
 SVDCswpV9W9/BZTC5cX0cEHyZas1GauzcX/CkdfcR33acXLDeVlBJr6b6x+OISV/grPb
 hy60ytN58g4yRcoNzm/2PVPyQ01NZ7eK5iToTkVrBrH6FxuY5sKtFdIalozQksK1Sje5
 UIbxHbj2+J+EohHkIaLKR9zdC4wdl4tJJm9h48+ZkkOLNQ9i7zM8MldJrra2V2x+zzHh
 mma1PXrk9/T30oizA+dwJ3QLcPPTwyyTu6K+Fpivz5Nruc32d+KWQg9y6OEUIRnk3Iuv Ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uea7qwxu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:23:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMYOs115054;
        Wed, 21 Aug 2019 14:23:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ug26a3bh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:23:44 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LENh9q031870;
        Wed, 21 Aug 2019 14:23:43 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:23:43 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org
Subject: [PATCH v1 21/24] IB/mlx5: Add implementation of clone_pd callback
Date:   Wed, 21 Aug 2019 17:21:22 +0300
Message-Id: <20190821142125.5706-22-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821142125.5706-1-yuval.shaia@oracle.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210158
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No special handling in for object cloning, utilize the trivial
implementation.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 drivers/infiniband/hw/mlx5/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 89ba3330d2ef..79eef45167bd 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6352,6 +6352,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 
 	/* Object sharing callbacks */
 	.clone_ib_pd = mlx5_ib_clone_pd,
+	.clone_ib_mr = trivial_clone_ib_mr,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mlx5_ib_cq, ibcq),
-- 
2.20.1

