Return-Path: <linux-rdma+bounces-1685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA897892448
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 20:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DA41F21866
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 19:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EED13A3FF;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVV3npmS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0B1EEE4;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740633; cv=none; b=Y3AO3jOXTEgQYgdkbMV5ewrZXrVKIo6X4CYShjKv6NdKcjbw3VUuXTgX6iKbaKNUnVKVChX5FkkEdkpv3iXyTc2gQOx0ld+O0FfG7VjD1gKw/ao3DGZC7AyK12+hK3ag1Y2SAycLRM/tO1/Ih8FrgIdrAOgSzW7O5mNPsiyhcTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740633; c=relaxed/simple;
	bh=kASKGM3dFtExpzEE03kTs35TIgPe+csliIufLHzIK04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UqowPDwocud2Wj+bZuOSSys0qv9GjoET7RZzSWGxGa3G6E/OBej94f4wXaAe8vZCZsubIQhZhS6gBt4K1VKYAff947m6odSezcJPV4n1DrxVukivW4s5hRZyS0HxXvAB5WBwYM8kjXxqlhP2jF38ZpDyzoX86MS8xRz258oc/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVV3npmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 293A4C43390;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740633;
	bh=kASKGM3dFtExpzEE03kTs35TIgPe+csliIufLHzIK04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IVV3npmSePL8advnxP77niTJn9r5VWn3Rp+dlR8NGJ9lX2oLIqkoGV+xDPWNxKxDQ
	 Vy1L2g8YCGgRSXrLc/sQkv/2M4J9jxdAA8SAbhGR8ajFTlmfsqHLf0fvOTAPm2dcKv
	 R1fVsKFXQ0PjDCVdjZFjTagXNRerIfdbo2okMOvrjklmOXE9qqZC9SCAN3EPi44fip
	 ZCq07ahttvJ9JoOo07ITMoNBIgDCC6Y+Xv77EcLFfSARbiSqQFxIHg2hw6SwpkmRbP
	 ts7yiXSanAtz/RnbfgXbCMeoFa7uggmPCtKepIwsnK9u0syfJQLIrvmxPSuoFye3BV
	 B+EvADBhn/jTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FC90D2D0EE;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/9] enabled -Wformat-truncation for clang
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174063305.18563.745216419087873927.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:30:33 +0000
References: <20240326223825.4084412-1-arnd@kernel.org>
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: llvm@lists.linux.dev, arnd@arndb.de, dmitry.torokhov@gmail.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, kuba@kernel.org,
 saeedm@nvidia.com, leon@kernel.org, aelior@marvell.com, manishc@marvell.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, luzmaximilian@gmail.com,
 hare@kernel.org, martin.petersen@oracle.com, deller@gmx.de,
 masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
 johannes@sipsolutions.net, perex@perex.cz, tiwai@suse.com,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Mar 2024 23:37:59 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With randconfig build testing, I found only eight files that produce
> warnings with clang when -Wformat-truncation is enabled. This means
> we can just turn it on by default rather than only enabling it for
> "make W=1".
> 
> [...]

Here is the summary with links:
  - [2/9] enetc: avoid truncating error message
    https://git.kernel.org/netdev/net-next/c/9046d581ed58
  - [3/9] qed: avoid truncating work queue length
    https://git.kernel.org/netdev/net-next/c/954fd908f177
  - [4/9] mlx5: avoid truncating error message
    https://git.kernel.org/netdev/net-next/c/b324a960354b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



