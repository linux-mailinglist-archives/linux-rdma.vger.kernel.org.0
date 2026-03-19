Return-Path: <linux-rdma+bounces-18375-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNrgM5Rgu2lujQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18375-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 03:33:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF3B2C5035
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 03:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FA1A31B8EC8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548FD38A299;
	Thu, 19 Mar 2026 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeV65ALh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153AA27979A;
	Thu, 19 Mar 2026 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887442; cv=none; b=Y/URZAFmL/2nxT5YboqVVEWFI0OCcexc3lkhJZNru2pddT3jJuoM6bS7D80aheQAbbRDyxC6bi0aN6dkthBfmOYptYJ1eAVnw7dzrsbFbrelTSCQoT2f4l9dmlLLkROVMn2Pw4EWdGtiPbKrWruhAtfPrYiuyzUb8rZgIOk/5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887442; c=relaxed/simple;
	bh=JKPBBgrsfQgsMKtShfSZXaErvs8LjqErh2tg6cIi8Lc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DVOz8dLt6EvD4AaskOlnm2hWReEwxdaZPZRhkph3KVbfA66EciTesaCklZ9p65URPcAaRe5Ue0r0lajFWfEmpcPn+YI/Y1d2b2+AVXzKPsc8fhGyHitQYW2aqti1hGt/duSFObt2kPoe8w3V+kO9dapBwA325fJtWnoCd9qfZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeV65ALh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1DBC2BC87;
	Thu, 19 Mar 2026 02:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773887441;
	bh=JKPBBgrsfQgsMKtShfSZXaErvs8LjqErh2tg6cIi8Lc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JeV65ALhyOzwzMTW9TUxdKNq1Cqj1lZT03+iyxtoP6m5UBhhcpz15lZ3Ah6+Z+fdy
	 9+CBnw73lpZeQ9lYueFLzUNnezY0BTzvStagtPm5Pt/ekTlgZPDVtpsCdncKLO5oX6
	 FUCZ9qrwSlDyFxFB3xcYvyo75m8NdJu0Cc3eu46PhkfnAMSRQECEAtuQiuH6hB2QJM
	 XpUqhQGEN3v0KZTEmKEk3NQK/SvEx9xQuPKJw1nEBVCYJgK64SnAWZTayGumqKY/uE
	 AebFbU9+X/RGULe0F2omsuF3b5pSNHQesVcOz39b/zoC640DsZrK0PADQmDdvMRmMc
	 J6B2lmaUMqE/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCCE3808200;
	Thu, 19 Mar 2026 02:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2026-03-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388743278.997016.6159278446535538861.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 02:30:32 +0000
References: <20260317075844.12066-1-tariqt@nvidia.com>
In-Reply-To: <20260317075844.12066-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, leon@kernel.org, jgg@ziepe.ca,
 saeedm@nvidia.com, mbloch@nvidia.com, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-18375-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2CF3B2C5035
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 09:58:44 +0200 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2026-03-17
    https://git.kernel.org/netdev/net-next/c/76eea68d5fe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



