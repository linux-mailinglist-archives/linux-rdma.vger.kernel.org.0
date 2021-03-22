Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964833445E2
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 14:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhCVNgC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 09:36:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45902 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhCVNft (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 09:35:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MDYeV8151092;
        Mon, 22 Mar 2021 13:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=YY1Dm7I1KXkB70IhXwqNvVN04FcU4XM9LUOVPGDtH0I=;
 b=WVwr8/7I6BRd7i+NF1oKA+83lvYTTrXh1BzarF5UtATB67y6yn8QGtXQhY8P+3ZMyNuj
 ZIs0rAXOs2ghpdjnypeUDjzkGVJTYgg0DqJRD2UAXdPgCoW3kfq6xJAev2jNP3WnGmzd
 /WCUKUD3fOx9rwdO/7njmtrZvrq6Da3gEEzRcet9YgnBz4KkkCgcA+najJuquDztrakZ
 AK66NCYCagVcVo/kR/DeT6Xps5bK3HrtmvOWXwBX8LTs9CVUBdh/J8fNafNs9y6r+Isr
 DUxmjqTEEoFshBaOVzkI1k6glw0BaSYIZwxh03tjCVZHmBWompAbH5XFk9zQCsuGz2iu DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37d8fr3h1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 13:35:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MDU3L3039445;
        Mon, 22 Mar 2021 13:35:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37dttqkdr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 13:35:44 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12MDZhdU018508;
        Mon, 22 Mar 2021 13:35:43 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Mar 2021 06:35:43 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH for-rc] RDMA/core: Fix corrupted SL on passive side
Date:   Mon, 22 Mar 2021 14:35:32 +0100
Message-Id: <1616420132-31005-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9930 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9930 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220098
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On RoCE systems, a CM REQ contains a Primary Hop Limit > 1 and Primary
Subnet Local is zero.

In cm_req_handler(), the cm_process_routed_req() function is
called. Since the Primary Subnet Local value is zero in the request,
and since this is RoCE (Primary Local LID is permissive), the
following statement will be executed:

      IBA_SET(CM_REQ_PRIMARY_SL, req_msg, wc->sl);

This corrupts SL in req_msg if it was different from zero. In other
words, a request to setup a connection using an SL != zero, will not
be honored, and a connection using SL zero will be created instead.

Fixed by not calling cm_process_routed_req() on RoCE systems.

Fixes: 3971c9f6dbf2 ("IB/cm: Add interim support for routed paths")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 3d194bb..6adbaea 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2138,7 +2138,8 @@ static int cm_req_handler(struct cm_work *work)
 		goto destroy;
 	}
 
-	cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
+	if (cm_id_priv->av.ah_attr.type != RDMA_AH_ATTR_TYPE_ROCE)
+		cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
 
 	memset(&work->path[0], 0, sizeof(work->path[0]));
 	if (cm_req_has_alt_path(req_msg))
-- 
1.8.3.1

