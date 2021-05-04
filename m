Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A083729A5
	for <lists+linux-rdma@lfdr.de>; Tue,  4 May 2021 13:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhEDLrd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 May 2021 07:47:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34202 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhEDLrd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 May 2021 07:47:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144BiAK7080810;
        Tue, 4 May 2021 11:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=iwZB0ZnO0is2E0DGHrSZv0zRmI3kAqjpNNBhjJDdlTI=;
 b=hdjFCwkodWHdJGu3b9sqDhIi8BQi0owoDSewgJDXUKgG2G/3ZIS/R8MjjBXGjviR4hdy
 1Ga4HdSl+nIk3gHEOGI4VULOZuGxZ2b1XpRsTL2EEFceA2kep86tDwK8/RGtMye9/iTH
 pzL/x9ek/jqwYhHqS+cKhG3wO1vGLK3mBwm5Sroq4QGX2g8gjkmqwzERtsm3Nx0y+y9M
 oNAxVuYgya0oiVllG6Eh5P2rm+vaP1t7qt0Jt3InMzhT4Nog1wJFBEnEXDqUOsetvPAf
 RxI/QCaKsC6NjgwOhTyoT42Quzxk+0+nE5pwacNb+XbghvGskaizLXIsypqhxoME+bDI iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 388xxmxks8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 11:46:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144BkF6f158928;
        Tue, 4 May 2021 11:46:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 388xt3y6tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 11:46:35 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 144BkYIM006382;
        Tue, 4 May 2021 11:46:34 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 May 2021 11:46:34 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next] IB/core: Only update PKEY and GID caches on respective events
Date:   Tue,  4 May 2021 13:46:24 +0200
Message-Id: <1620128784-3283-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040088
X-Proofpoint-GUID: Fvd1hgR5ylNr8fbyUuvYGuyFQfoYkacr
X-Proofpoint-ORIG-GUID: Fvd1hgR5ylNr8fbyUuvYGuyFQfoYkacr
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040088
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

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cache.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 5c9fac7..531ae6b 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1472,10 +1472,14 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 }
 
 static int
-ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
+ib_cache_update(struct ib_device *device, u8 port, enum ib_event_type event,
+		bool reg_dev, bool enforce_security)
 {
 	struct ib_port_attr       *tprops = NULL;
-	struct ib_pkey_cache      *pkey_cache = NULL, *old_pkey_cache;
+	struct ib_pkey_cache      *pkey_cache = NULL;
+	struct ib_pkey_cache      *old_pkey_cache = NULL;
+	bool			   update_pkey_cache = (reg_dev || event == IB_EVENT_PKEY_CHANGE);
+	bool			   update_gid_cache = (reg_dev || event == IB_EVENT_GID_CHANGE);
 	int                        i;
 	int                        ret;
 
@@ -1492,14 +1496,16 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 		goto err;
 	}
 
-	if (!rdma_protocol_roce(device, port)) {
+	if (!rdma_protocol_roce(device, port) && update_gid_cache) {
 		ret = config_non_roce_gid_cache(device, port,
 						tprops->gid_tbl_len);
 		if (ret)
 			goto err;
 	}
 
-	if (tprops->pkey_tbl_len) {
+	update_pkey_cache &= !!tprops->pkey_tbl_len;
+
+	if (update_pkey_cache) {
 		pkey_cache = kmalloc(struct_size(pkey_cache, table,
 						 tprops->pkey_tbl_len),
 				     GFP_KERNEL);
@@ -1524,9 +1530,10 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 
 	write_lock_irq(&device->cache_lock);
 
-	old_pkey_cache = device->port_data[port].cache.pkey;
-
-	device->port_data[port].cache.pkey = pkey_cache;
+	if (update_pkey_cache) {
+		old_pkey_cache = device->port_data[port].cache.pkey;
+		device->port_data[port].cache.pkey = pkey_cache;
+	}
 	device->port_data[port].cache.lmc = tprops->lmc;
 	device->port_data[port].cache.port_state = tprops->state;
 
@@ -1558,7 +1565,7 @@ static void ib_cache_event_task(struct work_struct *_work)
 	 * the cache.
 	 */
 	ret = ib_cache_update(work->event.device, work->event.element.port_num,
-			      work->enforce_security);
+			      work->event.event, false, work->enforce_security);
 
 	/* GID event is notified already for individual GID entries by
 	 * dispatch_gid_change_event(). Hence, notifiy for rest of the
@@ -1631,7 +1638,7 @@ int ib_cache_setup_one(struct ib_device *device)
 		return err;
 
 	rdma_for_each_port (device, p) {
-		err = ib_cache_update(device, p, true);
+		err = ib_cache_update(device, p, 0, true, true);
 		if (err)
 			return err;
 	}
-- 
1.8.3.1

