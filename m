Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC113BF14A
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 23:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhGGVTH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 17:19:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:41730 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhGGVTH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Jul 2021 17:19:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="189068378"
X-IronPort-AV: E=Sophos;i="5.84,221,1620716400"; 
   d="scan'208";a="189068378"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 14:16:26 -0700
X-IronPort-AV: E=Sophos;i="5.84,221,1620716400"; 
   d="scan'208";a="648068082"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.209.149.124])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 14:16:25 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH rdma-next] irdma: Fix unused variable total_size warning
Date:   Wed,  7 Jul 2021 14:14:55 -0700
Message-Id: <20210707211455.2076-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the following unused variable warning:
>> drivers/infiniband/hw/irdma/uk.c:934:6: warning: variable 'total_size'
set but not used [-Wunused-but-set-variable]
           u32 total_size = 0, wqe_idx, i, byte_off;

Link: https://lkml.org/lkml/2021/7/1/726
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/uk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index a6d52c20091c..5fb92de1f015 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -931,7 +931,7 @@ enum irdma_status_code irdma_uk_mw_bind(struct irdma_qp_uk *qp,
 enum irdma_status_code irdma_uk_post_receive(struct irdma_qp_uk *qp,
 					     struct irdma_post_rq_info *info)
 {
-	u32 total_size = 0, wqe_idx, i, byte_off;
+	u32 wqe_idx, i, byte_off;
 	u32 addl_frag_cnt;
 	__le64 *wqe;
 	u64 hdr;
@@ -939,9 +939,6 @@ enum irdma_status_code irdma_uk_post_receive(struct irdma_qp_uk *qp,
 	if (qp->max_rq_frag_cnt < info->num_sges)
 		return IRDMA_ERR_INVALID_FRAG_COUNT;
 
-	for (i = 0; i < info->num_sges; i++)
-		total_size += info->sg_list[i].len;
-
 	wqe = irdma_qp_get_next_recv_wqe(qp, &wqe_idx);
 	if (!wqe)
 		return IRDMA_ERR_QP_TOOMANY_WRS_POSTED;
-- 
2.27.0

