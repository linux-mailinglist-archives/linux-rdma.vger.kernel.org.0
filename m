Return-Path: <linux-rdma+bounces-6203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529C49E206C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 15:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1907A28A339
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726191F75AF;
	Tue,  3 Dec 2024 14:57:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3051F7558
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237857; cv=none; b=efSbKqKvNQaqoFs8SoKAlQZLPTcICY0uDfPatVbZ5pAxPdbhIPMOukBYtypLKd865kiHtcardbX/0FxMZ9vvfV1EVgPm1pL1ZPZrBlo+I4AyvSiisKcfnlV2SHECOF/NNvUT/tZR1esb96hZ25s5n4HfSaHcUrHuQOrxZG+6w3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237857; c=relaxed/simple;
	bh=M6G447h611dfcAbP5L5mQQDlzr5htKfoVoh3VzIDxcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YW1hcjQc4H52TNkQupCcFw1ClZEGclmPWhz5f+KHKgi8wBAGyrffTzCGLXd93dWtGsD0mgX+C0pUj/ewG+c4xUsZmTEDFmgIsShMI9eHR6nCmVyQi6TOb81EHBKAyvmzpcPtE813PB/dNG6IwD1EqM4heG6CSz8SMmeJaJABLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 4B3E0ARX021897;
	Tue, 3 Dec 2024 06:00:11 -0800
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: jgg@nvidia.com, leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>
Subject: [PATCH for-rc v2] RDMA/core: Fix ENODEV error for iWARP test over vlan
Date: Tue,  3 Dec 2024 19:30:53 +0530
Message-Id: <20241203140052.3985-1-anumula@chelsio.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If traffic is over vlan, cma_validate_port() fails to match
net_device ifindex with bound_if_index and results in ENODEV error.
As iWARP gid table is static, it contains entry corresponding  to
only one net device which is either real netdev or vlan netdev for
cases like  siw attached to a vlan interface.
This patch fixes the issue by assigning bound_if_index with net
device index, if real net device obtained from bound if index matches
with net device retrieved from gid table

Fixes: f8ef1be816bf ("RDMA/cma: Avoid GID lookups on iWARP devices")
Link: https://lore.kernel.org/all/ZzNgdrjo1kSCGbRz@chelsio.com/
Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
Changes since v1:
Addressed previous review comments
---
 drivers/infiniband/core/cma.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 64ace0b968f0..91db10515d74 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -690,6 +690,7 @@ cma_validate_port(struct ib_device *device, u32 port,
 	int bound_if_index = dev_addr->bound_dev_if;
 	int dev_type = dev_addr->dev_type;
 	struct net_device *ndev = NULL;
+	struct net_device *pdev = NULL;
 
 	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
 		goto out;
@@ -714,6 +715,21 @@ cma_validate_port(struct ib_device *device, u32 port,
 
 		rcu_read_lock();
 		ndev = rcu_dereference(sgid_attr->ndev);
+		if (ndev->ifindex != bound_if_index) {
+			pdev = dev_get_by_index_rcu(dev_addr->net, bound_if_index);
+			if (pdev) {
+				if (is_vlan_dev(pdev)) {
+					pdev = vlan_dev_real_dev(pdev);
+					if (ndev->ifindex == pdev->ifindex)
+						bound_if_index = pdev->ifindex;
+				}
+				if (is_vlan_dev(ndev)) {
+					pdev = vlan_dev_real_dev(ndev);
+					if (bound_if_index == pdev->ifindex)
+						bound_if_index = ndev->ifindex;
+				}
+			}
+		}
 		if (!net_eq(dev_net(ndev), dev_addr->net) ||
 		    ndev->ifindex != bound_if_index) {
 			rdma_put_gid_attr(sgid_attr);
-- 
2.39.3


