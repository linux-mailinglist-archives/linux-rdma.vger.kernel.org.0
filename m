Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD554226DB4
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 19:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgGTR4k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 13:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389198AbgGTR4k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jul 2020 13:56:40 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25EDC20734;
        Mon, 20 Jul 2020 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595267799;
        bh=ltaNNKrUaC5+8kcmlG0UNFecdtzkKBhXYyBPHetyPaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4C16/UwMhrQHE/lNLHkJMjHkmTfrPRn31BA/GybpciT3JtBPVCO/suwm8AH95/dq
         U164+SAAzE2ItQIfPHXNgF8HfgWoqbiuYKAsjsRunFDSxSx0VFPh4F7J8lvcRMbpKZ
         eWp8BcG5V2vQ3h11dYe5LSJkZqikHqsE2gqKIzTw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 2/2] RDMA/uverbs: Silence shiftTooManyBitsSigned warning
Date:   Mon, 20 Jul 2020 20:56:27 +0300
Message-Id: <20200720175627.1273096-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720175627.1273096-1-leon@kernel.org>
References: <20200720175627.1273096-1-leon@kernel.org>
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
index c36f22ab9bae..896e2cc046b0 100644
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

