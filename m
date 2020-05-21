Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF08F1DD571
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2020 19:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgEUR7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 13:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgEUR7x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 May 2020 13:59:53 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B3AF20759;
        Thu, 21 May 2020 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590083993;
        bh=qPAVg2uQT1WzX5C9bhHA2uhhgUZDPmtRQwxeGPSpIMA=;
        h=From:To:Cc:Subject:Date:From;
        b=ptATd2SQSukxh4sk56uWisUuAUX5emTF/dtryeyRe6wUDzhtyBmlz8zQE/qzX5ekA
         ZA3ENPnvtDilxkPy6Pyg9P1iHrSpJxwcmA3f9t02NKCOHmEGktylbW81M7tlGSF6EE
         kpxq5dOp6BzizbTxujimpC5Jte12BY/iO0UpAr/I=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] IB/cma: Fix ports memory leak in cma_configfs
Date:   Thu, 21 May 2020 10:26:50 +0300
Message-Id: <20200521072650.567908-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

The allocated ports structure in never freed. The free function
should be called by release_cma_ports_group, but the group
is never released since we don't remove its default group.

Remove default groups when device group is deleted.

Fixes: 045959db65c6 ("IB/cma: Add configfs for rdma_cm")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma_configfs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index c672a4978bfd..5b6754f89a98 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -322,8 +322,21 @@ static struct config_group *make_cma_dev(struct config_group *group,
 	return ERR_PTR(err);
 }

+static void drop_cma_dev(struct config_group *cgroup,
+		struct config_item *item)
+{
+	struct config_group *group =
+		container_of(item, struct config_group, cg_item);
+	struct cma_dev_group *cma_dev_group =
+		container_of(group, struct cma_dev_group, device_group);
+	configfs_remove_default_groups(&cma_dev_group->ports_group);
+	configfs_remove_default_groups(&cma_dev_group->device_group);
+	config_item_put(item);
+}
+
 static struct configfs_group_operations cma_subsys_group_ops = {
 	.make_group	= make_cma_dev,
+	.drop_item	= drop_cma_dev,
 };

 static const struct config_item_type cma_subsys_type = {
--
2.26.2

