Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404C2688626
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 19:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBBSMd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 13:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBBSMc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 13:12:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DB36DB24
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 10:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675361551; x=1706897551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=avOGKTAZFPdlrFPfSEf/yFHiwgaOh5IwIB/x5IRWKQA=;
  b=k6IhI7+BpWrFMr7kCg90rFTwisdk+6wt6kx9nF3zSWGG1EOIb1/C9C6g
   jNwJuQCuGHO98/xsqQxedeckNfLCUR6Zjg0euc1ssfrTQCYoFSMZIrnOM
   f9NmIhMdMn2v87BlfzDZtm1VH+j83wHMmbR+jLsMK+ey4mRVnULkOgvo4
   gvMnInKSz4a48qN/XTDj/ilv6v9Iob9wsw/EDIBTHv14GMcFz95hh4HPm
   bYaWXnD+4CCodJXiguut1cEq70HvW4zotLMBt/XYkNMn0xxVzrhqUrLlL
   b0VVZ7HJFm6v1Cg3HFX28qKGm4tkbqiSck7KU9LK7Cg/r5v7I0LuOursA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393113566"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="393113566"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 10:12:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="994198650"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="994198650"
Received: from sindhude-mobl.amr.corp.intel.com ([10.255.34.164])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 10:12:29 -0800
From:   Sindhu Devale <sindhu.devale@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com, Sindhu Devale <sindhu.devale@intel.com>
Subject: [PATCH for-rc] RDMA/irdma: Cap MSIX used to online CPUs + 1
Date:   Thu,  2 Feb 2023 12:12:11 -0600
Message-Id: <20230202181211.1123-1-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

The irdma driver can use a maximum number of msix
vectors equal to num_online_cpus() + 1 and the Kernel
warning stack below is shown if that number is exceeded.
The kernel throws a warning as the driver tries to update
the affinity hint with a CPU mask greater than the max CPU IDs.
Fix this by capping the MSIX vectors to num_online_cpus() + 1.

kernel: WARNING: CPU: 7 PID: 23655 at include/linux/cpumask.h:106 irdma_cfg_ceq_vector+0x34c/0x3f0 [irdma]
kernel: RIP: 0010:irdma_cfg_ceq_vector+0x34c/0x3f0 [irdma]
kernel: Call Trace:
kernel: irdma_rt_init_hw+0xa62/0x1290 [irdma]

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index ab246447520b..2e1e2bad0401 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -483,6 +483,8 @@ static int irdma_save_msix_info(struct irdma_pci_f *rf)
 	iw_qvlist->num_vectors = rf->msix_count;
 	if (rf->msix_count <= num_online_cpus())
 		rf->msix_shared = true;
+	else if (rf->msix_count > num_online_cpus() + 1)
+		rf->msix_count = num_online_cpus() + 1;
 
 	pmsix = rf->msix_entries;
 	for (i = 0, ceq_idx = 0; i < rf->msix_count; i++, iw_qvinfo++) {
-- 
2.27.0

