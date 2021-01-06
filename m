Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C442EBD97
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jan 2021 13:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbhAFMVf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jan 2021 07:21:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbhAFMVf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Jan 2021 07:21:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A7922311B;
        Wed,  6 Jan 2021 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609935654;
        bh=5f3A7Dfa81O5zu/6+zqcUHwJ07D8IzaXO5ekqtK0VQw=;
        h=From:To:Cc:Subject:Date:From;
        b=CoS79aCyX2Td6FFgxScGhAbnKV3QNt/KDUbmi8/Rvr/hdQ7jdxQrEc29QqB8ZF9MT
         wf8DGXZmPTu2l49PKs+cDsVO7Vp5qD8ZjaSTlxte7zmhHRnRDvRrGcP9v9cSAdzdqI
         34GeD/O2pUbqx7lskIFwNL1zHweN5LFbOkuzfwwxnURem+sBd/EBmmHr+SNBpSuAZ/
         pR+nR2yozrH0CSSAxkZULBADdOYVef6gV5iiAnNGykYP/8Ba5x2f8uimY6xOuvAOmr
         hsgJEqhg6rASYRXw+Y7dL2gb/WtaD9m3+CaA1+Qnf0+3yp2c1dJCVuAQeVo4eZXDBD
         mqyS3Uj4o2EhQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/umem: Silence build warning on i386 architecture
Date:   Wed,  6 Jan 2021 14:20:47 +0200
Message-Id: <20210106122047.498453-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Sacrifice one page in order to silence compilation failure on i386
architecture.

drivers/infiniband/core/umem.c:205 __ib_umem_get() warn: impossible
			condition '(npages > (~0)) => (0-u32max > u32max)'

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 313fabb9f4a2..95be8cc75d2e 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -202,7 +202,7 @@ static struct ib_umem *__ib_umem_get(struct ib_device *device,
 	}
 
 	npages = ib_umem_num_pages(umem);
-	if (npages == 0 || npages > UINT_MAX) {
+	if (npages == 0 || npages >= UINT_MAX) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.29.2

