Return-Path: <linux-rdma+bounces-6524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D39F2402
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2024 14:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD19D165132
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2024 13:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBDB189912;
	Sun, 15 Dec 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCwzFEX+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7E14A4D4;
	Sun, 15 Dec 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734267618; cv=none; b=fzFjkFHTJo4RMoQDQN3UfriqKACzVYDVJLMz1tWNo6a1HMW8pxz3+3IKaKIwnQdMMrH0HYEBQ6lMo94rYYaCgg1QLJfRbBK5RbRUlkKhMStv1WL/cku+hYF2kN9c6/nfzSlm8MYZViDfah+3F+Ofb++elW+L3YeEo95j5sb4XDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734267618; c=relaxed/simple;
	bh=ovjTdhdS2ag8ix+fDM+12rd3WwymerQdUPyZV39SyIg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=txIzG5DW6W5piL+at04mQipMAp6yuDpUAuTzPG5xSD84k5vqwz5TF1DBfJZ67TWrjCCCPxzc1x8Z1JlS8q/2GnYtTVK9FjGKRqO2tCQwPpUJoa7p2UMohVXKTXaZAia7qcddJa9zVdexu0U/lSRO/d8oBevpgOfkHREM4vVXQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCwzFEX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5E0C4CECE;
	Sun, 15 Dec 2024 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734267618;
	bh=ovjTdhdS2ag8ix+fDM+12rd3WwymerQdUPyZV39SyIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mCwzFEX+Ay6sXBZmKo9FCmXxdCjVeNhhgWg7sjekJ+f3rPeRV1pfsmdFJplj0Gp+a
	 CCpLUFzQpnox3SGmNRht2Z8lDTDtSDANIbn1uFPzySz+zSqLDOoobzKSXsv4IFkarl
	 NCN7EIdLGK7SI2KPmnsnqV/mY6IvPUUYjzOc3Mqhm2ILzidz4u2jvl8tD8WAPpqEk2
	 Hpa6aMlhZhs1u9/IY8Sfr5NCHpDKYgv/3heXpFXpYFcgYstELmtUv0IqiKtFpBM5cn
	 C/2QfKShFcEcmmdtK2R2ublPc4oUz/9Z01nV90pYK3z1kquc+kDxVufaByk2vk4TIL
	 FJQkM09RoD0Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCA3806656;
	Sun, 15 Dec 2024 13:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/6] several fixes for smc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173426763526.3514004.3994108925591833248.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 13:00:35 +0000
References: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 11 Dec 2024 17:21:15 +0800 you wrote:
> v1 -> v2:
> rewrite patch #2 suggested by Paolo.
> 
> Guangguan Wang (6):
>   net/smc: protect link down work from execute after lgr freed
>   net/smc: check sndbuf_space again after NOSPACE flag is set in
>     smc_poll
>   net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving
>     proposal msg
>   net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when receiving
>     proposal msg
>   net/smc: check smcd_v2_ext_offset when receiving proposal msg
>   net/smc: check return value of sock_recvmsg when draining clc data
> 
> [...]

Here is the summary with links:
  - [net,v2,1/6] net/smc: protect link down work from execute after lgr freed
    https://git.kernel.org/netdev/net/c/2b33eb8f1b3e
  - [net,v2,2/6] net/smc: check sndbuf_space again after NOSPACE flag is set in smc_poll
    https://git.kernel.org/netdev/net/c/679e9ddcf90d
  - [net,v2,3/6] net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving proposal msg
    https://git.kernel.org/netdev/net/c/a29e220d3c8e
  - [net,v2,4/6] net/smc: check v2_ext_offset/eid_cnt/ism_gid_cnt when receiving proposal msg
    https://git.kernel.org/netdev/net/c/7863c9f3d24b
  - [net,v2,5/6] net/smc: check smcd_v2_ext_offset when receiving proposal msg
    https://git.kernel.org/netdev/net/c/9ab332deb671
  - [net,v2,6/6] net/smc: check return value of sock_recvmsg when draining clc data
    https://git.kernel.org/netdev/net/c/c5b8ee5022a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



