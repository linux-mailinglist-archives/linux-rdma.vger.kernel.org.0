Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4278263530
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 13:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfGILvl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 07:51:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52844 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGILvl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 07:51:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69BnWKa014504;
        Tue, 9 Jul 2019 11:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=xtBXsTaJ7dIMqNvrbwXEX92Vq1lmGGW+oyu54odZQc0=;
 b=pEUPLdfBRoms5xAoDhCqEkMUqR0uWVmyUahw9Zl3O+pgyWQ8l0C/PqTC7FI/1igtx100
 GhuB7jhGhb9HhaVZw5Fs7Zc54RqedYAPXcQptenp6AchPjPg8fw8PUsAZNfktFiI+IX8
 ovepCSnZ5s4panBc6Wf1pHhK+h/vs+NjUtr8TtQmL/VGK/1zp0ygByQFdDfgd5XIeeAu
 oKv44wtnx9sn7NpdBDvk9D23WDOn/pUgYH8EFmMFDq6eTIcRmbrSasfCrw08dFIRdRU5
 7jq3jycQ9PtZLEA6/glPjLgjoTgxcjJlUcu3V9ozUrqXcXbt/DR7Vh2PdPFWWmI9XdTQ qA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tjm9qksj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 11:50:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69Blnl9160141;
        Tue, 9 Jul 2019 11:50:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tmmh2wve0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 11:50:53 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x69BoqbV023270;
        Tue, 9 Jul 2019 11:50:52 GMT
Received: from dm-oel.no.oracle.com (/10.172.157.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jul 2019 04:50:52 -0700
From:   Dag Moxnes <dag.moxnes@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        parav@mellanox.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] RDMA/core: Fix race when resolving IP address
Date:   Tue,  9 Jul 2019 13:50:26 +0200
Message-Id: <1562673026-31996-1-git-send-email-dag.moxnes@oracle.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090146
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the neighbour lock when copying the MAC address from the neighbour
data struct in dst_fetch_ha.

When not using the lock, it is possible for the function to race with
neigh_update(), causing it to copy an torn MAC address:

rdma_resolve_addr()
  rdma_resolve_ip()
    addr_resolve()
      addr_resolve_neigh()
        fetch_ha()
          dst_fetch_ha()
	     memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN)

and

net_ioctl()
  arp_ioctl()
    arp_rec_delete()
      arp_invalidate()
        neigh_update()
          __neigh_update()
	    memcpy(&neigh->ha, lladdr, dev->addr_len)

It is possible to provoke this error by calling rdma_resolve_addr() in a
tight loop, while deleting the corresponding ARP entry in another tight
loop.

Fixes: 51d45974515c ("infiniband: addr: Consolidate code to fetch neighbour hardware address from dst.")
Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 2f7d141598..9b76a8fcdd 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -337,7 +337,7 @@ static int dst_fetch_ha(const struct dst_entry *dst,
 		neigh_event_send(n, NULL);
 		ret = -ENODATA;
 	} else {
-		memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
+		neigh_ha_snapshot(dev_addr->dst_dev_addr, n, dst->dev);
 	}
 
 	neigh_release(n);
-- 
2.20.1

