Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43F179236
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgCDOWl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 09:22:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbgCDOWl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 09:22:41 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024ED3cl147695;
        Wed, 4 Mar 2020 14:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=bE7sC7nJ7rSQT8HCdLruNQybs2hy567yeiO0aK5lroI=;
 b=uftF55W0p1TXun2B11WMya0bEYxXWmxgb1xg4z2W4OMiZuTFjhXVw4flPTil3SWgOtNM
 vhQ4jk19zHabcyCEPuk2G5Wx6a2i+Ane47/s0Nh5n7nwr/yJ6jSzQpOx5LpfBRCKsDHo
 nQDBoVxWtqNtk3tJmbp9SKD6+OoDEShREbrVb2JufsqDhmHSQdUaun11ODlH1S9ZcO0S
 0JOa/hooJwIpslamPsyEa7P8AucojZqeaLe3fMsWC4wW/OnpMWjgGpf5uHH9ukd8/vN0
 qeAIeX9Ql7s3/N1R2ccU6vXlwC172ZoozxNm09pp/ew1NSgFIqA7PvHUoD//TnvYLh7S Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yghn3abde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 14:22:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024EEhOP120584;
        Wed, 4 Mar 2020 14:22:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2yg1p7k61h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 14:22:35 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 024EMYMm001776;
        Wed, 4 Mar 2020 14:22:34 GMT
Received: from kili.mountain (/41.210.146.162)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 06:22:33 -0800
Date:   Wed, 4 Mar 2020 17:22:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@mellanox.com>, Eli Cohen <eli@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Mark Bloch <markb@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] net/mlx5e: Fix an IS_ERR() vs NULL check
Message-ID: <20200304142151.qivcobp6ngrynb2p@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040109
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The esw_vport_tbl_get() function returns error pointers on error.

Fixes: 96e326878fa5 ("net/mlx5e: Eswitch, Use per vport tables for mirroring")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 4b5b6618dff4..692fe9e6a08f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -198,7 +198,7 @@ int mlx5_esw_vport_tbl_get(struct mlx5_eswitch *esw)
 	mlx5_esw_for_all_vports(esw, i, vport) {
 		attr.in_rep->vport = vport->vport;
 		fdb = esw_vport_tbl_get(esw, &attr);
-		if (!fdb)
+		if (IS_ERR(fdb))
 			goto out;
 	}
 	return 0;
-- 
2.11.0

