Return-Path: <linux-rdma+bounces-21994-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mKuIG9pzJ2rcxAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21994-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 04:00:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7F065BC84
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 04:00:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Of6NNlln;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21994-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21994-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6AFF302FB40
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6DB362139;
	Tue,  9 Jun 2026 02:00:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE73603DF;
	Tue,  9 Jun 2026 02:00:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970414; cv=none; b=LQO12quXWKUzv6skJOhE+GzomXgkN2hbH2LJpDjinbVwPZCrU2h6Xw9/bkRRkVVn4n/uvJ/78NNRZy9MsROcI2jEzKZ+E9zeKQxdWFy3eLAwzY+6kRaeTbyi2Tl69Fh79wq7+A7zYrCqWX7S6xr9uwqh05lheKTEWsI0GXenDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970414; c=relaxed/simple;
	bh=Nb3syNVUCbIsKR4fOLTg2kYNKY5iyRqf2bzTkYQVfds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bp2mUeH4CsTe9JIhCtF79ZU35pgp7PZmJ5feh24YH8WJ73ORGqenXoiul5USmJylkw9W+Z4IySlAhkdghbCLkizfqduggoVM17zC0RLjU4ca4fRdRB86aGTZeFGeHARXum0g2Ah6AbizeGeb3LeJkqOCHzzOYrL5xWPJ7kXOmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of6NNlln; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734351F00898;
	Tue,  9 Jun 2026 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780970412;
	bh=GuPGsfl+3nepH4XQSbxK+iliY5cP1RFHvLwVMbEza/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Of6NNllnLRODkvrVsS3RQRfgSS0t8VraU+GpoT3pAPlNqnMOTGyF9F7OreXqVldWA
	 tBArmvSRikmvXzoPpMWdTrlHt353KM3qc4u0dMR1aqGnXJNiR8m7SN++Ar436cpqb6
	 kZWZryvTle7bjMZTxCv5hFV0LOshqc2iFubn/81tZPigg76a4fbrKqDoFuwf+my6VM
	 n8whAYGFWg5/Aw6H2BUiG9CROhO7T7+u7pHsBCuDu7KKtjUgta18zr7C5SpuUESwOi
	 grBPgkd5CYBv34tGFJEjlQeOl/W51UN/7wwYpArTndgD2OkcOHc3LGwVY/aHuqI9JM
	 xenqEg9WOOOFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569733822D43;
	Tue,  9 Jun 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX
 xmit
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178097041089.1753037.7766508727996138928.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 02:00:10 +0000
References: <20260604135446.456119-1-tariqt@nvidia.com>
In-Reply-To: <20260604135446.456119-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 saeedm@mellanox.com, tariqt@mellanox.com, maxtram95@gmail.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, dtatulea@nvidia.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21994-lists,linux-rdma=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,iogearbox.net,gmail.com,fomichev.me,nvidia.com,mellanox.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:saeedm@mellanox.com,m:tariqt@mellanox.com,m:maxtram95@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF7F065BC84

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Jun 2026 16:54:46 +0300 you wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> In the XSK branch of mlx5e_xmit_xdp_buff(), when sq->xmit_xdp_frame()
> returns false (e.g. XDPSQ is full), the function returns without
> unmapping the DMA address or freeing the xdp_frame allocated by
> xdp_convert_zc_to_xdp_frame(). The xdpi_fifo push only happens on
> success, so the completion path cannot recover these entries.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX xmit failure
    https://git.kernel.org/netdev/net/c/b69004f5a6ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



