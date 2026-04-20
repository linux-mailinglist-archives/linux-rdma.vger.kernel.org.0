Return-Path: <linux-rdma+bounces-19444-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKgHODKi5mkrzAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19444-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 00:01:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A5B4346C0
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DCB4302D0B9
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0513CFF47;
	Mon, 20 Apr 2026 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btajVv++"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A02274FD0;
	Mon, 20 Apr 2026 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722426; cv=none; b=iFAdQisl5ZEcYdzA6udSoiNYONtd+blP9wNnWbL3LZGYUNHVtfTD3tOZlzlK5AqijdGMmiHFdB4B6V5A9VssL17YSJEwyuP8RCEmuhWF1V1PKAGd7gnD+myY5cg54+D20hgzVG3EuzWl724kh0lfUtXOSgbHz8NndKspQVvqDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722426; c=relaxed/simple;
	bh=oHaDKe4pfNjvvj0Ijcm+SiMZhGHTBipXa16iV4hH07A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cbwqzgpqnhmBb27pq9XFfs8MnLDv08gN3qjInApLRZeoAqJIksYJZ/fju2BlrPis7Blb0z3fburfbmTpxK72CdgZxQKAVzjNb7XsCG/CRSDOu0eTHoSHZwKxtegD+G4JiCM4OqcEMkbE8kX9DrhVWkF/bqHi1cKk9V/cAN0WThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btajVv++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F16EC19425;
	Mon, 20 Apr 2026 22:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722424;
	bh=oHaDKe4pfNjvvj0Ijcm+SiMZhGHTBipXa16iV4hH07A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=btajVv+++pG+ETuXRzn+QGDbq7nIFEpnj9ABNytobsxXw1oKVzcy067+pVpIHP6Nw
	 MBgIfpkOy56Vxc7NOJJtOvs3FoAWYrejOrOp9sdAF4dHNutloI25bABavL/4BVz9XS
	 xgd3E/Kgcj4BaqdE8ukKY3da7mUGVwq1/vpWCvEkL+aIpixCCPsDdCwvipQ4/7FpX3
	 XoAjXpCJ4k9sF/is+IggicpwmdsB2eX3qRPL6E6uy2e9P5y7mqgOhuivoImg9ry3Wv
	 M41in2i92Xif5OGpzcBWcoC81o0QCkd+y1i6UMorA0GTX6YIklqpemVpH1ZSTdW4jd
	 Z+pzo2vkBupGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0313D3930022;
	Mon, 20 Apr 2026 21:59:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net/mlx5: Fix HCA caps leak on notifier init
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177672238865.1802062.5421654335000570916.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 21:59:48 +0000
References: <20260415005022.34764-1-prathameshdeshpande7@gmail.com>
In-Reply-To: <20260415005022.34764-1-prathameshdeshpande7@gmail.com>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: saeedm@nvidia.com, leon@kernel.org, cjubran@nvidia.com, cratiu@nvidia.com,
 tariqt@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19444-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55A5B4346C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Apr 2026 01:49:37 +0100 you wrote:
> mlx5_mdev_init() allocates HCA caps via mlx5_hca_caps_alloc() before
> calling mlx5_notifiers_init(). If notifier initialization fails, the
> error path jumps to err_hca_caps and skips mlx5_hca_caps_free(), leaking
> allocated caps.
> 
> Add a dedicated unwind label for notifier-init failure that frees HCA
> caps before continuing the existing cleanup sequence.
> 
> [...]

Here is the summary with links:
  - [net,v1] net/mlx5: Fix HCA caps leak on notifier init failure
    https://git.kernel.org/netdev/net/c/d03fc81a5795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



