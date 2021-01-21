Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F022FDEA1
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 02:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390150AbhAUBAK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 20:00:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:2132 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730863AbhAUAA2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 19:00:28 -0500
IronPort-SDR: oFyVS5GAIEJYuDxJ6A8t1L3q8DcjlxZwEaI/+hdMIAQGxjffMyZG8oZAYja4ScEq07tHkURmRD
 Dzu1Mor5U89Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="166291174"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="166291174"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 15:59:43 -0800
IronPort-SDR: qCuVemblU2j4shhSZINjtS2Gkf9dnhjFWuzhHa2GM0rx1YT7a4SlmuwFt23h/kdQE4fDajUf42
 dY0mcUf6vfow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="570551154"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2021 15:59:41 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Edward Srouji <edwards@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-core v6 6/6] tests: Bug fix for get_access_flags()
Date:   Wed, 20 Jan 2021 16:14:38 -0800
Message-Id: <1611188078-119233-7-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611188078-119233-1-git-send-email-jianxin.xiong@intel.com>
References: <1611188078-119233-1-git-send-email-jianxin.xiong@intel.com>
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
index 8546329..c41cb3b 100644
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -58,8 +58,8 @@ def filter_illegal_access_flags(element):
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

