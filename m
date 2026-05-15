Return-Path: <linux-rdma+bounces-20743-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJSLJ7hnBmrOjQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20743-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 02:24:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C3547FCD
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 02:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 152E3302FAFA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 00:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD58258EE9;
	Fri, 15 May 2026 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyAsEHwe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86224A06D;
	Fri, 15 May 2026 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804484; cv=none; b=jxa1SHZSqyCotodIdZXVyAwKJ/WU+XZYULT90FmO1OHVmzJ8A7rbp51O3udZ6MWU9ZNgtepupxoXUwl404pKP1MgSV0zCcHNf6qjSfiet+OLXKPI4vfqm3PR6vOyVsig0TZZuR5HiigJm0WV1TvPAFfiMtnqbOVfsveRhL4zo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804484; c=relaxed/simple;
	bh=G9uTTyNzrHQKSAO50UfTasKrmVD+4UC8dZ2+xuUu2r0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oEFv2CjPDqclAJfZmf3InaTRkXhQYlRzVYyuD9fOacBBn6v4/fjb6zjrdwOnpAaTgMBe3WJynB6jpUJwWCHyeun/yawcbrsBqXU1Cc/II+YBjmNusEMTpSLLh769P810Pa5N4lGXB0vnCrOf5lB7uRtidRnEEb7BSwVFL5wsE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyAsEHwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45A1C2BCB3;
	Fri, 15 May 2026 00:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804483;
	bh=G9uTTyNzrHQKSAO50UfTasKrmVD+4UC8dZ2+xuUu2r0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pyAsEHwehiEQDWq51luLRoDRGtxcZufUPS4aWzjBn7ow2VtMziCYCoKE6tOWVsx52
	 XNc062F053Haz8CrZ49XKh31bIkuQ+PxYk89T4iziBhUGi/o6Fzlw7z+NCiFDueYyS
	 1kKS+FFBpMBOnqU18Dp6gcUloWiQ4F71Ofb0RoGZxBpxfYYbmyxTNB6ldGdo5YdZ6D
	 752nx9CGDm6QjGI9D9/1+1uaiUeSUpxQV8l8/pqSnjiyvhVYiCpp9mHHC5BvC1KMCz
	 zyNZ6gSpOVZF9e/TvAUCh7j8P577rpOTl/ySQUhElAePV7hqWeB3T+0u36OJT0HzyL
	 m3+wcrXsBghVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD7939E4DB3;
	Fri, 15 May 2026 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rds: tcp_listen: fix typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880442804.134878.5537971782317134127.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 00:20:28 +0000
References: <20260512215531.1988662-1-avinash.duduskar@gmail.com>
In-Reply-To: <20260512215531.1988662-1-avinash.duduskar@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: netdev@vger.kernel.org, achender@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: A32C3547FCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20743-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 03:25:31 +0530 you wrote:
> Two typos in comments:
> 
> - "reconneect" -> "reconnect" (block comment above
>   rds_tcp_accept_one_path()).
> - "acccepted" -> "accepted" (block comment inside
>   rds_tcp_conn_slots_available()).
> 
> [...]

Here is the summary with links:
  - [net-next] rds: tcp_listen: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/1b2ba91c4505

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



