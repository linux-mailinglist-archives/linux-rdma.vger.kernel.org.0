Return-Path: <linux-rdma+bounces-3807-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC97B92DA2A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 22:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A816A28337A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 20:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4BD1974EA;
	Wed, 10 Jul 2024 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8EJikdC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3619149A
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643593; cv=none; b=K7eZe3iR+DXcuc8MHG4xgsBuhPLsxyEAlBItSLJ0B9EsU7P2qNu0EnGUg1Wzb2o6CXcyC3DUHl9JGL6ZdzYyu+CeiJJvZvZYewD4Ok1ktqXBV96o4ogDj8gbAZXx9BeeGahNDNo1UOToIYKZstZzC+J1eUtxjVVmlRk3gaauf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643593; c=relaxed/simple;
	bh=YOQuIzH4ZEs6wt8bbfk37JAfsRbvz7TGHn/d+Y5azK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VcDItzUrFl32iYoxZxgcE8KIdR774Agu/e0n61JaXCnZ1LAkNU+fOPaEzxtahPBkGNJlPA4dzseCvj9BshWvcjJrQ5a5FdYXRvbPf0c/iGP4QPBZ8DV94epNmXeAFwCOyrfG/OOFImmtPVe05ifGPzWcxW7qAzR6fcJI1ZEYs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8EJikdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CE3C32781;
	Wed, 10 Jul 2024 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720643592;
	bh=YOQuIzH4ZEs6wt8bbfk37JAfsRbvz7TGHn/d+Y5azK8=;
	h=From:To:Cc:Subject:Date:From;
	b=T8EJikdCzSkmpC2oxLMrbld782bz7fxg4rDsowc/wsXqPr302/5oLwhm0GR3nZSaA
	 AlZU9VJQkCa8UXWCasjz4TNPKUZqKPfrFZrmRdNCD54lKiyOKOQc/QPUfM+30slApQ
	 TTOlpTLrwEYP+iXh/y0kwbbrt4vv3b0D6aUVSYZ9aF0/72bVc6bhydrJE/oqQwc2ae
	 XuUR7QlQ+cNHpE1LXTq14lgXh2zQa67EbeLSeayjb9cfVjE5YwYarYJIRMZpR8APHE
	 tjlE3Rfoj37x5QVBpJ40QxfrRx2KZ/oPEYEH6w4CEJzO8JVjq0IEeGILYPucv5YnGS
	 1WmiJdwAL3vYA==
From: David Ahern <dsahern@kernel.org>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH v2] RDMA: Fix netdev tracker in ib_device_set_netdev
Date: Wed, 10 Jul 2024 13:33:10 -0700
Message-Id: <20240710203310.19317-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a netdev has already been assigned, ib_device_set_netdev needs to
release the reference on the older netdev but it is mistakenly being
called for the new netdev. Fix it and in the process use netdev_put
to be symmetrical with the netdev_hold.

Fixes: 09f530f0c6d6 ("RDMA: Add netdevice_tracker to ib_device_set_netdev()")
Signed-off-by: David Ahern <dsahern@kernel.org>
---
v2
- remove __dev_put now that netdev_put is used

 drivers/infiniband/core/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 55aa7aa32d4a..9b99112baf47 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2167,14 +2167,13 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 	}
 
 	if (old_ndev)
-		netdev_tracker_free(ndev, &pdata->netdev_tracker);
+		netdev_put(old_ndev, &pdata->netdev_tracker);
 	if (ndev)
 		netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
 	rcu_assign_pointer(pdata->netdev, ndev);
 	spin_unlock_irqrestore(&pdata->netdev_lock, flags);
 
 	add_ndev_hash(pdata);
-	__dev_put(old_ndev);
 
 	return 0;
 }
-- 
2.39.3 (Apple Git-146)


