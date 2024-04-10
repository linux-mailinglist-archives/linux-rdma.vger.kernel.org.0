Return-Path: <linux-rdma+bounces-1882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E95689EDD4
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 10:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0A81F22270
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB734155733;
	Wed, 10 Apr 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iDtPW5kq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F8E154C0C;
	Wed, 10 Apr 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738559; cv=none; b=Sre98Jpn740ELAeth3NBL0J3O9FqOCSjhEQJ1ssQKCiClKDMllvC54jAobehZ8b58LfvnVr3yLFFf+/bzgd8nC//QMYbyttKSbNXZ3eq8LBvaaVp00njxsKCqPkrE8uwGnyTTPXxlBEnkeSN8moMUZjWtSVPmEdfikgZvimCshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738559; c=relaxed/simple;
	bh=V9QotwQAxq0dq2KVBgFKkjWLwCSF1WZZRsf1g5P+K4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o6zD0d73fWDcdfOytPitCNkJngFYZxNTAnQaS0xNGrr6HBxiFvKzUTVHQlOLS5mX1ECkuKO0rMzRqyPuX6ej92n1AR3EN4xu5qg76Ecl173UiVDBU/Dw6IwR/uXnNR7y/KQuFvbBN0/1mZ6BymXVp93XhBGHGNuDgJipTMr+txs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iDtPW5kq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C827D20EB208;
	Wed, 10 Apr 2024 01:42:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C827D20EB208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712738557;
	bh=+xX48jZFtuWYH9+zqjjMhfndVe/+fw70VsSz49OGP3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDtPW5kq95evZOSIO09GHmNNR3HuWFRYFvnDHOESbLKe3PVt1aSskruT6IMiI1iz6
	 jUGUMvthXrk5I8QoNgdcZsZsz3D8cUWVlPWvaa/ANXGtWmeHTnengjbjeYWqmM6pEZ
	 8+nZnopQv6Zw3RaN6KJGEz6HCkzWTT+/CtFL00Ok=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 4/6] RDMA/mana_ib: enable RoCE on port 1
Date: Wed, 10 Apr 2024 01:42:29 -0700
Message-Id: <1712738551-22075-5-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Set netdev and RoCEv2 flag to enable GID population on port 1.
Use GIDs of the master netdev. As mc->ports[] stores slave devices,
use a helper to get the master netdev.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c | 15 +++++++++++++++
 drivers/infiniband/hw/mana/main.c   | 15 +++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 47547a962b19..e7981301d10b 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -53,6 +53,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 {
 	struct mana_adev *madev = container_of(adev, struct mana_adev, adev);
 	struct gdma_dev *mdev = madev->mdev;
+	struct net_device *upper_ndev;
 	struct mana_context *mc;
 	struct mana_ib_dev *dev;
 	int ret;
@@ -79,6 +80,20 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	dev->ib_dev.num_comp_vectors = 1;
 	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
+	rcu_read_lock(); /* required to get upper dev */
+	upper_ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
+	if (!upper_ndev) {
+		rcu_read_unlock();
+		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
+		goto free_ib_device;
+	}
+	ret = ib_device_set_netdev(&dev->ib_dev, upper_ndev, 1);
+	rcu_read_unlock();
+	if (ret) {
+		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
+		goto free_ib_device;
+	}
+
 	ret = mana_gd_register_device(&mdev->gdma_context->mana_ib);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to register device, ret %d",
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 29550f2173ff..7a9d7e13b7b1 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -527,11 +527,18 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 int mana_ib_get_port_immutable(struct ib_device *ibdev, u32 port_num,
 			       struct ib_port_immutable *immutable)
 {
-	/*
-	 * This version only support RAW_PACKET
-	 * other values need to be filled for other types
-	 */
+	struct ib_port_attr attr;
+	int err;
+
+	err = ib_query_port(ibdev, port_num, &attr);
+	if (err)
+		return err;
+
+	immutable->pkey_tbl_len = attr.pkey_tbl_len;
+	immutable->gid_tbl_len = attr.gid_tbl_len;
 	immutable->core_cap_flags = RDMA_CORE_PORT_RAW_PACKET;
+	if (port_num == 1)
+		immutable->core_cap_flags |= RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
 
 	return 0;
 }
-- 
2.43.0


