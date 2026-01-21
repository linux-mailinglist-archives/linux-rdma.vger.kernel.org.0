Return-Path: <linux-rdma+bounces-15791-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGhJD3c6cGmgXAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15791-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 03:31:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D574FCB8
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 03:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDBEFBC1DC6
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E02342C98;
	Wed, 21 Jan 2026 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLvm/pDw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2870222582;
	Wed, 21 Jan 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962627; cv=none; b=XHAoh4+Aw27/cgeEVAwaSKnWND0dkhMjtypbicfyMKqVKwn7tOprM8Y7g0SQ1S9xAiQ25ifWiWwMr5/cxPb0x+YmNUFsSjCWyAVB8ORd66IpNzbqwAE4xQXyt8GnNzSEepBwrbL6OEATnuDCHN4TYIXEwadUPZyf6c9DPz9nYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962627; c=relaxed/simple;
	bh=k+TKUc0GuHIF6ay52xPME+n8NJ6l+KMX+dcDoV1zwYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cqIA9PdI81vxr/xN6wvqDGg0vorQf1ExoD9ngvP544824zr5S6hnifvhoBBlK1pAlOwmhQ4iAvU/6TAM5Tm52ox/Dk18+bn7rh4g0sKUyDqkqugOKBl5MT7z6/Z9g4ahdm0vijft3WEUfr91NYIFlwxeJIKbjrk0Ri9Ij6GCii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLvm/pDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732FDC19423;
	Wed, 21 Jan 2026 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768962627;
	bh=k+TKUc0GuHIF6ay52xPME+n8NJ6l+KMX+dcDoV1zwYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pLvm/pDwlgzXSpfVDffw9uzj+IkP4xrcNZdjjzUdCGLXJ1abSoqNFjkFD4jnZM7o1
	 8v3avbwWS/H00VtHBma9uvdXbZ3UqbRKzj9n1tyEt6y7nT/OzWVxV0435VdnZwWLDL
	 8i9x95dcuAE6XvJHE07IwHxEoifw7OYWGUOJrg0Do00VudSv+P6JsIahzlGH2vSfal
	 EdHrIoOqn+4dhlyrhWdkz6gl8zMLKp4jsYIb75b0hqoMCjSDCwMVyNuE4ZmF3LE/in
	 O7M4s6Jpe+RKrsqRaYQc2GfENxojh0PRm4YyCGZgWmPMQyxljZDoYX6QubuJjG7gkh
	 gU2z5oCEoCISw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11BD5380820D;
	Wed, 21 Jan 2026 02:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: remove legacy way to get/set HW
 timestamp config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896262485.696500.7276448637891401906.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:30:24 +0000
References: <20260116062121.1230184-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20260116062121.1230184-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kory.maincent@bootlin.com,
 richardcochran@gmail.com, horms@kernel.org, shuah@kernel.org,
 sdf@fomichev.me, tariqt@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,gmail.com,fomichev.me,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-15791-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 94D574FCB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jan 2026 06:21:20 +0000 you wrote:
> With all drivers converted to use ndo_hwstamp callbacks the legacy way
> can be removed, marking ioctl interface as deprecated.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
> v1 -> v2:
> * added cleanup in Infiniband
> * adjusted documentation to remove mentions of legacy way
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: remove legacy way to get/set HW timestamp config
    https://git.kernel.org/netdev/net-next/c/5062245a5a7f
  - [net-next,v2,2/2] selftests: drv-net: extend HW timestamp test with ioctl
    https://git.kernel.org/netdev/net-next/c/49743f27268f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



