Return-Path: <linux-rdma+bounces-12730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D6EB25919
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 03:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599A19E0617
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220AA1D88AC;
	Thu, 14 Aug 2025 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TN9BTB8M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5761C6FE1;
	Thu, 14 Aug 2025 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755135006; cv=none; b=ddu0C2/IFxPv7p0EcSIaQUSM1tlhJDySDGC1wSrhTDLApuULCLSczZb+0ssj2Ur45f/EtjiSCzb0E8zyi8ccQIQx6ZbdJLaNLcX8X+nuY6O3yDwhazBrX4wjSUcG6nfzzA0x8pILUDUwy5ZyTvalHcygDumU99/Ti/WEu8HJ6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755135006; c=relaxed/simple;
	bh=P+It4k3Z3whbPaKl6RWbBy8Vkp87xIILFiRgerpR/1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JTP5fMAgkyecT778bfetd1oB9d1Llnps53dlBWTZAnBB3U20sYdJsolzvI0fUMkEDtE9aKbkB/fzSsQhmx+UC9Sv0sF05dk6wbaPrOsTsEBzbi8J8oxqWo9lvMDF+IZDxP28x2cWjyVsTfPH3vgWNjK0rW2DSo08ZmgAYDyJ3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TN9BTB8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30637C4CEEB;
	Thu, 14 Aug 2025 01:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755135006;
	bh=P+It4k3Z3whbPaKl6RWbBy8Vkp87xIILFiRgerpR/1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TN9BTB8Md7oeWbpnSfTIjNTZR6D5CVUotSIvHxdUc4aCZ15ng9ga9f0jnm7IhaKze
	 wY35f+SIB2xlOt6SwICuldTZ4QNjMV60Qc2shZOYwvDGyawEI1GYnaLH3m3w9vZPo6
	 uImYuI/ia+fm+rVz+VFNgDeF+0D05M2BBPnQQAtVic9bnt6LNPSeZ/wPQChyvzRbhS
	 sQK3C9992E/T+xMmKeDfF0j0kSwZTgAOVC6K4yPgAN8kj2Vhn2VB5Okt7Rsvttf2LG
	 d8aK8X20nU5TgvoSWSvTGItdIVCwgYiXQXrxag5g0pYksfqMUvTb+4Bhvnr7krd5Nx
	 mzRiGf7VqkKZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB09039D0C38;
	Thu, 14 Aug 2025 01:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] net: Don't use %pK through printk or
 tracepoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513501748.3846704.2653284504088460874.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 01:30:17 +0000
References: <20250811-restricted-pointers-net-v5-0-2e2fdc7d3f2c@linutronix.de>
In-Reply-To: 
 <20250811-restricted-pointers-net-v5-0-2e2fdc7d3f2c@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@codeaurora.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, aleksandr.loktionov@intel.com, horms@kernel.org,
 pmenzel@molgen.mpg.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 11:43:17 +0200 you wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] ice: Don't use %pK through printk or tracepoints
    https://git.kernel.org/netdev/net-next/c/66ceb45b7d7e
  - [net-next,v5,2/2] net/mlx5: Don't use %pK through tracepoints
    https://git.kernel.org/netdev/net-next/c/e2068f74b976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



