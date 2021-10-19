Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD414433A09
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhJSPTU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 11:19:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:11469 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhJSPTT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 11:19:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="228422217"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="228422217"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 08:17:06 -0700
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="594286121"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.209.137.150])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 08:17:05 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc 1/2] RDMA/irdma: Set VLAN in UD work completion correctly
Date:   Tue, 19 Oct 2021 10:16:53 -0500
Message-Id: <20211019151654.1943-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Currently VLAN is reported in UD work completion when VLAN id is zero,
i.e. no VLAN case.

Report VLAN in UD work completion only when VLAN id is non-zero.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 7110ebf..102dc93 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3399,9 +3399,13 @@ static void irdma_process_cqe(struct ib_wc *entry,
 		}
 
 		if (cq_poll_info->ud_vlan_valid) {
-			entry->vlan_id = cq_poll_info->ud_vlan & VLAN_VID_MASK;
-			entry->wc_flags |= IB_WC_WITH_VLAN;
+			u16 vlan = cq_poll_info->ud_vlan & VLAN_VID_MASK;
+
 			entry->sl = cq_poll_info->ud_vlan >> VLAN_PRIO_SHIFT;
+			if (vlan) {
+				entry->vlan_id = vlan;
+				entry->wc_flags |= IB_WC_WITH_VLAN;
+			}
 		} else {
 			entry->sl = 0;
 		}
-- 
1.8.3.1

