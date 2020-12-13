Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2740D2D8D4B
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Dec 2020 14:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394627AbgLMNa3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Dec 2020 08:30:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgLMNa3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Dec 2020 08:30:29 -0500
From:   Leon Romanovsky <leon@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 2/5] IB/umad: Return EIO in case of when device disassociated
Date:   Sun, 13 Dec 2020 15:29:37 +0200
Message-Id: <20201213132940.345554-3-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201213132940.345554-1-leon@kernel.org>
References: <20201213132940.345554-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

MAD message received by the user has EINVAL error in all flows
including when the device is disassociated. That makes it impossible
for the applications to treat such flow differently.

Change it to return EIO, so the applications will be able to perform
disassociation recovery.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/user_mad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 19104a675691..b671d4aede77 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -524,7 +524,7 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,

 	agent = __get_agent(file, packet->mad.hdr.id);
 	if (!agent) {
-		ret = -EINVAL;
+		ret = -EIO;
 		goto err_up;
 	}

--
2.29.2

