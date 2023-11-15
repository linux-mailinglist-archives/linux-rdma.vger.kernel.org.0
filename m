Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CEB7ECB0F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 20:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjKOTSI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 14:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjKOTSI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 14:18:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ABCA4
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 11:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700075885; x=1731611885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yepSmAwS4vl0z0H/87ExETPFZTsZehHP4EQyzVi9ja8=;
  b=Nc5DLNT6VkV4VtyhdhxrcOlsa2PK/RL021ATmv02dakxj4iSqrlWF1h8
   wUpwhgP0ArJwHsnnSkWd60xPTqxYrnMGENTlTcDZxnPDM34lPNRLCASCN
   dSA1r8ofGePEzrrour4JOcxpkJCP5RlzmYMDR5tTQzllGRqu1iB1BvZog
   iAj8Qsi5D/VC1MeQT5X0q4F0HFN0hDtHywGO+MsQhs0ymEbIBV2tbGxJK
   GQWns69rSOvkWRqOjX2Mf1BSmpz2awvjevfiWPDK7m6KWvNQVkLKfZhKL
   l+bF/eWbZl6HEQIPORnah34shNa6jmOa62TD1lKtusK8pdlxvrnUSQUAF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393793029"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="393793029"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758581290"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="758581290"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.124.160.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:18:04 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 0/3] Fixes for 64K page size support
Date:   Wed, 15 Nov 2023 13:17:49 -0600
Message-Id: <20231115191752.266-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a three patch series.

The first core hunk corrects the core iterator to use __sg_advance to skip
preceding 4k HCA pages.

The second patch corrects an iWarp issue where the SQ must be PAGE_SIZE
aligned.

The third patch corrects an issue with the RDMA driver use of
ib_umem_find_best_pgsz(). QP and CQ allocations pass PAGE_SIZE as the
only bitmap bit. This is incorrect and should use the precise 4k value.

Mike Marciniszyn (3):
  RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz
  RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned
  RDMA/irdma: Fix support for 64k pages

 drivers/infiniband/core/umem.c      | 6 ------
 drivers/infiniband/hw/irdma/verbs.c | 7 ++++++-
 include/rdma/ib_umem.h              | 4 +++-
 include/rdma/ib_verbs.h             | 1 +
 4 files changed, 10 insertions(+), 8 deletions(-)

-- 
1.8.3.1

