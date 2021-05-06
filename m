Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53F23750E8
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhEFIc7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 04:32:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50216 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhEFIc6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 04:32:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1468UbXC070160;
        Thu, 6 May 2021 08:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Q9QP+j00Q++qi7e7SS1BInREKT1byhsAI8lH0JIFhg4=;
 b=g7nBx8t7aErAzo6+/jUAAtRMr3F5b4TymNJjQvIb9OdqstCJn87sM5JoIZNl3cqSZqOw
 YkSGyLYRtKPgfdYOnZmeSygeRSkhdiBIVttELwRW9ncencsChYXxDQJPz9RCjgOD+6Zh
 dCrN1NUsGCV68Avt3XAH+ZQFw+667eFj+Ix+U3IO0HhJw1KFgZF7p3mS/7dp/ovtTMoo
 JwpevE1qzXCqp6NUt8wktFCb0F3vhAnZlCGHUPJURI2Xp3g0Po4T8POPPiftbwQbKh2i
 y+wmgS57Q3FqxBQ9pxzq9SQ1OosYtj8wselwND68ptY89iSq6S/zJ5K8GZI+Cbs+uicW Jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38bemjm5p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 May 2021 08:31:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1468Vc9s088494;
        Thu, 6 May 2021 08:31:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 38bfut80y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 May 2021 08:31:55 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1468Vqdx027903;
        Thu, 6 May 2021 08:31:53 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 May 2021 01:31:52 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2] IB/core: Only update PKEY and GID caches on respective events
Date:   Thu,  6 May 2021 10:31:44 +0200
Message-Id: <1620289904-27687-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060058
X-Proofpoint-ORIG-GUID: 3siMA51pWDHJhRYI68CbhV6oeZunpFsl
X-Proofpoint-GUID: 3siMA51pWDHJhRYI68CbhV6oeZunpFsl
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060058
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Both the PKEY and GID tables in an HCA can hold in the order of
hundreds entries. Reading them are expensive. Partly because the API
for retrieving them only returns a single entry at a time. Further, on
certain implementations, e.g., CX-3, the VFs are paravirtualized in
this respect and have to rely on the PF driver to perform the
read. This again demands VF to PF communication.

IB Core's cache is refreshed on all events. Hence, filter the refresh
of the PKEY and GID caches based on the event received being
IB_EVENT_PKEY_CHANGE and IB_EVENT_GID_CHANGE respectively.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

v1 -> v2:
   * Changed signature of ib_cache_update() as per Leon's suggestion
   * Added Fixes tag as per Zhu Yanjun' suggestion
---
 drivers/infiniband/core/cache.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 5c9fac7..1493a60 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1472,10 +1472,12 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 }
 
 static int
-ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
+ib_cache_update(struct ib_device *device, u8 port, bool update_gids,
+		bool update_pkeys, bool enforce_security)
 {
 	struct ib_port_attr       *tprops = NULL;
-	struct ib_pkey_cache      *pkey_cache = NULL, *old_pkey_cache;
+	struct ib_pkey_cache      *pkey_cache = NULL;
+	struct ib_pkey_cache      *old_pkey_cache = NULL;
 	int                        i;
 	int                        ret;
 
@@ -1492,14 +1494,16 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 		goto err;
 	}
 
-	if (!rdma_protocol_roce(device, port)) {
+	if (!rdma_protocol_roce(device, port) && update_gids) {
 		ret = config_non_roce_gid_cache(device, port,
 						tprops->gid_tbl_len);
 		if (ret)
 			goto err;
 	}
 
-	if (tprops->pkey_tbl_len) {
+	update_pkeys &= !!tprops->pkey_tbl_len;
+
+	if (update_pkeys) {
 		pkey_cache = kmalloc(struct_size(pkey_cache, table,
 						 tprops->pkey_tbl_len),
 				     GFP_KERNEL);
@@ -1524,9 +1528,10 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 
 	write_lock_irq(&device->cache_lock);
 
-	old_pkey_cache = device->port_data[port].cache.pkey;
-
-	device->port_data[port].cache.pkey = pkey_cache;
+	if (update_pkeys) {
+		old_pkey_cache = device->port_data[port].cache.pkey;
+		device->port_data[port].cache.pkey = pkey_cache;
+	}
 	device->port_data[port].cache.lmc = tprops->lmc;
 	device->port_data[port].cache.port_state = tprops->state;
 
@@ -1558,6 +1563,8 @@ static void ib_cache_event_task(struct work_struct *_work)
 	 * the cache.
 	 */
 	ret = ib_cache_update(work->event.device, work->event.element.port_num,
+			      work->event.event == IB_EVENT_GID_CHANGE,
+			      work->event.event == IB_EVENT_PKEY_CHANGE,
 			      work->enforce_security);
 
 	/* GID event is notified already for individual GID entries by
@@ -1631,7 +1638,7 @@ int ib_cache_setup_one(struct ib_device *device)
 		return err;
 
 	rdma_for_each_port (device, p) {
-		err = ib_cache_update(device, p, true);
+		err = ib_cache_update(device, p, true, true, true);
 		if (err)
 			return err;
 	}
-- 
1.8.3.1

