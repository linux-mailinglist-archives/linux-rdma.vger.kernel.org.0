Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294D8567A88
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiGEXIb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiGEXI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:08:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A152460FB
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062507; x=1688598507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xeJ2ovW/sOD29dV2jOp4Qqo8sM/PjKO9uWsriEwhLfg=;
  b=aAFDhgMPuSuJkgdOLA5OYJ56mAYJjLeLg2Bmkn0N4GgVXMBES626SR0Z
   HsU4D0pSLxytXaMzraofHfsH0g2TtqmXIzs9srq+XtJM1yhTsIaQpISb7
   wfVXVVpjYbj2K4XVWav7lNLnn0DjBA55ndO+ZtMLbHRE5h/kVXmluKDMx
   lqEWx8yFEH+fOhp8r2k1e7qqm8bOjXKdO/61mRWJE1liDVH1m0jBv1Cuj
   vT/p7I1VD9gMp8rhYoq0BWTNopMtRTmWgAG/tusEmZ+Uahwos5UStLEFR
   RkS9Lff2paf3xwj1U8C2CIxkS1ardRAfCmoStpyYQznSJldWMnKPacUSY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266588434"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266588434"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620047556"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.17.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:26 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 6/7] RDMA/irdma: Fix VLAN connection with wildcard address
Date:   Tue,  5 Jul 2022 18:08:14 -0500
Message-Id: <20220705230815.265-7-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220705230815.265-1-shiraz.saleem@intel.com>
References: <20220705230815.265-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

When an application listens on a wildcard address, and there are VLAN and
non-VLAN IP addresses, iWARP connection establishemnt can fail if the listen
node VLAN ID does not match.

Fix this by checking the vlan_id only if not a wildcard listen node.

Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/cm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 638bf4a..e4d837f 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -1477,12 +1477,13 @@ static int irdma_send_fin(struct irdma_cm_node *cm_node)
 	list_for_each_entry (listen_node, &cm_core->listen_list, list) {
 		memcpy(listen_addr, listen_node->loc_addr, sizeof(listen_addr));
 		listen_port = listen_node->loc_port;
+		if (listen_port != dst_port ||
+		    !(listener_state & listen_node->listener_state))
+			continue;
 		/* compare node pair, return node handle if a match */
-		if ((!memcmp(listen_addr, dst_addr, sizeof(listen_addr)) ||
-		     !memcmp(listen_addr, ip_zero, sizeof(listen_addr))) &&
-		    listen_port == dst_port &&
-		    vlan_id == listen_node->vlan_id &&
-		    (listener_state & listen_node->listener_state)) {
+		if (!memcmp(listen_addr, ip_zero, sizeof(listen_addr)) ||
+		    (!memcmp(listen_addr, dst_addr, sizeof(listen_addr)) &&
+		     vlan_id == listen_node->vlan_id)) {
 			refcount_inc(&listen_node->refcnt);
 			spin_unlock_irqrestore(&cm_core->listen_list_lock,
 					       flags);
-- 
1.8.3.1

