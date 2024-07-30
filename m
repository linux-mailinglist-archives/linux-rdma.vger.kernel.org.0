Return-Path: <linux-rdma+bounces-4097-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85463940D41
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 11:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBF4B21D03
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3441C194AD5;
	Tue, 30 Jul 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQH/3Orq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA83194AC7;
	Tue, 30 Jul 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331231; cv=none; b=iAxyQ8ZFawTeUUgB+wXr+dynR6dMGfj734cwtGQ8Xs/KRvnEd3HJiVHw9Fof0hRRucoG7P3xVmbFw5BsnoUpedGsEPPBE+2BhyvYQJETlGUO6pOKDqx2U0y7mYnBgsR+kUEUdQmZhFLXgl+A3n1mUq9mK0T6MkcbEFHUI7pWdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331231; c=relaxed/simple;
	bh=fLF5sQv83V6NnRXCX6jYjaT1Mjptt5bNeKmI2unxOjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ouU42Jx7GFLy7eacImVm2EIh10hgLSdX+0ilELJcGXj1AbYgVpNnfn3ZqXa0GuRVXvO47ee72xLw+qsvoDXifzTu6VrTiqo7rFhAHTJUKoiCEObkwzyYc+rWVzlh2rzDhlh/dyzOUSTUtgI27S0ie+darPi4244zYM/UEp0Hv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQH/3Orq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACC85C4AF09;
	Tue, 30 Jul 2024 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722331230;
	bh=fLF5sQv83V6NnRXCX6jYjaT1Mjptt5bNeKmI2unxOjQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nQH/3OrqUP1FQMLOlgZQt5d55MFv8XEEvSUtvO8EnEukHd/AFz5FB0Gy7dd3QYV0c
	 T5xlm41kc/WJ5Fqp4rojrMhrZAYHaVNQ2F7onxSPmLVUu6AJOkmHJIsN4q0aUt8IgF
	 NHSNS75l3GF5DsXIgJgaNy4yWHu7Vl2cmvOQrTWpdqgvSGFbBIK1dxqxo+x4+4Envp
	 TJmc5jJ0OvurO8AskyjOkEhHeVbeAWADVw+ixlg/1eOqxuLncvyXxkkw9/dc76IT27
	 EzdHX9K8szNvX3rbAsreHxsGndERKirJpMnl7FxKm/X4HGxirumI8cvWNZvqNLQ7V+
	 Ts99r02BfEg/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D0B7C43619;
	Tue, 30 Jul 2024 09:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: prevent UAF in inet_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172233123063.27487.10902097539435568908.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 09:20:30 +0000
References: <1722224415-30999-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1722224415-30999-1-git-send-email-alibuda@linux.alibaba.com>
To: D. Wythe <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jul 2024 11:40:15 +0800 you wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Following syzbot repro crashes the kernel:
> 
> socketpair(0x2, 0x1, 0x100, &(0x7f0000000140)) (fail_nth: 13)
> 
> Fix this by not calling sk_common_release() from smc_create_clcsk().
> 
> [...]

Here is the summary with links:
  - [net] net/smc: prevent UAF in inet_create()
    https://git.kernel.org/netdev/net/c/2fe5273f149c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



