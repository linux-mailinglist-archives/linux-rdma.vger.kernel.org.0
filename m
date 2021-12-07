Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7B46C055
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 17:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhLGQLq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 11:11:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:21677 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238478AbhLGQLq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 11:11:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="323864029"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="323864029"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 08:07:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="502648934"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.26.33])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 08:07:36 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dan.carpenter@oracle.com,
        christophe.jaillet@wanadoo.fr,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc] RDMA/irdma: Fix a user-after-free in add_pble_prm
Date:   Tue,  7 Dec 2021 09:21:36 -0600
Message-Id: <20211207152135.2192-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When irdma_hmc_sd_one fails, 'chunk' is freed while its still on the PBLE
info list.

Add the chunk entry to the PBLE info list only after successful setting of
the SD in irdma_hmc_sd_one.

Fixes: e8c4dbc2fcac ("RDMA/irdma: Add PBLE resource manager")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/pble.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index aeeb1c3..da032b9 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -283,7 +283,6 @@ static enum irdma_sd_entry_type irdma_get_type(struct irdma_sc_dev *dev,
 		  "PBLE: next_fpm_addr = %llx chunk_size[%llu] = 0x%llx\n",
 		  pble_rsrc->next_fpm_addr, chunk->size, chunk->size);
 	pble_rsrc->unallocated_pble -= (u32)(chunk->size >> 3);
-	list_add(&chunk->list, &pble_rsrc->pinfo.clist);
 	sd_reg_val = (sd_entry_type == IRDMA_SD_TYPE_PAGED) ?
 			     sd_entry->u.pd_table.pd_page_addr.pa :
 			     sd_entry->u.bp.addr.pa;
@@ -295,6 +294,7 @@ static enum irdma_sd_entry_type irdma_get_type(struct irdma_sc_dev *dev,
 			goto error;
 	}
 
+	list_add(&chunk->list, &pble_rsrc->pinfo.clist);
 	sd_entry->valid = true;
 	return 0;
 
-- 
1.8.3.1

