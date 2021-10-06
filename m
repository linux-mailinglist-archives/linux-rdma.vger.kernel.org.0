Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73225423DD2
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 14:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhJFMjd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 08:39:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:30430 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhJFMjd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 08:39:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="225873158"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="225873158"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 05:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="488475364"
Received: from unknown (HELO intel-73.bj.intel.com) ([10.238.154.73])
  by orsmga008.jf.intel.com with ESMTP; 06 Oct 2021 05:37:39 -0700
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCH 1/1] RDMA/irdma: compact the header file
Date:   Wed,  6 Oct 2021 16:15:31 -0400
Message-Id: <20211006201531.469650-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The struct irdma_bth is not used, so remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/cm.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.h b/drivers/infiniband/hw/irdma/cm.h
index d03cd29333ea..1fbe72e18625 100644
--- a/drivers/infiniband/hw/irdma/cm.h
+++ b/drivers/infiniband/hw/irdma/cm.h
@@ -159,14 +159,6 @@ enum irdma_cm_event_type {
 	IRDMA_CM_EVENT_ABORTED,
 };
 
-struct irdma_bth { /* Base Trasnport Header */
-	u8 opcode;
-	u8 flags;
-	__be16 pkey;
-	__be32 qpn;
-	__be32 apsn;
-};
-
 struct ietf_mpa_v1 {
 	u8 key[IETF_MPA_KEY_SIZE];
 	u8 flags;
-- 
2.27.0

