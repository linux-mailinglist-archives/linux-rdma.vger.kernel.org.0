Return-Path: <linux-rdma+bounces-9025-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DD0A74BEA
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 15:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E523B502D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898F721D5A2;
	Fri, 28 Mar 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXjwTIzd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCF21D3DF;
	Fri, 28 Mar 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169804; cv=none; b=qi+GLn6MLHexYDV43/q30pt2IohlltB/X8WWCJ3AxUizdtyntOnGu5U4BFTRFYZKZtM4DpPvAcKnZOKu1wPrrl1NuxFF87fWztZluirc7ywSNzbIde/UO5H2IYyZCN2cWRkOFMbZ7GNBCIbC4vOcn6i4ovFRb5RmWJXcsUIuuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169804; c=relaxed/simple;
	bh=++Wf31pg/OpvCXLQNuNhLu/4SJCaLWuaIEBlPe1gT64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UliVGrfzaUK5aGjSmCqGRp9giJkDw+e7GCDTJEgSxDVi+w12XJRTKdvSftnqk/30BfAQY00f6XcaEjDj0y4zLDXPSk64x0ONjwxAZKyKMTiD2RGhczz8UNv5eM8cset06Vg9Hn7NVdBYrbWly2q9h/PcgO4V90RioGD7Sedmz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXjwTIzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1655EC4CEEA;
	Fri, 28 Mar 2025 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743169804;
	bh=++Wf31pg/OpvCXLQNuNhLu/4SJCaLWuaIEBlPe1gT64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EXjwTIzd1bemcl0u+pPRKYYjZOXCg1n/FAkHDGJ6DQiOlBC4qlVHTbOOmUmvswXEr
	 sFjFAY2WVTm4yBtJImJNQZD+DwTmrnbqTdJmPGAFWS2LOrMZmIgusYL5rIYn2wTOWp
	 r8u6lwTbZD+oKV4J/u5Y5V/5zHle/w1S3ibuQUs4/Q1RtZkhV6wSKJXT/U0w0BIsdn
	 PjiBVoMxLEcnieeA8lczP9aNMF3i8xEPw5i2SROhqORaBvUwceqtxYdcMDE8+EWF6I
	 BA67lE1yHToMaKPUrgI8CbSG0sxBBJhDN8O84/aBlR4mGcBTtPAJftW2NumVWYC6ZH
	 im9YFikv31k5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF497380AA66;
	Fri, 28 Mar 2025 13:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: SHAMPO,
 Make reserved size independent of page size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174316984028.2839333.4008696441488010424.git-patchwork-notify@kernel.org>
Date: Fri, 28 Mar 2025 13:50:40 +0000
References: <1742732906-166564-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1742732906-166564-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gal@nvidia.com,
 leonro@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com, mbloch@nvidia.com,
 lkayal@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 23 Mar 2025 14:28:26 +0200 you wrote:
> From: Lama Kayal <lkayal@nvidia.com>
> 
> When hw-gro is enabled, the maximum number of header entries that are
> needed per wqe (hd_per_wqe) is calculated based on the size of the
> reservations among other parameters.
> 
> Miscalculation of the size of reservations leads to incorrect
> calculation of hd_per_wqe as 0, particularly in the case of large page
> size like in aarch64, this prevents the SHAMPO header from being
> correctly initialized in the device, ultimately causing the following
> cqe err that indicates a violation of PD.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: SHAMPO, Make reserved size independent of page size
    https://git.kernel.org/netdev/net/c/fab058356885

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



