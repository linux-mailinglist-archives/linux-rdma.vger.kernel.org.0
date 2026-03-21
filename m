Return-Path: <linux-rdma+bounces-18492-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDa8FCH+vWklFAMAu9opvQ
	(envelope-from <linux-rdma+bounces-18492-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 03:10:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE52E2DDC
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 03:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AFF3304972C
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 02:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0672C2349;
	Sat, 21 Mar 2026 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhqvlaY7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7ED29E10F;
	Sat, 21 Mar 2026 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774059020; cv=none; b=c9L1OepHYiHe5wfJhB6Obho+08JoCYf4k6tFa6XL5Wv8cvpMnfAFvxHOk6elrVJuPgXVHoPZbhlvofhGi/h26rx5OuFGXMBmhNnG5OO8vrixvVHuHrE5iZQpIwqFRkN+CKgJKOubdTxRmOge0s+hZosLo6O3oAqOkYCesH4O5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774059020; c=relaxed/simple;
	bh=FHN+jy/v6exz64De+HYRkHdLnswJzjjJLQOUpXLtf1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kpTd8Zh1DMyzzXkTRLohjvNN2efl3VHjQt6ZyL5IEDSfdrIZR0IA90kYikXguVmGMqxaByMWjHiGzPZUN+jYfQ/F977ROyeyJCu0ZrGsxDDirhSUGlHgXfmeeF9dRP+TSvWLb0BOKxLuqJeaAMqLQyi6flJvaO9EgbCd5Fl2EGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhqvlaY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8513EC2BCAF;
	Sat, 21 Mar 2026 02:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774059020;
	bh=FHN+jy/v6exz64De+HYRkHdLnswJzjjJLQOUpXLtf1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hhqvlaY7jnLRPEf2C+F0LRzML0sz6+YDjY2w785+lroH99zDG3RkXsqtZL5uv1XwJ
	 K/IffWrZSewdOv31QS5ioEmOSdDdcZJ35JaGn8umSlmR9ubJbp8nbRPv4r6fO/250w
	 H7AgJLXwXC5RH/htWeWelyPJf258XYaQLvisTxT6mEszNlIxEXdOm1/hhEPyrEW4+F
	 J0Y9UKyr+BZV/F7JixE7dKyCro08wECOol1x0BrAHHpEDuY0iVKrgwpp3F2dmgq4JA
	 1aE41gZsN5Uzxmk8AQ1+Emq4TfWfSrWz6mkhiHaEt49/F0l79x8rgsWPLrVwQbn9gb
	 BuUybNOnc8vMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F393808200;
	Sat, 21 Mar 2026 02:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix double-free of smc_spd_priv when tee()
 duplicates splice pipe buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405901028.2723214.8587147008267182174.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 02:10:10 +0000
References: <20260318064847.23341-1-tpluszz77@gmail.com>
In-Reply-To: <20260318064847.23341-1-tpluszz77@gmail.com>
To: Qi Tang <tpluszz77@gmail.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-18492-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2CE52E2DDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 14:48:47 +0800 you wrote:
> smc_rx_splice() allocates one smc_spd_priv per pipe_buffer and stores
> the pointer in pipe_buffer.private.  The pipe_buf_operations for these
> buffers used .get = generic_pipe_buf_get, which only increments the page
> reference count when tee(2) duplicates a pipe buffer.  The smc_spd_priv
> pointer itself was not handled, so after tee() both the original and the
> cloned pipe_buffer share the same smc_spd_priv *.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer
    https://git.kernel.org/netdev/net/c/24dd586bb4cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



