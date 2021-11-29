Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC8C462734
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 23:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbhK2XBU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 18:01:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:35313 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236077AbhK2W7s (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 17:59:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="233593347"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="233593347"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:55:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511902799"
Received: from sindhude-mobl.amr.corp.intel.com ([10.255.35.224])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:55:18 -0800
From:   Sindhu Devale <sindhu.devale@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, tatyana.e.nikolova@intel.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com,
        "Sindhu, Devale" <sindhu.devale@intel.com>
Subject: [PATCH rdma-core 2/2] providers/irdma: Validate input before memory window bind
Date:   Mon, 29 Nov 2021 16:54:46 -0600
Message-Id: <20211129225446.691-3-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211129225446.691-1-sindhu.devale@intel.com>
References: <20211129225446.691-1-sindhu.devale@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: "Sindhu, Devale" <sindhu.devale@intel.com>

Check for a non null MR, address and length
before allowing bind operation.

Also, add check to make sure the MR and MW are in
same PD before posting a bind MW op.

Fixes: 14a0fc824f16 ("rdma-core/irdma: Implement device supported verb APIs")
Signed-off-by: Sindhu, Devale <sindhu.devale@intel.com>
---
 providers/irdma/uverbs.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/providers/irdma/uverbs.c b/providers/irdma/uverbs.c
index c8222d14..dc7cf41a 100644
--- a/providers/irdma/uverbs.c
+++ b/providers/irdma/uverbs.c
@@ -206,19 +206,30 @@ int irdma_ubind_mw(struct ibv_qp *qp, struct ibv_mw *mw,
 		   struct ibv_mw_bind *mw_bind)
 {
 	struct ibv_mw_bind_info	*bind_info = &mw_bind->bind_info;
-	struct verbs_mr *vmr = verbs_get_mr(bind_info->mr);
-	struct irdma_umr *umr = container_of(vmr, struct irdma_umr, vmr);
+	struct verbs_mr *vmr;
+	struct irdma_umr *umr;
 
 	struct ibv_send_wr wr = {};
 	struct ibv_send_wr *bad_wr;
 	int err;
 
-	if (vmr->mr_type != IBV_MR_TYPE_MR || mw->type != IBV_MW_TYPE_1)
-		return ENOTSUP;
-
-	if (umr->acc_flags & IBV_ACCESS_ZERO_BASED)
+	if (!bind_info->mr && (bind_info->addr || bind_info->length))
 		return EINVAL;
 
+	if (bind_info->mr) {
+		vmr = verbs_get_mr(bind_info->mr);
+		umr = container_of(vmr, struct irdma_umr, vmr);
+
+		if (vmr->mr_type != IBV_MR_TYPE_MR || mw->type != IBV_MW_TYPE_1)
+			return ENOTSUP;
+
+		if (umr->acc_flags & IBV_ACCESS_ZERO_BASED)
+			return EINVAL;
+
+		if (mw->pd != bind_info->mr->pd)
+			return EPERM;
+	}
+
 	wr.opcode = IBV_WR_BIND_MW;
 	wr.bind_mw.bind_info = mw_bind->bind_info;
 	wr.bind_mw.mw = mw;
-- 
2.32.0

