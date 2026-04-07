Return-Path: <linux-rdma+bounces-19080-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBUqALvv1GkjywcAu9opvQ
	(envelope-from <linux-rdma+bounces-19080-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 13:51:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 541D03ADF3D
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 13:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17564306A1F1
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 11:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5D3A451D;
	Tue,  7 Apr 2026 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II8a75QD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F9303A37;
	Tue,  7 Apr 2026 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562637; cv=none; b=e4+A6nlYCt0pSPBu96aN7Dc/rDsFXSxYd6kYWUB++Mp2rEuKEx32k/DD7tqv1MbVv/N7zwB0Tly47KDKvD+b1OCFRPTH4G8tgh1kE1+hx7wHbeeeI7V2BrhpOpiyRxNkzSHcpTbUbeala7dXp2G60vUq0toyRwkW1n0P27fUjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562637; c=relaxed/simple;
	bh=k/oljhVZdj6guNzWvZmUYNC1Bp3zfCAM5LkEGMzctnQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uUNrNjkrIJX6Mb6E1YZ6vBATG00DeG2haiaSAX2b+gGjUgVJvanbI4esIec7LAMHtwclZ6GupTvi0N9iHrPORUY6NIR5YgmrOH0pSpMnRN77klc4XEC8ZeVI2pdWUQuO6oARYYFjE/bdeDNK515WEi0AaQGKbhiKqYYKFWeI7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II8a75QD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF75C116C6;
	Tue,  7 Apr 2026 11:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775562637;
	bh=k/oljhVZdj6guNzWvZmUYNC1Bp3zfCAM5LkEGMzctnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=II8a75QDuvH0GdnAfa+B3/SHXri77Xso4v8jkDJ3/9eLb5TyN/a/HHmlCnpBVut45
	 6dX0LkhUIvni4teY6MB5TPZrnBD8xlkXVcayCkleFUIdxAIiz58sdf2D502C3mXemq
	 S0u8nc50WuhBqK3tL/bC3KP2Nv2Br2gYHAeeYg4wTrRtPQUaOtc77O0hlKxyy5m4aM
	 rm+vylG1n5AKNutGoBxS1ed5H5M6J6q0LmOJMM2pG32Mc4BC93+XPJZyTMPzKc30vK
	 SJtW+K2dTXAgL60QiQ1i/n6nv7vdffi3RC9fTdBfIp3uLVAHNRJmkTzMOrqoAbpTaq
	 +NVB2o9OYNT1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF0C3809A2A;
	Tue,  7 Apr 2026 11:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/5] net/mlx5e: XDP,
 Add support for multi-packet per page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177556261506.3533890.2896935129697278952.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 11:50:15 +0000
References: <20260403090927.139042-1-tariqt@nvidia.com>
In-Reply-To: <20260403090927.139042-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 dtatulea@nvidia.com, cratiu@nvidia.com, horms@kernel.org,
 jacob.e.keller@intel.com, lkayal@nvidia.com,
 michal.swiatkowski@linux.intel.com, cjubran@nvidia.com, nathan@kernel.org,
 daniel.zahka@gmail.com, rrameshbabu@nvidia.com, raeds@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gal@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19080-lists,linux-rdma=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 541D03ADF3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 3 Apr 2026 12:09:22 +0300 you wrote:
> Hi,
> 
> This series removes the limitation of having one packet per page in XDP
> mode. This has the following implications:
> 
> - XDP in Striding RQ mode can now be used on 64K page systems.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/5] net/mlx5e: XSK, Increase size for chunk_size param
    https://git.kernel.org/netdev/net-next/c/1047e14b44ed
  - [net-next,V2,2/5] net/mlx5e: XDP, Improve dma address calculation of linear part for XDP_TX
    https://git.kernel.org/netdev/net-next/c/833e72645aac
  - [net-next,V2,3/5] net/mlx5e: XDP, Remove stride size limitation
    https://git.kernel.org/netdev/net-next/c/2dfaa0238774
  - [net-next,V2,4/5] net/mlx5e: XDP, Use a single linear page per rq
    https://git.kernel.org/netdev/net-next/c/ebd4ad29cc82
  - [net-next,V2,5/5] net/mlx5e: XDP, Use page fragments for linear data in multibuf-mode
    https://git.kernel.org/netdev/net-next/c/25b8c9b6d731

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



