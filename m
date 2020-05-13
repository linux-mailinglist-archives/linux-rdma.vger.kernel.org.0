Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7F01D0C6B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 11:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgEMJiY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 05:38:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37240 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgEMJiY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 05:38:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D9bJJP016157;
        Wed, 13 May 2020 09:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=x8e3vhoOs9yZYDFLS2a2wtkKJqxS3Ei3cBDJB5zRQEE=;
 b=z6y0G98opo6kgtt/9QLywO2cASgFfSTK8tonJSrO8FVXp+ieK3cgOEtHEDLsUi7vvW46
 gmGxqb3S7z6XaqfuP5RtgxcQtjT0OaqOhxKCympgEmlE+hkSrT4OydjVsni4wPdSHF1p
 m3Yy1WA/zTTd1FtcAwoll9ubfbHG7R6Id1p3spsQGnCcTXhzDMnmL77eauCrkWLZghZe
 8VM0w0NBzztp3s2lUsU30f/eIewzBa01TZ/IYRN9a4pntneya1rjPr5OO5DFQb6WpKbH
 bi992SGxFTHmO0rP/Y87FztbbHsKO+wFRYoznNU1GbkY2yztSor6HHcYpGxMdbU29fCl cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3100xwk4yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 09:38:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D9cIRA072853;
        Wed, 13 May 2020 09:38:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3100ye7n03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 09:38:19 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04D9bnaG008082;
        Wed, 13 May 2020 09:37:49 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 02:37:49 -0700
Date:   Wed, 13 May 2020 12:37:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: Fix query_srq_cmd() function
Message-ID: <20200513093741.GC347693@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130087
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The "srq_out" pointer is never freed so that causes a memory leak.  It's
never used and can be deleted.  Freeing "out" will lead to a double in
mlx5_ib_query_srq().

Fixes: 31578defe4eb ("RDMA/mlx5: Update mlx5_ib to use new cmd interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/mlx5/srq_cmd.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index bc50a712bf2ed..ee85b8087a718 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -159,27 +159,20 @@ static int query_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 			 struct mlx5_srq_attr *out)
 {
 	u32 in[MLX5_ST_SZ_DW(query_srq_in)] = {};
-	u32 *srq_out;
 	void *srqc;
 	int err;
 
-	srq_out = kvzalloc(MLX5_ST_SZ_BYTES(query_srq_out), GFP_KERNEL);
-	if (!srq_out)
-		return -ENOMEM;
-
 	MLX5_SET(query_srq_in, in, opcode, MLX5_CMD_OP_QUERY_SRQ);
 	MLX5_SET(query_srq_in, in, srqn, srq->srqn);
 	err = mlx5_cmd_exec_inout(dev->mdev, query_srq, in, out);
 	if (err)
-		goto out;
+		return err;
 
 	srqc = MLX5_ADDR_OF(query_srq_out, out, srq_context_entry);
 	get_srqc(srqc, out);
 	if (MLX5_GET(srqc, srqc, state) != MLX5_SRQC_STATE_GOOD)
 		out->flags |= MLX5_SRQ_FLAG_ERR;
-out:
-	kvfree(out);
-	return err;
+	return 0;
 }
 
 static int create_xrc_srq_cmd(struct mlx5_ib_dev *dev,
-- 
2.26.2

