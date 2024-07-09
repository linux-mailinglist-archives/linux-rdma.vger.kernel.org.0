Return-Path: <linux-rdma+bounces-3779-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D90192C5A6
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 23:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5A62833B9
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 21:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D428E18562D;
	Tue,  9 Jul 2024 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtiSOa85"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A7185606
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jul 2024 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561501; cv=none; b=Yua1G9PBDhIk5GO5S+gpl4B81Cs6QywahTYoX9GWoQq2IB0zd782MvI8huafqAW1hZgJgBv1r2psTN9HzaQzXVRQ53uFst3DjC+HPZLmUSyKn3RWlJzrk2SVw2xfVMDcL7jSLoWZbP8YFWtoK/bxFCGggqRqHTRlcJz7/MA+SSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561501; c=relaxed/simple;
	bh=1yjW0tSqvcxyKqSwKF5yTISXJradATOOnsgU0eXpltw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MynboXYmpk8X6Gn76WZ98//GAfA6XB/wc3BiKxX4FKpCDx5nPNb9HgwRvwBEtw+z7HCe985xrVHujcSzvM99WYgeTUxok5or8a+MVMO+EstBWKIPLFLfwKmEdAIoiaOOEY7hIe2SeOj6KfXLbeqJOHXFqWJ6w5z4xBv0+/Mzt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtiSOa85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36583C3277B;
	Tue,  9 Jul 2024 21:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720561501;
	bh=1yjW0tSqvcxyKqSwKF5yTISXJradATOOnsgU0eXpltw=;
	h=From:To:Cc:Subject:Date:From;
	b=VtiSOa85yA6531JoU6hk45/gBVRQgYpdpGi3IbKXEWoWwEpKrU5bBwtyheGr4Oa/K
	 6oe1Ie6HjFFrHMgRZY5uGjGYVlv+zcH9SKlbm3zcMxfyvtDMYTYGPIwuhlddwXYIUE
	 LL11ZqT3KGfo6pYrT5TUTTtzcu9c1ivnCGely4ZLLaIHNffN8a+kyQEWvuWLGlcmrY
	 7NW261B5+ML5WBwylHdFocu+l699v0OFqMt4ek0/GjeSwW15+ZMWTGmQRXL6jv0v9b
	 QWvmX9i4yFtRg0WQ91Qn616EUIkzbUJO10r28p8y4UZNIW3Q87i1e1l2IEFCmN1lS/
	 mNi+QCCC9WzCg==
From: David Ahern <dsahern@kernel.org>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH] RDMA: Fix netdev tracker in ib_device_set_netdev
Date: Tue,  9 Jul 2024 15:44:55 -0600
Message-Id: <20240709214455.17823-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a netdev has already been assigned, ib_device_set_netdev needs to release
the reference on the older but it is mistakenly being called for the new
netdev. Fix it and in the process use netdev_put to be symmetrical with
the netdev_hold.

Fixes: 09f530f0c6d6 ("RDMA: Add netdevice_tracker to ib_device_set_netdev()")
Signed-off-by: David Ahern <dsahern@kernel.org>
---
 drivers/infiniband/core/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 55aa7aa32d4a..7ddaec923569 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2167,7 +2167,7 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 	}
 
 	if (old_ndev)
-		netdev_tracker_free(ndev, &pdata->netdev_tracker);
+		netdev_put(old_ndev, &pdata->netdev_tracker);
 	if (ndev)
 		netdev_hold(ndev, &pdata->netdev_tracker, GFP_ATOMIC);
 	rcu_assign_pointer(pdata->netdev, ndev);
-- 
2.30.2

