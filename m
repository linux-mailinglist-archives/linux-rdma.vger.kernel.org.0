Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EDE50E7EE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbiDYSUT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 14:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244279AbiDYSUS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 14:20:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E113B285
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650910634; x=1682446634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5PEWEO1uUWLruV/rJb8RaPktXaXlbFtbPqoU6HxZjLM=;
  b=fAB57K23DOOH5d550fgP5XrGjHUv7GzMy8v/4Q2ZT3DJeO7owTS2aCHr
   gPUIYjdaHF9eTJEnZcrrStyiw3GHlX6gPDYDh7ETfyCWZehIZULVPVbv3
   k7gPk3JRE4YLayNEXGYOQlK1qHPdrFc0NM25GMbdHPYtT316UzmvbyaZz
   lci4D2qYh9TvNs2q4gkIygBX+Q+8NiREeEYrGT+mekyz0MqbbzJJa+eAU
   gLwLuaeD4vLhR8xmNWrgnELErrRMfqCrt5F82smR/K4qxsQ7R7ZCfQPGf
   hDt0Zd6WgpTDQxZvRTPoLKGybycSGC4PXaQXWKtkNblzbOxBN4hXGv87R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252697317"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="252697317"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:17:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="537708083"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.50.71])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:17:13 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 0/3] irdma fixes
Date:   Mon, 25 Apr 2022 13:17:00 -0500
Message-Id: <20220425181703.1634-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains a few irdma bug fixes for 5.18 cycle.

Mustafa Ismail (1):
  RDMA/irdma: Fix possible crash due to NULL netdev in notifier

Shiraz Saleem (1):
  RDMA/irdma: Reduce iWARP QP destroy time

Tatyana Nikolova (1):
  RDMA/irdma: Flush iWARP QP if modified to ERR from RTR state

 drivers/infiniband/hw/irdma/cm.c    | 26 +++++++++-----------------
 drivers/infiniband/hw/irdma/utils.c | 21 +++++++++------------
 drivers/infiniband/hw/irdma/verbs.c |  4 ++--
 3 files changed, 20 insertions(+), 31 deletions(-)

-- 
1.8.3.1

