Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308302D8D47
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Dec 2020 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394648AbgLMNaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Dec 2020 08:30:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgLMNad (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Dec 2020 08:30:33 -0500
From:   Leon Romanovsky <leon@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 3/5] IB/umad: Return EPOLLERR in case of when device disassociated
Date:   Sun, 13 Dec 2020 15:29:38 +0200
Message-Id: <20201213132940.345554-4-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201213132940.345554-1-leon@kernel.org>
References: <20201213132940.345554-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

Currently, polling a umad device will always works, even if the device
was disassociated. Hence, returning EPOLLERR if device was
disassociated.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/user_mad.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index b671d4aede77..6681e9cf8a18 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -653,10 +653,14 @@ static __poll_t ib_umad_poll(struct file *filp, struct poll_table_struct *wait)
 	/* we will always be able to post a MAD send */
 	__poll_t mask = EPOLLOUT | EPOLLWRNORM;

+	mutex_lock(&file->mutex);
 	poll_wait(filp, &file->recv_wait, wait);

 	if (!list_empty(&file->recv_list))
 		mask |= EPOLLIN | EPOLLRDNORM;
+	if (file->agents_dead)
+		mask = EPOLLERR;
+	mutex_unlock(&file->mutex);

 	return mask;
 }
--
2.29.2

