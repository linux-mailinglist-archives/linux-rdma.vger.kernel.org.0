Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A2C2CC83A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 21:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgLBUor (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Dec 2020 15:44:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:58987 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730287AbgLBUoq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Dec 2020 15:44:46 -0500
IronPort-SDR: DoOKPqPLzllfYUQeduDjXMMAdkQY9JZZa+On0TwPED4P+M2jnT9bPZGXYFkjFXbksVMOWkGbar
 WPNfHowCJ8kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="169579868"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="169579868"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 12:43:26 -0800
IronPort-SDR: 7XWW3y9BEqiharMEbxAeokIAShlgvisj2RBcFyOU6xRyr+Pn7ThlM6mTfH9Qn5cFpo+qf/dp3G
 kUHyy/Tta9BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="365457433"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga004.fm.intel.com with ESMTP; 02 Dec 2020 12:43:26 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-core v4 6/6] tests: Bug fix for get_access_flags()
Date:   Wed,  2 Dec 2020 12:57:21 -0800
Message-Id: <1606942641-47234-7-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606942641-47234-1-git-send-email-jianxin.xiong@intel.com>
References: <1606942641-47234-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The filter definition is wrong and causes get_access_flags() always
returning empty list. As the result the MR tests using this function
are effectively skipped (but report success).

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
---
 tests/utils.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/utils.py b/tests/utils.py
index d3d5c16..8bd0c16 100644
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -56,8 +56,8 @@ def filter_illegal_access_flags(element):
     :param element: A list of access flags to check
     :return: True if this list is legal, else False
     """
-    if e.IBV_ACCESS_REMOTE_ATOMIC in element or e.IBV_ACCESS_REMOTE_WRITE:
-        if e.IBV_ACCESS_LOCAL_WRITE:
+    if e.IBV_ACCESS_REMOTE_ATOMIC in element or e.IBV_ACCESS_REMOTE_WRITE in element:
+        if not e.IBV_ACCESS_LOCAL_WRITE in element:
             return False
     return True
 
-- 
1.8.3.1

