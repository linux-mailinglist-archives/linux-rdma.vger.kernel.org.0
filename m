Return-Path: <linux-rdma+bounces-9663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF779A963C3
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 11:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B303A3077
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554F2566C5;
	Tue, 22 Apr 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTAcr/gJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE9F2586EE;
	Tue, 22 Apr 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313017; cv=none; b=JghLoSNqVI8ajGWxhRG/lrtijtnbY7l7FXzjCbpbwf75dCfyb7mRavdP2JPCosHsdMACO3WHmY86Dszfb5RlvoAQXry45Hx4Lo6714PreCcZNbzvgMe4eyW4YEUVhslOMk6ZuNUgMA8UJrPqGeORsv+z439uEcl/RG4qYtDb5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313017; c=relaxed/simple;
	bh=jH8At2SfPuZmHTg0yL5nlwxNBYfhw+LxJLy97iuYdhE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dc++SXyv7Nx8pCvrTAJCtLHWKpJ0P+nuCD/ylM6iVnDsj8eW2dYYuo4pUiy7lgzIqDiNPdU4YGFDcYZguXE31IfRtEI366lawWMFn3DHvPlxtEeEFk449cS0O1Rxwi80jDU3MajtC14HSS9uQOgippEp5mqhtpJj6fS8n2xqob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTAcr/gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EF9C4CEEA;
	Tue, 22 Apr 2025 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313016;
	bh=jH8At2SfPuZmHTg0yL5nlwxNBYfhw+LxJLy97iuYdhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CTAcr/gJdCJTdZlKktxEL0yQa28Bts9wANoF/1DSJZkwFyX9qoC0EGD5SuUnD+8jr
	 Ht7A8t2Die7Pb6D0lHa6EYMW/mWGGaqIM1RICn8L8fihsLLKmYwG4Fh/WZ18gYttio
	 sEz/+ZKXsJaHdBF8JwF3EYgxaazeEfn9KEUg/L2J7FXjtEdhZRva4GHqVKfKzkMuPI
	 TKnx6qqiYaRMvbT+hifgTzPQ49LOt2rfhYzVs1QhZlX53HeZ8SifSqTxqUXFU+vMdi
	 yP7RczoAF1q4nFO0jA+Ua5Mw8uEdzxcSW43gP3RxQ7AaDBMketqFVGK111m6SPUFX9
	 ti3TbIs0I7/sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCA39D6546;
	Tue, 22 Apr 2025 09:10:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net/mlx5: Fix spelling mistakes in mlx5_core_dbg
 message and comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531305524.1477965.14350667004501439792.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:55 +0000
References: <20250418135703.542722-1-colin.i.king@gmail.com>
In-Reply-To: <20250418135703.542722-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Apr 2025 14:57:03 +0100 you wrote:
> There is a spelling mistake in a mlx5_core_dbg and two spelling mistakes
> in comment blocks. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [next] net/mlx5: Fix spelling mistakes in mlx5_core_dbg message and comments
    https://git.kernel.org/netdev/net-next/c/1e3647321529

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



