Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ABE1D97D4
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgESNcq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 09:32:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESNcp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 09:32:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JDR7pj059973;
        Tue, 19 May 2020 13:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=mVotQXi+g7MWY/7kK/wE3SeZ6B/1jICWNeepGmK5DrI=;
 b=ANAYwIWgbQuGCZAi7rEPg/XUBgJzYhhmIeqisxy5Vjj1V+mNQY/hILKXUCz0MXAfWdpe
 Oz3wXgE6qCEDp6wKmpZ/zgJVAbI55QRxa0Ydkl+n3mI4t7lXNqg7YwrDMS8et3Aat0Xs
 jwhO1a+KNQvzC2EQXtS5YH0Y5Ldxo5ufO6rqyzTTtAR4Nszz83pCLvgAJ/dPH0S48u7x
 HHd0lFTIW89Oq30ORHGTbPpcYhG/rb9p0yO/8JxL4AMZVSg0mH6Un5eP7WC223O4klu0
 L6HsBnkBWBEfaxyaI4+g1bpQJ/GhO6XmkzRy94vDD6rn/x6jE3dqroC5/Cj+Iyau/oSy Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3127kr5djn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 13:32:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JDWXiM017999;
        Tue, 19 May 2020 13:32:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 313gj1pb7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 13:32:35 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04JDWU3o021155;
        Tue, 19 May 2020 13:32:30 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 06:32:29 -0700
Date:   Tue, 19 May 2020 16:32:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] RDMA/rtrs: Fix some signedness bugs in error handling
Message-ID: <20200519133223.GN2078@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkkUVV9b=iMhP4C=ndBRcePcTQMiF4h-Et1DFEKYPA6mg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190120
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
v2: propagate the correct error code instead of returning -EINVAL

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
+		return nr;
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
