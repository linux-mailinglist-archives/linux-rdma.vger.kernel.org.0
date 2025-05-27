Return-Path: <linux-rdma+bounces-10751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D700AC4C1E
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 12:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F1C189A582
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4C42566DD;
	Tue, 27 May 2025 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTIzfKDZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FB255F3F;
	Tue, 27 May 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748341197; cv=none; b=F9Id5ZaXrnbAUidHU8zbhHx+LBMexKnV5wiNlgVuYlC6Hr5yYKGiLYeQQT+30sJcmPO3iElu/p8XRKa1QqrCajAxOZj0p65Gl7wkRfrMpd7HMdhv03T04GB/YLGjQp+rYKLgMLFESxehuoYIJwWNiHppGwHH6ybfv7UJxdg1M7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748341197; c=relaxed/simple;
	bh=b1HJT/bIb67VvOGRX5n+pSNHAQeQf60Fq1iVf+3ZpNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=keVIHh2m2ucXcn2Vw36YySzlaHRXSQFtJVGImoVBEQgA81tQx6Bo5mhQY+xh3jcI/BQxggyfqxkWLToZ+M0cAXrtO+dWmDVWVJmx+R07F9+j6hBdN1I9tiTUJNT8aZMQj2hBafkEorzP6eLwmjJQPAzy7vEIaAxnKa+LtL8aO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTIzfKDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E999C4CEEF;
	Tue, 27 May 2025 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748341196;
	bh=b1HJT/bIb67VvOGRX5n+pSNHAQeQf60Fq1iVf+3ZpNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RTIzfKDZDa8SVvxxgoC8wJDsIlSm6PxPLtyhNmwiHWto+ulrOm6XEZ01OfQ+0OwIh
	 m2mBM9+mWYXfIm2PgSVPY8/j27M9QqRv83LIGHsflJT6sd5PdU6XE0qXXpc3sBLQIx
	 ZYHUcPUIPKjMgRq/dJllJAkGeUXTamRl2STEsRpqZPAjJ2AwmLXIcODTPZDNWL2MZh
	 kYNs19ciTF53KMn9mkZnWym+WuTk+fJbKL2sIqybAlnUWFdOmgj+xDm5dAuYbnpW2W
	 q48fUoCNUqoDoSKdCmSl2ufn6jnNZh8eXnOdaawcfInT4Y4RWkWVEiuicsRdsOEvWI
	 x62+ylAOvfk6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE43380AAE2;
	Tue, 27 May 2025 10:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5e: Allow setting MAC address of representors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174834123049.1243040.2709055357586136320.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 10:20:30 +0000
References: <1747898036-1121904-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747898036-1121904-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com, mbloch@nvidia.com,
 gal@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 May 2025 10:13:56 +0300 you wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> A representor netdev does not correspond to real hardware that needs to
> be updated when setting the MAC address. The default eth_mac_addr() is
> sufficient for simply updating the netdev's MAC address with validation.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5e: Allow setting MAC address of representors
    https://git.kernel.org/netdev/net-next/c/f95633adc177

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



