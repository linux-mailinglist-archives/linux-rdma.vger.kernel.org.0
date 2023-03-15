Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32F76BB6AD
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 15:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjCOOzU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 10:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjCOOyv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 10:54:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D071C9C997
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678892041; x=1710428041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PmvPxOs1vEJjwbQyN0+AtU9wrPyxjHLwnq01TS7D1uE=;
  b=EKtxWTOhO//qP/aakB8m0W+KFhozheCrnzQ8vZ4PoBOEmnkM55OUaB9w
   mlEpjHbCdGdYu2A5G3iWK0Y1/TwxORDnLDPuDAFgXMlbRKbBVYFLLTDZp
   jfq+8Dc8RVpzAP3jFw0wnDhlhjuUGXmeECLT9TjcurIUWewV5OEnTN4S7
   C6jkcAR3tU37xX34gdtTqrKbz6uR93tjYraMOXR0U2fjIbZ8Z9PZwBpv7
   0s4iDrTlyBGXNTA8hw15oh5V3c7hYBEkuvmgnunOtMOjBPxUL7cK2YMXg
   mWRSSxz0E+O9Cs9DcFwWgX13kXh3zJqMjmTWrBcjioQDZt4jlGfGRuw99
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321561519"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321561519"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="748457439"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="748457439"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.35.84])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:52:45 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 0/4] irdma fixes
Date:   Wed, 15 Mar 2023 09:52:27 -0500
Message-Id: <20230315145231.931-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series adds a few driver fixes for irdma.

Mustafa Ismail (3):
  RDMA/irdma: Do not generate SW completions for NOPs
  RDMA/irdma: Fix memory leak of PBLE objects
  RDMA/irdma: Increase iWARP CM default rexmit count

Tatyana Nikolova (1):
  RDMA/irdma: Add ipv4 check to irdma_find_listener()

 drivers/infiniband/hw/irdma/cm.c    | 16 ++++++++++------
 drivers/infiniband/hw/irdma/cm.h    |  2 +-
 drivers/infiniband/hw/irdma/hw.c    |  3 +++
 drivers/infiniband/hw/irdma/utils.c |  5 ++++-
 4 files changed, 18 insertions(+), 8 deletions(-)

-- 
1.8.3.1

