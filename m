Return-Path: <linux-rdma+bounces-12940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D859B37690
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 03:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAECA7C51D7
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 01:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C01EB5CE;
	Wed, 27 Aug 2025 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9W9FtAP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632583595C;
	Wed, 27 Aug 2025 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257014; cv=none; b=DXA88OA1FKDLR69FExGXwIvNpGNn1QPgo7qV10ZB4W5n1zErBWRSPEelu2wM1B/QKKfSqrf2RwyaF3G7OZJUrI969sMtLQCLe5pWHOd3kWm7dE5Z6B1El6UJ3vJ9Cdv4I0PzbTN8pKq6ll/+uA347yet7SR1qsjuQQSKW06ioXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257014; c=relaxed/simple;
	bh=EMhGlZdTvvC26tq0WwXdUrkaRJh8TalYkZUal0nmwE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MF0ZfvOr5zcQT4TYS61BMBYHdVVvkcsg9teYgmOusFADpAHvcv4ZxtYqi4qFaOeNwvg881WkndMOfI5d5c1BqBqOlAy0l5WkimzE3T5imZS0q+n0bOGts28DyKg2G1ACOgVsGsd5WeY/y4mtzWUg15bzzrENEpdqLueQynr798c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9W9FtAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E730AC4CEF1;
	Wed, 27 Aug 2025 01:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756257014;
	bh=EMhGlZdTvvC26tq0WwXdUrkaRJh8TalYkZUal0nmwE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c9W9FtAPumVzAaJv0P327XCzeAq5WUCIU1VATVx7kyde8BgwwiZtcpOiG6dNKNF2G
	 O8QCe09JhSBo3jDyJ4wf9Tf5Yri6eog3H0HUT7P2qL/dcUTwWgBy/RGz62YsxV6HfU
	 6B+/MCW8RVUuf5QJzIED89ukLnw/f4YitRHInYICwvOARohatavtMmLUeFjn4rTTCM
	 iGqfjNacWe9Vdm1g270PWWN+id38cSZMpu2g0xefamZF0flMERk086yXCFhzJGLiGz
	 iewPIRFPCIRBzVxz2Fued4emyOZKE1r8W6hvoZUHDgn/qLTfBgJB8zEm5PEmTsAw+7
	 7CDFamMlN9FCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFDC383BF70;
	Wed, 27 Aug 2025 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2 00/11] mlx5 misc fixes 2025-08-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625702150.157007.438680153183937226.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 01:10:21 +0000
References: <20250825143435.598584-1-mbloch@nvidia.com>
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, tariqt@nvidia.com,
 leon@kernel.org, saeedm@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 17:34:23 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> V1: https://lore.kernel.org/all/20250824083944.523858-1-mbloch@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [net,V2,01/11] net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path
    https://git.kernel.org/netdev/net/c/2c0a959bebdc
  - [net,V2,02/11] net/mlx5: HWS, Fix memory leak in hws_action_get_shared_stc_nic error flow
    https://git.kernel.org/netdev/net/c/a630f83592cd
  - [net,V2,03/11] net/mlx5: HWS, Fix uninitialized variables in mlx5hws_pat_calc_nop error flow
    https://git.kernel.org/netdev/net/c/24b6e5314047
  - [net,V2,04/11] net/mlx5: HWS, Fix pattern destruction in mlx5hws_pat_get_pattern error path
    https://git.kernel.org/netdev/net/c/00a50e4e8974
  - [net,V2,05/11] net/mlx5: Reload auxiliary drivers on fw_activate
    https://git.kernel.org/netdev/net/c/34cc6a54914f
  - [net,V2,06/11] net/mlx5: Fix lockdep assertion on sync reset unload event
    https://git.kernel.org/netdev/net/c/902a8bc23a24
  - [net,V2,07/11] net/mlx5: Nack sync reset when SFs are present
    https://git.kernel.org/netdev/net/c/26e42ec7712d
  - [net,V2,08/11] net/mlx5: Prevent flow steering mode changes in switchdev mode
    https://git.kernel.org/netdev/net/c/cf9a8627b9a3
  - [net,V2,09/11] net/mlx5e: Update and set Xon/Xoff upon MTU set
    https://git.kernel.org/netdev/net/c/ceddedc969f0
  - [net,V2,10/11] net/mlx5e: Update and set Xon/Xoff upon port speed set
    https://git.kernel.org/netdev/net/c/d24341740fe4
  - [net,V2,11/11] net/mlx5e: Set local Xoff after FW update
    https://git.kernel.org/netdev/net/c/aca0c31af61e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



