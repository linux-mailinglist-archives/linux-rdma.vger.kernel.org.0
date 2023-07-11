Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B631174F78C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGKRxQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 13:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGKRxQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 13:53:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F0E75
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689097995; x=1720633995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yMw3o1fbvdRbLB5Qep/jvEISdGnAg4I/vP+zVLPbBiQ=;
  b=DbLIJtKVjv3xAm58hM1VqTMp7lE4HNcHtPAkflmdPwQLPRGnJYDVp0vg
   PWdusYCevtCmGtVIF+HAnRFIJZfw0oCVTJzEd6DJjbKnjB1W+y2MDyFrG
   PZKvB36cI5M5cg2KD3jqlbrtiO3lRCeii46rfKORA3EZA7g+qGr3GHmLi
   K1fq45rT6m92wD9RKl638V5wSGYo9AHWzu9ZiMpVqZTgCfF7nyzRG6Cdd
   3UtLc/MoPlK1nf6M4kgQ3XVmlYIHJxQ77PQsNU1DTd1K2/x0WD+88gvwW
   XXSfzoWRbF/rkBPpTS1pHjVuZIA942FhZpWdH9RBsUfsLGt277QpVbc5C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="395482602"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="395482602"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:53:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724542492"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="724542492"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.33.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:53:05 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 0/3] irdma KCSAN fixes
Date:   Tue, 11 Jul 2023 12:52:50 -0500
Message-Id: <20230711175253.1289-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series address missing read barriers and a couple
of KCSAN reports on the irdma driver.

Shiraz Saleem (3):
  RDMA/irdma: Add missing read barriers
  RDMA/irdma: Fix data race on CQP completion stats
  RDMA/irdma: Fix data race on CQP request done

 drivers/infiniband/hw/irdma/ctrl.c  | 31 +++++++++++++++----------
 drivers/infiniband/hw/irdma/defs.h  | 46 ++++++++++++++++++-------------------
 drivers/infiniband/hw/irdma/hw.c    |  2 +-
 drivers/infiniband/hw/irdma/main.h  |  2 +-
 drivers/infiniband/hw/irdma/puda.c  |  6 +++++
 drivers/infiniband/hw/irdma/type.h  |  2 ++
 drivers/infiniband/hw/irdma/uk.c    |  3 +++
 drivers/infiniband/hw/irdma/utils.c |  8 +++----
 8 files changed, 58 insertions(+), 42 deletions(-)

-- 
1.8.3.1

