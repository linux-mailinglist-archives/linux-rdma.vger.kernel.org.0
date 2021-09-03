Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C1E3FFC3A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 10:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbhICIoi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Sep 2021 04:44:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51552 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348276AbhICIoi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Sep 2021 04:44:38 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AjdWvWq8HLzLLjPo+zINuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.85,264,1624291200"; 
   d="scan'208";a="113950769"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Sep 2021 16:43:37 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 19E184D0D497;
        Fri,  3 Sep 2021 16:43:32 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Sep 2021 16:43:32 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Sep 2021 16:43:32 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Sep 2021 16:43:30 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <leon@kernel.org>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH] IB/mlx5: unify return value to ENOENT
Date:   Fri, 3 Sep 2021 16:48:15 +0800
Message-ID: <20210903084815.184320-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 19E184D0D497.AB791
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Previously, ENOENT or EINVAL will be returned by ibv_advise_mr() although
the errors all occur at get_prefetchable_mr().

flags = IBV_ADVISE_MR_FLAG_FLUSH:
mlx5_ib_advise_mr_prefetch()
  -> mlx5_ib_prefetch_sg_list()
      -> get_prefetchable_mr()
  return -ENOENT;

flags = 0:
mlx5_ib_advise_mr_prefetch()
  -> init_prefetch_work()
     -> get_prefetchable_mr()
  return -EINVAL;

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index d0d98e584ebc..52572e7ea6f6 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1828,7 +1828,7 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 
 	if (!init_prefetch_work(pd, advice, pf_flags, work, sg_list, num_sge)) {
 		destroy_prefetch_work(work);
-		return -EINVAL;
+		return -ENOENT;
 	}
 	queue_work(system_unbound_wq, &work->work);
 	return 0;
-- 
2.31.1



