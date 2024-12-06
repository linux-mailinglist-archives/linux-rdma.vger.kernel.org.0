Return-Path: <linux-rdma+bounces-6315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB8C9E679D
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 08:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4271E1885E7E
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 07:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8EF1DE3A0;
	Fri,  6 Dec 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSiGX76S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AE1DE2C3;
	Fri,  6 Dec 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469014; cv=none; b=ioBfQt8dzECMt39epGxC2XACi2h2UeEINFmOQewjHvlj1k3EdqG13IR+APFLnDD+o15boAN3XQHX03e7Wi+xhKaUfskJWw0iq7C9LgHbQY1QtXGCv5vr+kMkTAFF6xhgQxkXLSmeSLkcF/teHHqhL64gLj7PwPaCqlHy1S5BvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469014; c=relaxed/simple;
	bh=+XTZbyRM01pcdgGGUB6XMoxtSZFCtDYjX4YTpkytTAA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PalQ0HmfIIJmwP34/8crZnIUeZIcRO7WmgI7l8yWOGHKCSrx4ym2QKcG9ziG92Q5ZwRJZInwQOyqLsDDyYCyekMdjwlIJnS4GkgejneNIU8QMY6nCGzP31JrRDoSRyxrC1plvxcNjxjUFTHqzS0FSz7k37h+KfsMaACjeN6CBhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSiGX76S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAE5C4CEDD;
	Fri,  6 Dec 2024 07:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733469013;
	bh=+XTZbyRM01pcdgGGUB6XMoxtSZFCtDYjX4YTpkytTAA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BSiGX76SgX02MHHkrnTjKOZRj4AwtihHc6Wp0xjbKAJgu6Ycj1OEOaOrQU/EEoX8e
	 kJO0NZ26kfgcNJSraShGPxwTrEasRmQneTf3ElC0B6HEIoJN1+AZwK6rKyooKEW5bU
	 ct8gPks/UlkzBv/OOl1U38NRbfGkxeRVDrRlpMQb39zt0mtnbFAzoXglCmAKSFO/qf
	 iW/aNutg84cQgY3BSp0kM7NrGCd8/Cjo0VGMmGaz8L/M94oNuqlaAePeaa0Elz8shu
	 aUgOSKkPO85HPo6PIuEoKABn5eOnNhmuQq4XtN9wYQrpKd3ndsq+SotWozSnTioMBp
	 CgbIDn6SW//UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF85380A954;
	Fri,  6 Dec 2024 07:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net/mlx5: DR, prevent potential error pointer
 dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173346902878.2224618.10793227255056593351.git-patchwork-notify@kernel.org>
Date: Fri, 06 Dec 2024 07:10:28 +0000
References: <07477254-e179-43e2-b1b3-3b9db4674195@stanley.mountain>
In-Reply-To: <07477254-e179-43e2-b1b3-3b9db4674195@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: kliteyn@nvidia.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, muhammads@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Dec 2024 15:06:41 +0300 you wrote:
> The dr_domain_add_vport_cap() function generally returns NULL on error
> but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> and if it's and -ENOMEM then the error pointer is propogated back and
> eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().
> 
> Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v3,net] net/mlx5: DR, prevent potential error pointer dereference
    https://git.kernel.org/netdev/net/c/11776cff0b56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



