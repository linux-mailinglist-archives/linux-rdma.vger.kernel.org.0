Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258AA61DB8
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfGHLRR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 07:17:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39644 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbfGHLRR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 07:17:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x68BEbUZ144983;
        Mon, 8 Jul 2019 11:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=wyEdXnjJ8jw6sAdU9BtEeTeNAhQPGnvYdqq4Yf+RfmY=;
 b=EYrfpujejJTqx0+2HHciLdDO2gGPwyoRRmV3E7Nh2ivAl011KySpBHyaPVtBRkkzTTbW
 uhdORuYHtWrZ1c0PKLoyLwQsz6A0rqrIewH6meH2Z523hDUPBQyQCl+30IBQRjqLju90
 P3q31NT3cg0pgKnxrG3qRwaHA2MJ5xuwV+nHRy4/Xb6ix094srK+x1d/R8O3KLk/jeaz
 sY6bQkSlOplZ90iUa0nmelpzKRDgBI9L0pE3dE0i7xB7V7J4za2pBG4fJQk4mU2xh7Lf
 fES+O8cbpF7edN5wfSFrNFDnY+XlJlUCuyTv0AAZXotZaV3kEimOK+ivCQqQGI4DomXG hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tjkkpdsw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 11:16:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x68BD0nE176139;
        Mon, 8 Jul 2019 11:16:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tjjyk57pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 11:16:53 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x68BGqmU015176;
        Mon, 8 Jul 2019 11:16:52 GMT
Received: from dm-oel.no.oracle.com (/10.172.157.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 04:16:51 -0700
From:   Dag Moxnes <dag.moxnes@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        parav@mellanox.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] RDMA/core: Fix race when resolving IP address
Date:   Mon,  8 Jul 2019 13:16:24 +0200
Message-Id: <1562584584-13132-1-git-send-email-dag.moxnes@oracle.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080145
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

This will cause the race shown it the following sample trace:

rdma_resolve_addr()
  rdma_resolve_ip()
    addr_resolve()
      addr_resolve_neigh()
        fetch_ha()
          dst_fetch_ha()
            n->nud_state == NUD_VALID

and

net_ioctl()
  arp_ioctl()
    arp_rec_delete()
      arp_invalidate()
        neigh_update()
          __neigh_update()
            neigh->nud_state = new;

Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
---
v1 -> v2:
   * Modified implementation to improve readability

v2 -> v3:
   * Added sample trace as suggested by Parav Pandit
   * Added Reviewed-by


---
 drivers/infiniband/core/addr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 2f7d141598..51323ffbc5 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -333,11 +333,14 @@ static int dst_fetch_ha(const struct dst_entry *dst,
 	if (!n)
 		return -ENODATA;
 
-	if (!(n->nud_state & NUD_VALID)) {
+	read_lock_bh(&n->lock);
+	if (n->nud_state & NUD_VALID) {
+		memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
+		read_unlock_bh(&n->lock);
+	} else {
+		read_unlock_bh(&n->lock);
 		neigh_event_send(n, NULL);
 		ret = -ENODATA;
-	} else {
-		memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
 	}
 
 	neigh_release(n);
-- 
2.20.1

