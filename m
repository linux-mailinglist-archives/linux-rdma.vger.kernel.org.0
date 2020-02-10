Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDAB157A16
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgBJNUJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:20:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:55880 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730988AbgBJNUF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:20:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="221552763"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2020 05:20:04 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADK337008425;
        Mon, 10 Feb 2020 06:20:04 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADK2wO088495;
        Mon, 10 Feb 2020 08:20:02 -0500
Subject: [PATCH for-next 16/16] IB/hfi1: Enable the transmit side of the
 datagram ipoib netdev
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 10 Feb 2020 08:20:02 -0500
Message-ID: <20200210132002.87776.74958.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Piotr Stankiewicz <piotr.stankiewicz@intel.com>

This patch hooks the transmit side of the datagram netdev with
ipoib by setting the rdma_netdev_get_params function for the
hfi1 ib_device_ops structue. It also enables the receiving side
by adding the AIP capability into the default capabilities.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/common.h |    1 +
 drivers/infiniband/hw/hfi1/verbs.c  |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/common.h b/drivers/infiniband/hw/hfi1/common.h
index 6062545..ff423e54 100644
--- a/drivers/infiniband/hw/hfi1/common.h
+++ b/drivers/infiniband/hw/hfi1/common.h
@@ -160,6 +160,7 @@
 				 HFI1_CAP_PKEY_CHECK |			\
 				 HFI1_CAP_MULTI_PKT_EGR |		\
 				 HFI1_CAP_EXTENDED_PSN |		\
+				 HFI1_CAP_AIP |				\
 				 ((HFI1_CAP_HDRSUPP |			\
 				   HFI1_CAP_MULTI_PKT_EGR |		\
 				   HFI1_CAP_STATIC_RATE_CTRL |		\
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 04f0206..d7621c2 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -66,6 +66,7 @@
 #include "vnic.h"
 #include "fault.h"
 #include "affinity.h"
+#include "ipoib.h"
 
 static unsigned int hfi1_lkey_table_size = 16;
 module_param_named(lkey_table_size, hfi1_lkey_table_size, uint,
@@ -1793,6 +1794,7 @@ static int get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 	.modify_device = modify_device,
 	/* keep process mad in the driver */
 	.process_mad = hfi1_process_mad,
+	.rdma_netdev_get_params = hfi1_ipoib_rn_get_params,
 };
 
 /**

