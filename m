Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7026BC40
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 08:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgIPGKj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 02:10:39 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59554 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726128AbgIPGKj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Sep 2020 02:10:39 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sergeygo@nvidia.com)
        with SMTP; 16 Sep 2020 09:10:33 +0300
Received: from rsws38.mtr.labs.mlnx (rsws38.mtr.labs.mlnx [10.209.40.117])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 08G6AXrd017431;
        Wed, 16 Sep 2020 09:10:33 +0300
From:   Sergey Gorenko <sergeygo@nvidia.com>
To:     linux-rdma@vger.kernel.org
Cc:     Sergey Gorenko <sergeygo@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v1] srp_daemon: Avoid extra permissions for the lock file
Date:   Wed, 16 Sep 2020 05:51:13 +0000
Message-Id: <20200916055113.15151-1-sergeygo@nvidia.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to create a world-writable lock file.
It's enough to have an RW permission for the file owner only.

Fixes: ee138ce1e40d ("Cause srp_daemon launch to fail if another srp_daemon is already working on the same HCA port.")
Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
Changelog:
v1: Add the fixes line.
---
 srp_daemon/srp_daemon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
index f14d9f56c9f2..fcf94537cebb 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -142,7 +142,6 @@ static int check_process_uniqueness(struct config_t *conf)
 		return -1;
 	}
 
-	fchmod(fd, S_IRUSR|S_IRGRP|S_IROTH|S_IWUSR|S_IWGRP|S_IWOTH);
 	if (0 != lockf(fd, F_TLOCK, 0)) {
 		pr_err("failed to lock %s (errno: %d). possibly another "
 		       "srp_daemon is locking it\n", path, errno);
-- 
2.21.1

