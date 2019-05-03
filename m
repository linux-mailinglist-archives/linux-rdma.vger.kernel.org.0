Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF9912D90
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 14:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfECMaz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 08:30:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37556 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfECMaz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 May 2019 08:30:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43CSqtw090545;
        Fri, 3 May 2019 12:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=3KTnCL8rBm3ZETBuMa8pUIkej7HXJ9t/QJLPziRBsrg=;
 b=KRGzqjj72pAO+SBeIKwgURohjFufPLEtgGs39qGNSeUP9zJnVPAYlALdXH1FWbIlgn2L
 PNbU4AtI38hH1VyAoGa0pEN5ZAAqB8KJgIehdhsjyKZUbuduCqiq7UyskdUcQYa5jHf7
 M81UIrrzjSUhc5gmNYHDTXzutn9MBeKJiSYfegqjvgRI1EHoC8Zz5nkZnEjJFy3sv4fs
 WQLDI+V1mvmKS7bGSR46+Aq9HwQe6mNib+DLDebXqGw3u6QreA0nZiCr2HdONx3VcC77
 T8nSAxWFBJ9svXNJuvY/aYbNo9gAGErgwvoN57dP/AQpu+lUAE8FHevFWI08St1W2HPT SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s6xhypdbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 12:30:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43CRp3W066152;
        Fri, 3 May 2019 12:28:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2s7p8aa7b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 12:28:49 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x43CSmxT008795;
        Fri, 3 May 2019 12:28:48 GMT
Received: from mwanda (/196.104.111.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 May 2019 05:28:48 -0700
Date:   Fri, 3 May 2019 15:28:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] net/mlx5: potential error pointer dereference in error
 handling
Message-ID: <20190503122839.GB29695@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905030078
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905030079
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The error handling was a bit flipped around.  If the mlx5_create_flow_group()
function failed then it would have resulted in dereferencing "fg" when
it was an error pointer.

Fixes: 80f09dfc237f ("net/mlx5: Eswitch, enable RoCE loopback traffic")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
index 86f77456f873..401441aefbcb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
@@ -106,10 +106,10 @@ static int mlx5_rdma_enable_roce_steering(struct mlx5_core_dev *dev)
 
 	return 0;
 
-destroy_flow_table:
-	mlx5_destroy_flow_table(ft);
 destroy_flow_group:
 	mlx5_destroy_flow_group(fg);
+destroy_flow_table:
+	mlx5_destroy_flow_table(ft);
 free:
 	kvfree(spec);
 	kvfree(flow_group_in);
-- 
2.18.0

