Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BD91C6A56
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgEFHrV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgEFHrV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:47:21 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3E7206D5;
        Wed,  6 May 2020 07:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751241;
        bh=biqdghDKhTY9b+91KYI3aC+Y/96HNwhBChHJdip7kqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sx46BbX8kTZxioWATkLzribICPFPcsUlMFCkbOa1Y8fN8S8G76UVhlCd4SJXlPw4/
         EoxsRUb+FqbDvqHorfWzZppxI9PqzTNEJG6JuJwXTyaTnK+5H97zuYQQmBt8L5f9g1
         GCT72+CjLaIo7h1Ob/3E6yZG2k9gW5l6k/XxZY8g=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Danit Goldberg <danitg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 03/10] RDMA/cm: Remove unused store to ret in cm_rej_handler
Date:   Wed,  6 May 2020 10:46:54 +0300
Message-Id: <20200506074701.9775-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506074701.9775-1-leon@kernel.org>
References: <20200506074701.9775-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Danit Goldberg <danitg@mellanox.com>

The 'goto out' label doesn't read ret, so don't set it.

Signed-off-by: Danit Goldberg <danitg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 78c9acc9393a..439055c463fa 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3083,7 +3083,6 @@ static int cm_rej_handler(struct cm_work *work)
 			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
 			 cm_id_priv->id.state);
 		spin_unlock_irq(&cm_id_priv->lock);
-		ret = -EINVAL;
 		goto out;
 	}
 
-- 
2.26.2

