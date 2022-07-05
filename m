Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52E567A86
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGEXIa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiGEXI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:08:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3FD85
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062506; x=1688598506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a+A8MHDt5TTVXRjklmppYCO9Tycs5HYBURRPwkyuyA8=;
  b=CPm/OEEl8mvQgW4SjkO7P+ZzA3QgzTU8R2+5xABrTzfVqkm7MotnbQ4Z
   s0HgkvJeyYVQsCbXz+JDY9Wg+p9a9df97NFE1kkY8dvPmKh/wZ/yZKz3K
   +/Hbbx8He/QFjyejKRFBjLpuH6rfXqQY3lZqN+VhtqwvHyUI5V9/CV7c8
   VZpKtdSaI2nlAuTTe+W2AxYN908OwPg/OMVey84HtGxctRmElOgeGR/3K
   JIQbAgM4hPfECycCjFlgq/ToSCWoDyNTIprreQp7vzIMXNBIOBIdmUaNA
   z4rcV/QKcyXJUvwnB3FG8N4LyuhrYvGsnX4uV/EUWnxayUO+ufokO4uFW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266588423"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266588423"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620047547"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.17.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:26 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 5/7] RDMA/irdma: Fix a window for use-after-free
Date:   Tue,  5 Jul 2022 18:08:13 -0500
Message-Id: <20220705230815.265-6-shiraz.saleem@intel.com>
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

During a destroy CQ an interrupt may cause processing of a CQE after CQ
resources are freed by irdma_cq_free_rsrc(). Fix this by moving the call
to irdma_cq_free_rsrc() after the irdma_sc_cleanup_ceqes(), which is
called under the cq_lock.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Bartosz Sobczak <bartosz.sobczak@intel.com>
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 0f5856b..d78b11a 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1776,11 +1776,11 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	spin_unlock_irqrestore(&iwcq->lock, flags);
 
 	irdma_cq_wq_destroy(iwdev->rf, cq);
-	irdma_cq_free_rsrc(iwdev->rf, iwcq);
 
 	spin_lock_irqsave(&iwceq->ce_lock, flags);
 	irdma_sc_cleanup_ceqes(cq, ceq);
 	spin_unlock_irqrestore(&iwceq->ce_lock, flags);
+	irdma_cq_free_rsrc(iwdev->rf, iwcq);
 
 	return 0;
 }
-- 
1.8.3.1

