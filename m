Return-Path: <linux-rdma+bounces-19517-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOYwNLZz6mlAzgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19517-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 21:32:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B077456D22
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 21:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00382304FF98
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 19:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E72B30B53E;
	Thu, 23 Apr 2026 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaScGOxD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27FE2BE053;
	Thu, 23 Apr 2026 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972645; cv=none; b=UonZSmPQm2EnOwE6ir2I6YrTArW0sI6JRbkNEcSl3pTEEK84iqZMFHfvVQEHt8fMjQiH28DR7bt7nWQrVhT4GeyvQvMfiRjhI21f3ZQL+9D+kPPfVITZa+7i/sXKyKT4+a/CQGHlsgdbagcUxGowK/DGnn6EYZ2WJgfZbh2mSeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972645; c=relaxed/simple;
	bh=wEEzDSvGh4RC49EaRHrMFFS5Pokda4U2Hdmfqzgnm3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LwbrKrXMFN4OABt43XTBaoBK1UzVoJjc1OYvQeK1iYBW4a21M05E/3s23hG8DdjBBQjs6FJTlDd0OobewVeZwUzmYM7u1khrh5gMY25ws4VO/NRpsvhmY1cJcTbRArWv3+iQ8jEMrRHgWJZ9x8/QJRJMYx6eBdsSzr7lv62GCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaScGOxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DA6C2BCAF;
	Thu, 23 Apr 2026 19:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776972644;
	bh=wEEzDSvGh4RC49EaRHrMFFS5Pokda4U2Hdmfqzgnm3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GaScGOxD4HxDBUWJQEMe7sp8xVySbuIO6c2vJEHrUPhWFFdc37IdcarFOQQg/10wI
	 QZ0E55Ejq4ceZ8isrBDv+K5evNevtJObOY0Fk+/2yPMYDTdFk3i1DFWfgCWdLyr/kc
	 TEz/Tmx9f65PNtEvVBjdCNgjH5OObRS8dOTLUnAS+o6n1K0b1K5pqfcqEGR8wWiPUT
	 nAfX4Gx+trl044rPzE0shazF1Jaz+nO3519KU9i1UrAkjS5lIShLNbLpk6MnN6svvN
	 7SM0mEZZHLjVEuCyeXIcGw0im/UnswsmmU4YQINQKljlTPi9KLKZLJMRQ5xoFzRxHI
	 ZdCSVphC7OdpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC483809A90;
	Thu, 23 Apr 2026 19:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: rds: fix MR cleanup on copy error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697260580.733594.2705597671788388088.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 19:30:05 +0000
References: 
 <79c8ef73ec8e5844d71038983940cc2943099baf.1776764247.git.draw51280@163.com>
In-Reply-To: 
 <79c8ef73ec8e5844d71038983940cc2943099baf.1776764247.git.draw51280@163.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, achender@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 leon@kernel.org, santosh.shilimkar@oracle.com, jhubbard@nvidia.com,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, draw51280@163.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.oracle.com,kernel.org,davemloft.net,google.com,redhat.com,oracle.com,nvidia.com,gmail.com,lzu.edu.cn,163.com];
	TAGGED_FROM(0.00)[bounces-19517-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B077456D22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 22:52:07 +0800 you wrote:
> From: Ao Zhou <draw51280@163.com>
> 
> __rds_rdma_map() hands sg/pages ownership to the transport after
> get_mr() succeeds. If copying the generated cookie back to user space
> fails after that point, the error path must not free those resources
> again before dropping the MR reference.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: rds: fix MR cleanup on copy error
    https://git.kernel.org/netdev/net/c/8141a2dc7008

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



