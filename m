Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB7239D720
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFGIUv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231124AbhFGIUo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:20:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 983D361205;
        Mon,  7 Jun 2021 08:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053933;
        bh=LrvOY0pEZ6nKYO0bQdlUnQxVkKq9zwYJVPPplq+P6j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iLS910zAgBN6xw5KwYJtiuHfy4NX8jFe5GtrqLD6sMwMfiBoAd5tdwa4A0ElALGbn
         igfxeZSVAkAxvsXn27+SUPxQFoYRYACISSl4Etr03LK/M4NOMRL35gGHfzgxDGAJBH
         tOMshFtxG8MX1GTcl9XWnBZPP1C7Y5968omvjtZUdSi+gpWe+MSiI+6vWAVk2sCojG
         r59ub2fbgc84RX/x5Of6d0bwcC9+Xsx7bb7Kw6bQsjqGzbH4BUGWwO2QNjJfAHHn5M
         PyRcYFIgJiH1/X9bs1iEdcowkJ19yujjU5t/ldnRMxzROt4WiqL7ZarMUsn+Tru3mu
         rkx4T/YAYnUwg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v1 14/15] RDMA/core: Allow port_groups to be used with namespaces
Date:   Mon,  7 Jun 2021 11:17:39 +0300
Message-Id: <a1a8a96629405ff3b2990f5f8dbd7b57a818571e.1623053078.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623053078.git.leonro@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Now that the port_groups data is being destroyed and managed by the core
code this restriction is no longer needed. All the ib_port_attrs are
compatible with the core's sysfs lifecycle.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 10 ++++------
 drivers/infiniband/core/sysfs.c  | 17 ++++++-----------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 2cbd77933ea5..92f224a97481 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1698,13 +1698,11 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	}
 
 	/*
-	 * Currently supported only for those providers which support
-	 * disassociation and don't do port specific sysfs init. Once a
-	 * port_cleanup infrastructure is implemented, this limitation will be
-	 * removed.
+	 * All the ib_clients, including uverbs, are reset when the namespace is
+	 * changed and this cannot be blocked waiting for userspace to do
+	 * something, so disassociation is mandatory.
 	 */
-	if (!dev->ops.disassociate_ucontext || dev->ops.port_groups ||
-	    ib_devices_shared_netns) {
+	if (!dev->ops.disassociate_ucontext || ib_devices_shared_netns) {
 		ret = -EOPNOTSUPP;
 		goto ns_err;
 	}
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 09a2e1066df0..f42034fcf3d9 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1236,11 +1236,9 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	ret = sysfs_create_groups(&p->kobj, p->groups_list);
 	if (ret)
 		goto err_del;
-	if (is_full_dev) {
-		ret = sysfs_create_groups(&p->kobj, device->ops.port_groups);
-		if (ret)
-			goto err_groups;
-	}
+	ret = sysfs_create_groups(&p->kobj, device->ops.port_groups);
+	if (ret)
+		goto err_groups;
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
 	if (device->port_data && is_full_dev)
@@ -1257,16 +1255,13 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	return ERR_PTR(ret);
 }
 
-static void destroy_port(struct ib_core_device *coredev, struct ib_port *port)
+static void destroy_port(struct ib_port *port)
 {
-	bool is_full_dev = &port->ibdev->coredev == coredev;
-
 	if (port->ibdev->port_data &&
 	    port->ibdev->port_data[port->port_num].sysfs == port)
 		port->ibdev->port_data[port->port_num].sysfs = NULL;
 	list_del(&port->kobj.entry);
-	if (is_full_dev)
-		sysfs_remove_groups(&port->kobj, port->ibdev->ops.port_groups);
+	sysfs_remove_groups(&port->kobj, port->ibdev->ops.port_groups);
 	sysfs_remove_groups(&port->kobj, port->groups_list);
 	kobject_del(&port->kobj);
 	kobject_put(&port->kobj);
@@ -1392,7 +1387,7 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 		struct ib_port *port = container_of(p, struct ib_port, kobj);
 
 		destroy_gid_attrs(port);
-		destroy_port(coredev, port);
+		destroy_port(port);
 	}
 
 	kobject_put(coredev->ports_kobj);
-- 
2.31.1

