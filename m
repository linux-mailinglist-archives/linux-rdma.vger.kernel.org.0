Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3083C1901B1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 00:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCWXOl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Mar 2020 19:14:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:55412 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgCWXOl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Mar 2020 19:14:41 -0400
IronPort-SDR: TGAdG25SCG2t00uEpZ3LgtLwL5eWN+HTFjaHLRVvrSSmrjmvnLJYDaEyqcaZ8m8cWFOe/tNlm7
 oFEuEoCi80iA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 16:14:37 -0700
IronPort-SDR: rg2zQ/bCKmQtIaWtw6nvtDiM6vtpuPlt/6HHB0Rto5xmBEQNNh8zgLBmbj0BBbZdXUybepQXpA
 gbChLjXdF2cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="249790672"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2020 16:14:36 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02NNEa3F013899;
        Mon, 23 Mar 2020 16:14:36 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02NNEYPe064349;
        Mon, 23 Mar 2020 19:14:34 -0400
Subject: [PATCH v2 for-next 01/16] IB/hfi1: Add accelerated IP capability bit
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 23 Mar 2020 19:14:34 -0400
Message-ID: <20200323231434.64035.37141.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

The accelerated IP capability bit is added to allow users to control
which feature is enabled and disabled.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/common.h |    5 +++--
 include/uapi/rdma/hfi/hfi1_user.h   |    3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/common.h b/drivers/infiniband/hw/hfi1/common.h
index 40a1ff0..1f7107e 100644
--- a/drivers/infiniband/hw/hfi1/common.h
+++ b/drivers/infiniband/hw/hfi1/common.h
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -149,7 +149,8 @@
 				   HFI1_CAP_NO_INTEGRITY |		\
 				   HFI1_CAP_PKEY_CHECK |		\
 				   HFI1_CAP_TID_RDMA |			\
-				   HFI1_CAP_OPFN) <<			\
+				   HFI1_CAP_OPFN |			\
+				   HFI1_CAP_AIP) <<			\
 				  HFI1_CAP_USER_SHIFT)
 /*
  * Set of capabilities that need to be enabled for kernel context in
diff --git a/include/uapi/rdma/hfi/hfi1_user.h b/include/uapi/rdma/hfi/hfi1_user.h
index 01ac585..d95ef9a 100644
--- a/include/uapi/rdma/hfi/hfi1_user.h
+++ b/include/uapi/rdma/hfi/hfi1_user.h
@@ -6,7 +6,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2020 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -109,6 +109,7 @@
 #define HFI1_CAP_OPFN             (1UL << 16) /* Enable the OPFN protocol */
 #define HFI1_CAP_SDMA_HEAD_CHECK  (1UL << 17) /* SDMA head checking */
 #define HFI1_CAP_EARLY_CREDIT_RETURN (1UL << 18) /* early credit return */
+#define HFI1_CAP_AIP              (1UL << 19) /* Enable accelerated IP */
 
 #define HFI1_RCVHDR_ENTSIZE_2    (1UL << 0)
 #define HFI1_RCVHDR_ENTSIZE_16   (1UL << 1)

