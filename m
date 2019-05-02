Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E811488
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 09:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEBHsb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 03:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfEBHsb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 03:48:31 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 499D5208C4;
        Thu,  2 May 2019 07:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556783310;
        bh=jJ7MSwkqJvVJU/p5m7YFMSLg1cBcdfmnCoHIYqrKaeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDqWt+vED6G9aVMz+GuJ/P2ccry9Q4kFWGb9YBi7LTPDOR7QuEXNOkoH346+IRvqc
         Yr6gUNR16a9CPvlmAiwIeplKnwr4NlaM9cuFF8xMDcp7Zz7LalnUZGhXEwNDbBrfZP
         j4uK43Kans3yvhHmj42T1XIiQsTjOL3/8gQsLFhQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v2 6/7] net/smc: Use rdma_read_gid_l2_fields to L2 fields
Date:   Thu,  2 May 2019 10:48:06 +0300
Message-Id: <20190502074807.26566-7-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502074807.26566-1-leon@kernel.org>
References: <20190502074807.26566-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Use core provided API to fill the source MAC address and use
rdma_read_gid_attr_ndev_rcu() to get stable netdev.

This is preparation patch to allow gid attribute to become NULL
when associated net device is removed.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 net/smc/smc_ib.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 53f429c04843..d14ca4af6f94 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -146,18 +146,13 @@ int smc_ib_ready_link(struct smc_link *lnk)
 static int smc_ib_fill_mac(struct smc_ib_device *smcibdev, u8 ibport)
 {
 	const struct ib_gid_attr *attr;
-	int rc = 0;
+	int rc;
 
 	attr = rdma_get_gid_attr(smcibdev->ibdev, ibport, 0);
 	if (IS_ERR(attr))
 		return -ENODEV;
 
-	if (attr->ndev)
-		memcpy(smcibdev->mac[ibport - 1], attr->ndev->dev_addr,
-		       ETH_ALEN);
-	else
-		rc = -ENODEV;
-
+	rc = rdma_read_gid_l2_fields(attr, NULL, smcibdev->mac[ibport - 1]);
 	rdma_put_gid_attr(attr);
 	return rc;
 }
@@ -185,6 +180,7 @@ int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
 			 unsigned short vlan_id, u8 gid[], u8 *sgid_index)
 {
 	const struct ib_gid_attr *attr;
+	const struct net_device *ndev;
 	int i;
 
 	for (i = 0; i < smcibdev->pattr[ibport - 1].gid_tbl_len; i++) {
@@ -192,11 +188,14 @@ int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
 		if (IS_ERR(attr))
 			continue;
 
-		if (attr->ndev &&
+		rcu_read_lock();
+		ndev = rdma_read_gid_attr_ndev_rcu(attr);
+		if (!IS_ERR(ndev) &&
 		    ((!vlan_id && !is_vlan_dev(attr->ndev)) ||
 		     (vlan_id && is_vlan_dev(attr->ndev) &&
 		      vlan_dev_vlan_id(attr->ndev) == vlan_id)) &&
 		    attr->gid_type == IB_GID_TYPE_ROCE) {
+			rcu_read_unlock();
 			if (gid)
 				memcpy(gid, &attr->gid, SMC_GID_SIZE);
 			if (sgid_index)
@@ -204,6 +203,7 @@ int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
 			rdma_put_gid_attr(attr);
 			return 0;
 		}
+		rcu_read_unlock();
 		rdma_put_gid_attr(attr);
 	}
 	return -ENODEV;
-- 
2.20.1

