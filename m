Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF78730316F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 02:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbhAZBZT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 20:25:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:28888 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731557AbhAYTnU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Jan 2021 14:43:20 -0500
IronPort-SDR: 3TjHhgR3VYqo2MS20xeaUzZMUBR+LVuJIXzHhpUqY1fMGsxQBxBfKr1Jp9QNXZ3JG1v44wXHvH
 uhRpP5Bs0YvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179937095"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="179937095"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:42:00 -0800
IronPort-SDR: 2GeBmKcADVG0ofST3+fLqVnmy7Uc44MaTcO5OE9YHqHojY5cfKHSHFxB5lISXW3/kfwEhCK7Hp
 LeJF8ZHAepTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="402468971"
Received: from cst-dev.jf.intel.com ([10.23.221.69])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2021 11:41:59 -0800
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
Subject: [PATCH rdma-core v7 6/6] tests: Bug fix for get_access_flags()
Date:   Mon, 25 Jan 2021 11:57:02 -0800
Message-Id: <1611604622-86968-7-git-send-email-jianxin.xiong@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611604622-86968-1-git-send-email-jianxin.xiong@intel.com>
References: <1611604622-86968-1-git-send-email-jianxin.xiong@intel.com>
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

