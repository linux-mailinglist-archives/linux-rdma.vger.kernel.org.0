Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED281ED579
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 19:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgFCR4v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 13:56:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60754 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgFCR4u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 13:56:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053HuUu1190893;
        Wed, 3 Jun 2020 17:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=MJTv6a2OHHheaHNAL3q6r4VjxzBt6CSR3ftLDvE4ay4=;
 b=pGFY7vU6/gMsx3fV7LHL65tu7HLb8Et5stcnhz9oYyA14+YbM9nRI6q7aqxuEUETokyK
 HXZeIhVNmVdJp/sgfggH4LeeOF2jxhDQVfQKpSLUxaaxYkNjM60BYVTjV/2wxxmyvJnz
 4kdCJaF/Tzc1Twnr8HnXSqJUI86BqJeK4Vsz/vg9IY/AInJALJzn8Tv4EKaCXrcGu07p
 G5TrNyg7ygzJKPmrdL+FUFNIEkFHHiZkpEHWuvTDpIJ/PBZ1UTJqfOBd9BBJuSItknAr
 0PooUukU2qjTdPDo/aNepDdP+c6oP9DoqxBMukExeovHiniPFG9eV5loweM/ftho+gsW rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31bfemameh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 17:56:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053Hs4IK070765;
        Wed, 3 Jun 2020 17:54:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31dju3ma7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 17:54:45 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053Hsilc026366;
        Wed, 3 Jun 2020 17:54:44 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 10:54:44 -0700
Date:   Wed, 3 Jun 2020 20:54:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Vu Pham <vuhuong@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] net/mlx5: E-Switch, Fix some error pointer dereferences
Message-ID: <20200603175436.GD18931@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030139
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We can't leave "counter" set to an error pointer.  Otherwise either it
will lead to an error pointer dereference later in the function or it
leads to an error pointer dereference when we call mlx5_fc_destroy().

Fixes: 07bab9502641d ("net/mlx5: E-Switch, Refactor eswitch ingress acl codes")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c  | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
index 9bda4fe2eafa7..5dc335e621c57 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
@@ -162,10 +162,12 @@ int esw_acl_ingress_lgcy_setup(struct mlx5_eswitch *esw,
 
 	if (MLX5_CAP_ESW_INGRESS_ACL(esw->dev, flow_counter)) {
 		counter = mlx5_fc_create(esw->dev, false);
-		if (IS_ERR(counter))
+		if (IS_ERR(counter)) {
 			esw_warn(esw->dev,
 				 "vport[%d] configure ingress drop rule counter failed\n",
 				 vport->vport);
+			counter = NULL;
+		}
 		vport->ingress.legacy.drop_counter = counter;
 	}
 
@@ -272,7 +274,7 @@ void esw_acl_ingress_lgcy_cleanup(struct mlx5_eswitch *esw,
 	esw_acl_ingress_table_destroy(vport);
 
 clean_drop_counter:
-	if (!IS_ERR_OR_NULL(vport->ingress.legacy.drop_counter)) {
+	if (vport->ingress.legacy.drop_counter) {
 		mlx5_fc_destroy(esw->dev, vport->ingress.legacy.drop_counter);
 		vport->ingress.legacy.drop_counter = NULL;
 	}
-- 
2.26.2

