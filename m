Return-Path: <linux-rdma+bounces-13911-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD51ABE5B7E
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 00:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D123A9105
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DCE2E62CF;
	Thu, 16 Oct 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADnXDFgU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAD2E54DB;
	Thu, 16 Oct 2025 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655028; cv=none; b=tw4n/+60ZXxmNbBWhIxHnPLKICVetBH6GrycrnykW5UrzyItINj8tFuczbfN2upqfiW+9AFwV79ImejdGHDpf6WlBEFSQsZMk91rTgNfroaDRc/DUChTTvS/B+6xd4oZzb1O48vyPQhGwRGtedkUQmDjctJ6+DiOANN7v1BSsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655028; c=relaxed/simple;
	bh=LEyjDqt+KSXqFAGgDm/vrhUy0sgGU+mTGvsIjUu/j+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hz845oMoW7ukLF0ZmBu0u26LUwNp3FGDw32upM7SHUzPIb3/S5I+AL3bhOJPdYOnwT3BIpv7Da66ZbKWbxoi1GX/l3WnhA62UyllsKJhXbJuhMcAmwSaMbAqIWTG3nBqhv75icebKSCv60tr/Adr+cjP2NwicBwJQ2kOEzmJ3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADnXDFgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F73C4CEF1;
	Thu, 16 Oct 2025 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655027;
	bh=LEyjDqt+KSXqFAGgDm/vrhUy0sgGU+mTGvsIjUu/j+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ADnXDFgUDvMeJXHX+EGj3/UImc0MkM4/HJLoV7bcjT8vvKRZ/7AoRQMaCeHLWoImp
	 QREZv+HpilkhdhEpxzNoOk/4KktSqe6bcaM7lRe+NgDKfMLUvkEOP7cXdN9dD5ZSuF
	 tSHG9FOAbE0J+Z6x6GxBt37ekt5g05s4dPYSmTJTK1+To6jmuDWzgAv0U9L8qSSbuw
	 9MnHNuurYIaGhKrXERd2tArFwIUEGgzVd+1e5AH+Iyk/I1xmOIzJtCAntMzd2OmsMR
	 yup261zVpyAvLkwdfeYMAVa2IAOES0FmoMa4xXX6atuQnUbM/VXSfRYe7CwSIehOuc
	 xHIFrEih+j9jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC139D0C23;
	Thu, 16 Oct 2025 22:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: psp,
 avoid 'accel' NULL pointer dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065501149.1934842.14113114853264935323.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 22:50:11 +0000
References: <1760511923-890650-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1760511923-890650-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, dtatulea@nvidia.com, cratiu@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 10:05:23 +0300 you wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> The 'accel' parameter of mlx5e_txwqe_build_eseg_csum() and the similar
> 'state' parameter of mlx5e_accel_tx_ids_len() were NULL when called
> from mlx5i_sq_xmit() and were causing kernel panics from that context.
> 
> Fix that by passing in a local empty mlx5e_accel_tx_state variable, thus
> guaranteeing that 'accel' is never NULL. Also remove an unnecessary
> check from mlx5e_tx_wqe_inline_mode().
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: psp, avoid 'accel' NULL pointer dereference
    https://git.kernel.org/netdev/net/c/5348d6312446

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



