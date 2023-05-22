Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B47F70C2D9
	for <lists+linux-rdma@lfdr.de>; Mon, 22 May 2023 17:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjEVP6x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 May 2023 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjEVP6u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 May 2023 11:58:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58917ED
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684771129; x=1716307129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NBozmYtN2/tLkelZAXcxjXjtyZJIXkZDAC8PCpSTVjI=;
  b=LUr7BHOC8Wiq1zzESGfWkt0ss3TwE3XUHfshueF38VJHibpMVqk+BkIM
   en1kLwyEGycxruB791lWbrTPZ+2+LboQKzqq2zlUpNOUW972uxO6dYFCE
   0AQaIWhLwf9IHaidrLxGyF5DhziUOq73HSG3FDvC9QYixL+fvLzJPtdyJ
   ezDXHIvd0WsSBHvYD2nJyGoawzEIQOFF5KJJL2sCdImpbjHZytbOS+Eju
   zRUky4whWFCfwD8jJMZSmBELRx1i8DCZBzQEZoyRB4A5wVIWPkV8Knxwr
   KS/G/1a9BylgzvbdQh00HMBOxk0qF06q7Fc8ThLMRNz+iovMxJtSrL5Qm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="337546887"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="337546887"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="734312890"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="734312890"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.172.160])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:58:48 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 0/2] RDMA/irdma: Bug fixes
Date:   Mon, 22 May 2023 10:56:51 -0500
Message-Id: <20230522155654.1309-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
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

This series adds a couple of minor driver fixes for irdma.

Mustafa Ismail (2):
  RDMA/irdma: Prevent QP use after free
  RDMA/irdma: Fix Local Invalidate fencing

 drivers/infiniband/hw/irdma/verbs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
1.8.3.1

