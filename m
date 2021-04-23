Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6769436916E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Apr 2021 13:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhDWLnq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Apr 2021 07:43:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50200 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhDWLnq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Apr 2021 07:43:46 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13NBea49169184;
        Fri, 23 Apr 2021 11:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=S66XGWsxtWw3KFeNK/zMFkU4+OP6l6K4EheP3hlTzoI=;
 b=BgWwaFiOwJahgfkC+kjgUCbCf5bM6NZdufF/jdoeHVkUUHzNWJDNA5xPF+Cn+rKvfz9R
 kkDV7Z5q6732IG5j8SwbBl9YWMUzRDB3+8yoKuAc5kx/PS4M4jxsQi7U+L6aToczTfU0
 piliPw2KdZ5el9XzF87DPSHA3fnVBZ7EpFJzuFwEDGZHomcj7yWEyxoVXmhnPKuKKJS5
 kyH52vf+HxNFeqruhAAgTJUndvkNUpDHbtEkHXdxfXXSsP6rjBYLNjVpVXkFHKpIuh8u
 WiGCQJp6HwfAMAaYxm4LLJx+5XQWUUECb3f5KQO1az87MCNuR9sKKLM0QT+Cjdj0Wbh/ jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37yn6cg8dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:43:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13NBduR4013295;
        Fri, 23 Apr 2021 11:43:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 383ccffnsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:43:06 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13NBh5pM018898;
        Fri, 23 Apr 2021 11:43:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 383ccffns7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:43:05 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13NBh4EF001372;
        Fri, 23 Apr 2021 11:43:04 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Apr 2021 04:43:03 -0700
Date:   Fri, 23 Apr 2021 14:42:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@nvidia.com>,
        Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: Fix some error messages
Message-ID: <YIKywXhusLj4cDFM@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: YSFmQf3h8wS6QcxzcBUv3cQJ8cimGK3h
X-Proofpoint-ORIG-GUID: YSFmQf3h8wS6QcxzcBUv3cQJ8cimGK3h
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104230076
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This code was using IS_ERR() instead of PTR_ERR() so it prints 1 instead
of the correct error code.

Fixes: 25cb31768042 ("net/mlx5: E-Switch, Improve error messages in term table creation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c
index a81ece94f599..95f5c1a27718 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c
@@ -83,16 +83,16 @@ mlx5_eswitch_termtbl_create(struct mlx5_core_dev *dev,
 	ft_attr.autogroup.max_num_groups = 1;
 	tt->termtbl = mlx5_create_auto_grouped_flow_table(root_ns, &ft_attr);
 	if (IS_ERR(tt->termtbl)) {
-		esw_warn(dev, "Failed to create termination table (error %d)\n",
-			 IS_ERR(tt->termtbl));
+		esw_warn(dev, "Failed to create termination table (error %ld)\n",
+			 PTR_ERR(tt->termtbl));
 		return -EOPNOTSUPP;
 	}
 
 	tt->rule = mlx5_add_flow_rules(tt->termtbl, NULL, flow_act,
 				       &tt->dest, 1);
 	if (IS_ERR(tt->rule)) {
-		esw_warn(dev, "Failed to create termination table rule (error %d)\n",
-			 IS_ERR(tt->rule));
+		esw_warn(dev, "Failed to create termination table rule (error %ld)\n",
+			 PTR_ERR(tt->rule));
 		goto add_flow_err;
 	}
 	return 0;
@@ -283,8 +283,8 @@ mlx5_eswitch_add_termtbl_rule(struct mlx5_eswitch *esw,
 		tt = mlx5_eswitch_termtbl_get_create(esw, &term_tbl_act,
 						     &dest[i], attr);
 		if (IS_ERR(tt)) {
-			esw_warn(esw->dev, "Failed to get termination table (error %d)\n",
-				 IS_ERR(tt));
+			esw_warn(esw->dev, "Failed to get termination table (error %ld)\n",
+				 PTR_ERR(tt));
 			goto revert_changes;
 		}
 		attr->dests[num_vport_dests].termtbl = tt;
-- 
2.30.2

