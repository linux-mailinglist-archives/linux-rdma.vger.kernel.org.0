Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4A7A64C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfG3KzO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 06:55:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:57348 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728940AbfG3KzO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 06:55:14 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from sergeygo@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 Jul 2019 13:55:09 +0300
Received: from rsws38.mtr.labs.mlnx (rsws38.mtr.labs.mlnx [10.209.40.117])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x6UAt9wo025972;
        Tue, 30 Jul 2019 13:55:09 +0300
From:   Sergey Gorenko <sergeygo@mellanox.com>
To:     bvanassche@acm.org
Cc:     linux-rdma@vger.kernel.org,
        Vladimir Koushnir <vladimirk@mellanox.com>,
        Sergey Gorenko <sergeygo@mellanox.com>
Subject: [PATCH rdma-core] srp_daemon: check that port LID is valid before calling create_ah
Date:   Tue, 30 Jul 2019 10:54:55 +0000
Message-Id: <20190730105455.15080-1-sergeygo@mellanox.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Vladimir Koushnir <vladimirk@mellanox.com>

The default LID that is given to the port is not valid (a valid LID value
is > 0 and < 0xc000), so in case the port didn't get a valid lid from the
SM there is no need to call create_ah.

Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
---
 srp_daemon/srp_daemon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
index e85b96686d47..337b21c7d7c9 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -2228,8 +2228,9 @@ catas_start:
 			pr_debug("Starting a recalculation\n");
 			port_lid = get_port_lid(res->ud_res->ib_ctx,
 						config->port_num, &sm_lid);
-			if (port_lid != res->ud_res->port_attr.lid ||
-				sm_lid != res->ud_res->port_attr.sm_lid) {
+			if (port_lid > 0 && port_lid < 0xc000 &&
+			    (port_lid != res->ud_res->port_attr.lid ||
+			     sm_lid != res->ud_res->port_attr.sm_lid)) {
 
 				if (res->ud_res->ah) {
 					ibv_destroy_ah(res->ud_res->ah);
-- 
2.17.2

