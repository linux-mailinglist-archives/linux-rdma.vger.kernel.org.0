Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8C3616B9
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Apr 2021 02:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhDPAVr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Apr 2021 20:21:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:65495 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234716AbhDPAVr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Apr 2021 20:21:47 -0400
IronPort-SDR: JugC+zQadhPOvQk9RMaUD+d4rMsc1L7KcHyPvCDUqIvSBK4+lP2obO+4XJIioURAwWJbrKPE23
 Pd8SDQyoCV3Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="215484325"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="215484325"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 17:21:23 -0700
IronPort-SDR: ikC6uwD/4DEE5HBvJLPPoctX62x6iXHPudQ6EhBrkTulkG50nVTL8BlAB1faHEN+pMd/t4eOHA
 YG80NCor4rmQ==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461801402"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.209.186.205])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 17:21:22 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH] i40iw: Fix error unwinding when i40iw_hmc_sd_one fails
Date:   Thu, 15 Apr 2021 19:21:04 -0500
Message-Id: <20210416002104.323-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu Devale <sindhu.devale@intel.com>

When i40iw_hmc_sd_one fails, chunk is freed without the
deletion of chunk entry in the PBLE info list.

Fix it by adding the chunk entry to the PBLE info list only
after successful addition of SD in i40iw_hmc_sd_one.

This fixes a static checker warning reported in [1]

[1] https://lore.kernel.org/linux-rdma/YHV4CFXzqTm23AOZ@mwanda/

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw_pble.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_pble.c b/drivers/infiniband/hw/i40iw/i40iw_pble.c
index 53e5cd1..146a414 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_pble.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_pble.c
@@ -393,12 +393,9 @@ static enum i40iw_status_code add_pble_pool(struct i40iw_sc_dev *dev,
 	i40iw_debug(dev, I40IW_DEBUG_PBLE, "next_fpm_addr = %llx chunk_size[%u] = 0x%x\n",
 		    pble_rsrc->next_fpm_addr, chunk->size, chunk->size);
 	pble_rsrc->unallocated_pble -= (chunk->size >> 3);
-	list_add(&chunk->list, &pble_rsrc->pinfo.clist);
 	sd_reg_val = (sd_entry_type == I40IW_SD_TYPE_PAGED) ?
 			sd_entry->u.pd_table.pd_page_addr.pa : sd_entry->u.bp.addr.pa;
-	if (sd_entry->valid)
-		return 0;
-	if (dev->is_pf) {
+	if (dev->is_pf && !sd_entry->valid) {
 		ret_code = i40iw_hmc_sd_one(dev, hmc_info->hmc_fn_id,
 					    sd_reg_val, idx->sd_idx,
 					    sd_entry->entry_type, true);
@@ -409,6 +406,7 @@ static enum i40iw_status_code add_pble_pool(struct i40iw_sc_dev *dev,
 	}
 
 	sd_entry->valid = true;
+	list_add(&chunk->list, &pble_rsrc->pinfo.clist);
 	return 0;
  error:
 	kfree(chunk);
-- 
1.8.3.1

