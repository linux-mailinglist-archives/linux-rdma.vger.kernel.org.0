Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F33E91EC5D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEOKtg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 06:49:36 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34510 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726381AbfEOKtf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 06:49:35 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 15 May 2019 13:49:32 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4FAnVKP025252;
        Wed, 15 May 2019 13:49:32 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@mellanox.com,
        dledford@redhat.com
Cc:     hch@lst.de, sagi@grimberg.me, maxg@mellanox.com,
        israelr@mellanox.com
Subject: [PATCH 4/7] RDMA/rw: Fix doc typo
Date:   Wed, 15 May 2019 13:49:28 +0300
Message-Id: <1557917371-8777-5-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
References: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Use the correct function name.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/core/rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 89a5be3a2f97..e763e42dce05 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -613,7 +613,7 @@ EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
 /**
  * rdma_rw_ctx_destroy_signature - release all resources allocated by
- *	rdma_rw_ctx_init_signature
+ *	rdma_rw_ctx_signature_init
  * @ctx:	context to release
  * @qp:		queue pair to operate on
  * @port_num:	port num to which the connection is bound
-- 
2.16.3

