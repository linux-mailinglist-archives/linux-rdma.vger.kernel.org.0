Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE891EC5A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfEOKtg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 06:49:36 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34515 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbfEOKtf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 06:49:35 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 15 May 2019 13:49:32 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4FAnVKM025252;
        Wed, 15 May 2019 13:49:32 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-rdma@vger.kernel.org, leon@kernel.org, jgg@mellanox.com,
        dledford@redhat.com
Cc:     hch@lst.de, sagi@grimberg.me, maxg@mellanox.com,
        israelr@mellanox.com
Subject: [PATCH 1/7] IB/iser: Refactor iscsi_iser_check_protection function
Date:   Wed, 15 May 2019 13:49:25 +0300
Message-Id: <1557917371-8777-2-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
References: <1557917371-8777-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Reduce lines of code by using local variable.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 9c185a8dabd3..dbad8275b3bc 100644
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

