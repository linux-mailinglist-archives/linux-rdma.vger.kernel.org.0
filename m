Return-Path: <linux-rdma+bounces-7091-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FA3A161D6
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 13:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F23F3A5128
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434121DE8B7;
	Sun, 19 Jan 2025 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9d7aiGu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA8EEB5;
	Sun, 19 Jan 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737291430; cv=none; b=JWrO1tTxq1WblxNqWJeZvQS/yGM26GhBwfOSE7NYFgOYv4hXRGYNbVCfHoaWG7C7qLpRb1cCz3nUuZGOAsWx4I3AMyVBBlbtW9bhgTkdaAW6Jg8KyvhLmuqCU0hDQPS54mHMkGY1mm/YOlD8u7r3Q/Wesaryml7utcJo1nKwRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737291430; c=relaxed/simple;
	bh=kZBk0xY7dzPEbqW2Oj9HUHBdBGOfJSzXNqHm2jGWMU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Srg9DaVpgiQUYyfCoTTzScWIrBCgjkgboy/3tTCLBacaGg2TiD/W1LzbglPOsd/pKXTobbX6CTo9YnNzPVouo7h3ufSemGWC3QSGfIsU8n4l2aLXoLoCfMyH6Ff9PW5zhpsXW80ZipFabNXT0OkLRzmyRDLcPD7nosBspV1Yiu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9d7aiGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAE5C4CED6;
	Sun, 19 Jan 2025 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737291429;
	bh=kZBk0xY7dzPEbqW2Oj9HUHBdBGOfJSzXNqHm2jGWMU0=;
	h=From:To:Cc:Subject:Date:From;
	b=k9d7aiGuS3Wceq/yPgDQlkiBt0M3ysKH5WL5IVTj2rJ/xOW6dTb8BPel4UflZ6JCy
	 z2QJWZAhoALlwZZ9omi+w2B+/bgGDklBdEycCuOip+zLO4yeZgpHtpNqEE+fb9wdtI
	 yRk8vDWcm+gSCOwNck4Woff/CnHWwcTTymhqpLTEJVQUpfYBZVWX8+2minEfRWR0ut
	 WRwoAoSNsMXE53X36I/134VjXk16t66PrQ0s0jyEXSejSkoeOPqMbnJJVKNtL+/uGb
	 Hxdn10aUW2roDb6Yyn83fV8XSAOW+C+2bzNWmKQztRtNPmQyuVDNX6q54ta1EZisPa
	 6eUo9yZIuNe/A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next 0/3] Print link status when it is changed
Date: Sun, 19 Jan 2025 14:56:59 +0200
Message-ID: <cover.1737290406.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In similar to netdev and hfi1 behaviour, add general implementation to
IB/core to print IB port state changes.

"mlx5_core 0000:08:00.0 mlx5_0: Port DOWN"
"mlx5_core 0000:08:00.0 rocep8s0f0: Port ACTIVE"

Thanks

Maher Sanalla (3):
  IB/cache: Add log messages for IB device state changes
  RDMA/core: Use ib_port_state_to_str() for IB state sysfs
  IB/hfi1: Remove state transition log message and opa_lstate_name()

 drivers/infiniband/core/cache.c     |  5 +++++
 drivers/infiniband/core/sysfs.c     | 14 +-------------
 drivers/infiniband/hw/hfi1/chip.c   | 18 ------------------
 drivers/infiniband/hw/hfi1/chip.h   |  1 -
 drivers/infiniband/hw/hfi1/driver.c |  2 +-
 drivers/infiniband/hw/hfi1/mad.c    |  4 ++--
 include/rdma/ib_verbs.h             | 17 +++++++++++++++++
 7 files changed, 26 insertions(+), 35 deletions(-)

-- 
2.47.1


