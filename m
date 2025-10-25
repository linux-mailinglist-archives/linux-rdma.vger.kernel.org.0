Return-Path: <linux-rdma+bounces-14040-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3199BC088C0
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 04:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 947E14EC32A
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 02:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408CF274658;
	Sat, 25 Oct 2025 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oECC2nf7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12CF271A71;
	Sat, 25 Oct 2025 02:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761358265; cv=none; b=s56vpEVg82thhEGA62FbL9tevL21/qBmi/Izt08S71TcFaDrr+qIvNplIidDOdciohGeN65IbhGTn14milwm3eHXM2QxxN47uFlEoJJnTXOaWeL3Q8nQOKsl8+mbXCBVCfWGcIi0u3sgeDDTvFAntTKSsajKY2rsRR/tnZDwW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761358265; c=relaxed/simple;
	bh=RTw86OBX86kh4PXIEEZj/1gJo7b+gSmdLTy9PZeMkOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rFvM9xnBbq4vy9A5OZ3AGTPsCy1xQIZoebnkBXd4nC64lXsYwBHpMDzdvFhYfnalXxmPAA820SicZDKxrJGi5dJ7zCKSFStG+2l6EP2CbN/hEo7YBRPEHmHCUTZT4OFDY9HR9fPNW1QlcG9CkGv+LOQsmovH4V5/dc3o4/A+HmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oECC2nf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2146C19422;
	Sat, 25 Oct 2025 02:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761358264;
	bh=RTw86OBX86kh4PXIEEZj/1gJo7b+gSmdLTy9PZeMkOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oECC2nf7VMhXmAsokXKnwqlajJVeeUNzZX9S3j94MEc5Mj9TGAFkWtm1uCRAAlhqX
	 PRFq6A+nFYgDoWErlsXMaCMSOCCf3IBAu155MOvGxj9hK2OVaOZ+nXFPb9LHrcZW2B
	 v6xXAHsLyR5o9NSKObwlpF1T/Pusygcxy96cihG8ujmYVakzOYQwXJLZyIscIVY0xU
	 UlQYoe/iXpGfhzpQSy0wPXwqWgTYHCfGpfBg5qPHIGEQs1mp73DadaJrvEa9muGElr
	 hXFGP1PCiHgyFZdVUsnUfseSgbcGhIUR4kotTTXXlWvHlfJt3wjFvOWFtMzPfmZZKy
	 EVRV8KhLjrY2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEF1B380AA59;
	Sat, 25 Oct 2025 02:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] smc: rename smc_find_ism_store_rc to reflect
 broader
 usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176135824449.4124588.179663436214250179.git-patchwork-notify@kernel.org>
Date: Sat, 25 Oct 2025 02:10:44 +0000
References: <20251023020012.69609-1-dust.li@linux.alibaba.com>
In-Reply-To: <20251023020012.69609-1-dust.li@linux.alibaba.com>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: alibuda@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
 mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 10:00:12 +0800 you wrote:
> The function smc_find_ism_store_rc() is used to record the reason
> why a suitable device (either ISM or RDMA) could not be found.
> However, its name suggests it is ISM-specific, which is misleading.
> 
> Rename it to better reflect its actual usage.
> 
> No functional changes.
> 
> [...]

Here is the summary with links:
  - [net-next] smc: rename smc_find_ism_store_rc to reflect broader usage
    https://git.kernel.org/netdev/net-next/c/f0773d0b41b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



