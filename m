Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EBE5AF807
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 00:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIFWdN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 18:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiIFWdL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 18:33:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D9E8B2D2
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662503590; x=1694039590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e/d/YSWSQaLK85irF5TXWWeW2ABM85xnpz7Emrhaw0U=;
  b=e9QPzPVbgazdE4QSLtjUZNngVTbIH6UCmNRIzBepYYvImxOTnn1cHQkW
   1UuUd8iV4EYkjNoR94G9P/tGd4b8MFP6Ad/rkV23qIceqHnhW9HfwxiBz
   Y1d3QB3Lol7/nUeqwQsidUr8/1LeJIwlfwYVHyUNTSWJJDmwOZI9f063L
   fZTeT8/51EMLCuTf97UDXV9Forv040qjZGrquNc/R7z96HIL2XVG4huQG
   LQp1ep8aGXkkS1zoo84az2m3TqAnFAaO1zNb7WP5gRoAehferXZPLeGnF
   +SYyTht4XeAXUkx8oIppqcJPrZ9zT4nDCut/yDlGEfjVJ3UiYdVXTeFjw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296724584"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296724584"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:33:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675898255"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:33:09 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu-Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 5/5] RDMA/irdma: Report RNR NAK generation in device caps
Date:   Tue,  6 Sep 2022 17:32:44 -0500
Message-Id: <20220906223244.1119-6-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220906223244.1119-1-shiraz.saleem@intel.com>
References: <20220906223244.1119-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu-Devale <sindhu.devale@intel.com>

Report RNR NAK generation when device capabilities are queried

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Sindhu-Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 892467c..9b207f5 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -46,8 +46,11 @@ static int irdma_query_device(struct ib_device *ibdev,
 	props->max_sge_rd = hw_attrs->uk_attrs.max_hw_read_sges;
 	props->max_qp_rd_atom = hw_attrs->max_hw_ird;
 	props->max_qp_init_rd_atom = hw_attrs->max_hw_ord;
-	if (rdma_protocol_roce(ibdev, 1))
+	if (rdma_protocol_roce(ibdev, 1)) {
+		props->device_cap_flags |= IB_DEVICE_RC_RNR_NAK_GEN;
 		props->max_pkeys = IRDMA_PKEY_TBL_SZ;
+	}
+
 	props->max_ah = rf->max_ah;
 	props->max_mcast_grp = rf->max_mcg;
 	props->max_mcast_qp_attach = IRDMA_MAX_MGS_PER_CTX;
-- 
1.8.3.1

