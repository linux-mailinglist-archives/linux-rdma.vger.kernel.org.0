Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FC71ED564
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgFCRxc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 13:53:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44690 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgFCRxa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 13:53:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053Hooiq168693;
        Wed, 3 Jun 2020 17:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=xKDI9HOgvqsdKul9Kh945N/ueriDG+wJa0TtbjNh6NM=;
 b=uW9WwiN6skELua9f0OvxoolkqXac22G1btA1VNpF+AdpCU9lQbrs7iL6SwXJjshRowNu
 dLGvO4yb5o/QS/aGE1u9jw01bXIY1ExuoQjyjB8gbHrAEv/t24u3PHQJ52agMtMD+PEy
 l1az3RY51dfo4qLCDUpKn+HxXo9mUcppwKgyyKF2BGkXgQpDhFXn24BMkZDjM77ZR4WX
 g9GvzYx+DKfrYB+pg4h8WFB5ldVxWf3ZJhKiX/UC/gdmA69nx3LiDejMBLSlgZu9w/+q
 yWGAPwFuGvtH2LJW8Bs9ZoZvuaWbbMqrMMSGFxukS7h2KPBj97YWISvHkPcqxVwRFeXq 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31bewr2qr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 17:53:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053HrKi6083739;
        Wed, 3 Jun 2020 17:53:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31c1e0d9av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 17:53:25 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053HrOvq025737;
        Wed, 3 Jun 2020 17:53:24 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 10:53:23 -0700
Date:   Wed, 3 Jun 2020 20:53:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Vu Pham <vuhuong@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Roi Dayan <roid@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] net/mlx5: E-Switch, Fix an Oops error handling code
Message-ID: <20200603175316.GC18931@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=2 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=2 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030138
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The error handling dereferences "vport".  There is nothing we can do if
it is an error pointer except returning the error code.

Fixes: 133dcfc577ea ("net/mlx5: E-Switch, Alloc and free unique metadata for match")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
index 4e55d7225a265..857f6193f3b14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
@@ -301,8 +301,7 @@ int mlx5_esw_acl_ingress_vport_bond_update(struct mlx5_eswitch *esw, u16 vport_n
 
 	if (WARN_ON_ONCE(IS_ERR(vport))) {
 		esw_warn(esw->dev, "vport(%d) invalid!\n", vport_num);
-		err = PTR_ERR(vport);
-		goto out;
+		return PTR_ERR(vport);
 	}
 
 	esw_acl_ingress_ofld_rules_destroy(esw, vport);
-- 
2.26.2

