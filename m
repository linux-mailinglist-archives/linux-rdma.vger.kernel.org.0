Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF897D4B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfHUOje (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:39:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56240 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbfHUOje (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:39:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEd52C086578;
        Wed, 21 Aug 2019 14:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=AL22DhFQL2h05YrnNk4vkx3QgpPetCGoFZEW2DTQpi8=;
 b=JuemfpMNGJT6YTb0PrELnp5tfdoytSf63TNkh+b610K8jBiAj8SrkzusHB9eRELRZumd
 VWiHUbKl7pSVfQ/nPhZtUBIDL0J035v1Ti0RkWMQhB2HyNzqs2/MrUlNZe5jf9t2DHm/
 C6E2+bcbDLQpQv38nZ4DVJ5kldN2unrA5d4UXr25aOZwvvDqxrxwvdcLse+hM301wlug
 1xvyDMgVJ4McL6DQ7IwpMaEMv6MecRBlrwMkQ1A7zQOS/zzrF3o/znwpWrsDI1VbMYRY
 ub7qU05mak0cEQeM8HweyYfMpQsio5YDmZ4Nx1vNslx2inp9Jx0Pyrhh/P+LtyydDfAI uQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ue90tp7b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:39:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEd1jG045262;
        Wed, 21 Aug 2019 14:39:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ugj7qguw0-87
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:39:03 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LEMdJP031263;
        Wed, 21 Aug 2019 14:22:39 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:22:38 -0700
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
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>
Subject: [PATCH v1 10/24] IB/mlx4: Add implementation of clone_pd callback
Date:   Wed, 21 Aug 2019 17:21:11 +0300
Message-Id: <20190821142125.5706-11-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821142125.5706-1-yuval.shaia@oracle.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210159
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

Copy mlx4 ib_pd to user-space.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 drivers/infiniband/hw/mlx4/main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 8d2f1e38b891..6baf52d988ed 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1179,6 +1179,13 @@ static int mlx4_ib_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	}
 }
 
+static int mlx4_ib_clone_pd(struct ib_udata *udata, struct ib_pd *ibpd)
+{
+	struct mlx4_ib_pd *pd = to_mpd(ibpd);
+
+	return udata ? ib_copy_to_udata(udata, &pd->pdn, sizeof(__u32)) : 0;
+}
+
 static int mlx4_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct mlx4_ib_pd *pd = to_mpd(ibpd);
@@ -1189,10 +1196,12 @@ static int mlx4_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	if (err)
 		return err;
 
-	if (udata && ib_copy_to_udata(udata, &pd->pdn, sizeof(__u32))) {
+	err = mlx4_ib_clone_pd(udata, ibpd);
+	if (err) {
 		mlx4_pd_free(to_mdev(ibdev)->dev, pd->pdn);
 		return -EFAULT;
 	}
+
 	return 0;
 }
 
@@ -2565,6 +2574,9 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
 	.rereg_user_mr = mlx4_ib_rereg_user_mr,
 	.resize_cq = mlx4_ib_resize_cq,
 
+	/* Object sharing callbacks */
+	.clone_ib_pd = mlx4_ib_clone_pd,
+
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx4_ib_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mlx4_ib_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, mlx4_ib_pd, ibpd),
-- 
2.20.1

