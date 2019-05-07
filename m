Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4308F164BD
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 15:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfEGNix (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 09:38:53 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40395 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726658AbfEGNix (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 09:38:53 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 May 2019 16:38:41 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x47DcdFB021865;
        Tue, 7 May 2019 16:38:40 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com, maxg@mellanox.com
Subject: [PATCH 11/25] IB/iser: Refactor iscsi_iser_check_protection function
Date:   Tue,  7 May 2019 16:38:25 +0300
Message-Id: <1557236319-9986-12-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Reduce lines of code by using local variable.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 8c707accd148..a78e219a2297 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -406,13 +406,10 @@ static u8
 iscsi_iser_check_protection(struct iscsi_task *task, sector_t *sector)
 {
 	struct iscsi_iser_task *iser_task = task->dd_data;
+	enum iser_data_dir dir = iser_task->dir[ISER_DIR_IN] ?
+					ISER_DIR_IN : ISER_DIR_OUT;
 
-	if (iser_task->dir[ISER_DIR_IN])
-		return iser_check_task_pi_status(iser_task, ISER_DIR_IN,
-						 sector);
-	else
-		return iser_check_task_pi_status(iser_task, ISER_DIR_OUT,
-						 sector);
+	return iser_check_task_pi_status(iser_task, dir, sector);
 }
 
 /**
-- 
2.16.3

