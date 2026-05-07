Return-Path: <linux-rdma+bounces-20192-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOKUH5n8/GmxVwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20192-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 22:56:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E18A04EF078
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 22:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95127308BD45
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 20:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0CA339B41;
	Thu,  7 May 2026 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUd9LToE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9B333725;
	Thu,  7 May 2026 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187057; cv=none; b=KLdLkleluQ5KUSm5PgyWYz4brk+o9vMlGwWBqyr6L17aDFzeCpFb9Jdm3cjKqZk8hCAAMqP+NBCwfvMjtnHlizrn1a8Yi4zpdZGD2xCOkPcu2dxtosXUMyIlKUyXHeMDEzcAZw+4XwoNPDqmGb/y5ODZkE6M1eJq05SCnM3vVPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187057; c=relaxed/simple;
	bh=tqrRf3nSFj/j3ZS3Cq6KVwqpX95LO4jkX2QK6Hb2qIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TZYtqlwjsqXTGfPrNjt4c5xzg196Oj8kRMhLUhx2PNR4rfy1NFYRd55QlOfSbD0YpL8dBCQ2ac73wT3Rhyuiu7wSdnqPkqAE5InDCN1nrhfaceSjVVxNnNOPIcgj+/jo8oNH368DanaDQAhNgxR6YgZthjNE1BCfJw7Pj96Q79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUd9LToE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7334EC2BCB2;
	Thu,  7 May 2026 20:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778187057;
	bh=tqrRf3nSFj/j3ZS3Cq6KVwqpX95LO4jkX2QK6Hb2qIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eUd9LToEzFX7AhNctzjdKWu5IX9J51oiDSdHLjMDjnL/CB55FxMw2I8ZvdtqHw003
	 zrwBIpshkJBhzh6+f2Oq2If6NRUgyRuSyH6CNRfxN4SAbFnZ0/N/ovDNVgVuChgtHx
	 mlFh696j6Bw6key4AixeewtkKYzunh8lXpds+93hSJ/pMMS/41RvEosTAbrUq7+Udt
	 f6cLHT2/ya4CT1dz7AP34LU5oQVDXw32r80ibS1f3Hh+gowTnOPnsjDArqxZ6P4kTt
	 u911rZkdv0zpfdvA1nB1GbZjvNuPLFQI03/umgbfXMq9AYtH0UdeCr7WEPDCexYoms
	 VJoFVrNv1I58w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EA9380DBD4;
	Thu,  7 May 2026 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] rdma: Align FRMR pool UAPI names with
 merged
 kernel UAPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177818700630.4157512.14062569798440942116.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 20:50:06 +0000
References: <20260507184609.3439875-1-cmeiohas@nvidia.com>
In-Reply-To: <20260507184609.3439875-1-cmeiohas@nvidia.com>
To: Chiara Meiohas <cmeiohas@nvidia.com>
Cc: leon@kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 michaelgur@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: E18A04EF078
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,networkplumber.org,nvidia.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20192-lists,linux-rdma=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 7 May 2026 21:46:09 +0300 you wrote:
> From: Michael Guralnik <michaelgur@nvidia.com>
> 
> The FRMR pools UAPI merged in kernel v7.0-rc1 commit dbd0472fd7a5
> ("RDMA/nldev: Expose kernel-internal FRMR pools in netlink")
> uses different identifier names than what the iproute2 FRMR pools
> series was developed against.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] rdma: Align FRMR pool UAPI names with merged kernel UAPI
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=87c66f79d8b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



