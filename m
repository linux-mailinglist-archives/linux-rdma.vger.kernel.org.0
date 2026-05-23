Return-Path: <linux-rdma+bounces-21187-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CI2E8H3EGoxgAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21187-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:41:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C265BC1F2
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 02:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D65F301C6E9
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 00:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121F51F5842;
	Sat, 23 May 2026 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjqjFLzx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470D1FE471;
	Sat, 23 May 2026 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496800; cv=none; b=NiyEOrn0S93k870JMze+qibyfLNHxfnckxrE4o6Gy7SeSdDFUjW3imgwmDK9csQ73V/zd/qO44OIGTLmsz10vua8wfQWpWMfu8gPAcFIZQpsRB+dbZNFg7qCm10qWYAzaNM20rnJv56P6kVjgX4n+ot+qWpKDTe3WyHwTP+XmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496800; c=relaxed/simple;
	bh=suNveJ2/qCd8PcjtNHTceevirQ9Jgc5FeD9OaM8PKus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ASPsYDU7aJEo9MRPvOI7qGDSeSQnJLNzOMdIWSMNsv8vzh4KslxtcoJsPsrmE5UMgsZZjzx6WZ8YeiXq63+fWR6o30xxj9oT/f2RI7/8JaPechwQK9InNFyio7K4zQfEwZF/XsiQ33AbANqi0t9x8HS6aMntP6gyTO1WmFrwdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjqjFLzx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98DA1F000E9;
	Sat, 23 May 2026 00:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496796;
	bh=/HS56sPbhZsprJXjWSZkZnxJ9H4+zwflumIWS3ATgEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HjqjFLzxYBt1F+XJoWChDq8WG9851VrbbXPyazUXaymeMORqb5i9fwLEzY4lAATwa
	 uCb+/1pG1xuOF89bhXV98RuCQh+zA7EYung6GjGSY5F1WXHG6L6PC0Ddm4h0uzdjKw
	 sFoyYSW99Bx7lf5kLD/wNPu7UNvejOPc1a7FWIdh3tQsF1Vk3l4/gD1C+Hs2DxsGpp
	 jHIy88VKqbZJUBrW0LVOIT4zFqIASrqlKvDGJFBtSUN5oD5iy9M/js+JSBtYipk4Pl
	 Fea8pOHZ5qFLtuDnDQfaThPuoXFGBHKI8nj5WqVD79gKtLSTOO7jPfZCro6A4EYTXo
	 EB0UdRSTSH0Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A6C393100F;
	Sat, 23 May 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: Do not re-initialize smc hashtables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177949680539.1426243.8549979818463783234.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 00:40:05 +0000
References: <20260521145639.10317-1-wintera@linux.ibm.com>
In-Reply-To: <20260521145639.10317-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, pasic@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21187-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C4C265BC1F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 16:56:39 +0200 you wrote:
> INIT_HLIST_HEAD(&smc_v*_hashinfo.ht) are called after smc_nl_init(),
> proto_register() and sock_register(). This can lead to smc_v*_hashinfo.ht
> being reset even though hash entries already exist and are being used,
> possibly resulting in a corrupted list.
> 
> Remove unnecessary and dangerous re-initialisation of smc_v*_hashinfo.ht in
> smc_init(); it is implicitly initialised to zero anyhow. Add
> HLIST_HEAD_INIT to the definitions for clarity.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: Do not re-initialize smc hashtables
    https://git.kernel.org/netdev/net/c/9e4389b00387

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



