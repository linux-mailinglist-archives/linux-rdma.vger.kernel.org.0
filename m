Return-Path: <linux-rdma+bounces-14373-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE735C4B2F4
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 03:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCD73B5B03
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 02:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C717346E68;
	Tue, 11 Nov 2025 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN4tl92i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8F346E4A;
	Tue, 11 Nov 2025 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827045; cv=none; b=MxTKC77svrE+8Ajrso9n5ECzBL6NSLL5F3hPPmvUA+OOPLLwabmpe/LgMP19XzLwlzLsBnr0e8UMA1C8ZD/Qa8//IwOPcqmoL/2xqHlTIAmiMo+CHmLuDfKXAtDhDY7M/5p/n95HtRLAV5K8g0sNNW5SJb5aGce15y5/8NEfxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827045; c=relaxed/simple;
	bh=ATzBksBCOTmNeMSA8xlp+L3ecCv2sI/QV4plnPjFfcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bE5gmtfwmLW8uNUN6M+dL1T6SOPcuMxXkwPkkcxnd8HrA6X14oXB9BkO0cg6qOmy4nhVvzbW6j03TuLBU+cgEp2pRKtQasaeRprNQo0ELc7dG2yICtYtF69imtl1+bU3qYZ+3RYc2vANFiZeg0Clf4Qm3U1uVQ0pZr9lUGFNHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN4tl92i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2F0C4CEFB;
	Tue, 11 Nov 2025 02:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762827044;
	bh=ATzBksBCOTmNeMSA8xlp+L3ecCv2sI/QV4plnPjFfcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jN4tl92iVUewXUBBdojgxUzuLY9Hp95hWi84vAgHKQQw7asUc8J8fJznq1oTtZWCh
	 WTPE73heCZqMWqNfsP4JWu6UIK3d20R1yj8jxHiyF18SjuApFKcaf8M95vSii+3Ne4
	 9ZgnNKp78Sown/rT5MD5OUEB1dSIgO69wnu+49PtAgNHgDP7SinubuBHIhrm94WGCG
	 61YUCzXAebYgKbKYzGg2JAwqsQkwehTcMUJivYVaEAWpP01OfeEUsnPyg782uOUuOZ
	 YhHe3gbdxWj9XKRhz6hJvmJGwejz/3Ws/c0fha7YsOSJIT0yLhghoyC5h3+48Wq/wE
	 c3V7AYkEwKYIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF5380CFD7;
	Tue, 11 Nov 2025 02:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/smc: fix mismatch between CLC header and
 proposal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282701549.2852248.13088246510149489093.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 02:10:15 +0000
References: <20251107024029.88753-1-alibuda@linux.alibaba.com>
In-Reply-To: <20251107024029.88753-1-alibuda@linux.alibaba.com>
To: D. Wythe <alibuda@linux.alibaba.com>
Cc: mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
 dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, sidraya@linux.ibm.com, jaka@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Nov 2025 10:40:29 +0800 you wrote:
> The current CLC proposal message construction uses a mix of
> `ini->smc_type_v1/v2` and `pclc_base->hdr.typev1/v2` to decide whether
> to include optional extensions (IPv6 prefix extension for v1, and v2
> extension). This leads to a critical inconsistency: when
> `smc_clc_prfx_set()` fails - for example, in IPv6-only environments with
> only link-local addresses, or when the local IP address and the outgoing
> interface’s network address are not in the same subnet.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/smc: fix mismatch between CLC header and proposal
    https://git.kernel.org/netdev/net/c/ec33f2e5a2d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



