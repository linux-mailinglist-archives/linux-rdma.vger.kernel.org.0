Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29CC1A0A4A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2020 11:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgDGJjy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Apr 2020 05:39:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34312 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGJjy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Apr 2020 05:39:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0379btq5173072;
        Tue, 7 Apr 2020 09:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=cYST/ZoiF0Dr/rfKoOwPAP097lohkPoNAscvUBJPy5A=;
 b=fOUJvOYEyZhF4fYVmjvwqkNZWBtbxg5V9pUOnPDU8yINM4oaaF1zrQvfnK4MCImsjjwl
 b+drRiW5BofybHNK9rd5ATpUkKbfC4QrfFUgeMUtYpOFH+82D+0aHzGDytAhzmzj2//r
 /jV5HWgfy0an9ebwYa7m7eJB92FgqI+Fxs6uyTdsF/fWaGmbFyS1bGeOaDG4cbw+CnVf
 VBQ3n405JmHvlTw4aCZf8w4eeiGTxlr5hA1pOAy8sUXcNv6BX17EluHfsuN4k+93vSaM
 r8ijvUp4hln9wCR0yiC2svGd0MmXRyuPpP7c0G3bFC/arGVPIqimett5wjnMDCzQOQb4 vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 308ffd9t5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 09:39:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0379bbM7133800;
        Tue, 7 Apr 2020 09:37:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30741dn379-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 09:37:40 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0379bNBi008412;
        Tue, 7 Apr 2020 09:37:23 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 02:37:22 -0700
Date:   Tue, 7 Apr 2020 12:37:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] RDMA/cm: Fix an error check in cm_alloc_id_priv()
Message-ID: <20200407093714.GA80285@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406145109.GQ20941@ziepe.ca>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070082
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The xa_alloc_cyclic_irq() function returns either 0 or 1 on success and
negatives on error.  This code treats 1 as an error and returns
ERR_PTR(1) which will cause an Oops in the caller.

Fixes: ae78ff3a0f0c ("RDMA/cm: Convert local_id_table to XArray")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Use the correct Fixes tag and add Matthew to the CC list.

 drivers/infiniband/core/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 4794113ecd59..f7ac5974176f 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -862,7 +862,7 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
 
 	ret = xa_alloc_cyclic_irq(&cm.local_id_table, &id, NULL, xa_limit_32b,
 				  &cm.local_id_next, GFP_KERNEL);
-	if (ret)
+	if (ret < 0)
 		goto error;
 	cm_id_priv->id.local_id = (__force __be32)id ^ cm.random_id_operand;
 
-- 
2.25.1

