Return-Path: <linux-rdma+bounces-11387-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC84ADC51E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D5616BB22
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530EE288CB5;
	Tue, 17 Jun 2025 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1HKiJqy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344C1DE3DC
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149361; cv=none; b=bN+5Whcad/dtCo/IiufGTmq7oeTAvKGgANq2nvQCRHOi7y7or4vfIvLYKx5jFF63wR9Ew8dx+iA7G6iZwLR1UYkR9t8m3ijLIA8SWY0pY06hQHDBCIkjwSYW3Etq6dE0Rgy8LGpJeUnAU0uI2oVE9jiWTs7uw0NSgLWIavo3y+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149361; c=relaxed/simple;
	bh=8a/2Ev7sJRewtVAgoidgkuLTIitfpy2hUf7fz7twVZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIZLH052wHi5uSWOlxYpsBtk3oOaivD5LxeZzR3ASmjYLD/qWfkWtNVUteu9jrbIDiDs/uRiq4DzSFUE8mL8SDGnK0QkSQ2ltYpSfO5fEQVzPDrg0zb+qQ53UP9q7kGs5TKFqwA37S/UEXo4i9VVy9xJtiZaySwy4dFLRvF4OqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1HKiJqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2BEC4CEE3;
	Tue, 17 Jun 2025 08:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149360;
	bh=8a/2Ev7sJRewtVAgoidgkuLTIitfpy2hUf7fz7twVZg=;
	h=From:To:Cc:Subject:Date:From;
	b=u1HKiJqy4OKs0cqWFKJxPssNpDbzPh0p+sLtXODf3/Kx1l1cPWY0XhWzMWK2Kr9pw
	 M6SjHyMTSJLQu8oCCGiXlz7vm5pOpZqWFEfTEBx6kh/M2qXS11Njcfb8KA7+i85oLW
	 iENRSXQNKL+POfuDUQF7mYJXFAm8e5XDjekQ2ouMrSusJU8NjEbuM4l1iXSt67OWa0
	 TYMidx3JXF5JiJy5a2x47kV5bzKSsYnn4BA8d62gTzXYyWNUJrgg1Gkt7Y3eTmpCkU
	 zL5lSPI+cChK4gPN+7SC6VnJ08W7Hp0XatAzqiiMDB1YnnmFbzbWDGsaIrCJCnx0Yr
	 I6tw8Mfeob8Mw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next 0/7] Check CAP_NET_RAW in right namespace
Date: Tue, 17 Jun 2025 11:35:44 +0300
Message-ID: <cover.1750148509.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following series from Parav clears the mud where against which 
namespace the CAP_NET_RAW should be checked.

It is followup of this discussion:
https://lore.kernel.org/all/20250313050832.113030-1-parav@nvidia.com

Thanks

Parav Pandit (7):
  RDMA/uverbs: Check CAP_NET_RAW in user namespace for flow create
  RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create
  RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create
  RDMA/mlx5: Check CAP_NET_RAW in user namespace for anchor create
  RDMA/mlx5: Check CAP_NET_RAW in user namespace for devx create
  RDMA/counter: Check CAP_NET_RAW check in user namespace for RDMA
    counters
  RDMA/nldev: Check CAP_NET_RAW in user namespace for QP modify

 drivers/infiniband/core/core_priv.h           |  2 +-
 drivers/infiniband/core/counters.c            |  2 +-
 drivers/infiniband/core/device.c              | 27 +++++++++++++++++++
 drivers/infiniband/core/nldev.c               |  4 +--
 drivers/infiniband/core/uverbs_cmd.c          | 21 +++++++++------
 drivers/infiniband/core/uverbs_std_types_qp.c |  2 +-
 drivers/infiniband/hw/mlx5/devx.c             |  2 +-
 drivers/infiniband/hw/mlx5/fs.c               |  7 +++--
 include/rdma/ib_verbs.h                       |  2 ++
 9 files changed, 51 insertions(+), 18 deletions(-)

-- 
2.49.0


