Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F33109FCC
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2019 15:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfKZOD4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 09:03:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:44771 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfKZOD4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Nov 2019 09:03:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 06:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="408670138"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2019 06:03:57 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xAQE3tgX038538;
        Tue, 26 Nov 2019 07:03:55 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xAQE3s8P057871;
        Tue, 26 Nov 2019 09:03:54 -0500
Subject: [PATCH for-next 07/11] IB/hfi1: Create API for auto activate
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Tue, 26 Nov 2019 09:03:54 -0500
Message-ID: <20191126140354.57492.69531.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191126140020.57492.67772.stgit@awfm-01.aw.intel.com>
References: <20191126140020.57492.67772.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

Add an auto activate routine for use by the interrupt handler.

Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/driver.c |   37 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index bbc7458..46c1be0 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -924,11 +924,8 @@ void set_all_slowpath(struct hfi1_devdata *dd)
 	}
 }
 
-static inline int set_armed_to_active(struct hfi1_ctxtdata *rcd,
-				      struct hfi1_packet *packet,
-				      struct hfi1_devdata *dd)
+static bool __set_armed_to_active(struct hfi1_packet *packet)
 {
-	struct work_struct *lsaw = &rcd->ppd->linkstate_active_work;
 	u8 etype = rhf_rcv_type(packet->rhf);
 	u8 sc = SC15_PACKET;
 
@@ -943,19 +940,34 @@ static inline int set_armed_to_active(struct hfi1_ctxtdata *rcd,
 		sc = hfi1_16B_get_sc(hdr);
 	}
 	if (sc != SC15_PACKET) {
-		int hwstate = driver_lstate(rcd->ppd);
+		int hwstate = driver_lstate(packet->rcd->ppd);
+		struct work_struct *lsaw =
+				&packet->rcd->ppd->linkstate_active_work;
 
 		if (hwstate != IB_PORT_ACTIVE) {
-			dd_dev_info(dd,
+			dd_dev_info(packet->rcd->dd,
 				    "Unexpected link state %s\n",
 				    opa_lstate_name(hwstate));
-			return 0;
+			return false;
 		}
 
-		queue_work(rcd->ppd->link_wq, lsaw);
-		return 1;
+		queue_work(packet->rcd->ppd->link_wq, lsaw);
+		return true;
 	}
-	return 0;
+	return false;
+}
+
+/**
+ * armed to active - the fast path for armed to active
+ * @packet: the packet structure
+ *
+ * Return true if packet processing needs to bail.
+ */
+static bool set_armed_to_active(struct hfi1_packet *packet)
+{
+	if (likely(packet->rcd->ppd->host_link_state != HLS_UP_ARMED))
+		return false;
+	return __set_armed_to_active(packet);
 }
 
 /*
@@ -1016,10 +1028,7 @@ int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread)
 			last = skip_rcv_packet(&packet, thread);
 			skip_pkt = 0;
 		} else {
-			/* Auto activate link on non-SC15 packet receive */
-			if (unlikely(rcd->ppd->host_link_state ==
-				     HLS_UP_ARMED) &&
-			    set_armed_to_active(rcd, &packet, dd))
+			if (set_armed_to_active(&packet))
 				goto bail;
 			last = process_rcv_packet(&packet, thread);
 		}

