Return-Path: <linux-rdma+bounces-11261-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E8AD7613
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215DF1885EC3
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110162DFA3F;
	Thu, 12 Jun 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8Zatx+E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A182DFA2F;
	Thu, 12 Jun 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741625; cv=none; b=q/hCh4S9dMzhDYCKUJx13XEPFwSVdeRbPmMg6ok+VEllRCyXKnSOnKD06qP3FHMwKYpfPxyxrUuGx1vurBAe3ExcjVhA3uVf9UDvoHP8TXBIZvPkjS2JiCAihKkLzAB9H9e0HQPeVnC7aUxEc2XB8Uwy4TYMhIe+0XDRImFPs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741625; c=relaxed/simple;
	bh=ohaM//YlfVRwFhoaU5seQ2zQya1SsMLpsL7jIG2uzMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XByWcz81vtwRzZOZz2M2ViLZQm6BJgLANyY9swUMdeOxINUXzAHpgwyI+h58YGR8h7JTggWDxLRmXr9FVrcJpQpIOz3pLm3r+uZSxFoabHWFebdI2hwjdfTS3J968lYXKP5CTp6cYwMejHURtRg9F68ZG1AuMNlRGr6S9IWKF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8Zatx+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A50C4CEEA;
	Thu, 12 Jun 2025 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741625;
	bh=ohaM//YlfVRwFhoaU5seQ2zQya1SsMLpsL7jIG2uzMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I8Zatx+E3gUhVhnMfLIlexkwthMcILemqJgU7RRCAf5wXXpWlQLUq9jlkjla9LJbE
	 PGn6VD3+1H+Fz4H6cFCD/DObdJFze3u6XeQoentvcq2wUZ31UiVtQQKI2atiuZC492
	 FCvWCk4bCEl2KH3RkxLtZ2svG2z7zq7oqmWUavi00pFnRKqOSihYv8Qh8YIqMgDYXv
	 YfMeDAoSwLDhKjvy/NL7dk+FscV4Vz45ImFHUU74Z4FLUovLC47sZ0O1fGWyZU0SUd
	 zSTGodEYFQnkSvSIM++3b/+NGK4jX/YmlJGQ/5DVhIBnLO2x/pW6KbASOkPm7ro82h
	 8iOvrU88vPnwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8939EFFCF;
	Thu, 12 Jun 2025 15:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/mlx5: HWS, Add error checking to
 hws_bwc_rule_complex_hash_node_get()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974165549.4177214.8588898310621902880.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:20:55 +0000
References: <aEmBONjyiF6z5yCV@stanley.mountain>
In-Reply-To: <aEmBONjyiF6z5yCV@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: kliteyn@nvidia.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, cratiu@nvidia.com, mbloch@nvidia.com,
 vdogaru@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 16:14:32 +0300 you wrote:
> Check for if ida_alloc() or rhashtable_lookup_get_insert_fast() fails.
> 
> Fixes: 17e0accac577 ("net/mlx5: HWS, support complex matchers")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: Add error checking for ida_alloc() and add cleanup.
> 
> [...]

Here is the summary with links:
  - [v2,net] net/mlx5: HWS, Add error checking to hws_bwc_rule_complex_hash_node_get()
    https://git.kernel.org/netdev/net/c/1619bdf4389c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



