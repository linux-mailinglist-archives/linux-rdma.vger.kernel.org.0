Return-Path: <linux-rdma+bounces-11384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E56AADC477
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3BB7A9608
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AB828FA91;
	Tue, 17 Jun 2025 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJd4Pdp7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBB28F523;
	Tue, 17 Jun 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148363; cv=none; b=o2n5QbP/31dcOae0KXnVfavBpkm2yufIDy7/cxnK+/H39qoUdiM3Whu/NlJavdIz3gk3oXBJDwsm6zcmlC7Y2Qk+dv1IlMQCuorGuDADcMISccgQLU4F0Vcl7mUqDeHgOpV5EaWIvY46a523PLijaUIBKn7875pBO7nDgZXn4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148363; c=relaxed/simple;
	bh=C2yNifr16v/kB8TxxJUMkx+a98Ciu/zR+feupeb7yY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qbluv3egf7YLOaWCpRZDv903lRmKqXi0FE7z6gWmVeV0DaJ1XZqSjeM0KqhEPfxhxxOznVKqdMpXWGPaZkOXuyma8ZIEngifX2TorLpDgd0efmi5a7sNFdgx8bVcC8qsAEvNUzzJkVieGfYPmRdAX5flD1Yjlfb0zU2yOczbrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJd4Pdp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865ECC4CEE3;
	Tue, 17 Jun 2025 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750148363;
	bh=C2yNifr16v/kB8TxxJUMkx+a98Ciu/zR+feupeb7yY8=;
	h=From:To:Cc:Subject:Date:From;
	b=IJd4Pdp77jVJFkZYFQdblDl3xS/CNWtpR9iOaL+hU6tCSwiXM/9m4366B2ge6+RFd
	 5ujyjq+zUkbU9COQHIktiImjUtRpdhVVdgXndJJHF5mlTKuHl95YHMX3sfpG4w71na
	 HZdHaJ6taAOSRjjQiOur+nlbZ4kdyptsMgSTkHEc6T4gGvicRczPVxj9qsxHA+iWtC
	 a++U3eEQzd1YMTS0vlCF6l5eL3aPbyM62CX1YwSBgqj+c6BslTK+l27IpIU/0HyMaG
	 4tZ9HdmCDp/YLAOWAAG2FzgQvIqPXx7pC7qFmNT/VIywItzf53C/3JLbd613SsgJCm
	 JuWPvmwr/D9jQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 0/2] Add multiple priorities support to mlx5 RDMA TRANSPORT tables
Date: Tue, 17 Jun 2025 11:19:14 +0300
Message-ID: <cover.1750148083.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This short series from Patrisious extends mlx5 flow steering logic to
allow creation rule creation with priorities in RDMA TRANSPORT tables.

Thanks  

Patrisious Haddad (2):
  net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain
  RDMA/mlx5: Add multiple priorities support to RDMA TRANSPORT userspace
    tables

 drivers/infiniband/hw/mlx5/fs.c               | 40 ++++++++++++-------
 drivers/infiniband/hw/mlx5/fs.h               |  8 +++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  4 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 30 ++++++++++----
 include/linux/mlx5/fs.h                       |  2 +-
 5 files changed, 56 insertions(+), 28 deletions(-)

-- 
2.49.0


