Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16541140BDC
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2020 14:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgAQN6r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jan 2020 08:58:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54368 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgAQN6q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Jan 2020 08:58:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HDwWP5123410;
        Fri, 17 Jan 2020 13:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=+XClf+6vInzWnoz/XX8Nh5/S7PiR5cNmiXBXBiOGx/o=;
 b=H1OWyP14aXaIOwMl/kmVhB8NLyWcO3jV5N7zwGZcKYOgMU6UXaCXYEt8/NYUQV61PaXq
 pzsYIKuXJ1YnwwvboW9LmIQyz5YFazOH+C0AVQOqXazHgxa+p8uLYu7bZDRDjn7LA0m1
 Mw0I0ZxaMWAYO6APW5mBInC881HYNRMPhcNVtesxccuiabVcV293NoA8PLqNfPQ5tNyo
 4uvKchO4rwbF6Kbcj8oznD5sr/UDb8cg1XLAyHLi/1t6oCDwgjFWa/dip5bKf5ViWaIO
 SMZI3dnM4q5MfYRFn9gT0EREJQnHm4+Ggr2kFDQ7xa9qlhvUtJpEgOYDCEKH8TWWD7YT oQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xf73u8qmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 13:58:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HDrXrw125346;
        Fri, 17 Jan 2020 13:56:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xk232gv9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 13:56:32 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00HDuV3f031546;
        Fri, 17 Jan 2020 13:56:31 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 05:56:30 -0800
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Yishai Hadas <yishaih@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-rc] IB/mlx4: Fix leak in id_map_find_del
Date:   Fri, 17 Jan 2020 14:56:22 +0100
Message-Id: <20200117135622.836563-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170111
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Using CX-3 virtual functions, either from a bare-metal machine or
pass-through from a VM, MAD packets are proxied through the PF driver.

Since the VF drivers have separate name spaces for MAD Transaction Ids
(TIDs), the PF driver has to re-map the TIDs and keep the book keeping
in a cache.

Following the RDMA Connection Manager (CM) protocol, it is clear when
an entry has to evicted from the cache. When a DREP is sent from
mlx4_ib_multiplex_cm_handler(), id_map_find_del() is called. Similar
when a REJ is received by the mlx4_ib_demux_cm_handler(),
id_map_find_del() is called.

This function wipes out the TID in use from the IDR or XArray and
removes the id_map_entry from the table.

In short, it does everything except the topping of the cake, which is
to remove the entry from the list and free it. In other words, for the
DREP and REJ cases enumerated above, both will leak one id_map_entry.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/hw/mlx4/cm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index ecd6cadd529a..1df6d3ccfc62 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -197,8 +197,13 @@ static void id_map_find_del(struct ib_device *ibdev, int pv_cm_id)
 	if (!ent)
 		goto out;
 	found_ent = id_map_find_by_sl_id(ibdev, ent->slave_id, ent->sl_cm_id);
-	if (found_ent && found_ent == ent)
+	if (found_ent && found_ent == ent) {
 		rb_erase(&found_ent->node, sl_id_map);
+		if (!ent->scheduled_delete) {
+			list_del(&ent->list);
+			kfree(ent);
+		}
+	}
 out:
 	spin_unlock(&sriov->id_map_lock);
 }
-- 
2.20.1

