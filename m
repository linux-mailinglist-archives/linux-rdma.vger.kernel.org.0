Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318B8109FFB
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2019 15:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfKZOMt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 09:12:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:13387 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfKZOMt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Nov 2019 09:12:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 06:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="211424335"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga006.jf.intel.com with ESMTP; 26 Nov 2019 06:12:48 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id xAQEClTo042060;
        Tue, 26 Nov 2019 07:12:47 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id xAQECjFx059102;
        Tue, 26 Nov 2019 09:12:45 -0500
Subject: [PATCH for-next v2 06/11] IB/hfi1: IB/hfi1: Add an API to handle
 special case drop
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Tue, 26 Nov 2019 09:12:45 -0500
Message-ID: <20191126141245.58836.286.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
References: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

This patch pushes special case drop logic into an API to be shared by
all interrupt handlers.

Additionally, convert do_drop to a bool.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/driver.c |    6 +-----
 drivers/infiniband/hw/hfi1/hfi.h    |   21 ++++++++++++++++++++-
 drivers/infiniband/hw/hfi1/init.c   |    4 ++--
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 3671191..bbc7458 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1004,11 +1004,7 @@ int handle_receive_interrupt(struct hfi1_ctxtdata *rcd, int thread)
 	prescan_rxq(rcd, &packet);
 
 	while (last == RCV_PKT_OK) {
-		if (unlikely(dd->do_drop &&
-			     atomic_xchg(&dd->drop_packet, DROP_PACKET_OFF) ==
-			     DROP_PACKET_ON)) {
-			dd->do_drop = 0;
-
+		if (hfi1_need_drop(dd)) {
 			/* On to the next packet */
 			packet.rhqoff += packet.rsize;
 			packet.rhf_addr = (__le32 *)rcd->rcvhdrq +
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index b819d7d..9480499 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1316,7 +1316,7 @@ struct hfi1_devdata {
 	struct err_info_constraint err_info_xmit_constraint;
 
 	atomic_t drop_packet;
-	u8 do_drop;
+	bool do_drop;
 	u8 err_info_uncorrectable;
 	u8 err_info_fmconfig;
 
@@ -2462,6 +2462,25 @@ static inline bool is_integrated(struct hfi1_devdata *dd)
 	return dd->pcidev->device == PCI_DEVICE_ID_INTEL1;
 }
 
+/**
+ * hfi1_need_drop - detect need for drop
+ * @dd: - the device
+ *
+ * In some cases, the first packet needs to be dropped.
+ *
+ * Return true is the current packet needs to be dropped and false otherwise.
+ */
+static inline bool hfi1_need_drop(struct hfi1_devdata *dd)
+{
+	if (unlikely(dd->do_drop &&
+		     atomic_xchg(&dd->drop_packet, DROP_PACKET_OFF) ==
+		     DROP_PACKET_ON)) {
+		dd->do_drop = false;
+		return true;
+	}
+	return false;
+}
+
 int hfi1_tempsense_rd(struct hfi1_devdata *dd, struct hfi1_temp *temp);
 
 #define DD_DEV_ENTRY(dd)       __string(dev, dev_name(&(dd)->pcidev->dev))
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 55adc97..2e6938c 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -876,10 +876,10 @@ int hfi1_init(struct hfi1_devdata *dd, int reinit)
 
 	if (is_ax(dd)) {
 		atomic_set(&dd->drop_packet, DROP_PACKET_ON);
-		dd->do_drop = 1;
+		dd->do_drop = true;
 	} else {
 		atomic_set(&dd->drop_packet, DROP_PACKET_OFF);
-		dd->do_drop = 0;
+		dd->do_drop = false;
 	}
 
 	/* make sure the link is not "up" */

