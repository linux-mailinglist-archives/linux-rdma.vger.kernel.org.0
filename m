Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8251169EDB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 07:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgBXG4Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 01:56:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52420 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgBXG4Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 01:56:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O6mSe3155842;
        Mon, 24 Feb 2020 06:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=QWSqwcIztpQts4IfNeoCEMDWvigo5Raa0tAsMwAZU2I=;
 b=goAgTDHk3dBlgxcN0WuI+knSIkjjK0sMNTkh8kpipA9dTQRrShE24/TUATz5V0+5uMoM
 DMPFp0fzZMb2uh5FgKZ05eCNfFLT4ZFLhtjw/E75hKA35U3O4rZCh717p6U99PC6dikA
 5jvmOg3rwOVOXQ5UStMCFYAZkaCJMkKPWuLUTTkbywHoIFeaXARCu6yCe97OdUjlAhVk
 qYxBjUu8QcAdqiWo1hQ5MA8NZ8NH0OH7nmE9zn/7ODxkZ9LdUgem4dfXWo16cF5S+n8K
 pO3jxugzpRxSisNLCa7E0hDjSUWX7ZzXF8fexz10PpouQ9kf1PTqCDd6uTCKidaFZUeo lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yavxrd886-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 06:56:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O6m3ts186167;
        Mon, 24 Feb 2020 06:56:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ybdsfxf4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 06:56:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01O6uIlV018109;
        Mon, 24 Feb 2020 06:56:18 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Feb 2020 22:56:17 -0800
Date:   Mon, 24 Feb 2020 09:55:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@mellanox.com>, Aya Levin <ayal@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] net/mlx5e: Fix error code in mlx5e_fec_in_caps()
Message-ID: <20200224065557.d23b4yd46kjnzfya@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240059
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The mlx5e_fec_in_caps() function is type bool so these negative returns
become "return true;" when they should be "return false;"

Fixes: 2132b71f78d2 ("net/mlx5e: Advertise globaly supported FEC modes")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
index 2c4a670c8ffd..b5ddf9bf2681 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
@@ -471,10 +471,10 @@ bool mlx5e_fec_in_caps(struct mlx5_core_dev *dev, int fec_policy)
 	int i;
 
 	if (!MLX5_CAP_GEN(dev, pcam_reg))
-		return -EOPNOTSUPP;
+		return false;
 
 	if (!MLX5_CAP_PCAM_REG(dev, pplm))
-		return -EOPNOTSUPP;
+		return false;
 
 	MLX5_SET(pplm_reg, in, local_port, 1);
 	err =  mlx5_core_access_reg(dev, in, sz, out, sz, MLX5_REG_PPLM, 0, 0);
-- 
2.11.0

