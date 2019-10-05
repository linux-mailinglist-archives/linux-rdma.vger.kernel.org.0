Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0353FCC81E
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2019 07:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfJEFY5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Oct 2019 01:24:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42156 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJEFY4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 5 Oct 2019 01:24:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x955OT3t118128;
        Sat, 5 Oct 2019 05:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=MHLJ+v2FrwvIQqoJEE93jo71MnucBzuVQQK/GeAiIyI=;
 b=Ue2H6Cq82olsWjvH2AUAP3xoP5U8JmjAtcPVtyQ7UH8XU1PQLcqaDvro4w0oKLAuzHzr
 Fv3tkLzSWj6oi3xGkqNoi6chyLeq+gN6aOy2GzSX9jH3XdS/N5cIBzD4K8hWSot4FZJa
 yro5j5oZWCtkio1kpk8Yv30wl0u2K9W56bacdTQQvOYnqhRj1KmZNxbjgFBZEDQLx8nm
 9OArFb9GGWNjz2Crp1pg9dMt5xRXYGHtNa8IPDuwPqsowiSsZI84Xn7pZ7JYJ7QcZ29G
 WuvUTkX6fvWE3olqjepLWZvlZHdCywoMu+ywjZruXEqHJnvG88+UvxN+jrAAq0hEFp2l gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vejku0dee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Oct 2019 05:24:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x955OMg2185985;
        Sat, 5 Oct 2019 05:24:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vegagre0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Oct 2019 05:24:29 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x955NjMx021940;
        Sat, 5 Oct 2019 05:23:46 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 22:23:45 -0700
Date:   Sat, 5 Oct 2019 08:23:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Matan Barak <matanb@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] uverbs: prevent potential underflow
Message-ID: <20191005052337.GA20129@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9400 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910050048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9400 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910050049
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The issue is in drivers/infiniband/core/uverbs_std_types_cq.c in the
UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE) function.  We check that:

	if (attr.comp_vector >= attrs->ufile->device->num_comp_vectors) {

But we don't check that "attr.comp_vector" whether negative.  It
could potentially lead to an array underflow.  My concern would be where
cq->vector is used in the create_cq() function from the cxgb4 driver.

Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/core/uverbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 1e5aeb39f774..63f7f7db5902 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -98,7 +98,7 @@ ib_uverbs_init_udata_buf_or_null(struct ib_udata *udata,
 
 struct ib_uverbs_device {
 	atomic_t				refcount;
-	int					num_comp_vectors;
+	u32					num_comp_vectors;
 	struct completion			comp;
 	struct device				dev;
 	/* First group for device attributes, NULL terminated array */
-- 
2.20.1

