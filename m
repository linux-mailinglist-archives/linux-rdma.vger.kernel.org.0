Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F03B2B5A00
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 08:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgKQHCG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 02:02:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgKQHCF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Nov 2020 02:02:05 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B1B241A6;
        Tue, 17 Nov 2020 07:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605596525;
        bh=705AQFg48JYSoBR8K0coQS4UIIVfR9sqw4Xgq3pz+yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y473HntpqiXDSqxLJqfIPUcX3tdrN93st8gsq5SHXwnSyG538Rc5vzXu59iuvX59v
         ElsSo4qByGy5ur0g+Lh5ARv8Sb/EIGP5J0I8rcBSiC7kr5pKzXMUT4dMiQkxzD7Ygo
         DIQzjGR6nV/mZh5RbP+IXOsZUXYMIkgeEmPAbqi8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v5 1/3] RDMA/core: Track device memory MRs
Date:   Tue, 17 Nov 2020 09:01:46 +0200
Message-Id: <20201117070148.1974114-2-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201117070148.1974114-1-leon@kernel.org>
References: <20201117070148.1974114-1-leon@kernel.org>
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
 drivers/infiniband/core/uverbs_std_types_mr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index 9b22bb553e8b..dc5856441729 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -33,6 +33,7 @@
 #include "rdma_core.h"
 #include "uverbs.h"
 #include <rdma/uverbs_std_types.h>
+#include "restrack.h"
 
 static int uverbs_free_mr(struct ib_uobject *uobject,
 			  enum rdma_remove_reason why,
@@ -134,6 +135,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	atomic_inc(&pd->usecnt);
 	atomic_inc(&dm->usecnt);
 
+	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
+	rdma_restrack_set_name(&mr->res, NULL);
+	rdma_restrack_add(&mr->res);
 	uobj->object = mr;
 
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_DM_MR_HANDLE);
-- 
2.28.0

