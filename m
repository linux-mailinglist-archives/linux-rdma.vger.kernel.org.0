Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C096D4165
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2019 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfJKNfE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Oct 2019 09:35:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38084 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJKNfE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Oct 2019 09:35:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BDYOnH180550;
        Fri, 11 Oct 2019 13:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=zYRrN4ptli6lIkl9bheayVe/eW/vl9po/KIQvkCwEPw=;
 b=QR2q3QT9nE/C5SJVUogQySBsIHkwgRTru8o3PblqA0s2xmQZD2aQ+2KWzA7H0tmWP8Ld
 CNTmjFpg2WCBxgVXF1GUOkHUjI9kSs8cM+Pxch9Uii3FuR/36K39QFuZOiRrrF5wNNhI
 t6OFc8bQGBhLUzlrJoialtemcVz4qEIJpjuV9qlPoId3jCBn8iToMVuvxyOTlqlaBonN
 zGMnWxBSH0W34uxTG9ynNUQK435vH87WMhSbgom53FmonOWZgZUeN/775HeCSjX5cW7h
 XwNhJ+r5SHMBkFwllA1vO3Yt1A0vlKK2/8in21ugj0RzcfSW3yyAwQ2GwzxaIvrSOHEt Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vekts1h27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 13:34:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BDXZvk030182;
        Fri, 11 Oct 2019 13:34:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vj9quvudy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 13:34:33 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9BDYRkr029053;
        Fri, 11 Oct 2019 13:34:27 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 06:34:27 -0700
Date:   Fri, 11 Oct 2019 16:34:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Matan Barak <matanb@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] uverbs: prevent potential underflow
Message-ID: <20191011133419.GA22905@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008194425.GA28067@ziepe.ca>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110127
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

And really "attr.comp_vector" is appears as a u32 to user space so that's
the right type to use.

Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Change both types to u32

 drivers/infiniband/core/uverbs.h | 2 +-
 include/rdma/ib_verbs.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6a47ba85c54c..e7e733add99f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -366,7 +366,7 @@ struct ib_tm_caps {
 
 struct ib_cq_init_attr {
 	unsigned int	cqe;
-	int		comp_vector;
+	u32		comp_vector;
 	u32		flags;
 };
 
-- 
2.20.1

