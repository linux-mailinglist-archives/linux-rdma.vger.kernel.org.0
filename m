Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E547567A82
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiGEXIZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiGEXIY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:08:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF20CFD5
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062503; x=1688598503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p//nJQXJJMDWAc6QLDRuJYJiRFB3NvUy2BGu78vNnS0=;
  b=PzLkeoGLTFZTg73iyu8hpzh7nV4/PlePnsxih+ZMzHLFaRmpHc6gVAEZ
   laDn20JZQvvZZkOo2juRrITWKXviSACcl+a5hd5igRhzGSVbilsBCPqiL
   5wNln8y/aO65voO4n7M6qS7Qc2rU3Xvcwh0eAOagAganFj07WDiITgXmc
   FjzJY5FtxERkGgzNprZVDsDL98gKKhlSfZljHI6nmp8apyA0oIxpNPsO2
   H4d2jn5D9VQpIMCGiaBwb7okDYqpjbMnyEeViGW+m7GNkafGvYTw0i3hq
   2m42hXTQa23UhwQHgumBV4BjrPG8qPhee4jy9MLCBuM+1/uQm/tSndYmJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266588397"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266588397"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620047507"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.17.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:23 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 0/7] irdma for-next updates 7-5-2022
Date:   Tue,  5 Jul 2022 18:08:08 -0500
Message-Id: <20220705230815.265-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
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

This series adds level2 PBLE support, debug tracing and a few minor
fixes for irdma.

Mustafa Ismail (6):
  RDMA/irdma: Add 2 level PBLE support for FMR
  RDMA/irdma: Add AE source to error log
  RDMA/irdma: Make CQP invalid state error non-critical
  RDMA/irdma: Fix a window for use-after-free
  RDMA/irdma: Fix VLAN connection with wildcard address
  RDMA/irdma: Fix setting of QP context err_rq_idx_valid field

Nayan Kumar (1):
  RDMA/irdma: Make resource distribution algorithm more QP oriented

 drivers/infiniband/hw/irdma/cm.c    | 11 ++++++-----
 drivers/infiniband/hw/irdma/ctrl.c  |  8 +++++---
 drivers/infiniband/hw/irdma/hw.c    | 24 +++++++-----------------
 drivers/infiniband/hw/irdma/main.h  |  2 +-
 drivers/infiniband/hw/irdma/utils.c |  1 +
 drivers/infiniband/hw/irdma/verbs.c | 16 ++++++++++++----
 6 files changed, 32 insertions(+), 30 deletions(-)

-- 
1.8.3.1

