Return-Path: <linux-rdma+bounces-14048-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF35C0A12D
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 02:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D286A4E2DD2
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97689212542;
	Sun, 26 Oct 2025 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rF/eTQIS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184417C21E
	for <linux-rdma@vger.kernel.org>; Sun, 26 Oct 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761436820; cv=none; b=ETlMdqnwoAP5Ul1msxsQwXu/qfLws9K67sVtflaWaPFGhZf1Jln6Ts/0FrWR2bjAR0GW2lNJ4tY6pF75IQrqZeFamWZlDOwBF9KR3eaeHeGvkvzz9suc39WG7gv238GziZa1qE3jOFH2kVc+fDxXx1VVyUKMiBL/kasqFo1rCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761436820; c=relaxed/simple;
	bh=BL9iIxGzcOrrn5GUC/h6Vz6nDiCCgt8tKcGksVUNAcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcUKoaXxpY18w3o3qOMtwl82ZMwFTK5UMEfX2u8T773ZDU1JJ+Gpp+ZXmDmDBIPoUi8dTn0xeDRq8z7/ikfeUP0INu8C8fMHnLAuAuyD5p/fKCkfeut9E4risTFvUO9UdReveweEdLTr4v4rf/XZUMM7kGbsDxzXfGfv7csNw/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rF/eTQIS; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <328ebb4f-b1ce-4645-9cea-5fe81d3483e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761436811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bE6U4DIZJuvGeeM9mWvYcD6GNpIIZgiIJKMCn5NvN5s=;
	b=rF/eTQISKdPGI3C7IDMbDet/37bE+bETIsWqYLnW9PK3MsBXqEnHv+W9CArj9rdIYFARY/
	xCWk7Qo6XM6YOWr27u9Wb/0AmiDv56MGhS/dkROsBj0a0r33dgASUNSnvd86J66nMcIPSM
	F30SLujwwBOepns6sDPiUDjnX0UIzZg=
Date: Sat, 25 Oct 2025 16:59:53 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/5] net/mlx5: Add balance ID support for LAG
 multiplane groups
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shay Drori <shayd@nvidia.com>
References: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/23 2:16, Tariq Toukan 写道:
> Hi,
> 
> This series adds balance ID support for MLX5 LAG in multiplane
> configurations.
> 
> See detailed description by Mark below [1].
> 
> Regards,
> Tariq
> 
> 
> [1]
> The problem: In complex multiplane LAG setups, we need finer control over LAG
> groups. Currently, devices with the same system image GUID are treated
> identically, but hardware now supports per-multiplane-group balance IDs that
> let us differentiate between them. On such systems image system guid
> isn't enough to decide which devices should be part of which LAG.
> 
> The solution: Extend the system image GUID with a balance ID byte when the
> hardware supports it. This gives us the granularity we need without breaking
> existing deployments.
> 
> What this series does:
> 
> 1. Add the hardware interface bits (load_balance_id and lag_per_mp_group)
> 2. Clean up some duplicate code while we're here
> 3. Rework the system image GUID infrastructure to handle variable lengths
> 4. Update PTP clock pairing to use the new approach
> 5. Restructure capability setting to make room for the new feature
> 6. Actually implement the balance ID support
> 
> The key insight is in patch 6: we only append the balance ID when both

In the above, patch 6 is the following patch? It should be patch 5?

[PATCH net-next 5/5] net/mlx5: Add balance ID support for LAG multiplane 
groups

Yanjun.Zhu

> capabilities are present, so older hardware and software continue to work
> exactly as before. For newer setups, you get the extra byte that enables
> per-multiplane-group load balancing.
> 
> This has been tested with both old and new hardware configurations.
> 
> 
> Mark Bloch (5):
>    net/mlx5: Use common mlx5_same_hw_devs function
>    net/mlx5: Add software system image GUID infrastructure
>    net/mlx5: Refactor PTP clock devcom pairing
>    net/mlx5: Refactor HCA cap 2 setting
>    net/mlx5: Add balance ID support for LAG multiplane groups
> 
>   drivers/net/ethernet/mellanox/mlx5/core/dev.c | 12 ++++---
>   .../ethernet/mellanox/mlx5/core/en/devlink.c  |  7 ++--
>   .../ethernet/mellanox/mlx5/core/en/mapping.c  | 13 +++++---
>   .../ethernet/mellanox/mlx5/core/en/mapping.h  |  3 +-
>   .../mellanox/mlx5/core/en/rep/bridge.c        |  6 +---
>   .../mellanox/mlx5/core/en/tc/int_port.c       |  8 +++--
>   .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 11 ++++---
>   .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 32 ++++++++++---------
>   .../mellanox/mlx5/core/esw/devlink_port.c     |  6 +---
>   .../mellanox/mlx5/core/eswitch_offloads.c     |  8 +++--
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  4 ++-
>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 19 ++++++-----
>   .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  2 ++
>   .../net/ethernet/mellanox/mlx5/core/main.c    | 23 +++++++++----
>   .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  2 ++
>   .../net/ethernet/mellanox/mlx5/core/vport.c   | 19 +++++++++++
>   include/linux/mlx5/driver.h                   |  3 ++
>   17 files changed, 112 insertions(+), 66 deletions(-)
> 
> 
> base-commit: d550d63d0082268a31e93a10c64cbc2476b98b24


