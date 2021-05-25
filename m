Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E464390826
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 19:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhEYRu5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 13:50:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33456 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhEYRu4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 13:50:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PHmahR090552;
        Tue, 25 May 2021 17:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=otRVOeDoJG5pvcSmYnpofzVqwTigUCxWhb0fucKWclw=;
 b=wd0GnWDfHECWfpIpjNCBnGn+sWFXamj1zV6fUgnw6j9Gxgs92ZkRDp8cn5qgOg7jmSli
 TDe4p3p18XKGvlEC4HyYsbNQsp6GS+gy/ZgLJbiMpl/EFXetFSBKpssGUU1psVpn+SAl
 LmKv33P+Yfrf/4h1UXJvaelhhgxxHYnirKYvgWkScygcYoUmlB3wkWoVqkMdPBfI+lc2
 sDvWk4XT8SYDLf6RZW7+oDgHc5Vvoa89SzoJMz+vX7br7u6lC992axzmenQ8Njh29uKS
 DNaA0uMCK65xfXT9WlHV+lX9+JZElibSK7llZjDE3IivXmfoBZzgffXp4J25KsWL7UDw bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38pqfcewhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 17:49:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PHeDWY133282;
        Tue, 25 May 2021 17:49:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 38qbqsfv0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 17:49:21 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14PHnK0x014197;
        Tue, 25 May 2021 17:49:20 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 May 2021 10:49:20 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH for-next v3] IB/core: Only update PKEY and GID caches on respective events
Date:   Tue, 25 May 2021 19:49:09 +0200
Message-Id: <1621964949-28484-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250109
X-Proofpoint-ORIG-GUID: jHyB0DmS2p_fd_5RviYUntnkGSoQ4asO
X-Proofpoint-GUID: jHyB0DmS2p_fd_5RviYUntnkGSoQ4asO
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250110
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

---

v1 -> v2:
   * Changed signature of ib_cache_update() as per Leon's suggestion
   * Added Fixes tag as per Zhu Yanjun' suggestion

v2 -> v3:
   * Rebased on tip of dledford/wip/jgg-for-next, 331859d320f5
     ("RDMA/hns: Remove unused CMDQ member")
   * Added Leon's r-b
---
 drivers/infiniband/core/cache.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 3b0991f..d320459 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1465,10 +1465,12 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 }
 
 static int
-ib_cache_update(struct ib_device *device, u32 port, bool enforce_security)
+ib_cache_update(struct ib_device *device, u32 port, bool update_gids,
+		bool update_pkeys, bool enforce_security)
 {
 	struct ib_port_attr       *tprops = NULL;
-	struct ib_pkey_cache      *pkey_cache = NULL, *old_pkey_cache;
+	struct ib_pkey_cache      *pkey_cache = NULL;
+	struct ib_pkey_cache      *old_pkey_cache = NULL;
 	int                        i;
 	int                        ret;
 
@@ -1485,14 +1487,16 @@ static int config_non_roce_gid_cache(struct ib_device *device,
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
@@ -1517,9 +1521,10 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 
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
 
@@ -1551,6 +1556,8 @@ static void ib_cache_event_task(struct work_struct *_work)
 	 * the cache.
 	 */
 	ret = ib_cache_update(work->event.device, work->event.element.port_num,
+			      work->event.event == IB_EVENT_GID_CHANGE,
+			      work->event.event == IB_EVENT_PKEY_CHANGE,
 			      work->enforce_security);
 
 	/* GID event is notified already for individual GID entries by
@@ -1624,7 +1631,7 @@ int ib_cache_setup_one(struct ib_device *device)
 		return err;
 
 	rdma_for_each_port (device, p) {
-		err = ib_cache_update(device, p, true);
+		err = ib_cache_update(device, p, true, true, true);
 		if (err)
 			return err;
 	}
-- 
1.8.3.1

