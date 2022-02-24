Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF64C21C3
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 03:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiBXCZR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 21:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiBXCZQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 21:25:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788D322EDC3
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 18:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645669487; x=1677205487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z/ADNYHu0/bLOBV/UryH4NXyK6lHu72pUIOw6vIlPZM=;
  b=CloOh8HnG8v6A+oPV9RIPWwuCV10/8LBUDZCZoZwGm5yg9I3rzpN6ZAJ
   2hxdl8sUCIoJo67n0mcLykHx9qIC5Z35mOCL/G7VAKEcaLY8vWLFeHyAU
   /n9SLwu/zyIL+XnL11RTtTkUyTFScFwz8A2MZvwOHsKzYWQg7Dwl7d3y7
   6PjHUC6Rps8bzfkXrSGPj/rQKeojq/xWRFsGJv8nFseMRYfJmVwsx32zj
   lfoXf/1SmweEOac7PfP2IgjsWJVwAt0TPqwT3qRRtbKX8zO3w0XcSLJ49
   LApJG/VbQbLCHGn9My911ngmXmZ1BAZ/qTFXsxUg5JRer5dCDHwNd+cnJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235627961"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="235627961"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:58:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="548513116"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.38.207])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:58:50 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc 0/3] irdma driver updates
Date:   Wed, 23 Feb 2022 18:58:39 -0600
Message-Id: <20220224005842.1707-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains a set of irdma bug fixes for 5.17 cycle.

Mustafa Ismail (3):
  RDMA/irdma: Fix netdev notifications for vlan's
  RDMA/irdma: Fix Passthrough mode in VM
  RDMA/irdma: Remove incorrect masking of PD

 drivers/infiniband/hw/irdma/hw.c       |  2 +-
 drivers/infiniband/hw/irdma/i40iw_if.c |  1 +
 drivers/infiniband/hw/irdma/main.c     |  1 +
 drivers/infiniband/hw/irdma/main.h     |  1 +
 drivers/infiniband/hw/irdma/utils.c    | 10 ++++++++--
 drivers/infiniband/hw/irdma/verbs.c    |  4 ++--
 6 files changed, 14 insertions(+), 5 deletions(-)

-- 
1.8.3.1

