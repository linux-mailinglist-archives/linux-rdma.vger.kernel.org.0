Return-Path: <linux-rdma+bounces-21581-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMvqJ1eIHWrAbQkAu9opvQ
	(envelope-from <linux-rdma+bounces-21581-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 15:25:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4957B620014
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 181C9308F809
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3F23A5439;
	Mon,  1 Jun 2026 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRnlSyrB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB6361667;
	Mon,  1 Jun 2026 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320004; cv=none; b=a4cXtJfLecTTJdNMs6F+p/X+lSwrmEU4cCE/EZv2jWV98qejRl5BeWLRkBu1p4Y75Mpo0GVhpX1xR1hxzi/XToCjPS4SHlPcNwzwkmi84c1bhUa5HWCcIoUgN8cE3s1FWw0ILJeyKXUmuEl7arsu3D+eQk3+leXMki2qo0ZFTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320004; c=relaxed/simple;
	bh=9W2NPKEDU1da2jjyWsGK2j1JtSQDRiYaTlXLHKrAK/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mEqNCHlUBXD2cj9nBIYTRI0CJeYysed1KPteLch4luzH8SkcZ8j5ff4nbU/2riF2UQbkdvUJhMIj2PMnGWsNZ2VWElJufr0lRO8KTbwEHnys5OIgEy2F2Adu7tUke6cRsvD1YBurxrCKPh9c84f4/lzGyMEarFzOC3hz9tH3aQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRnlSyrB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234991F00893;
	Mon,  1 Jun 2026 13:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780320003;
	bh=NwRQuglpCzv2aWAtVxL3KeXU1pHrNihF16osYLcGXpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TRnlSyrB0Nbnkm6pc/WwNlWZPP5pGKJPDQ2Ga214z4/6ciEQy5CqGbQ6df0I1xScU
	 Ril8Gk+OkCKVY+M4apdWotxLVQ38OkdvbPawA8tA6A8JFjT6fBcrXAkrS35FVXpNrT
	 EYOyctfx7Y1F1ZH0izS9t3Lu88SlWuRKSdd1wtFUdXH0IbudgpVTPxp3GH0aO9+dHr
	 sbxbIcehYKbUgkbtiibYOj8GvGwI5RF+/4ipYl+haQP26DrS+JKxJZ7RP8vMxG06Dg
	 YSTxXtr8PFEte2L7nGXkc5FchJ6WzWivBVReilnj7IoTcN9F4CykSZ/KjaFEHePlIB
	 fUMQcSnJrAxWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D396E38119D1;
	Mon,  1 Jun 2026 13:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx5: Reorder completion before putting command entry
 in
 cmd_work_handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178032000565.3675417.3853659741110676431.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 13:20:05 +0000
References: <20260526162932.501584-1-kniv@yandex-team.ru>
In-Reply-To: <20260526162932.501584-1-kniv@yandex-team.ru>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, saeedm@nvidia.com, moshe@nvidia.com,
 agoldberger@nvidia.com, tariqt@nvidia.com, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-21581-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4957B620014
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 May 2026 19:29:32 +0300 you wrote:
> Assuming callback != NULL && !page_queue, cmd_work_handler takes
> command entry with refcnt == 1 from mlx5_cmd_invoke.
> If either semaphore timeout or index allocation error happens,
> it does final cmd_ent_put(ent). To avoid access to freed memory,
> notify slotted completion before cmd_ent_put.
> 
> This is theoretical issue found by Svace static analyser.
> 
> [...]

Here is the summary with links:
  - net/mlx5: Reorder completion before putting command entry in cmd_work_handler
    https://git.kernel.org/netdev/net/c/02896a7fa4cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



