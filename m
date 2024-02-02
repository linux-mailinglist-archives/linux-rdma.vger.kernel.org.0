Return-Path: <linux-rdma+bounces-871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DDC84729C
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 16:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29B11F2C305
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76290145B25;
	Fri,  2 Feb 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L9d5b9x0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE13145341;
	Fri,  2 Feb 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886413; cv=none; b=gyFGmRGkwA7jDklzCByPdf14flw277O315aB+qO4w8fmUTQEqeFJCAO+hWMJaUInvY4XX+h2XDlfyMew0hXW18HO6YWr313ZvVkqW3eC9VAKnhncApOmyDijGrnj+CuvmvenPpd2EJPTzPYtRnxKjTkXa4GHrL8syM6NeoNhsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886413; c=relaxed/simple;
	bh=xIgDQeQggRzU0YUbTvsi5ADzqvMrctEjnbNPqcT5orI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vt62EdGECu97VUMiPV+cmUF60hMpw5M8FazOdRvOdYiVQu5kU2pjmmUJbKLVLmVFa35IFT3faQPtE77zbbN34hLvFDsNV7a01d+UE1eUW1XLdwnG8hSPHv+7YJoIejW3EGOhA6Mm6e12/V28jpgbfEJ5qWspJrRfG0iLTPFlQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L9d5b9x0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9CAFF20B2004;
	Fri,  2 Feb 2024 07:06:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CAFF20B2004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706886405;
	bh=tbOBGmywCw1yErcHhceCuwXOroc2dZSPwsDCR0qMCyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9d5b9x09yTEVlhqzmyDmgdBpcsfrZGnqOCy+kbh+bYb2ZKG8k/3CnwyuCrCJOOlX
	 Mso9fdUN3BuWhJUuPOEvWa30dJ6YD/xgA9Ao7mXREHJNZY0nj2jX665hYRO7TjvhyH
	 HS9nC6DExliRmNyLfA8f1u/QBzgLoo0x7s0j1Nx0=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 4/5] RDMA/mana_ib: Enable RoCE on port 1
Date: Fri,  2 Feb 2024 07:06:36 -0800
Message-Id: <1706886397-16600-5-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1706886397-16600-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Set netdev and RoCEv2 flag to be used in GID population.
We need GIDs of the master netdev and mc->ports stores slave devices.

Signed-off-by: Konstantin Taranov <kotaranov@linux.microsoft.com>
---
 drivers/infiniband/hw/mana/device.c | 15 +++++++++++++++
 drivers/infiniband/hw/mana/main.c   | 16 ++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 11b0410..2b362f5 100644
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


