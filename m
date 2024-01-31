Return-Path: <linux-rdma+bounces-829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A2843D62
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 11:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76D429BABD
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9BD78665;
	Wed, 31 Jan 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iII5BczB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418506D1D4;
	Wed, 31 Jan 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698561; cv=none; b=s+zox8VCtKW2//vuYXAnlpmOFNol80pQqZ0TSs/i0YugamRxNp3kpDtxFP+UPh0keYPK7X2JeFPmDLrIrNl8rsNHztNTxMGorbLsBw4knRBg8JafKQaEoXUnSYI4rLNvim/L/r10uEIBowlZ73e7ixLu7YTfEozPkK5jYn0N+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698561; c=relaxed/simple;
	bh=ykFVDqFPB4lY6V66losZpGAUIa9JbgeucCmBSnLGxnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SgRGU8J/2k2pEe71ZXyf9sZLmwJEiPrD00GpytQ2zb8X1q2mLOkCHD/kyJTRPurVy6DyfZT2ki6lYVRZpoP4StSht/j57nnUswd2PqMg5+lBaeZ88bgyaErJnoUTUgtItuZ9w5iWapJgw5VhW7Xge8A4LO/TfawpHHFhwFAwnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iII5BczB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id F3EF920B2004;
	Wed, 31 Jan 2024 02:55:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F3EF920B2004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706698558;
	bh=snXzVvd1Es1P5EFCe7tEDBGYBTXVzvrZs/jkgBz6PiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iII5BczBqDghQYdz16lH6P0WkkFIkrwADtobdOVYg48E8A/y6nDssi7bcU7GilcPt
	 JxTK6JBmLHB3cG7sRC1ZYLfEW7JOvSESXczdslow/HlU+mI7SQSgHbeqgwMDPdzcF9
	 wvrF9w8cUCFoffgzm1B/GFZSkxabAneZfzWj8XnQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v1 4/5] RDMA/mana_ib: Enable RoCE on port 1
Date: Wed, 31 Jan 2024 02:55:51 -0800
Message-Id: <1706698552-25383-5-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1706698552-25383-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1706698552-25383-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Set netdev and RoCEv2 flag to be used in GID population.
mana_ib is auxiliary device, thus we need GIDs of the master netdev. 

Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
---
 drivers/infiniband/hw/mana/device.c | 14 ++++++++++++++
 drivers/infiniband/hw/mana/main.c   | 16 ++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 11b0410..b9ff3fd 100644
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
@@ -79,6 +80,19 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	dev->ib_dev.num_comp_vectors = 1;
 	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
+	rcu_read_lock(); /* required to get upper dev */
+	upper_ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
+	rcu_read_unlock();
+	if (!upper_ndev) {
+		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
+		goto free_ib_device;
+	}
+	ret = ib_device_set_netdev(&dev->ib_dev, upper_ndev, 1);
+	if (ret) {
+		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
+		goto free_ib_device;
+	}
+
 	ret = mana_gd_register_device(&mdev->gdma_context->mana_ib);
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to register device, ret %d",
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 3e05a62..645abf3 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -462,11 +462,19 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 int mana_ib_get_port_immutable(struct ib_device *ibdev, u32 port_num,
 			       struct ib_port_immutable *immutable)
 {
-	/*
-	 * This version only support RAW_PACKET
-	 * other values need to be filled for other types
-	 */
+	struct mana_ib_dev *mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
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
+	if (port_num == 1 && rnic_is_enabled(mdev))
+		immutable->core_cap_flags |= RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
 
 	return 0;
 }
-- 
1.8.3.1


