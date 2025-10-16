Return-Path: <linux-rdma+bounces-13910-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BBABE5B72
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 00:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 194794E3275
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 22:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF72D9ECE;
	Thu, 16 Oct 2025 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBUuZHG8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F68834;
	Thu, 16 Oct 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655025; cv=none; b=hzwdZmipE2+FKL2fh9R7b4mfWbAzgWOe4opUdFaP/485hYZdtlsl6/UMZWtlR4jyiF/Q3X/DYhGSzWDW3IU7233j+X1rwKZyXBDNO5v1y3aXRTyHG4lmQgNqGNVY9hcRt15UEQk254iALhyJap2XtN6M5uKfxRxpS51gb00N8Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655025; c=relaxed/simple;
	bh=Y30PzYE3tUSFUAGRL8A2xsJQQQGFkteVQIJrABahShY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IHZA25Hu8yjJGlqCZH/YrgyL8PUYiKlaXg1o/HqKrgD29qqhRxjsxe2vqqMxb9z2kC2Lg86XWQ3tqmiO3c25xLC8952osDMJIQq+Ev9DhhFLGSpLwe7Vap4WaE7JIY1jIqslpetJ+emYjcro3Ez4vL8qMeoNjqUnzGZM/COoe8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBUuZHG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAF7C4CEF1;
	Thu, 16 Oct 2025 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655024;
	bh=Y30PzYE3tUSFUAGRL8A2xsJQQQGFkteVQIJrABahShY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fBUuZHG8oEtGqKj/57cBfTX2IgUdSoEVFMQaqG1E3bPDFxrwLuGF9Uigv9Bg4ol2P
	 fROxHibKmrPvt6y+0V/CCs5jdN3fc9jVvX7lNfvMOTzFi2RQmo3l5obKTU3kCActbi
	 WnfkZlagN0vBkD6wPyg/K05CaHM7Fl1i0BbQF7L7Pe46wkXWQbh0E1Aq+RcLagQrqP
	 D/pPkdGW7KfMDy+aGml9sSttrZ0Df9fgXVOhnAJ8ggv2ZlMY5p4Hy2OoasLZ7wqLfl
	 qL9OxxPw9zlujHv6+qIQv3M4GhqbnGI11bzFuRh8iuDcCFz1Qq2hAv9hLfgB++IfUn
	 /rb0STeAW+xfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB06839D0C23;
	Thu, 16 Oct 2025 22:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: Return 1 instead of 0 in invalid case in
 mlx5e_mpwrq_umr_entry_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065500875.1934842.18128333206683438556.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 22:50:08 +0000
References: 
 <20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-v1-1-dc186b8819ef@kernel.org>
In-Reply-To: 
 <20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-v1-1-dc186b8819ef@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, patches@lists.linux.dev, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 13:46:49 -0700 you wrote:
> When building with Clang 20 or newer, there are some objtool warnings
> from unexpected fallthroughs to other functions:
> 
>   vmlinux.o: warning: objtool: mlx5e_mpwrq_mtts_per_wqe() falls through to next function mlx5e_mpwrq_max_num_entries()
>   vmlinux.o: warning: objtool: mlx5e_mpwrq_max_log_rq_size() falls through to next function mlx5e_get_linear_rq_headroom()
> 
> LLVM 20 contains an (admittedly problematic [1]) optimization [2] to
> convert divide by zero into the equivalent of __builtin_unreachable(),
> which invokes undefined behavior and destroys code generation when it is
> encountered in a control flow graph.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: Return 1 instead of 0 in invalid case in mlx5e_mpwrq_umr_entry_size()
    https://git.kernel.org/netdev/net/c/aaf043a56881

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



