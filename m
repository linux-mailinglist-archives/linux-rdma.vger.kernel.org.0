Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BCD8E6FB
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 10:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfHOIiu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 04:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOIiu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 04:38:50 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A9D62235C;
        Thu, 15 Aug 2019 08:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858329;
        bh=slfkj9/oCbfad1bdDkD1CTC3FM/HsENN7n3X2pH0X2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VI9RDNtw6kvGGs+ZxrOlUEswZ32jYVu62rz69MXP1GDkbhCy+z8YX8gv+31oUgGxU
         tl/+W6+eFwQ4gjWguA9G04CkPI7pBPFtsxyOg72u8nhT13TNE0g3/VRwPF5uC2jPvR
         D1xCEn/tKlC80VIm6A1+0ewcR8LA32V9TflcAFmE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-rc 2/8] RDMA/counters: Properly implement PID checks
Date:   Thu, 15 Aug 2019 11:38:28 +0300
Message-Id: <20190815083834.9245-3-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815083834.9245-1-leon@kernel.org>
References: <20190815083834.9245-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

"Auto" configuration mode is called for visible in that PID
namespace and it ensures that all counters and QPs are coexist
in the same namespace and belong to same PID.

Fixes: 99fa331dc862 ("RDMA/counter: Add "auto" configuration mode support")
Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 955d061af06a..af8c85d18e62 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -149,13 +149,11 @@ static bool auto_mode_match(struct ib_qp *qp, struct rdma_counter *counter,
 	struct auto_mode_param *param = &counter->mode.param;
 	bool match = true;
 
-	if (rdma_is_kernel_res(&counter->res) != rdma_is_kernel_res(&qp->res))
+	if (!rdma_is_visible_in_pid_ns(&qp->res))
 		return false;
 
-	/* Ensure that counter belong to right PID */
-	if (!rdma_is_kernel_res(&counter->res) &&
-	    !rdma_is_kernel_res(&qp->res) &&
-	    (task_pid_vnr(counter->res.task) != current->pid))
+	/* Ensure that counter belongs to the right PID */
+	if (task_pid_nr(counter->res.task) != task_pid_nr(qp->res.task))
 		return false;
 
 	if (auto_mask & RDMA_COUNTER_MASK_QP_TYPE)
-- 
2.20.1

