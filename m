Return-Path: <linux-rdma+bounces-20537-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOfVDPT0A2rKBAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20537-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:50:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B47B52CFFC
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D98E30C452B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 03:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E87239479F;
	Wed, 13 May 2026 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7DwdxVR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C6C399346;
	Wed, 13 May 2026 03:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643968; cv=none; b=eQmNh17E3DVHV1CEpWxVGJTjJ4Ae8+LPCLrMiNO+AMLj0PuFeov1heD6bn6hd+1/lkphOW9NkQsKJ5cskAyreUuzj4IjWgKahaEU87wq6Q5hA+CnecU0d0NJE2OFIL+7/dKZMwEVa/WdbnCuJGweZRXOC7dBoEQOBHncznUP8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643968; c=relaxed/simple;
	bh=cBzNfESIoIwL0XJB4bSmZHEGSqM7E9hWVahPbhi2bAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JwB3/DLldblOwQpsH/hDTPS9+Qr1cOnDN/zrOcu0MUX+qSBTh7mGrlZObg0BqIZoorMabIyaYAsTWYlRog48eYMa3y/onUyhN5hTLORuMlj8K7kcrP+Js1HlTEmc2M7JfhrtwAR2UjtZXatpeObk3gJSyqdTxx2IkzoOy8b46pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7DwdxVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FF5C2BCFA;
	Wed, 13 May 2026 03:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643968;
	bh=cBzNfESIoIwL0XJB4bSmZHEGSqM7E9hWVahPbhi2bAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L7DwdxVR4NN24rI3/0OoLDhaX1P5TQmYbin08SesHvX0JzxSbHdfot5BDuezRmch5
	 q7DcA9y4VL/+qYtBvZqwDFCyrFzM+ha4WTC5nSP2pj7LnxOsXplUgrCSYg2rM5kp3X
	 TOGnzCBM7jSxI7ciYPOqcNBfvRxc3FZOfeNTvnc3ySPTJOBqgZEHjzJgV9+S5HNlti
	 XN2Dcqpj0GNQPUNRELjNGqejwLJuc8bGAA72abF/VBcAFFF2hpiIhk5ivQXUxl33v7
	 dBuQQQQJlfKAIRYtDkDaWlHVGpS2sumGMEy8TuAxDhQ04JbZtEt+s0Y/UDOucFRHlA
	 GM7R/RRC96GAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEAB3822D60;
	Wed, 13 May 2026 03:45:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: avoid NULL deref of conn->lnk in
 smc_msg_event
 tracepoint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864391404.3173643.11609029182707256473.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:14 +0000
References: <20260510222640.1230720-1-xmei5@asu.edu>
In-Reply-To: <20260510222640.1230720-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, wenjia@linux.ibm.com, sidraya@linux.ibm.com,
 tonylu@linux.alibaba.com, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, bestswngs@gmail.com
X-Rspamd-Queue-Id: 7B47B52CFFC
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
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.alibaba.com,linux.ibm.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20537-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 May 2026 15:26:40 -0700 you wrote:
> The smc_msg_event tracepoint class, shared by smc_tx_sendmsg and
> smc_rx_recvmsg, unconditionally dereferences smc->conn.lnk:
> 
> 	__string(name, smc->conn.lnk->ibname)
> 
> conn->lnk is only set for SMC-R; for SMC-D it is NULL. Other code on
> these paths already handles this (e.g. !conn->lnk in
> SMC_STAT_RMB_TX_SIZE_SMALL()). With the tracepoint enabled, the first
> sendmsg()/recvmsg() on an SMC-D socket crashes:
> 
> [...]

Here is the summary with links:
  - [net] net/smc: avoid NULL deref of conn->lnk in smc_msg_event tracepoint
    https://git.kernel.org/netdev/net/c/7bf563badd37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



