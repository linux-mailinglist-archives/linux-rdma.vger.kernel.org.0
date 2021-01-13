Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E902F4BF1
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 14:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbhAMNDB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 08:03:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbhAMNDB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Jan 2021 08:03:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1635C23405;
        Wed, 13 Jan 2021 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610542940;
        bh=Gpq5B/G498ZPM+R40jsII9bhSeN4vXbkG2HbFZCotuY=;
        h=From:To:Cc:Subject:Date:From;
        b=b29GPqwBg3XjEh9yv/OAXN0ScAf8BeAg3GIUwDvYk26LxwV1SR10OPPHvVwVmdUze
         ogmqL6S0I2TRpNyxjGoKgr2JgRNtxA/i3uiaaG0DR7qCWDnrgAVhhk6S960wKcZrue
         3c8FzupOG/Y16OE1xw9CPcBekE5eN6HjKSMFcrqHx1zHgDcsA1wNfy60YNdY1qA7Xy
         VUg7iZ5vfeSWSA1RxvSBpQhbP8/TDgf8zQK/J8sFz+fZblx0EgpJTT13Mb2n6wI2oQ
         XsyuqLcO+gwRMgzLKVjsYzpLbg+DprZG0J/wYrBHHbF6SINEQzZF7tYRpUVS2Ym/PC
         6rT2ZQt5bvnbA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Neta Ostrovsky <netao@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/cma: Fix error flow in default_roce_mode_store
Date:   Wed, 13 Jan 2021 15:02:14 +0200
Message-Id: <20210113130214.562108-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Neta Ostrovsky <netao@nvidia.com>

In default_roce_mode_store(), we took a reference to cma_dev, but
didn't return it in error flow. Fix it by calling to cma_dev_put
in such flow.

Fixes: 1c15b4f2a42f ("RDMA/core: Modify enum ib_gid_type and enum rdma_network_type")
Signed-off-by: Neta Ostrovsky <netao@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma_configfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 9fa1653fb7b7..e0d5e3bae458 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -131,8 +131,10 @@ static ssize_t default_roce_mode_store(struct config_item *item,
 		return ret;
 
 	gid_type = ib_cache_gid_parse_type_str(buf);
-	if (gid_type < 0)
+	if (gid_type < 0) {
+		cma_configfs_params_put(cma_dev);
 		return -EINVAL;
+	}
 
 	ret = cma_set_default_gid_type(cma_dev, group->port_num, gid_type);
 
-- 
2.29.2

