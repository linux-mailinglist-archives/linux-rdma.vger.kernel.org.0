Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7057A5B0CF0
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 21:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIGTNj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 15:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIGTNh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 15:13:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB397B15
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662578016; x=1694114016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GAsbVVZvBPgX53J8g02CbVMGCz15On+5+FFqNpmlxbU=;
  b=a15hpH+MFqSYyvl8UDCGyL9Yk1V684CK8Mzqg0aw3RUpqH8lu9AUjhm3
   0hPodG1HEcwuy28qFa5gCe6+gtXORmf8vJFXRMJvworWhGfly1symM9AO
   HlzwXALnmfZ2Eo7wC0YueMTVTuZv+djVJThCyP4gq1mJbNQyoRvpNS2p8
   vjjjAki+jnyRvC54Briy/7yLiJcVm0rUs+3Ge2O84/WPFUG89EzOPHW+W
   mcpS9Z4cUZGMHiU/f05vbdxJbmQcpA+hTYICj4f9CosFuCHJczpqTjs6j
   icAFX/lyOfQyTqX/u7jpt6vRiUoU7FdSC+VN/BrWJkkoW89iPFTeeoK0x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295709240"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="295709240"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:13:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676339035"
Received: from sveedu-mobl.amr.corp.intel.com (HELO ssaleem-mobl1.amr.corp.intel.com) ([10.255.37.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:13:36 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 0/2] irdma for-next updates 9-7-2022
Date:   Wed,  7 Sep 2022 14:13:22 -0500
Message-Id: <20220907191324.1173-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
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

This series adds udata inlen/outlen validation for the verb API's
and fixes up completion error code reporting to ulp's.

Shiraz Saleem (1):
  RDMA/irdma: Validate udata inlen and outlen

Sindhu-Devale (1):
  RDMA/irdma: Align AE id codes to correct flush code and event

 drivers/infiniband/hw/irdma/defs.h  |  1 +
 drivers/infiniband/hw/irdma/hw.c    | 51 ++++++++++++++++-----------
 drivers/infiniband/hw/irdma/type.h  |  1 +
 drivers/infiniband/hw/irdma/user.h  |  1 +
 drivers/infiniband/hw/irdma/utils.c |  3 ++
 drivers/infiniband/hw/irdma/verbs.c | 69 +++++++++++++++++++++++++++++++++----
 6 files changed, 98 insertions(+), 28 deletions(-)

-- 
1.8.3.1

