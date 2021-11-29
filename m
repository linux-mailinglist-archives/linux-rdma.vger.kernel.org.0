Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054C24626FA
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 23:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhK2W74 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 17:59:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:35265 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236009AbhK2W7O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 17:59:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="233593336"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="233593336"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:55:15 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511902785"
Received: from sindhude-mobl.amr.corp.intel.com ([10.255.35.224])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:55:14 -0800
From:   Sindhu Devale <sindhu.devale@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, tatyana.e.nikolova@intel.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com,
        "Sindhu, Devale" <sindhu.devale@intel.com>
Subject: [PATCH rdma-core 1/2] providers/irdma: Report correct WC errors
Date:   Mon, 29 Nov 2021 16:54:45 -0600
Message-Id: <20211129225446.691-2-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211129225446.691-1-sindhu.devale@intel.com>
References: <20211129225446.691-1-sindhu.devale@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: "Sindhu, Devale" <sindhu.devale@intel.com>

Return specific WC errors for certain type of error
events as opposed to a generic IBV_WC_FATAL_ERR.

In particular,

Return IBV_WC_MW_BIND_ERR for memory window
related asynchronous events.

Return IBV_WC_REM_INV_REQ_ERR for errors which is
detected when the remote side detects an operation
outside of the established use for the transport.

Return IBV_WC_RETRY_EXC_ERR when transport retry
counter is exceeded.

Fixes: 14a0fc824f16 ("rdma-core/irdma: Implement device supported verb APIs")
Signed-off-by: Sindhu, Devale <sindhu.devale@intel.com>
---
 providers/irdma/uverbs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/providers/irdma/uverbs.c b/providers/irdma/uverbs.c
index edd8821f..c8222d14 100644
--- a/providers/irdma/uverbs.c
+++ b/providers/irdma/uverbs.c
@@ -556,6 +556,12 @@ static enum ibv_wc_status irdma_flush_err_to_ib_wc_status(enum irdma_flush_opcod
 		return IBV_WC_LOC_LEN_ERR;
 	case FLUSH_GENERAL_ERR:
 		return IBV_WC_WR_FLUSH_ERR;
+	case FLUSH_MW_BIND_ERR:
+		return IBV_WC_MW_BIND_ERR;
+	case FLUSH_REM_INV_REQ_ERR:
+		return IBV_WC_REM_INV_REQ_ERR;
+	case FLUSH_RETRY_EXC_ERR:
+		return IBV_WC_RETRY_EXC_ERR;
 	case FLUSH_FATAL_ERR:
 	default:
 		return IBV_WC_FATAL_ERR;
-- 
2.32.0

