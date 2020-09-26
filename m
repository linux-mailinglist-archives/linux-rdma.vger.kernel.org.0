Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB04027984C
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgIZKUJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZKUJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:20:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E431238E5;
        Sat, 26 Sep 2020 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115608;
        bh=ZETtpIWThWXcJp0aYzYMsktdpYhvXxG/jKJydq8fRh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJNXZk9hiNz0NdaVoqW6G3pm9OZRX14hypq2J/ExZJRfP3mg7SVjFV+NWGuSVqFij
         YQbH1cA3m0NeCbbrOYra/QpKasgQEiDTFhexFT+LVY2nMvRXzlaEn6o1rsojqsSjsV
         /GNNiq8TBIPIVbaTKCNZ3yAzfm72C9Pqj5zTbgks=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 8/9] RDMA/core: Track device memory MRs
Date:   Sat, 26 Sep 2020 13:19:37 +0300
Message-Id: <20200926101938.2964394-9-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926101938.2964394-1-leon@kernel.org>
References: <20200926101938.2964394-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Device memory (DM) are registered as MR during initialization flow,
these MRs were not tracked by resource tracker and had res->valid set
as a false. Update the code to manage them too.

Before this change:
[leonro@vm ~]$ ibv_rc_pingpong -j &
[leonro@vm ~]$ rdma res show mr <-- shows nothing

After this change:
[leonro@vm ~]$ ibv_rc_pingpong -j &
[leonro@vm ~]$ rdma res show mr
dev ibp0s9 mrn 0 mrlen 4096 pdn 3 pid 734 comm ibv_rc_pingpong

Fixes: be934cca9e98 ("IB/uverbs: Add device memory registration ioctl support")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_std_types_mr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 9b22bb553e8b..9ec5ea49e06e 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -31,6 +31,7 @@
  */
 
 #include "rdma_core.h"
+#include "restrack.h"
 #include "uverbs.h"
 #include <rdma/uverbs_std_types.h>
 
@@ -134,6 +135,15 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	atomic_inc(&pd->usecnt);
 	atomic_inc(&dm->usecnt);
 
+	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
+	rdma_restrack_set_name(&mr->res, NULL);
+	ret = rdma_restrack_add(&mr->res);
+	if (ret) {
+		rdma_restrack_put(&mr->res);
+		pd->device->ops.dereg_mr(mr, &attrs->driver_udata);
+		return ret;
+	}
+
 	uobj->object = mr;
 
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_DM_MR_HANDLE);
-- 
2.26.2

