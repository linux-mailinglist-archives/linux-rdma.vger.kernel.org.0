Return-Path: <linux-rdma+bounces-7360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B4AA259F3
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 13:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D26165130
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078E20764A;
	Mon,  3 Feb 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhmnltgV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F0204C3D;
	Mon,  3 Feb 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586919; cv=none; b=ZBLKYALaCkPQYyMW3VqfX43xxH5olwbx1FLLpVHBaEbzC3j+zjmUg4GZxkghOax3BbzL3+O3eZyAvcuqlB8V+9M05fairCsyrmoRoyx9LHBzYbO9eATQE8koBmfyDggnUtma/2Ntj97bZ0GgL6dqeknCVrtO53uZxdFNleM5w3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586919; c=relaxed/simple;
	bh=ErTHNCwJHHxLprWei3Un96riaRASdT57IFS1D11Vm44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k89vF8/J2jJ8e9WsXZ+Tw2owoQ8kbde/61nyNraA0vAflM4YcuphCZ3ZelyEIeepS1nzXQQwbxKm8LyqIcteTBerCGFbBrwEnaSJJeZovaI0H7Pt9zVYYT2ujl6BkkBk2bRnaL6c7CJShlPA7V6LhvjheJcxozNyYAnrU5aB0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhmnltgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48253C4CEE0;
	Mon,  3 Feb 2025 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738586918;
	bh=ErTHNCwJHHxLprWei3Un96riaRASdT57IFS1D11Vm44=;
	h=From:To:Cc:Subject:Date:From;
	b=GhmnltgVMen4ZBnYyijEBejBTh/AOO2bYx+8iMopHfKXmHj0S09jJ8vU3Ca0U3TYv
	 rWAdX1+6Vtaxxrk4QAGkh+VE8fK2rWq2nXAw3MbYIerO7lvNKmnrFpW8Gxw5UKHIrK
	 EZYby3o3ibZ8PU6c+DtqiNewmo13E4plwSi+6kL+MYyKeq0JtcGb299yBq6eNsWgHT
	 EvZT0S8PizO/IHo3Fu9wk4vQN0hjEAfNBNHJi6kOuKKtQxCH8kal1nFawbq0o/ZsPf
	 ZYRs8MHmihXx/FLvHOImWp9LC3JMWAZNIpamYVwAJaU1UrKyUQOfAFGV7Oqzn26yz5
	 Cw+Nt9FNwih0Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next v1 0/3] Print link status when it is changed
Date: Mon,  3 Feb 2025 14:48:03 +0200
Message-ID: <cover.1738586601.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1:
 * Changed print to include port number
 * Don't print anything on change state from NOP
v0: https://lore.kernel.org/all/cover.1737290406.git.leon@kernel.org
-----------------------------------------------------------------------

In similar to netdev and hfi1 behavior, add general implementation to
IB/core to print IB port state changes.

"mlx5_core 0000:08:00.0 mlx5_0: Port: 1 Link DOWN"
"mlx5_core 0000:08:00.0 rdmap8s0f0: Port: 2 Link ACTIVE"

Thanks

Maher Sanalla (3):
  IB/cache: Add log messages for IB device state changes
  RDMA/core: Use ib_port_state_to_str() for IB state sysfs
  IB/hfi1: Remove state transition log message and opa_lstate_name()

 drivers/infiniband/core/cache.c     |  6 ++++++
 drivers/infiniband/core/sysfs.c     | 14 +-------------
 drivers/infiniband/hw/hfi1/chip.c   | 18 ------------------
 drivers/infiniband/hw/hfi1/chip.h   |  1 -
 drivers/infiniband/hw/hfi1/driver.c |  2 +-
 drivers/infiniband/hw/hfi1/mad.c    |  4 ++--
 include/rdma/ib_verbs.h             | 17 +++++++++++++++++
 7 files changed, 27 insertions(+), 35 deletions(-)

-- 
2.48.1


