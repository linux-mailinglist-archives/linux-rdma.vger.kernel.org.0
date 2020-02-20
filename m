Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48816584B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 08:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgBTHM4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 02:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgBTHMz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 02:12:55 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E145924656;
        Thu, 20 Feb 2020 07:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582182775;
        bh=nmdGAm/bHRJyEhvVpkP1UxPBvgllgItEdNktEej7lPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VbcHqtdiN2JvYMDxt4jABFHy6uZiYUxB8/7fX6VhTnzabo/S743LdsDq24NkMbks0
         /3cK6g5662lE/pKpTYgv8cV1faPR2wCyVIljYlRt3M5Gqb+tN33m8xwI3ie9PRPZty
         6E/6xc4lWPR2BIBaarFYHcLAlXgecJBUtf82vYfs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH rdma-next 2/2] RDMA/opa_vnic: Delete driver version
Date:   Thu, 20 Feb 2020 09:12:39 +0200
Message-Id: <20200220071239.231800-3-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220071239.231800-1-leon@kernel.org>
References: <20200220071239.231800-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The default version provided by "ethtool -i" it the correct way
to identify Driver version. There is no need to overwrite it.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c  | 2 --
 drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h | 1 -
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c     | 5 -----
 3 files changed, 8 deletions(-)

diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
index 8ad7da989a0e..42d557dff19d 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
@@ -125,8 +125,6 @@ static void vnic_get_drvinfo(struct net_device *netdev,
 			     struct ethtool_drvinfo *drvinfo)
 {
 	strlcpy(drvinfo->driver, opa_vnic_driver_name, sizeof(drvinfo->driver));
-	strlcpy(drvinfo->version, opa_vnic_driver_version,
-		sizeof(drvinfo->version));
 	strlcpy(drvinfo->bus_info, dev_name(netdev->dev.parent),
 		sizeof(drvinfo->bus_info));
 }
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h b/drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
index 6dbc08e1a6a6..dd942dd642bd 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
@@ -292,7 +292,6 @@ struct opa_vnic_mac_tbl_node {
 		hlist_for_each_entry(obj, &name[bkt], member)

 extern char opa_vnic_driver_name[];
-extern const char opa_vnic_driver_version[];

 struct opa_vnic_adapter *opa_vnic_add_netdev(struct ib_device *ibdev,
 					     u8 port_num, u8 vport_num);
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
index be5befd92d16..6e8d650c17c7 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
@@ -59,9 +59,7 @@

 #include "opa_vnic_internal.h"

-#define DRV_VERSION "1.0"
 char opa_vnic_driver_name[] = "opa_vnic";
-const char opa_vnic_driver_version[] = DRV_VERSION;

 /*
  * The trap service level is kept in bits 3 to 7 in the trap_sl_rsvd
@@ -1041,9 +1039,6 @@ static int __init opa_vnic_init(void)
 {
 	int rc;

-	pr_info("OPA Virtual Network Driver - v%s\n",
-		opa_vnic_driver_version);
-
 	rc = ib_register_client(&opa_vnic_client);
 	if (rc)
 		pr_err("VNIC driver register failed %d\n", rc);
--
2.24.1

