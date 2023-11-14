Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3177EB54A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Nov 2023 18:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjKNREQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Nov 2023 12:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNREP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Nov 2023 12:04:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0389DB8
        for <linux-rdma@vger.kernel.org>; Tue, 14 Nov 2023 09:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699981453; x=1731517453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u16K1nCoIk3DmFBcGOcSDQugUPKp+M919ltErDGFWPg=;
  b=AI3JsJF6I3KZjj9EYipiiyCLhchppoxnI9UqBiQm/K94avJA29B8yV/c
   Aicqys3HJQTTtzwC2qWuEXGOp1wrcws9/ihUl5XXCXREH8rdT5EHtKQZL
   Qxy3W2WPfyu260usD9sjo694RDDynpaSUITvQgRTTQ2Ckb5d0bH91eoAo
   jUfU8eu2xcuXROpCQ+nzyD7eOQW6xzg9EYUaKhFPkH/pKCotf7zw9TzX0
   XG8RkO+k4pMpqIXBrNqAPm0aEqv3cIfaHVDE+VxHLhGttvv8eSSPGK9jH
   VTKfuBr2Bve5XUWOVW9jWCxCB8ankkv9cWvLYhUxxIceqwyVuDdFrvHwm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394614901"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="394614901"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 09:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908450226"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="908450226"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.179])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 09:03:15 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 0/2] irdma SQD fixes
Date:   Tue, 14 Nov 2023 11:02:44 -0600
Message-Id: <20231114170246.238-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series addresses a couple of minor fixes related to SQD flow
in irdma.

Mustafa Ismail (2):
  RDMA/irdma: Do not modify to SQD on error
  RDMA/irdma: Add wait for suspend on SQD

 drivers/infiniband/hw/irdma/hw.c    |  6 +++++-
 drivers/infiniband/hw/irdma/main.c  |  2 +-
 drivers/infiniband/hw/irdma/main.h  |  2 +-
 drivers/infiniband/hw/irdma/verbs.c | 28 +++++++++++++++++++++-------
 drivers/infiniband/hw/irdma/verbs.h |  1 +
 5 files changed, 29 insertions(+), 10 deletions(-)

-- 
1.8.3.1

