Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E47146D6F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2020 16:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAWPzk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jan 2020 10:55:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36724 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgAWPzk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jan 2020 10:55:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NFnMnl156969;
        Thu, 23 Jan 2020 15:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=obonjtei1iuTFG/+UDK5e9D1cVPlY8oTHettR8GiCdw=;
 b=qZlyon/IGd3hV0J7tmnw/cXhJwnhVbNP1HQXmnQyfjbZ4k5mK6TgLochquA0jBclEAtj
 xkMD6ZFc2oXcVy6Ff68bCP6pwsoFO/7WoeHg7ejONookJ8jn4/pPDmsfVwIweSDET8ik
 IyFwB6zn4FNEXci7oAUVbvZfgWCTleUJCW4VXE1S0/XX67ZMjWAcjAt/4orW7BfFAr2l
 XnbVHj3FtMnTmZ2BeRfoENUsG0kkl0Bso48mGiJuAI+q+6oX/EBfbEeO4AzsWwqu2JkP
 Q0AebENwuROKGxvUszCj4JCoPU3tMfUmiLjjcV1sY8OzrFADLsKJZHPeqgoXloTiLUlZ NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xksyqk5qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 15:55:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NFmCWV038381;
        Thu, 23 Jan 2020 15:55:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xpq0wsbv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 15:55:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00NFtXc9020857;
        Thu, 23 Jan 2020 15:55:33 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 07:55:33 -0800
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Yishai Hadas <yishaih@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org
Subject: [PATCH for-rc v2] IB/mlx4: Fix leak in id_map_find_del
Date:   Thu, 23 Jan 2020 16:55:21 +0100
Message-Id: <20200123155521.1212288-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230129
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
REJ case enumerated above, one id_map_entry will be leaked.

For the other case above, a DREQ has been received first. The
reception of the DREQ will trigger queuing of a delayed work to delete
the id_map_entry, for the case where the VM doesn't send back a DREP.

In the normal case, the VM _will_ send back a DREP, and
id_map_find_del() will be called.

But this scenario introduces a secondary leak. First, when the DREQ is
received, a delayed work is queued. The VM will then return a DREP,
which will call id_map_find_del(). As stated above, this will free the
TID used from the XArray or IDR. Now, there is window where that
particular TID can be re-allocated, lets say by an outgoing REQ. This
TID will later be wiped out by the delayed work, when the function
id_map_ent_timeout() is called. But the id_map_entry allocated by the
outgoing REQ will not be de-allocated, and we have a leak.

Both leaks are fixed by removing the id_map_find_del() function and
only using schedule_delayed(). Of course, a check in
schedule_delayed() to see if the work already has been queued, has
been added.

Another benefit of always using the delayed version for deleting
entries, is that we do get a TimeWait effect; a TID no longer in use,
will occupy the XArray or IDR for CM_CLEANUP_CACHE_TIMEOUT time,
without any ability of being re-used for that time period.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

    v1 -> v2:
       * Re-factored and removed id_map_find_del
       * Fixed a secondary leak
---
 drivers/infiniband/hw/mlx4/cm.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index ecd6cadd529a..018449681959 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -186,23 +186,6 @@ static void id_map_ent_timeout(struct work_struct *work)
 	kfree(ent);
 }
 
-static void id_map_find_del(struct ib_device *ibdev, int pv_cm_id)
-{
-	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
-	struct rb_root *sl_id_map = &sriov->sl_id_map;
-	struct id_map_entry *ent, *found_ent;
-
-	spin_lock(&sriov->id_map_lock);
-	ent = xa_erase(&sriov->pv_id_table, pv_cm_id);
-	if (!ent)
-		goto out;
-	found_ent = id_map_find_by_sl_id(ibdev, ent->slave_id, ent->sl_cm_id);
-	if (found_ent && found_ent == ent)
-		rb_erase(&found_ent->node, sl_id_map);
-out:
-	spin_unlock(&sriov->id_map_lock);
-}
-
 static void sl_id_map_add(struct ib_device *ibdev, struct id_map_entry *new)
 {
 	struct rb_root *sl_id_map = &to_mdev(ibdev)->sriov.sl_id_map;
@@ -294,7 +277,7 @@ static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id)
 	spin_lock(&sriov->id_map_lock);
 	spin_lock_irqsave(&sriov->going_down_lock, flags);
 	/*make sure that there is no schedule inside the scheduled work.*/
-	if (!sriov->is_going_down) {
+	if (!sriov->is_going_down && !id->scheduled_delete) {
 		id->scheduled_delete = 1;
 		schedule_delayed_work(&id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
 	}
@@ -339,11 +322,9 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 cont:
 	set_local_comm_id(mad, id->pv_cm_id);
 
-	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
+	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
+	    mad->mad_hdr.attr_id == CM_DREP_ATTR_ID)
 		schedule_delayed(ibdev, id);
-	else if (mad->mad_hdr.attr_id == CM_DREP_ATTR_ID)
-		id_map_find_del(ibdev, pv_cm_id);
-
 	return 0;
 }
 
@@ -382,12 +363,10 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
 		*slave = id->slave_id;
 	set_remote_comm_id(mad, id->sl_cm_id);
 
-	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
+	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
+	    mad->mad_hdr.attr_id == CM_REJ_ATTR_ID ||
+	    mad->mad_hdr.attr_id == CM_DREP_ATTR_ID)
 		schedule_delayed(ibdev, id);
-	else if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID ||
-			mad->mad_hdr.attr_id == CM_DREP_ATTR_ID) {
-		id_map_find_del(ibdev, (int) pv_cm_id);
-	}
 
 	return 0;
 }
-- 
2.20.1

