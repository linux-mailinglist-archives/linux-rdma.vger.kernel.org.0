Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A859EC8859
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 14:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfJBMZ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 08:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfJBMZ3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 08:25:29 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E16F021920;
        Wed,  2 Oct 2019 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570019128;
        bh=oNFaSR3Inr1MFcGQ7RR6qO4j2SokI/gSfKfg0+ZhJJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pfy+2yHXGpIx4+V49XKktVSzIHaHmeISy0Z1HuvPWL+gbyp3u6vJbXchWVyCah32m
         mPxhQSR0GN2guprfqzPhtgCu7526iWbbcE66pmKTkDLVAWa414PnPN3986UkiLxlSG
         vnn9sksmnMgy59ynRR9rHzKSdoTonxy3B6de2pXM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next 3/4] IB/mlx5: Remove unnecessary else statement
Date:   Wed,  2 Oct 2019 15:25:16 +0300
Message-Id: <20191002122517.17721-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002122517.17721-1-leon@kernel.org>
References: <20191002122517.17721-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

'else' is not generally useful after a break or
return. Remove this unnecessary statement.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 831539419c30..b95c2b05f682 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -844,8 +844,8 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	resp_len = sizeof(resp.comp_mask) + sizeof(resp.response_length);
 	if (uhw->outlen && uhw->outlen < resp_len)
 		return -EINVAL;
-	else
-		resp.response_length = resp_len;
+
+	resp.response_length = resp_len;
 
 	if (uhw->inlen && !ib_is_udata_cleared(uhw, 0, uhw->inlen))
 		return -EINVAL;
-- 
2.20.1

