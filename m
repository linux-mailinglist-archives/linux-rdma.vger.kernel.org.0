Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B744697CB7
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfHUOYE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:24:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34084 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbfHUOYD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:24:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENWvq071722;
        Wed, 21 Aug 2019 14:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=MvNPO4dpKeDdmtzLKonZjiC3Ub3LV1ByRCK+eujaa08=;
 b=pOrf5WOyPxQrat1953XiRDNFPVrZIfS5sy2lFs0htQ9nqGvVDlwKRkfGJnTrpcAyq3eo
 lZ2DXkpoAwvyN4DEWSkIZrqgFtE5EOFACI415fHoP0qnmusak5DegqjMlwkrUGFj5XcR
 +/V9e7H0PCXPqs3zYdcufMAQkPVK3KBQBHhqNYL+wHc1HIXHZgt0n5hgDSIE4f1PzVjl
 ScgfE67fsTqH1bMe0gdQ4sxAXU8gNUMvotZBU9d7F839PtHXjTHbR3/jlDfHYSHnNiAu
 RaM95OLw5yij1DJy23t74GW1odjgH8yWL58T4atqP7mWZvTAVuhsy/sFrBISWkERcw/A 5A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ue90tp43g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:23:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMq50017078;
        Wed, 21 Aug 2019 14:23:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2uh2q4jx5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:23:40 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LENc1A015788;
        Wed, 21 Aug 2019 14:23:38 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:23:37 -0700
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
Subject: [PATCH v1 20/24] IB/mlx4: Add implementation of clone_pd callback
Date:   Wed, 21 Aug 2019 17:21:21 +0300
Message-Id: <20190821142125.5706-21-yuval.shaia@oracle.com>
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
 drivers/infiniband/hw/mlx4/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index d0eef7e2d5a3..3192284a85ca 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2576,6 +2576,7 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
 
 	/* Object sharing callbacks */
 	.clone_ib_pd = mlx4_ib_clone_pd,
+	.clone_ib_mr = trivial_clone_ib_mr,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx4_ib_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mlx4_ib_cq, ibcq),
-- 
2.20.1

