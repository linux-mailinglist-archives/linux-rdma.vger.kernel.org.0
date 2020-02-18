Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A050B16209D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 06:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgBRF6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 00:58:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51118 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgBRF6U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 00:58:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I5qltY105132;
        Tue, 18 Feb 2020 05:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=5ieENpEvs/1sXyVr2XodpsXB4V9kVxkivQF8v1qz2ng=;
 b=MSetE2KJNmOlYcUTwJ/NVf8WomIQcJuHbf2LMCXp2yh9U5MWGOvz2qO61sDgfx4WFMSb
 NQ2mndR5GJDiCNCHLvyar+fAfdq56rsFuOOqim4CA2lfcXickx4Enp/192GHhwX6jNWh
 JzCpZR0sz2wFOzMLsgMlh59sUhBYbNA4kRrXKn+tqcwdE/gDh05nmEIrtKKZQAiGmpYE
 foTnf4P2+XOJBJsFVriCwDANubHNO/7RW/rTSov//u4PC+6yIRT/a08iecsjZk0etxk3
 1pPqCbFggaPzpDgvGtu54Yqr7vYURqQFZn0DUtC6IE7SlgnoLQSZLPOgpe4MKWnhbqN+ 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y7aq5peva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 05:58:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I5wCSb117434;
        Tue, 18 Feb 2020 05:58:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y6tep00q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 05:58:12 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01I5wBHp023576;
        Tue, 18 Feb 2020 05:58:11 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 21:58:10 -0800
Date:   Tue, 18 Feb 2020 08:58:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Erez Alfasi <ereza@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Mohamad Heib <mohamadh@mellanox.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] IB/core: Fix a bitwise vs logical OR typo
Message-ID: <20200218055801.cosg4fylgfxhk67s@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180047
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This was supposed to be a bitwise | instead of a logical ||.

Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/core/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 2b4d80393bd0..b9a36ea244d4 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -348,7 +348,7 @@ static struct ib_ports_pkeys *get_new_pps(const struct ib_qp *qp,
 	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
 		new_pps->main.state = IB_PORT_PKEY_VALID;
 
-	if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
+	if (!(qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
 		new_pps->main.port_num = qp_pps->main.port_num;
 		new_pps->main.pkey_index = qp_pps->main.pkey_index;
 		if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
-- 
2.11.0

