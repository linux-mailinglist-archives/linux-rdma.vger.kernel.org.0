Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC4761DBC
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 17:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjGYPyx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 11:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjGYPyw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 11:54:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2062125
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300488; x=1721836488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2d3AOGmOAdGlU+Sk1eNS2msFyXyLmTmIyKiCo892pNI=;
  b=RGPWAiPPgScyenZBDAoFfT+ZY8DttsUueTZ4rJORRzDuiQK62zwg4u9P
   AD+lVcOoAGaLFrS3WPXpsVDfnTaaN7cEr8GnDXC5BJdXRpFxFE0dqYN8q
   C5elf3JlodgdN9svKB/zy++HgBbanMq/bYVxFFQ9R/eMM2pqEcgb2Ud/n
   vMQSeDkgQD1PIDRBJm2TPykmrslWLEC8RljAaWq2qf0KRHxg9F4orqqJb
   E7yq5KH4oIrZz0kxogmELHjAlzPKI7ET2EEQeDi5pE00qktaBnY/W9NoF
   298qzRx1I1+N/0JAHqddY6Vv1E2Ba1fJqc1AfZPjWBb9Qd7VuZ3sUM7mD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367795434"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367795434"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="755808769"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="755808769"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:54:46 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 2/2] RDMA/irdma: Report correct WC error
Date:   Tue, 25 Jul 2023 10:54:38 -0500
Message-Id: <20230725155439.1057-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230725155439.1057-1-shiraz.saleem@intel.com>
References: <20230725155439.1057-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu Devale <sindhu.devale@intel.com>

Report the correct WC error if a MW bind is performed
on an already valid/bound window.

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 1cfc03da89e7..457368e324e1 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -191,6 +191,7 @@ static void irdma_set_flush_fields(struct irdma_sc_qp *qp,
 	case IRDMA_AE_AMP_MWBIND_INVALID_RIGHTS:
 	case IRDMA_AE_AMP_MWBIND_BIND_DISABLED:
 	case IRDMA_AE_AMP_MWBIND_INVALID_BOUNDS:
+	case IRDMA_AE_AMP_MWBIND_VALID_STAG:
 		qp->flush_code = FLUSH_MW_BIND_ERR;
 		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
 		break;
-- 
1.8.3.1

