Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EBF224FE0
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jul 2020 08:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgGSGDe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jul 2020 02:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgGSGDe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Jul 2020 02:03:34 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E8FF2073E;
        Sun, 19 Jul 2020 06:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595138613;
        bh=LZCHWgLF87wsWmXBSss4Kyz2PY2Q0uJMgATPvFB/3oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+14cJ6eJgxCg6TkXY9veucoNuM+TaYlfdkSpvffIbet9iiSWjtow3zSRjrLS+F0L
         /xTNaFBUruzZbWq2Bih0deXf3bj3dkuIu3bYP1m8NrGb/dRcnZMGwUyg1tVv3WJRei
         zs3aBKAuZ7dMk3Q2pga8DDqZQ+ZzDTtFkKq9HoCw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/uverbs: Silence shiftTooManyBitsSigned warning
Date:   Sun, 19 Jul 2020 09:03:19 +0300
Message-Id: <20200719060319.77603-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719060319.77603-1-leon@kernel.org>
References: <20200719060319.77603-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Fix reported by kbuild warning.

   drivers/infiniband/core/uverbs_cmd.c:1897:47: warning: Shifting
signed 32-bit value by 31 bits is undefined
behaviour [shiftTooManyBitsSigned]
    BUILD_BUG_ON(IB_USER_LAST_QP_ATTR_MASK == (1 << 31));
                                                 ^
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 7d2b4258f573..51f8e5464f10 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1892,7 +1892,7 @@ static int ib_uverbs_ex_modify_qp(struct uverbs_attr_bundle *attrs)
 	 * Last bit is reserved for extending the attr_mask by
 	 * using another field.
 	 */
-	BUILD_BUG_ON(IB_USER_LAST_QP_ATTR_MASK == (1 << 31));
+	BUILD_BUG_ON(IB_USER_LAST_QP_ATTR_MASK == (1ULL << 31));
 
 	if (cmd.base.attr_mask &
 	    ~((IB_USER_LAST_QP_ATTR_MASK << 1) - 1))
-- 
2.26.2

