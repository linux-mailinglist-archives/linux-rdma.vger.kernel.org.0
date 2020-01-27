Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18814AB14
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 21:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgA0UQX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 15:16:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49024 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA0UQX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 15:16:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RK8WMo077279;
        Mon, 27 Jan 2020 20:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=fDsungFwpuwJwGPNxuHW2ofKbH9eBws9/Gml5Z7wWEA=;
 b=H6NWNwYp1stwfxUE6WVsia3UzhNSJp/baO5urFprsbm+W+GmaNA51QUbLgOCpsqKxqrw
 6mhFjyJpfb+FG3rZAJGr7C43+/55xLaAskbsvqY298Fd7YsBaZ2HhtPUE29ww4hDNgB3
 zBtEteDvfvAOgeiu/G1AT08ZtQT4bbErEw7gw2rRX7sR1xx2abNfSwh2aC7BShE7GwMD
 i4SMW2D5nmriJUKjWshIOMXFnYrz+Wq3iZl/3WlAvhLv3MNmxiwOTVnxzPgdUxUPhzw1
 r57COZGdgs++LPWKftSQkNCVBVHqBYTM5jgS20c4RgPCXrgJZj2u89HOZJRGAeGAEeZ/ Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xrd3u1v1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 20:16:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RKA5sA091656;
        Mon, 27 Jan 2020 20:16:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xry6v1aa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 20:16:17 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00RKGFCj024061;
        Mon, 27 Jan 2020 20:16:16 GMT
Received: from mbpatil.us.oracle.com (/10.211.44.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 12:16:15 -0800
From:   Manjunath Patil <manjunath.b.patil@oracle.com>
To:     jgg@ziepe.ca
Cc:     haakon.bugge@oracle.com, rama.nichanamatlu@oracle.com,
        yishaih@mellanox.com, linux-rdma@vger.kernel.org, leon@kernel.org
Subject: [PATCH] IB/mlx4: Fix use after free in RDMA CM disconnect code path
Date:   Mon, 27 Jan 2020 12:16:52 -0800
Message-Id: <1580156212-28267-1-git-send-email-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270161
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

---
PS:
This fixes the recently submitted patch from Haakon[cc'd]
The commit hash used in here has to be updated while applying
---
Commit 01528b332860 ("IB/mlx4: Fix leak in id_map_find_del") introduces
two code paths that can pontentially cause use after free.

1. active side - Send DREQ and Recv DREP
Sending of DREQ in mux schedules a work[id->timeout] to clean up the
id_map_entry. Receive of DREP in demux also try to schedule the work.
This can cause the second schedule_delayed() call to access the id,
which might have been freed by the first scheduled work. We actually
don't need to schedule clean up work when we receive DREP. Hence avoid
scheduling of clean up work on receiving
DREP[mlx4_ib_demux_cm_handler()].

2. passive side - Recv DREQ and Send DREP
Similar thing can happen on the passive side, when we receive a DREQ and
send a DREP. We don't need to schedule clean up work when we send
DREP. Hence avoid scheduling of clean up work while sending
DREP[mlx4_ib_multiplex_cm_handler()].

How race can happen on active side:
thread 1				thread 2
send DREQ
schedule id->timeout
			..delay..
receive DREP
id = id_map_get(..)
					id->timeout() -> frees id
schedule_delayed(ibdev, id)

id is accessed inside schedule_delayed()

Fixes: 01528b332860 ("IB/mlx4: Fix leak in id_map_find_del")

Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
Reviewed-by: Rama Nichanamatlu <rama.nichanamatlu@oracle.com>
---
 drivers/infiniband/hw/mlx4/cm.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 84ea003..9d2f216 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -331,8 +331,7 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 cont:
 	set_local_comm_id(mad, id->pv_cm_id);
 
-	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
-	    mad->mad_hdr.attr_id == CM_DREP_ATTR_ID)
+	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
 		schedule_delayed(ibdev, id);
 	return 0;
 }
@@ -373,8 +372,7 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
 	set_remote_comm_id(mad, id->sl_cm_id);
 
 	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
-	    mad->mad_hdr.attr_id == CM_REJ_ATTR_ID ||
-	    mad->mad_hdr.attr_id == CM_DREP_ATTR_ID)
+	    mad->mad_hdr.attr_id == CM_REJ_ATTR_ID)
 		schedule_delayed(ibdev, id);
 
 	return 0;
-- 
1.7.1

