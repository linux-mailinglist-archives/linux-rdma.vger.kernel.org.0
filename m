Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25102C32AC
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbgKXVY6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 16:24:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:3768 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730408AbgKXVY6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 16:24:58 -0500
IronPort-SDR: k5QHRgkoio8xllBaJJ3u9Tbx+cQC9aMi0iiBihj/G9FdsabgOUXZCe6STmIgBX6w4pGuT3x0gX
 0Fhh1vIPohWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="172117609"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="172117609"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 13:24:56 -0800
IronPort-SDR: 1eod7JVgHIf1fqpcsM5IjySiBg5w+qVnb4tydiOUihbCWpNG71rhTuoRkyXoxt5XkqYRXaAewV
 c+parO6st4+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="332701590"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by orsmga006.jf.intel.com with ESMTP; 24 Nov 2020 13:24:56 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH rdma-core v2 6/6] tests: Bug fix for get_access_flags()
Date:   Tue, 24 Nov 2020 13:38:54 -0800
Message-Id: <1606253934-67181-7-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606253934-67181-1-git-send-email-jianxin.xiong@intel.com>
References: <1606253934-67181-1-git-send-email-jianxin.xiong@intel.com>
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
index 0ad7110..9ff2603 100644
--- a/tests/utils.py
+++ b/tests/utils.py
@@ -55,8 +55,8 @@ def filter_illegal_access_flags(element):
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

