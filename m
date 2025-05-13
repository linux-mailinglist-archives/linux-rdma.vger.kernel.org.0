Return-Path: <linux-rdma+bounces-10310-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B1AB48BA
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 03:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124CD467355
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C693A17A306;
	Tue, 13 May 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoQMBtBh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF0EEA6;
	Tue, 13 May 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747099203; cv=none; b=r943ViiMW99QtCbvY8KMDE9NHsEJm0vFXE5mFpTyz4ZTzGScf8YFj+90dr/s7KXNNGB4dv+22WwiL+3LTOrLyHzmlBPJZsMNHLWaAXgXIgpDCx5L3iWe9NyAvCtZ03foLcd7DLybxNaei+fjBN6/mdoVj/DGDdaachmUrtJOipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747099203; c=relaxed/simple;
	bh=cuIZKzEcq7ypcPWdlS2jPEZ9kghqs5BsLdljXN9FrfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TX3F6Fl4n9uk1EK6sUp4EMPRkOyNEiTsxwYY/xpfcqn85cvgW1D3Z7ENX2VgF7GP/DKhQntK4SzBKfuoNuURr5GFI2NE2e1B0ny9qiuLxfr6G6+GgTFz4YH8UsXgt9phJlY6cMFsNB8U3yIUyTrtqbRNjGWdfko+WAPlO9JQ/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoQMBtBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB79BC4CEE7;
	Tue, 13 May 2025 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747099202;
	bh=cuIZKzEcq7ypcPWdlS2jPEZ9kghqs5BsLdljXN9FrfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aoQMBtBhrin1VgdQTSLYsOb50+J4nT6E+iSsf+4YNE7+GMTJB2usE0bPfH/OO9Q6s
	 oi5axLm/F+qnCs66nLcOsKchh8QmhYr1pRMq7SXwRax0GaiRMwChbskbCX1m3AE9cA
	 m6wMtXB59rlzDvv+M7TfdTIF/bBCLg3ksyxi6GNZYDaxmntcBn1SIdwU653ls2dSuk
	 vLWaWrXFR/uH99dH6WIobr98BY1lVGmOVd8KamlASrz/qAwsWaCk280JZwtlwR2UdF
	 VdRyjHpyUoA0bvrYAgmobNQpGx3/fjJY0PKAiPDhFGPNzz3kFpSqxLx6TObD9O1ZYT
	 hI6sL9jgI1UCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0439D60BA;
	Tue, 13 May 2025 01:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/mlx5: support software TX timestamp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174709924051.1134434.3136276821026297312.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 01:20:40 +0000
References: <20250508235109.585096-1-stfomichev@gmail.com>
In-Reply-To: <20250508235109.585096-1-stfomichev@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, leon@kernel.org, kerneljasonxing@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 16:51:09 -0700 you wrote:
> Having a software timestamp (along with existing hardware one) is
> useful to trace how the packets flow through the stack.
> mlx5e_tx_skb_update_hwts_flags is called from tx paths
> to setup HW timestamp; extend it to add software one as well.
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/mlx5: support software TX timestamp
    https://git.kernel.org/netdev/net-next/c/2451d3fb388f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



