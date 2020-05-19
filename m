Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4819D1D9B90
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgESPpl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 11:45:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52750 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgESPpl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 11:45:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JFba9R137478;
        Tue, 19 May 2020 15:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=N051ZBCa5vr/bo3pN8vlQTa8Ks4pH+TkFHzqVXxAw7Q=;
 b=mRJoEAxJFFj9D3cNgTMNEHVxko9PvrqTS3UiRZe2m995gwFpsE4+dKTPjnBEv4A2Zvun
 EM8RWYkb7RCFRFwyghQz0EUyELWgUAKEoHtzP8lhNzhbAtGPZdhmeiJ+l0xf8+yDiSXa
 fLqjpyCNOxkCQNguro9HGx4hu6FL4apyxTc3WmrinbTm1IM6+5H4e+ORSO135gbDmSuV
 boW8ihTm8FcaGE3EqdL6n3Ytj7Vo2bW9M520OAFF/LLJdjolj6Y3/MTz8sVoFyL71abX
 81madnE3i67gr6brPIXy65VLxPV3+TVYxUJRWlIbAhQINm5ScX/cfoiN0eoezd5MOIEn 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3128tne3yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 15:45:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JFdHDP123517;
        Tue, 19 May 2020 15:45:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 312t34mqg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 15:45:34 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04JFjW9i012230;
        Tue, 19 May 2020 15:45:32 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 08:45:31 -0700
Date:   Tue, 19 May 2020 18:45:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/rtrs: Fix a couple off by one bugs in
 rtrs_srv_rdma_done()
Message-ID: <20200519154525.GA66801@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHg0Huz39q9nWwTrtCY=SgU=T9oZJQdchx6c1LOPbSQiywzrqw@mail.gmail.com>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 cotscore=-2147483648 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190134
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These > comparisons should be >= to prevent accessing one element
beyond the end of the buffer.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 658c8999cb0d..0b53b79b0e27 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1213,8 +1213,8 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 
 			msg_id = imm_payload >> sess->mem_bits;
 			off = imm_payload & ((1 << sess->mem_bits) - 1);
-			if (unlikely(msg_id > srv->queue_depth ||
-				     off > max_chunk_size)) {
+			if (unlikely(msg_id >= srv->queue_depth ||
+				     off >= max_chunk_size)) {
 				rtrs_err(s, "Wrong msg_id %u, off %u\n",
 					  msg_id, off);
 				close_sess(sess);
-- 
2.26.2

