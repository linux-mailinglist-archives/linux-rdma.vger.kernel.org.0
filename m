Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17AD4471EF
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Nov 2021 07:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhKGGnf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Nov 2021 01:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhKGGnf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Nov 2021 01:43:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C13861186;
        Sun,  7 Nov 2021 06:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636267253;
        bh=MvVLzHsUMEmKpRJPqQysiS74gj9z5ZqLJdElO+9uN7U=;
        h=From:To:Cc:Subject:Date:From;
        b=U/D/oF7vuiaG8gY1aPiX/Uut2z4C4HmnB2obWjBnPZFvaw3bOpI5CfwpPfgaKumjb
         biO94gGphFW0nX/Sc5D6scHnWtbYO9/zIBNbnF/qX2nLBYnYPlYh3U+naSU/l6+RA0
         +HREsKVSz3hjCFIUQEKm6GTuw1S9mu9RT0PCMsRFgh3g7L3sNsMqxsq4+/L9aBnf3s
         nuDZZEMHXlpAawBWTDlMWcjnnmKXUC8NOCTw7yEfjb4Z98gVJQ1DD6W94uzNC2Tu/5
         Q9+4ES987/BBl26dFyWht1QLQWC754UyIKAMZpw+cRM2u/cg7F4W4vJTji3GcSbKcS
         I07aztQjHQFeg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/netlink: Annotate unused function that is needed for compilation check
Date:   Sun,  7 Nov 2021 08:40:47 +0200
Message-Id: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

>> drivers/infiniband/core/nldev.c:2543:1: warning: unused function '__chk_RDMA_NL_NLDEV'
   MODULE_ALIAS_RDMA_NETLINK(RDMA_NL_NLDEV, 5);
   ^

Fixes: e3bf14bdc17a ("rdma: Autoload netlink client modules")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/rdma/rdma_netlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
index 2758d9df71ee..c2a79aeee113 100644
--- a/include/rdma/rdma_netlink.h
+++ b/include/rdma/rdma_netlink.h
@@ -30,7 +30,7 @@ enum rdma_nl_flags {
  * constant as well and the compiler checks they are the same.
  */
 #define MODULE_ALIAS_RDMA_NETLINK(_index, _val)                                \
-	static inline void __chk_##_index(void)                                \
+	static inline void __maybe_unused __chk_##_index(void)                 \
 	{                                                                      \
 		BUILD_BUG_ON(_index != _val);                                  \
 	}                                                                      \
-- 
2.33.1

