Return-Path: <linux-rdma+bounces-11334-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C909AADAB9C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 11:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3A87AA025
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 09:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854C8264FB4;
	Mon, 16 Jun 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEkRnaju"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AA1E231E
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065340; cv=none; b=pksYGkbPIGBUfg/h5ZrGPqhyw1blDOlVFn5glNkOIitPSDhOki8BDYvj1gUN+/ITU7xziOY63FijmldKRe2YriBTYN9W1vHbp9P8AfZBp75ZzPdPD/zRSYXuVsAOOWMyJRFxKMhHBu2N/wosSHYXYF6gzbVB5VB/RoFyG+DsAlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065340; c=relaxed/simple;
	bh=UZZnNSyOpT1WzIr3zW1oZ/+mh+5c7m5jBgQCELpnpj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L34Q82KCVuO3tN9LrMwMUrEHLB5hQ9dlpTdYmwBHlfsCaqI5pZUAF1etualkQFptflEiAl8ytQY5kknsaklJAWhbN0B0nEe+hIUr/W3owY0cQhehHJSKgpyGHi7UipJdmKR2fnnBv8uE3u8gg1TfJiLCHfa9uyze+AfgOp9ZzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEkRnaju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228CAC4CEEF;
	Mon, 16 Jun 2025 09:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750065338;
	bh=UZZnNSyOpT1WzIr3zW1oZ/+mh+5c7m5jBgQCELpnpj4=;
	h=From:To:Cc:Subject:Date:From;
	b=tEkRnajucKwY1CGA4cOmhunIgCJ5p0k4pufYMzxW7fBtpfkmYau0uynBsDiNsCxeZ
	 d+PTeiiRtSTRMupS3BESjtAHC/auP3NL2rGswwjvrwox9uRpqY1iicDbFhznFYbNnl
	 yFhRd4Utrw8lbLmqvgrT35H60Hp9PpBB6sBdnzt8RinRZv0k4f/FKcpidcwmliNNkx
	 62lkTvz6JGLPCA+vVid2DnuLg0UjSCLyApOuJ6xB/l2jqGbcB6yKDBplQJCxF79hqs
	 ur1FCiUST9+2Nola0hOtibNMgjpdYEJGn/qHCXhdPsCII5k3RhQAKuJ7lIJBegbfVj
	 OZcfu1edKVKVQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Parav Pandit <parav@mellanox.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH rdma-rc 0/3] Batch of mlx5_ib fixes
Date: Mon, 16 Jun 2025 12:14:51 +0300
Message-ID: <cover.1750064969.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The batch of different mlx5_ib fixes from Patrisious.

Patrisious Haddad (3):
  RDMA/mlx5: Fix HW counters query for non-representor devices
  RDMA/mlx5: Fix CC counters query for MPV
  RDMA/mlx5: Fix vport loopback for MPV device

 drivers/infiniband/hw/mlx5/counters.c |  4 ++--
 drivers/infiniband/hw/mlx5/main.c     | 33 +++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.49.0


