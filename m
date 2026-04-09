Return-Path: <linux-rdma+bounces-19144-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI75M9QY12ldKwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19144-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 05:11:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CB03C5F71
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 05:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 366C130166CB
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9D36EAA6;
	Thu,  9 Apr 2026 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U52Z5gYZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A5283C89;
	Thu,  9 Apr 2026 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704268; cv=none; b=dyfXBlnJwl0unJX/Y5UyQZ8H80/F7SzPnJDSYvOC+SCA5cP0myAFjXZrGMiKmFbNL2U7deJ8t0dFLn9MtnPXLTECPmME11GCTV567SfbobkpBMLcF8OMRsoRsqH86uJZCqHkJFQfUn8SSmlBhxx0nfvwPdtE7c+g92Fre6NvA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704268; c=relaxed/simple;
	bh=vhO89C65ftvx49gMiDTfTu64UlsVk0MtZwfzqWwu/SY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NzmXT8ZPbm4FcegNCYvUDsRUX2cFw64b/YTb2g49bexQNnG6m8bKwZM2yEUTdi1P9mGENLehYebX7ukRHK5cwKg3YmDMMcUAw86dc/MYfFJF/y9+K9LCVqlBcIGiY1D9RntrB/oftM4xQrnm56XcCKxRicXGwfSE7LekWtchG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U52Z5gYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52281C19421;
	Thu,  9 Apr 2026 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775704268;
	bh=vhO89C65ftvx49gMiDTfTu64UlsVk0MtZwfzqWwu/SY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U52Z5gYZLbQr3xZbqtBvdfG8lbDCtSkapzDqQ0KNfg2sXHcM+pdygFjz1edaxjrop
	 y+FYpFl8C1vFI6GIMQH+UWPPnmuqTslMMeZnM1rFCaUi5xvDThZ1GI20fBtS2yaxvp
	 dyXW5XJ97JfvU9HONqOr0woLDq6P9eZNbTa0AUjgaaGekWTxdjBlwK9zGSURMnGZ0K
	 AVX5DemHpG1pbfjzT9YjKDZg11yutCOwmPI+pYL1hqDc5Co6Emh5IQi9TgBO3OM7mW
	 kyxVLNM57K7/0GiaTXl0N+TpWdBxpvtaFSR7DUK+0bpN3HJkYrwUNk5ftatTwW3Z9d
	 bg6xFi0gkQB8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FF2393079A;
	Thu,  9 Apr 2026 03:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V5 00/12] devlink: add per-port resource support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570424453.975519.14430257685849148487.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 03:10:44 +0000
References: <20260407194107.148063-1-tariqt@nvidia.com>
In-Reply-To: <20260407194107.148063-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, horms@kernel.org,
 donald.hunter@gmail.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org,
 mbloch@nvidia.com, shuah@kernel.org, matttbe@kernel.org,
 chuck.lever@oracle.com, cjubran@nvidia.com, ohartoov@nvidia.com,
 moshe@nvidia.com, dtatulea@nvidia.com, daniel.zahka@gmail.com,
 shshitrit@nvidia.com, cratiu@nvidia.com, jacob.e.keller@intel.com,
 parav@nvidia.com, ajayachandra@nvidia.com, shayd@nvidia.com, kees@kernel.org,
 danielj@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, gal@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19144-lists,linux-rdma=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93CB03C5F71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 7 Apr 2026 22:40:55 +0300 you wrote:
> Hi,
> 
> This series by Or adds devlink per-port resource support.
> See detailed description by Or below [1].
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,V5,01/12] devlink: Refactor resource functions to be generic
    https://git.kernel.org/netdev/net-next/c/7be3163c49b2
  - [net-next,V5,02/12] devlink: Add port-level resource registration infrastructure
    https://git.kernel.org/netdev/net-next/c/6f38acfed5ed
  - [net-next,V5,03/12] net/mlx5: Register SF resource on PF port representor
    https://git.kernel.org/netdev/net-next/c/4be8326d817e
  - [net-next,V5,04/12] netdevsim: Add devlink port resource registration
    https://git.kernel.org/netdev/net-next/c/085b234b28cc
  - [net-next,V5,05/12] devlink: Add dump support for device-level resources
    https://git.kernel.org/netdev/net-next/c/11636b550eea
  - [net-next,V5,06/12] devlink: Include port resources in resource dump dumpit
    https://git.kernel.org/netdev/net-next/c/810b76394d69
  - [net-next,V5,07/12] devlink: Add port-specific option to resource dump doit
    https://git.kernel.org/netdev/net-next/c/7511ff14f30d
  - [net-next,V5,08/12] selftest: netdevsim: Add devlink port resource doit test
    https://git.kernel.org/netdev/net-next/c/396135377104
  - [net-next,V5,09/12] devlink: Document port-level resources and full dump
    https://git.kernel.org/netdev/net-next/c/170e160a0e7c
  - [net-next,V5,10/12] devlink: Add resource scope filtering to resource dump
    https://git.kernel.org/netdev/net-next/c/1bc45341a6ea
  - [net-next,V5,11/12] selftest: netdevsim: Add resource dump and scope filter test
    https://git.kernel.org/netdev/net-next/c/2a8e91235254
  - [net-next,V5,12/12] devlink: Document resource scope filtering
    https://git.kernel.org/netdev/net-next/c/78c327c1728d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



