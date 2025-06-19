Return-Path: <linux-rdma+bounces-11446-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171A5AE0266
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D7E16650A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0439221DB0;
	Thu, 19 Jun 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9zedLJq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CE21E094;
	Thu, 19 Jun 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327779; cv=none; b=VFlyf8XcGbG1f4IeaeDUr6Sn6BDVa4ComOh06Ch6rA155juse/6d/VP+9ztl/aLpVl+pmcUPzv32mQWfgjA3e0f+4HAj971zy/y00A1H1wFzBsaiSSlkdKeTbSNiD3G8xtMvhYzLwwCpi9mBhjHyhTgM6vZaBp+UWUOxmPttYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327779; c=relaxed/simple;
	bh=WLc3BX8dey/TGHqHCL7aDNiX1X6kZBTwKfJj81g4Tk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I4/eUz4NACdeeR6aWzzXS7bxBGmKUGxRDXKXwUKOzdZzime0g3HtaPk4msp5e6ZYzkYX3ekdTc8jjNUEEDM+/USpb03uGFrfIUkRrLNbB8imjD83DTDarNX3x2pNMIx7UtXnTDrhJzP1jBvUoQF31NOl26zURR7HQfhvTYRFfTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9zedLJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F49C4CEEA;
	Thu, 19 Jun 2025 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327777;
	bh=WLc3BX8dey/TGHqHCL7aDNiX1X6kZBTwKfJj81g4Tk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f9zedLJq6aTadbQhi1atWiI9IZxlMZOY830en5m2VxEkXne1REgfIIBdoq3VJId/s
	 Rlq8YS42Q5mv6M7AvVxbyDSe3e+oFtcbSlpeES0RhSYzADxkaE/crsHN8qIHeBcOdH
	 jOXHCULC5Af1Rq+wItubUymxjfjBr++09kANQDOWHyhHsoGnIkWKlqMYHW7O5gYUbQ
	 X8tpsHi/TG4tTTkk8vz5WDs9bhu5uMdIR/pyv9boWYqO68YKUealbkMjL6iLhFD9mj
	 03ld2BdCoNNKz5kZOnmlLTr4MKX0SVQdGSE51P9SMCjjCUqBhlbmUxnvewk2RbdZVu
	 hgJo3DnsHd8vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B953806649;
	Thu, 19 Jun 2025 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx4_en: Remove the redundant NULL check for
 the
 'my_ets' object
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175032780600.443970.13826449946822831786.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 10:10:06 +0000
References: <20250616045034.26000-1-a.vatoropin@crpt.ru>
In-Reply-To: <20250616045034.26000-1-a.vatoropin@crpt.ru>
To: =?utf-8?b?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuSA8YS52YXRvcm9waW5AY3Jw?=@codeaurora.org,
	=?utf-8?b?dC5ydT4=?=@codeaurora.org
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 16 Jun 2025 04:50:44 +0000 you wrote:
> From: Andrey Vatoropin <a.vatoropin@crpt.ru>
> 
> Static analysis shows that pointer "my_ets" cannot be NULL because it
> points to the object "struct ieee_ets".
> 
> Remove the extra NULL check. It is meaningless and harms the readability
> of the code.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx4_en: Remove the redundant NULL check for the 'my_ets' object
    https://git.kernel.org/netdev/net-next/c/f6be1f290c65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



