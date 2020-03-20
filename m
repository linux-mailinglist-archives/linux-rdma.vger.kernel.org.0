Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4F518CEC9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 14:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgCTNZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 09:25:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40862 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTNZi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 09:25:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KDE3LD106985;
        Fri, 20 Mar 2020 13:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=bdSbUfGENDlkzdRDthVsqJu4/pVICInAf99yzDW///k=;
 b=GVrx5vH1wpAbFjaKazVoQmIHAcYohd87nnCN7qwFjwSjTKQ2kiOSZuYJeAMWl9cAUsRz
 juzz2M04Z1LlsEaxnYuerxF1wbSb0cvKsb0yC0xrF6PE9QqYexmMayWyIl1AD1dEvQSu
 IpiTmsaKVauyydSqfNEO2DvoGY60MtjVl8gvyH70PYM/qklQtiTjpxpvzXkMSQrD674p
 duJkCij+PvkSzc9dQzfHJxUmP0stJZnwKx0JDe6cx9pjWnICee+UMo/9iCaHb3ZXoIBn
 mK2J4WyRIFd68NyhJxckU2e9lzRiN6wrPyrESvrNr9azvnTpbEENr5SpAAgVUJVukqDs IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yub27dgna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 13:25:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02KDKkdp080446;
        Fri, 20 Mar 2020 13:25:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ys906shme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Mar 2020 13:25:32 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02KDPVGW005818;
        Fri, 20 Mar 2020 13:25:31 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Mar 2020 06:25:31 -0700
Date:   Fri, 20 Mar 2020 16:25:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] {IB,net}/mlx5: Remove unused variable
Message-ID: <20200320132525.GE95012@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003200057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200057
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The "key" variable is never initialized or used except to print out a
debug message.

Fixes: fc6a9f86f08a ("{IB,net}/mlx5: Assign mkey variant in mlx5_ib only")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/mr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mr.c b/drivers/net/ethernet/mellanox/mlx5/core/mr.c
index fd3e6d217c3b..5286e8d5aa57 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mr.c
@@ -44,7 +44,6 @@ int mlx5_core_create_mkey(struct mlx5_core_dev *dev,
 	u32 mkey_index;
 	void *mkc;
 	int err;
-	u8 key;
 
 	MLX5_SET(create_mkey_in, in, opcode, MLX5_CMD_OP_CREATE_MKEY);
 
@@ -59,8 +58,8 @@ int mlx5_core_create_mkey(struct mlx5_core_dev *dev,
 	mkey->key |= mlx5_idx_to_mkey(mkey_index);
 	mkey->pd = MLX5_GET(mkc, mkc, pd);
 
-	mlx5_core_dbg(dev, "out 0x%x, key 0x%x, mkey 0x%x\n",
-		      mkey_index, key, mkey->key);
+	mlx5_core_dbg(dev, "out 0x%x, mkey 0x%x\n",
+		      mkey_index, mkey->key);
 	return 0;
 }
 EXPORT_SYMBOL(mlx5_core_create_mkey);
-- 
2.25.1

