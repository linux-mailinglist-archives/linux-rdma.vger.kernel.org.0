Return-Path: <linux-rdma+bounces-5663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6599B7BC9
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 14:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F8E2823E6
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F50D19F105;
	Thu, 31 Oct 2024 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t58CNjN+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A66195FF1
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381824; cv=none; b=V8CSklnlByKp0hJZexdOqiGZAMxwjV9YT8J3fkGhnVPtM8/ZRoj3xuxlpyRG40b60biu/ota/+GOax061+NRnZW715QZEOlCRuyEKrUnoGLEd+QJ6fGD26Olx+Hj0AsGtJmscMZ+4mLNlGp602RKP3vudA+r9RRzNDJe9KmwSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381824; c=relaxed/simple;
	bh=M20uYfjD5RpOG3/msJXy6kaC8H7QrZLAx4mhCiTehIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLnmsB9vrJNh7EwIrv7dEIWl1k+yFy70XoQTPjwJ8fS96qXw1DSCq4jA5b/37dRcKZLQuUrt7utLKOCPVf6EvzpGTMb5MRtkqf6cyOmCGBJWofMDw+loaAos6dF8zd79JrY+rQsC5iMzo+L1m+ziqHaLi4rTm3JvUnUnvxq7JXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t58CNjN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94C0C4E698;
	Thu, 31 Oct 2024 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730381823;
	bh=M20uYfjD5RpOG3/msJXy6kaC8H7QrZLAx4mhCiTehIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t58CNjN+rXF7+de0MUk7eUZ1CxfMQOaRc10XXU28MWbDsdz6jUsi6XQuWX8rW9uDK
	 +zywEvQVCtafRS1udIr2jf99fYAgmUnWNC51SfBRdRN9n4yrW0ffRkdg/bO/Y3Z/Ob
	 s8ozzSlxKZCGfXkxYD62JzVZh9ChgK5ux+61HuloRanOzqK7aRZke9y0CAQx8EXEzk
	 b8bpl/jJj9bYxEVKHOaorV/yEO9FlCc0FMxRkvYg6bJR51b1fv+PjPHTnWoBBuWNhm
	 2A4tqsEbv0044uoVAxqkrCbvVT7E7ockFICGfK3BhHvLjzSz2UTDhQ/UyCBNHwV1FQ
	 W/tgLgZhMeqrA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/3] RDMA/core: Implement RoCE GID port rescan and export delete function
Date: Thu, 31 Oct 2024 15:36:51 +0200
Message-ID: <674d498da4637a1503ff1367e28bd09ff942fd5e.1730381292.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730381292.git.leon@kernel.org>
References: <cover.1730381292.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

rdma_roce_rescan_port() scans all network devices in
the system and adds the gids if relevant to the RoCE device
port. When not in bonding mode it adds the GIDs of the
netdevice in this port. When in bonding mode it adds the
GIDs of both the port's netdevice and the bond master
netdevice.

Export roce_del_all_netdev_gids(), which  removes all GIDs
associated with a specific netdevice for a given port.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/roce_gid_mgmt.c | 30 +++++++++++++++++++++----
 include/rdma/ib_verbs.h                 |  3 +++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index d5131b3ba8ab..a9f2c6b1b29e 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -515,6 +515,27 @@ void rdma_roce_rescan_device(struct ib_device *ib_dev)
 }
 EXPORT_SYMBOL(rdma_roce_rescan_device);
 
+/**
+ * rdma_roce_rescan_port - Rescan all of the network devices in the system
+ * and add their gids if relevant to the port of the RoCE device.
+ *
+ * @ib_dev: IB device
+ * @port: Port number
+ */
+void rdma_roce_rescan_port(struct ib_device *ib_dev, u32 port)
+{
+	struct net_device *ndev = NULL;
+
+	if (rdma_protocol_roce(ib_dev, port)) {
+		ndev = ib_device_get_netdev(ib_dev, port);
+		if (!ndev)
+			return;
+		enum_all_gids_of_dev_cb(ib_dev, port, ndev, ndev);
+		dev_put(ndev);
+	}
+}
+EXPORT_SYMBOL(rdma_roce_rescan_port);
+
 static void callback_for_addr_gid_device_scan(struct ib_device *device,
 					      u32 port,
 					      struct net_device *rdma_ndev,
@@ -575,16 +596,17 @@ static void handle_netdev_upper(struct ib_device *ib_dev, u32 port,
 	}
 }
 
-static void _roce_del_all_netdev_gids(struct ib_device *ib_dev, u32 port,
-				      struct net_device *event_ndev)
+void roce_del_all_netdev_gids(struct ib_device *ib_dev,
+			      u32 port, struct net_device *ndev)
 {
-	ib_cache_gid_del_all_netdev_gids(ib_dev, port, event_ndev);
+	ib_cache_gid_del_all_netdev_gids(ib_dev, port, ndev);
 }
+EXPORT_SYMBOL(roce_del_all_netdev_gids);
 
 static void del_netdev_upper_ips(struct ib_device *ib_dev, u32 port,
 				 struct net_device *rdma_ndev, void *cookie)
 {
-	handle_netdev_upper(ib_dev, port, cookie, _roce_del_all_netdev_gids);
+	handle_netdev_upper(ib_dev, port, cookie, roce_del_all_netdev_gids);
 }
 
 static void add_netdev_upper_ips(struct ib_device *ib_dev, u32 port,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9cb8b5fe7eee..67551133b522 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4734,6 +4734,9 @@ ib_get_vector_affinity(struct ib_device *device, int comp_vector)
  * @device:         the rdma device
  */
 void rdma_roce_rescan_device(struct ib_device *ibdev);
+void rdma_roce_rescan_port(struct ib_device *ib_dev, u32 port);
+void roce_del_all_netdev_gids(struct ib_device *ib_dev,
+			      u32 port, struct net_device *ndev);
 
 struct ib_ucontext *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile);
 
-- 
2.46.2


