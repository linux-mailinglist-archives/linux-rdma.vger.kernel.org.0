Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A583F97CA2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfHUOXK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:23:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60740 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfHUOXJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:23:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEEbWw063203;
        Wed, 21 Aug 2019 14:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=vk2LYfndXmI8k5pWaqinBWS5l81xac9OZSb+63HN7Mk=;
 b=Hj7su8RiFxYIiD6lQhBa42S3igVjZiqSdpQIqLmPzm/TNzrmwEuNBhQDcRsAklH61vd9
 Eg6y077KJw1zlHYqUwE/gzZVznWtq0EcFvU9m4vLV9bd//l5LrCmE1vHKuTyYNUNv858
 CWHB35CiZ1PDs7fDGde1g/7rvqolPZWrFNYnapxd4CwV2rFspXzSqCPro9O7ULI/HM6p
 A56qTrU2E+zNfaZPBUG+Nb1KJSEGBo0aBfWxqkBdFxou3MfLChaJGMWAJVoAo2El0pL2
 GkSYCPKU984St3W7RmXAZY+E2WFw2Nm9dMA0HDgUnvpZbw+GCrJlrnP+0ywK7rQryVe4 KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ue90tp3v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:22:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMYbp115048;
        Wed, 21 Aug 2019 14:22:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ug26a3aay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:22:46 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LEMjfc011046;
        Wed, 21 Aug 2019 14:22:45 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:22:44 -0700
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
Subject: [PATCH v1 11/24] IB/mlx5: Add implementation of clone_pd callback
Date:   Wed, 21 Aug 2019 17:21:12 +0300
Message-Id: <20190821142125.5706-12-yuval.shaia@oracle.com>
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
 definitions=main-1908210157
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

Copy mlx5 ib_pd to user-space.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 drivers/infiniband/hw/mlx5/main.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 93db6d4c7da4..63beee644b46 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2464,11 +2464,24 @@ int mlx5_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
 	return 0;
 }
 
+static int mlx5_ib_clone_pd(struct ib_udata *udata, struct ib_pd *ibpd)
+{
+	struct mlx5_ib_pd *pd = to_mpd(ibpd);
+	struct mlx5_ib_alloc_pd_resp resp;
+	int ret = 0;
+
+	if (udata) {
+		resp.pdn = pd->pdn;
+		ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	}
+
+	return ret;
+}
+
 static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct mlx5_ib_pd *pd = to_mpd(ibpd);
 	struct ib_device *ibdev = ibpd->device;
-	struct mlx5_ib_alloc_pd_resp resp;
 	int err;
 	u32 out[MLX5_ST_SZ_DW(alloc_pd_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(alloc_pd_in)]   = {};
@@ -2486,12 +2499,11 @@ static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	pd->pdn = MLX5_GET(alloc_pd_out, out, pd);
 	pd->uid = uid;
-	if (udata) {
-		resp.pdn = pd->pdn;
-		if (ib_copy_to_udata(udata, &resp, sizeof(resp))) {
-			mlx5_cmd_dealloc_pd(to_mdev(ibdev)->mdev, pd->pdn, uid);
-			return -EFAULT;
-		}
+
+	err = mlx5_ib_clone_pd(udata, ibpd);
+	if (err) {
+		mlx5_cmd_dealloc_pd(to_mdev(ibdev)->mdev, pd->pdn, uid);
+		return err;
 	}
 
 	return 0;
@@ -6338,6 +6350,9 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.rereg_user_mr = mlx5_ib_rereg_user_mr,
 	.resize_cq = mlx5_ib_resize_cq,
 
+	/* Object sharing callbacks */
+	.clone_ib_pd = mlx5_ib_clone_pd,
+
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mlx5_ib_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, mlx5_ib_pd, ibpd),
-- 
2.20.1

