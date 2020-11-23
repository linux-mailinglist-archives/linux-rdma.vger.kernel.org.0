Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844882C1233
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 18:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbgKWRjL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 12:39:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:51717 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388467AbgKWRjK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 12:39:10 -0500
IronPort-SDR: atO4aDPdWSB6t++e+AV8D6ksibLAOuqebKoiVpcUtB7ZZ+/xbuOlapS0CUdeiBQ0gSsuDhKC4P
 6F24Z0MkvCqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="168301230"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="168301230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:39:10 -0800
IronPort-SDR: oH3phGhklkDmg9YwGLBlv5uAttjT2t2C5x7KxrhvQ1P+urIfs9DpBb3MrkWE1ax8HbJp7CRmMG
 DEfvrRpKzFrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="361525804"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2020 09:39:10 -0800
From:   Jianxin Xiong <jianxin.xiong@intel.com>
To:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Jianxin Xiong <jianxin.xiong@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH rdma-core 5/5] tests: Bug fix for get_access_flags()
Date:   Mon, 23 Nov 2020 09:53:04 -0800
Message-Id: <1606153984-104583-6-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606153984-104583-1-git-send-email-jianxin.xiong@intel.com>
References: <1606153984-104583-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The filter defintion is wrong and causes get_access_flags() always
returning empty list. As the result the MR tests using this function
are effectively skipped (but report success).

Also fix a typo in the comments.

Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
---
 tests/utils.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/utils.py b/tests/utils.py
index 0ad7110..eee44b4 100644
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
 
@@ -69,7 +69,7 @@ def get_access_flags(ctx):
     added as well.
     After verifying that the flags selection is legal, it is appended to an
     array, assuming it wasn't previously appended.
-    :param ctx: Device Context to check capabilities
+    :param ctx: Device Coyyntext to check capabilities
     :param num: Size of initial collection
     :return: A random legal value for MR flags
     """
-- 
1.8.3.1

