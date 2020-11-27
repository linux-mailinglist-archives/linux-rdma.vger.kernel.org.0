Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440512C6097
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 08:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgK0HoG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 02:44:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57086 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgK0HoG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 02:44:06 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AR7chCU033341;
        Fri, 27 Nov 2020 07:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=4oBBvldraXOOArp5hfpDrfqTTN1jyV+NrA9jh4uwx6w=;
 b=ujE5E1fZcpQa/BuiFKd5Ym8i4gH8jd4GqeJwPgCUQPUkf7wpT7FoOCnYHkzJ7HcrNJL4
 IqJkXuPxdJ07zvi67Cm65eu3OQpyO7ctySdfuv3P9PPIIZzsMDkzep78E5oSTO2g5Gon
 TFmlRUDolx8jlis0OAeG/i4h6ej/ILsaPWphFCuV0sKQ0IqFaqQuQ3ewnH6CnhL3JKGn
 +Qzryynppy9JzlmfCKiEwWph94knrcm9AqoxIuLU+GXTlWFaPCedODoXyFYhd3OA8DaT
 Q/Nzz0UrlInlVJ8srBSXUccnl5LrB5fddSYH8MBpnMa5aQ8C+JJ+TUL39MkeFDEHEJjl nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 351kwhg82j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 07:44:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AR7a1wG040129;
        Fri, 27 Nov 2020 07:44:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 351kwhpmbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 07:44:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AR7hwJD012674;
        Fri, 27 Nov 2020 07:43:58 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Nov 2020 23:43:58 -0800
Date:   Fri, 27 Nov 2020 10:43:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: Fix a error code in devx_umem_reg_cmd_alloc()
Message-ID: <20201127074349.GA7391@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270045
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This code returns PTR_ERR(NULL) which is zero or success but it should
return -ENOMEM.

Fixes: 878f7b31c3a7 ("RDMA/mlx5: Use ib_umem_find_best_pgsz() for devx")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 7c3eefba6197..0b87c74281d3 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2107,7 +2107,7 @@ static int devx_umem_reg_cmd_alloc(struct mlx5_ib_dev *dev,
 		      ib_umem_num_dma_blocks(obj->umem, page_size));
 	cmd->in = uverbs_zalloc(attrs, cmd->inlen);
 	if (!cmd->in)
-		return PTR_ERR(cmd->in);
+		return -ENOMEM;
 
 	umem = MLX5_ADDR_OF(create_umem_in, cmd->in, umem);
 	mtt = (__be64 *)MLX5_ADDR_OF(umem, umem, mtt);
-- 
2.29.2

