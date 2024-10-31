Return-Path: <linux-rdma+bounces-5662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A773A9B7BC8
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 14:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0F5282384
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD18019DF60;
	Thu, 31 Oct 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep+llTuV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7D195FF1;
	Thu, 31 Oct 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381819; cv=none; b=JZ2eYnygCL3quPRY9RMM/WDP6poWpE7zXGQncGFwQ9prHPSFpO9L3RC1YZqyjzobxp9y+6a3F3OBVRJRpGCsJ0h1glG8FP1WpYsI70f9BGnm96P6HvqtTUegX+MTLby+sCZlowbrj4bjZsPXVSKPBqncbHBah8HVTRUgXjW6QQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381819; c=relaxed/simple;
	bh=g5zIDqS1lgFwlAPosIhVl0Rw/a5LszVsuLo7t4HkTbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUI8GydFKmS38e8E07Dw2SAMrjvogehdtAf9xaTqss32fCY7/9NHi8f0lIREojLXzoZOKNG5swMPh2Rp6lokdIFxZmskIUu9daJMIb0MUvaqU6vNpnaLEa5VDJHwvxclFg3d8cv5n2yJEJDx6w/9GLwv5hV/pxDLpkZmeDSO/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep+llTuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CC5C4E692;
	Thu, 31 Oct 2024 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730381819;
	bh=g5zIDqS1lgFwlAPosIhVl0Rw/a5LszVsuLo7t4HkTbc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ep+llTuViGIlfAGPKpvluPJ22wHAOqKb89xpX9ahi3zYhsKawF14vjcwWlQD7RFr1
	 yxD7rwK4Bd7s46B0CBK/rOIzfFXwoza/Dwmf13ke2na85j0CZNY6Lf9TuUZ8W+sg+D
	 VOKyy+5LXoU3t/gOInTiusL/pZM2BBODtKDVbxBW/gHoCmXi9sQ60yVgOkpTFdrqkP
	 /dGSBmb8MOx67QaDnPO/Gdv7/Vxp4awlYui+Of84tt0XSJfsJjoL1RyYguzZElvcEv
	 bFuXA5tmULg1OlJzI6tIQ/7LNPdseXmkJ2ZW3D96kZhUI5G5rKmKH9gSj+xPw+Cllb
	 CzdMgzV0q1A4A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 0/3] Fixes to set_netdev/get_netdev flow
Date: Thu, 31 Oct 2024 15:36:49 +0200
Message-ID: <cover.1730381292.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the set_netdev/get_netdev flow in mlx5 drive around LAG.

Thanks

Chiara Meiohas (3):
  RDMA/mlx5: Call dev_put() after the blocking notifier
  RDMA/core: Implement RoCE GID port rescan and export delete function
  RDMA/mlx5: Ensure active slave attachment to the bond IB device

 drivers/infiniband/core/roce_gid_mgmt.c       | 30 ++++++++++++++++---
 drivers/infiniband/hw/mlx5/main.c             | 29 +++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 12 ++++++++
 include/rdma/ib_verbs.h                       |  3 ++
 4 files changed, 59 insertions(+), 15 deletions(-)

-- 
2.46.2


