Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F006AB9BB8
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Sep 2019 02:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394087AbfIUAtg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 20:49:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47712 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394086AbfIUAtg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 20:49:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8L0nZsn142767
        for <linux-rdma@vger.kernel.org>; Sat, 21 Sep 2019 00:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=ZzsgiDt5gXjArT8tG+fM5TtUpiF+qHsbVjay7P15YVA=;
 b=iQHjXpZJkmjFV7Q4BkJ5oeAsjbuhm5ogNv7a8LMeihuRXK52XxXiKWgrLYGxMKTwXZoI
 MqiEtSPskldIA2AVo6WDT66xUUYzTvL0Xv1jkd7ZpoFuv3Yg9rg7EtZwLhCX2qFPPapA
 V+/+w3YIPOnLAKzt9I4DsRAu6pDJEjRUzisxLf7DjHcqjz1ERGpq3LsQjrErsmiIS6li
 au7yVBMmu37XxxHNY6S+J0Fq/64cJtB/SsWi8R6c1ryT4YJ6e7H/1NPBKbClNPSDbxUX
 14hJi7WpAXCgmr/g1AB9VkmdSD657QfYSAktTdWCYSXONxkaqf2s5fFZDZHR47LKOlIb sQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v3vb5d574-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Sat, 21 Sep 2019 00:49:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8L0mgI1170323
        for <linux-rdma@vger.kernel.org>; Sat, 21 Sep 2019 00:49:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2v4vpnd8xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Sat, 21 Sep 2019 00:49:34 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8L0nY8I024436
        for <linux-rdma@vger.kernel.org>; Sat, 21 Sep 2019 00:49:34 GMT
Received: from qing-ol6-work.us.oracle.com (/10.132.91.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Sep 2019 17:49:33 -0700
From:   Qing Huang <qing.huang@oracle.com>
To:     linux-rdma@vger.kernel.org
Subject: [PATCH] net/mlx5: Fixed a typo in a comment in esw_del_uc_addr()
Date:   Fri, 20 Sep 2019 17:49:28 -0700
Message-Id: <20190921004928.24349-1-qing.huang@oracle.com>
X-Mailer: git-send-email 2.9.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9386 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=779
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909210007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9386 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=863 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909210007
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changed "managerss" to "managers".

Fixes: a1b3839ac4a4 ("net/mlx5: E-Switch, Properly refer to the esw manager vport")
Signed-off-by: Qing Huang <qing.huang@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 81e03e4..48642b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -530,7 +530,7 @@ static int esw_del_uc_addr(struct mlx5_eswitch *esw, struct vport_addr *vaddr)
 	u16 vport = vaddr->vport;
 	int err = 0;
 
-	/* Skip mlx5_mpfs_del_mac for eswitch managerss,
+	/* Skip mlx5_mpfs_del_mac for eswitch managers,
 	 * it is already done by its netdev in mlx5e_execute_l2_action
 	 */
 	if (!vaddr->mpfs || esw->manager_vport == vport)
-- 
2.9.3

