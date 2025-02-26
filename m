Return-Path: <linux-rdma+bounces-8146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 896F7A45FF6
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3783618943C3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22B114900F;
	Wed, 26 Feb 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9l6L5uq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0784A2B;
	Wed, 26 Feb 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574893; cv=none; b=stuGsaGm9XnCOmGkxICOUqPntPsYigX5DJhd4r9kQUFcjnBSueqQP738tG2T0QCLIFusZlWwyDpriPFcZyBvETCOvgTRQ6OhOPxabs6/x4QmTBD6x7iPb9zZ/SjCi9AO0ytPDG5tvSlJ6JAn927jDjTOUSd8GU2UDCdlPgjfgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574893; c=relaxed/simple;
	bh=fAW6QONAJiM7wEki8tU63IcHhV385LMxqMzHXcALnM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zru5RhzD1QppVX0Cxspy6eLIWaA67nBjRKiZe4nwAl+qY7eCCJRPpeNo40vAmMqDpwjQ5HA0LYfaoJiLco2fLdjtssPJ/bu8BtPVDifKKrttN+v7bd48rpk8Q0p0eVbtFTO2vEwkxBr7bHTR4fPOjz6hT9anKppa4vqAF2Iyi9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9l6L5uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671DCC4CED6;
	Wed, 26 Feb 2025 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740574892;
	bh=fAW6QONAJiM7wEki8tU63IcHhV385LMxqMzHXcALnM4=;
	h=From:To:Cc:Subject:Date:From;
	b=Y9l6L5uq8VIZTdAtU1w6+mVKRkHycIsuBP0gDU5OkZtBFJVKxLouQjbFMwFVeQhxP
	 qJevWxI3KIC0BZ3r1IHR+V/tkkWgXpgsTxpH8bLd9InlQk3wvNBoD9JSJLtA+zYyoO
	 jd0A8BYc624bEwdp5I55O4ZH8plfPqQm2NEGpUZYjuJ71tTYNIGA8Dt/3Q8cPoZXd3
	 sVyDOxTrGMTt+LLPEHm3yO6rrs3BxTE9Q6Levt39gUQC1+YSiJgi9cmcSPOQRjI5+M
	 oKs4BO0XSVqAvyf887sehI+ewoFcOPYubKVsx08lRYSbmOtJsvxpHrbyZ+GU+Rno/A
	 Y9UCBs4dlZfDQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 0/5] Add support and infrastructure for RDMA TRANSPORT
Date: Wed, 26 Feb 2025 15:01:04 +0200
Message-ID: <cover.1740574103.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is preparation series targeted for mlx5-next, which will be used
later in RDMA. 

This series adds RDMA transport steering logic which would allow the
vport group manager to catch control packets from VFs and forward them
to control SW to help with congestion control.

In addition, RDMA will provide new set of APIs to better control exposed
FW capabilities and this series is needed to make sure mlx5 command interface
will ensure that privileged commands can always proceed,

Thanks

Chiara Meiohas (3):
  net/mlx5: Add RDMA_CTRL HW capabilities
  net/mlx5: Allow the throttle mechanism to be more dynamic
  net/mlx5: Limit non-privileged commands

Patrisious Haddad (2):
  net/mlx5: Query ADV_RDMA capabilities
  net/mlx5: fs, add RDMA TRANSPORT steering domain support

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 120 ++++++++++--
 .../mellanox/mlx5/core/esw/acl/helper.c       |   2 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |   2 +
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 178 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   7 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
 include/linux/mlx5/device.h                   |  11 ++
 include/linux/mlx5/driver.h                   |   6 +
 include/linux/mlx5/fs.h                       |  10 +-
 include/linux/mlx5/mlx5_ifc.h                 |  52 ++++-
 12 files changed, 368 insertions(+), 39 deletions(-)

-- 
2.48.1


