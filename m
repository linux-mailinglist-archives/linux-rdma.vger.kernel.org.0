Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E122D2F4B2D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 13:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbhAMMSb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 07:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbhAMMSa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Jan 2021 07:18:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ECAC233FC;
        Wed, 13 Jan 2021 12:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610540248;
        bh=KctZd2yLeT+pqm+/uA6eByWOmiY4bBxZiglKl0HlLK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oI8NLhtQb2r8z4+0Mk1iBb1EDDISsoZHeEgLJn4cEKKgDPYYDuRr/HdkXXL2VYgC8
         JLpwtHcQ76IxYN7noEj1TLOpsQAXE0Y21U5tCQXTNZdMbLnpFgCPHD3+4GaSWGUD5o
         JPmySFbRpO+l6gXEoPReKE99E7948uXMUtIxyGIm7QgHheF8S6i2n8nQfY5GDgr0IC
         0Dq8tAP883qM5RDCLWWq9OvmRp685VamnsGtPKGK2K+kZz/NI8EXVwbJ1b8ek7R9wH
         H/iUb+y5+JhelfBG8sumQWUYw90+FM/hti7+eulpS63Jx2Cm7KCO/baWUSc+9kqZsT
         LQSe3zEnBH59A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next 1/5] RDMA/umem: Avoid undefined behavior of rounddown_pow_of_two
Date:   Wed, 13 Jan 2021 14:16:59 +0200
Message-Id: <20210113121703.559778-2-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113121703.559778-1-leon@kernel.org>
References: <20210113121703.559778-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

rounddown_pow_of_two is undefined when the input is 0. Therefore we need
to avoid it in ib_umem_find_best_pgsz and return 0.
Otherwise, it could result in incorrect page size.

Fixes: 3361c29e9279 ("RDMA/umem: Use simpler logic for ib_umem_find_best_pgsz()")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 95be8cc75d2e..baaf1bf22941 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -137,7 +137,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 	 */
 	if (mask)
 		pgsz_bitmap &= GENMASK(count_trailing_zeros(mask), 0);
-	return rounddown_pow_of_two(pgsz_bitmap);
+	return pgsz_bitmap ? rounddown_pow_of_two(pgsz_bitmap) : 0;
 }
 EXPORT_SYMBOL(ib_umem_find_best_pgsz);

--
2.29.2

