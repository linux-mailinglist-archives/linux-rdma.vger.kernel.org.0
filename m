Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0306BB6B4
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjCOO4D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjCOOzs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 10:55:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C4D93E04
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678892089; x=1710428089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tnADPxFQMHiIvqBjqalGRZjmxxBP6LwWe0CVM1b6Bd0=;
  b=EHs1jbf56NnYvc7Aij3uvlpkpU01JOISkrGPI95iSBDu8/wSKty4IL8V
   NpCBJNZnBBZ8rSpU1dxK+XSk93nO3yWvGc0GKJOhi6CRPQyaaZiZu00r+
   xSU9cQo33vdk31BB+I7qWEfZcLxCJ8HDU/umy3btDJm9NkXHN4C2zsQo+
   Z08d8r6BHoSR3O9F9Xn21F382vG/0vjK/DWwV7DljYSKHUfdOjzcM997d
   qTwFAeJ3dXDA7XAsuqVMzEYxXU1/uRvkY9DHYCJfuOOY7mGtYBAqrwHSb
   4M5jcUnhrVy4eDogK4QDjcBcszLY6JG60hY2RKYx0tMk8UWMIIfjCDlPh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321561537"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321561537"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="748457451"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="748457451"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.35.84])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:52:47 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 3/4] RDMA/irdma: Increase iWARP CM default rexmit count
Date:   Wed, 15 Mar 2023 09:52:30 -0500
Message-Id: <20230315145231.931-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230315145231.931-1-shiraz.saleem@intel.com>
References: <20230315145231.931-1-shiraz.saleem@intel.com>
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

From: Mustafa Ismail <mustafa.ismail@intel.com>

When running perftest with large number of connections in iWARP mode, the
passive side could be slow to respond. Increase the rexmit counter default
to allow scaling connections.

Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/cm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/cm.h b/drivers/infiniband/hw/irdma/cm.h
index 19c2849..7feadb3 100644
--- a/drivers/infiniband/hw/irdma/cm.h
+++ b/drivers/infiniband/hw/irdma/cm.h
@@ -41,7 +41,7 @@
 #define TCP_OPTIONS_PADDING	3
 
 #define IRDMA_DEFAULT_RETRYS	64
-#define IRDMA_DEFAULT_RETRANS	8
+#define IRDMA_DEFAULT_RETRANS	32
 #define IRDMA_DEFAULT_TTL		0x40
 #define IRDMA_DEFAULT_RTT_VAR		6
 #define IRDMA_DEFAULT_SS_THRESH		0x3fffffff
-- 
1.8.3.1

