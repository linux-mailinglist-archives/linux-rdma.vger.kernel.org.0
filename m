Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB52B1D95D3
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgESMFO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 08:05:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36540 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgESMFO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 08:05:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JC36kD118347;
        Tue, 19 May 2020 12:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2fpmY1k55WSq8WljHrbcXEhrjzL8/nsgsGqNUB8dwII=;
 b=aYhuBfrFn8xwLyp/OcAgaRdEW0b8PIXIppoEPm5GvR0xkE8PlJnbandLn3Ca9Y0CjCGl
 DK5+7NhRhKHq+aNUxnB+SUC96h7COSK+bwavR21391pOsfjIJvCTzneQ6P28JpzEUXtt
 hek7HGWhL6FhpRbkPAYMLygopZbt+rSjKpMuW0wHj7s0SyBz9C7Qg0JShKKHJ6cDoAKw
 fQIpcESIsL3RWqY3eA7kChyYGZEOxNX7sgGKqsh5mz80e5HtD4eL8BgCLsB98Dy4QpkY
 DAU/A1g0gRhKCoOXcUM28F3d38pFvVYcoAxw/9oOJmqspvWXf9DwFlBIW1VmfmGDhGwl Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3127kr4xee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 12:05:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JC2YY0084270;
        Tue, 19 May 2020 12:03:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 313gj1j7b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 12:03:05 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04JC34ho028158;
        Tue, 19 May 2020 12:03:04 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 05:03:04 -0700
Date:   Tue, 19 May 2020 15:02:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/rtrs: Fix some signedness bugs in error handling
Message-ID: <20200519120256.GC42765@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190109
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The problem is that "req->sg_cnt" is an unsigned int so if "nr" is
negative, it gets type promoted to a high positive value and the
condition is false.  This patch fixes it by handling negatives separately.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 +++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 468fdd0d8713..17f99f0962d0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1047,11 +1047,10 @@ static int rtrs_map_sg_fr(struct rtrs_clt_io_req *req, size_t count)
 
 	/* Align the MR to a 4K page size to match the block virt boundary */
 	nr = ib_map_mr_sg(req->mr, req->sglist, count, NULL, SZ_4K);
-	if (unlikely(nr < req->sg_cnt)) {
-		if (nr < 0)
-			return nr;
+	if (nr < 0)
+		return -EINVAL;
+	if (unlikely(nr < req->sg_cnt))
 		return -EINVAL;
-	}
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
 
 	return nr;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ba8ab33b94a2..eefd149ce7a4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -649,7 +649,7 @@ static int map_cont_bufs(struct rtrs_srv_sess *sess)
 		}
 		nr = ib_map_mr_sg(mr, sgt->sgl, sgt->nents,
 				  NULL, max_chunk_size);
-		if (nr < sgt->nents) {
+		if (nr < 0 || nr < sgt->nents) {
 			err = nr < 0 ? nr : -EINVAL;
 			goto dereg_mr;
 		}
-- 
2.26.2

