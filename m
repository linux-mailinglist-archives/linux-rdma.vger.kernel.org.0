Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E86C883E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfJBMVd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 08:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfJBMVd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 08:21:33 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BBF121920;
        Wed,  2 Oct 2019 12:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570018892;
        bh=Oh5/WnwBtsPLYt0+aGA3BlHAkS4SLscg5xN3ZOxxGpw=;
        h=From:To:Cc:Subject:Date:From;
        b=NUBCRw3VGkigG9z1t/S//Rt+C0TfxPcgBa7z7yJXFfQ1sn55YtSBdJKDzmMFKsUsa
         q0K+wk8ENJEQJX/HgpavJNK+qLCu4MY34UwXDjgM+NRNjC7uuZvLfvsfR1U5jhcLME
         KRrv5to2K5imKX7IEtBOxM1Kg2NXveWlVIVGyIe4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mohamad Heib <mohamadh@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-rc] IB/core: Fix wrong iterating on ports
Date:   Wed,  2 Oct 2019 15:21:27 +0300
Message-Id: <20191002122127.17571-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mohamad Heib <mohamadh@mellanox.com>

rdma_for_each_port is already incrementing the iterator's value
it receives therefore, after the first iteration the iterator is
increased by 2 which eventually causing wrong queries
and possible traces.

Fix the above by removing the old redundant incrementation that
was used before rdma_for_each_port() macro.

Fixes: ea1075edcbab ("RDMA: Add and use rdma_for_each_port")
Signed-off-by: Mohamad Heib <mohamadh@mellanox.com>
Reviewed-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 1ab423b19f77..6eb6d2717ca5 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -426,7 +426,7 @@ int ib_create_qp_security(struct ib_qp *qp, struct ib_device *dev)
 	int ret;
 
 	rdma_for_each_port (dev, i) {
-		is_ib = rdma_protocol_ib(dev, i++);
+		is_ib = rdma_protocol_ib(dev, i);
 		if (is_ib)
 			break;
 	}
-- 
2.20.1

