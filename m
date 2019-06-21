Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898494EA40
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 16:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfFUOJp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 10:09:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUOJp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jun 2019 10:09:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LE4EhB119871;
        Fri, 21 Jun 2019 14:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=QDLZN1HgJ+/BQ+FyQff3Jo34xNZRRZDqv9MXgPbWNrI=;
 b=jPFLSyADEMtahQwESDqTZ0nwlF7Fd6xUsP4ziR2gAHIYUG4qtdnOwGRJoNOMz+phfRUw
 R5fILir7lic56V/N2vMtg+x26494+nfK8LjCULlbn1feYyGZ5obqWb+0BxoIlSKZDsc6
 CN+SpDTcbOvP0C2qG+MygUfqUs4rnV18cQce38IO6YIXEjiAR6tOCXOIlWVHqDTSmor2
 6wz65p78bUUrtof60Fqpbb48238IG64oEf5YNURN5VpmPv3PBj6aDv1Hfz8tHc2C6ja8
 sap9ggtkSl3/EmoafiT7xR2jU5wP2VdDWTiq1kOSkRovKsbtbhY1YUSa1suERvLw7NC5 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t7809pp7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 14:09:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LE7g94137107;
        Fri, 21 Jun 2019 14:09:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t77yp7k0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 14:09:22 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5LE9LXJ025111;
        Fri, 21 Jun 2019 14:09:21 GMT
Received: from dm-oel.no.oracle.com (/10.172.157.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Jun 2019 07:09:21 -0700
From:   Dag Moxnes <dag.moxnes@oracle.com>
To:     dag.moxnes@oracle.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/core: Fix race when resolving IP address
Date:   Fri, 21 Jun 2019 16:09:16 +0200
Message-Id: <1561126156-10162-1-git-send-email-dag.moxnes@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use neighbour lock when copying MAC address from neighbour data struct
in dst_fetch_ha.

When not using the lock, it is possible for the function to race with
neigh_update, causing it to copy an invalid MAC address.

It is possible to provoke this error by calling rdma_resolve_addr in a
tight loop, while deleting the corresponding ARP entry in another tight
loop.

Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
Change-Id: I3c5f982b304457f0a83ea7def2fac70315ed38b4
---
 drivers/infiniband/core/addr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 2f7d141598..e4945fd1bb 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -333,12 +333,16 @@ static int dst_fetch_ha(const struct dst_entry *dst,
 	if (!n)
 		return -ENODATA;
 
+	read_lock_bh(&n->lock)
 	if (!(n->nud_state & NUD_VALID)) {
-		neigh_event_send(n, NULL);
 		ret = -ENODATA;
 	} else {
 		memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
 	}
+	read_unlock_bh(&n->lock);
+
+	if (ret)
+		neigh_event_send(n, NULL);
 
 	neigh_release(n);
 
-- 
2.20.1

