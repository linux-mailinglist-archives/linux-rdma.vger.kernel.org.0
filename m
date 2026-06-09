Return-Path: <linux-rdma+bounces-21991-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fo1+OapeJ2oPvQIAu9opvQ
	(envelope-from <linux-rdma+bounces-21991-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 02:30:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934265B585
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 02:30:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kZmvb2R0;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21991-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21991-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC846307B912
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 00:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100F0263F5E;
	Tue,  9 Jun 2026 00:30:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAC25FA05;
	Tue,  9 Jun 2026 00:30:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965012; cv=none; b=AlP6HmHFfYij6hvuFpwvZQOPTqnNQVeVgG7JNPtYvicgauPl3TKDVulCXf1VY6X6aPhjPCRGDOfau25NTdOQFHAz8ApyYHs8L/R9+XmhBQ3lhpYRiX5N1005JqHWdm67pzxUB7I7SuOSA2cucUUgX3E/kWOnZO9GQV36sEpwwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965012; c=relaxed/simple;
	bh=kj2KXnTNNmf6Tzf2kZK47V6quFzLpPcGmpSCmxECHhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cs6qUzjDPWvJMnKEf4ZROVQR/4OjCV8J3UYol+NPV4m/ce7KaaVV1QPEJJy0FysBCdqNGJ3EF11yx2M5d5vO67VFysf9HLtyc44ilKzHZ/tbc8aurnlih4O++O8oskmUmgPo/I8fQ8ug2viHlyM2HvhDv+W33HT7n7J6OcR+zrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZmvb2R0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8401F00893;
	Tue,  9 Jun 2026 00:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965011;
	bh=4ht2oC4CSK5BZkNCmgqpgK5CIHBdLYYHpYT2Hx3ogSg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kZmvb2R0ahBHRiYUiI5I7FRlUm3agM3H1PjErPCGCPBz7JxDjfkcf8xL9rbhJzmzY
	 uFChsfKolNU43MwphKbWK5oGudrPDdKldtjPFydkzRV8GwuaZhko3tZMceGrvu85qK
	 0B3wTX4TSeyIYAvrSd/9nIzx7KxYegYyM14DNHDgOwHNXvoO6dPZbLIssnvG60J/2u
	 BRrLcs3oH2HvZi1JA0jEn9cPwLthh/cRp0snIVla+972BOorT1B59FJhzZWP+pkoU9
	 J1LrEOFRcm3yhCUkNMEI+4PRo2FJkLP8Cs2C/Vl+ckP/sWHt/oE+FZOtMu35u0oT+U
	 v/G3FaPqLkEzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568183812FDA;
	Tue,  9 Jun 2026 00:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096500989.1726280.2088342671692076500.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:30:09 +0000
References: <20260603061044.2055155-1-sangyao@kylinos.cn>
In-Reply-To: <20260603061044.2055155-1-sangyao@kylinos.cn>
To: Yao Sang <sangyao@kylinos.cn>
Cc: tariqt@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
 gustavoars@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21991-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sangyao@kylinos.cn,m:tariqt@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5934265B585

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 14:10:44 +0800 you wrote:
> mlx4_init_user_cqes() fills a scratch buffer with the CQE
> initialization pattern and then copies from that buffer to userspace.
> 
> In the single-copy path, the copy length is array_size(entries,
> cqe_size), but the scratch buffer is allocated with PAGE_SIZE. GCC 10
> does not carry the branch invariant strongly enough through the object
> size checks and falsely triggers __bad_copy_from().
> 
> [...]

Here is the summary with links:
  - [net,v2] net/mlx4: avoid GCC 10 __bad_copy_from() false positive
    https://git.kernel.org/netdev/net/c/2365343f4aad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



