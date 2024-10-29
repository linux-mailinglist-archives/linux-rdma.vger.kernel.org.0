Return-Path: <linux-rdma+bounces-5591-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BBD9B3F57
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 01:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C343283563
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D82260C;
	Tue, 29 Oct 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfql4fSw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE751CD2B;
	Tue, 29 Oct 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163026; cv=none; b=UuyjpwMCdk5BcwfrPoRvKRt/XiWAP8AiEoF6JnTL6e6ztSy7T+ajF67ZCYer/R7OhDsNKnYv+kTRtl1Pcly7e4a4pFovafJ0vE1kaa3kQ9S0ruJvnWvcTXgAKC27IQLNiMp+EMqhBBBa0S28sp5OrTt7dv5+7JmxOot2TLX8SHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163026; c=relaxed/simple;
	bh=LC3vPd8Mz0/2fXWJuHDNtycmcAaFSNnXAXue3BfkBBg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nkBjqdP75pvX9Be8ZKJaCXWa6YNZuJVyG5fnnxS+bX4fvEKIwvQfh4q0/ZigdLDBDdz3LlKX/XCBDRou2Vorofg79Tt3rI/5+vN/O8mv0VGrNI1QF4lIKrHAYSxE3NmKbKwjKm7vgWveIEikvN15tcaGcCm1+ovhdrr6eq7nUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mfql4fSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F491C4CEC3;
	Tue, 29 Oct 2024 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730163026;
	bh=LC3vPd8Mz0/2fXWJuHDNtycmcAaFSNnXAXue3BfkBBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mfql4fSwo5gR+WOqmol5EBg5EbeLQh/ZvfbNbn1drfBIqQTYp7MujP5u6EhUfzOcj
	 IvjxtaUnDO8bHC5dqWxtMjOSKBLg/em/TtpI69cVW2EcmpCbndUHtBTixhSJ2CPb3Y
	 q06l4SnluugmcljKUErFlsQ+4HQ15w3E7PAkIOQp2680HERYMVFzQQCbCadecY89BM
	 q3GOvXGROb7GUCEp+/sCwKmZzca7NQZC3jkhUkZHPr5aV1r7MGCWFIWtwyYloV3vwZ
	 bLOhBx4Y0amAUDpARJ/VHWKXqXy1gMzQMlnogOW6GcGI4IF49VFcBzjD9z+xVcL3oq
	 eM7tdMDfl6jYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE452380AC1C;
	Tue, 29 Oct 2024 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 RESEND] net/mlx5: unique names for per device caches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173016303349.228747.4611085482072300116.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 00:50:33 +0000
References: <20241023134146.28448-1-sebott@redhat.com>
In-Reply-To: <20241023134146.28448-1-sebott@redhat.com>
To: Sebastian Ott <sebott@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, parav@nvidia.com, leitao@debian.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 15:41:46 +0200 you wrote:
> Add the device name to the per device kmem_cache names to
> ensure their uniqueness. This fixes warnings like this:
> "kmem_cache of name 'mlx5_fs_fgs' already exists".
> 
> Reviwed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> 
> [...]

Here is the summary with links:
  - [v2,RESEND] net/mlx5: unique names for per device caches
    https://git.kernel.org/netdev/net-next/c/25872a079bbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



