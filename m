Return-Path: <linux-rdma+bounces-11397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E834CADC536
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB233B343E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B6128FAB7;
	Tue, 17 Jun 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaEaDK3G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C0F28DB57
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149865; cv=none; b=LSc3CYmWlQRR18cyejjhQiPN2R/+R5feJPFyQHI9YR0mvOFUgub1W02O7oL4PsTqPgyAqna1iYoLApmRbUfQoA4GYe9xHKHoJxVxyI3i2SXSmXcEJ1E1o2z2yuKh/+Juw939MLWRAv76Qw+fTFCGpprN1rjT40OTyjGNyQiLvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149865; c=relaxed/simple;
	bh=ZRUcx1fV7TAMTpOarJGOtJ98OvlVKSARIuQbqTtpWP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhAOnMOogs9ojeIpp/Cz0bj1kQwHBODmoeXdGQXoujHOGhowcSI08SBbOnsQANBdZUSBaF2PkDNHeVlm2TnekjeRrYHvMgkUClcnwGZxHKXLo075SUutWVKqKdrxgySjvDFBeNjOoQ6XRitKvdeEjviKgBA1VOfJwJ7SA/FOmUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaEaDK3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB381C4CEE3;
	Tue, 17 Jun 2025 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149864;
	bh=ZRUcx1fV7TAMTpOarJGOtJ98OvlVKSARIuQbqTtpWP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaEaDK3G2PyTT+Mq07ambSWnNZj/7qLTJ0XFHqUlKWt0ZXXorXSez4naeRR9LDFlz
	 GU/uB6GA699d73fVJOaXBnMtRLtc7CcKJerqJJv4bwwLvQonQ3C5JzF5Vwmvxsn5Zf
	 diUPZBNZ01pxejZsAYxBX0gfubERvK+gEuC8u2heEkTZIFIbLRL4UqGhS0JkJk+V54
	 FWeMXdGHvw1klGwkzJIrDfJXAyUqgcC5O4vFAcqtKPKdN7JPAZ5IdTA7fFMLyHTmfW
	 05nApVaQ++65CtPYM9kAOxDRbX8wEaGiGcD+BHUQ6Nm6IXvxTZ5XECFPgazIzrIWE+
	 15PmzUmUVKGyw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next 3/3] RDMA/ipoib: Use parent rdma device net namespace
Date: Tue, 17 Jun 2025 11:44:03 +0300
Message-ID: <df4fcdc38f5bd0348aa0d9a49ce4253dda074ed8.1750149405.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750149405.git.leon@kernel.org>
References: <cover.1750149405.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

Use the net namespace of the underlying rdma device.
After honoring the rdma device's namespace, the ipoib
netdev now also runs in the same net namespace of the
rdma device.

Add an API to read the net namespace of the rdma device
so that ULP such as IPoIB can use it to initialize its
netdev.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 2 ++
 include/rdma/ib_verbs.h                   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index f2f5465f2a90..7acafc5c0e09 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2577,6 +2577,8 @@ static struct net_device *ipoib_add_port(const char *format,
 
 	ndev->rtnl_link_ops = ipoib_get_link_ops();
 
+	dev_net_set(ndev, rdma_dev_net(hca));
+
 	result = register_netdev(ndev);
 	if (result) {
 		pr_warn("%s: couldn't register ipoib port %d; error %d\n",
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 77cea846eb2d..2288387089cd 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4872,6 +4872,10 @@ bool rdma_dev_access_netns(const struct ib_device *device,
 			   const struct net *net);
 
 bool rdma_dev_has_raw_cap(const struct ib_device *dev);
+static inline struct net *rdma_dev_net(struct ib_device *device)
+{
+	return read_pnet(&device->coredev.rdma_net);
+}
 
 #define IB_ROCE_UDP_ENCAP_VALID_PORT_MIN (0xC000)
 #define IB_ROCE_UDP_ENCAP_VALID_PORT_MAX (0xFFFF)
-- 
2.49.0


