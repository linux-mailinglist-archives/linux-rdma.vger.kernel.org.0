Return-Path: <linux-rdma+bounces-8695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74631A60C50
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 09:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0902460DC9
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63C1DA617;
	Fri, 14 Mar 2025 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XR0c0GMD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9F1953A9
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942546; cv=none; b=pH1aZph7G8qV35HN8eyDBwFpDmIyxPbQRo48niMMZEVV1ftwbP5kmL46BDERbu6Fo6vfdkGse7PSch1QXJANXHy0bLXASb0AbVEfQHqDH5/v7Dx7lHxUnut09sXuL3ipNDcW5Gh2jC53292d6iN3xy8ZKyWVrdXLju6dMtnBD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942546; c=relaxed/simple;
	bh=x48LR8dbdzARydBiQgRGgjodVvEmqR9oU8EyEs1euRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GdHLFZrWyO6qawet1abiVRtnnFXxgzKZFc2wrn8KDZz/twK/cdbg+SMMttgEvLp4kizt6OdR6oXZrKhtiPk7bmJp0etudYA9aMlGJzAg2gM2e8HsHNKJxa8W771hx8uUzPdqsROGHzNpwtSdiuY+EI1I1PjFNVMJBzramx5OY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XR0c0GMD; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741942542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nERHPD2a7D5A0ltlknUVvRo289nyarbNZQmIk/k1cag=;
	b=XR0c0GMDONxy0hN2WuAFekiwRm65TKM7hZta799/9345PETBYYMOrWtZR5gSEoySC5O+zz
	6cR8FFolKF8hZo+LI6Q3o+1+ahyM7jvEU8EEagG0K7WLRkEH6K2idAKWgX+syzBpcULSBQ
	hJ1nLFsf37sf4VI9vfL6Lt9oFKff6L0=
From: luoxuanqiang <xuanqiang.luo@linux.dev>
To: leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: eric.dumazet@gmail.com,
	luoxuanqiang <luoxuanqiang@kylinos.cn>
Subject: [PATCH] [PATCH net-next] RDMA/device: Change dev_hold() to netdev_hold() in ib_device_get_netdev()
Date: Fri, 14 Mar 2025 16:54:51 +0800
Message-Id: <20250314085451.1551714-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: luoxuanqiang <luoxuanqiang@kylinos.cn>

When adding the "netdevice ref tracker" mechanism to ib_port_data, the
dev_hold() in ib_device_get_netdev() was missed, which may cause false
alarms of ref leak. Replace dev_hold() with netdev_hold() to fix it.

Fixes: 09f530f0c6d6 ("RDMA: Add netdevice_tracker to ib_device_set_netdev()")
Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>
---
 drivers/infiniband/core/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 0ded91f056f3..f65a7e2b4f2b 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2270,7 +2270,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 		spin_lock(&pdata->netdev_lock);
 		res = rcu_dereference_protected(
 			pdata->netdev, lockdep_is_held(&pdata->netdev_lock));
-		dev_hold(res);
+		netdev_hold(res, &pdata->netdev_tracker, GFP_ATOMIC);
 		spin_unlock(&pdata->netdev_lock);
 	}
 
-- 
2.27.0


