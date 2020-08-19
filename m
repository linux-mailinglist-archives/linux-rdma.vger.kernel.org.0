Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7949624A188
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgHSOS1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Aug 2020 10:18:27 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:36638 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726953AbgHSOS0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Aug 2020 10:18:26 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sergeygo@nvidia.com)
        with SMTP; 19 Aug 2020 17:18:24 +0300
Received: from rsws38.mtr.labs.mlnx (rsws38.mtr.labs.mlnx [10.209.40.117])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 07JEIN2X008959;
        Wed, 19 Aug 2020 17:18:23 +0300
From:   Sergey Gorenko <sergeygo@nvidia.com>
To:     bvanassche@acm.org
Cc:     linux-rdma@vger.kernel.org, Sergey Gorenko <sergeygo@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH] srp_daemon: Avoid extra permissions for the lock file
Date:   Wed, 19 Aug 2020 14:17:45 +0000
Message-Id: <20200819141745.11005-1-sergeygo@nvidia.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is no need to create a world-writable lock file.
It's enough to have an RW permission for the file owner only.

Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
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

