Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAE2327911
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 09:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhCAITu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 03:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232685AbhCAIT3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Mar 2021 03:19:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20DF164E45;
        Mon,  1 Mar 2021 08:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614586728;
        bh=ECir64iCmwKlpei8WmzKmkAa64D1et2bR32f80pRYqg=;
        h=From:To:Cc:Subject:Date:From;
        b=uHQB/cWKyMJ0mKF2W2fOjUBbsC1EcdsnlHKt1gPcp3YjnQu3f5xp69SP0ArFZCjUe
         cBUOr/kIQX+j5OLbC4MBZ4kTm0JDOsZCx07yFSO5eg80VhIBVjMHSo2VZ02X7DcKkA
         zOwJBmJXjrbILo/Y+1Iw/7eScQBx/gKhLhI1vyAM33Hfy2Rc2FnG8fMK2UJN5k4wgj
         yVVbtgsyjBBNQYtH5HzcNXWM26N3nrhvSzK3QJrb+y7zplezvpHpZlnwkWOt7Zbjif
         mKTvWS9gP/bB8hVv0YPrDtpfh4aZF5GQU4lehbXdyJ9+V9KZGsjECeCjCoQ9N4zlTa
         7qNVeAsX4Ngbw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/cm: Fix IRQ restore in ib_send_cm_sidr_rep
Date:   Mon,  1 Mar 2021 10:18:44 +0200
Message-Id: <20210301081844.445823-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Saeed Mahameed <saeedm@nvidia.com>

ib_send_cm_sidr_rep() {
	spin_lock_irqsave()
        cm_send_sidr_rep_locked() {
                ...
        	spin_lock_irq()
                ....
                spin_unlock_irq() <--- this will enable interrupts
        }
        spin_unlock_irqrestore()
}

spin_unlock_irqrestore() expects interrupts to be disabled
but the internal spin_unlock_irq() will always enable hard interrupts.

Fix this by replacing the internal spin_{lock,unlock}_irq() with
irqsave/restore variants.

It fixes the following kernel trace:

 ------------[ cut here ]------------
 raw_local_irq_restore() called with IRQs enabled
 WARNING: CPU: 2 PID: 20001 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20

 Call Trace:
  _raw_spin_unlock_irqrestore+0x4e/0x50
  ib_send_cm_sidr_rep+0x3a/0x50 [ib_cm]
  cma_send_sidr_rep+0xa1/0x160 [rdma_cm]
  rdma_accept+0x25e/0x350 [rdma_cm]
  ucma_accept+0x132/0x1cc [rdma_ucm]
  ucma_write+0xbf/0x140 [rdma_ucm]
  vfs_write+0xc1/0x340
  ksys_write+0xb3/0xe0
  do_syscall_64+0x2d/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: 87c4c774cbef ("RDMA/cm: Protect access to remote_sidr_table")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index be996dba040c..3d194bb60840 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3651,6 +3651,7 @@ static int cm_send_sidr_rep_locked(struct cm_id_private *cm_id_priv,
 				   struct ib_cm_sidr_rep_param *param)
 {
 	struct ib_mad_send_buf *msg;
+	unsigned long flags;
 	int ret;

 	lockdep_assert_held(&cm_id_priv->lock);
@@ -3676,12 +3677,12 @@ static int cm_send_sidr_rep_locked(struct cm_id_private *cm_id_priv,
 		return ret;
 	}
 	cm_id_priv->id.state = IB_CM_IDLE;
-	spin_lock_irq(&cm.lock);
+	spin_lock_irqsave(&cm.lock, flags);
 	if (!RB_EMPTY_NODE(&cm_id_priv->sidr_id_node)) {
 		rb_erase(&cm_id_priv->sidr_id_node, &cm.remote_sidr_table);
 		RB_CLEAR_NODE(&cm_id_priv->sidr_id_node);
 	}
-	spin_unlock_irq(&cm.lock);
+	spin_unlock_irqrestore(&cm.lock, flags);
 	return 0;
 }

--
2.29.2

