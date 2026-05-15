Return-Path: <linux-rdma+bounces-20788-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG/JEdh1B2pL4QIAu9opvQ
	(envelope-from <linux-rdma+bounces-20788-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 21:36:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 101AC556F3F
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 21:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D22C13061EA2
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1A413D84;
	Fri, 15 May 2026 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJBAo9Jz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCF413D61;
	Fri, 15 May 2026 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873398; cv=none; b=OzkpZ4dFul99o+Uzk6nv1qsuRuW6t1JRB1zmTXAvKGqW7ufWMHfmSUGthac8bN8z2AUIV7c0BXNd2FkQ+9TjQj/pNegbnh366T0kCD675tB0zHkM+u+mFUi80XWoisdgRhMnwn48y2g9qz3iyBdrmJOGpywlIf1cDEdU/8smp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873398; c=relaxed/simple;
	bh=joDb/8rcMXnErFCCWSLgDu0tYliVVhs9gpThcz/uisc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LeDGkB5LnpipAGA2fqkkgbnvJqerc1QKvzVSWhD9dPgGztjlk4aGUww/65zfoPW58LGhLQEQrzHopyO6PlF6kHuhvR9tuWTJZvMY8spJtW1KM+uf+6BbYbXKp+EPNy6WFaHctQaeXS80PgDd4+sA0FoTOcqTxFDCz0E1zWOnlck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJBAo9Jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143FFC2BCB3;
	Fri, 15 May 2026 19:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778873398;
	bh=joDb/8rcMXnErFCCWSLgDu0tYliVVhs9gpThcz/uisc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dJBAo9Jz9x2igEXixJPRBAem+bsxmDbmJ+rEuweAq6SAKCgLAV5O8JcpCxNSVVWDB
	 NqyRkvVb2XEpIal7+bui7kcikQsqoDr+hJqyFJ2M0lKHHE05x6ZfnLOsJpvecaC/8v
	 6Xe1YypILJPCY8srQqra5szYBNGrt9fbKKrvMzSu3YDuYR3Tf69pfjbtViz766/GyG
	 RBdToBo45W+5OurcIXk/yJMMyiKDzJxS6om8hBX5hx980U6ZN8bFtZqTXspMTLYfd5
	 M6qoKE0BRZgNsFVsgfIABQ0rkHqxBRIUMF0d3le6vBTFVLdS7Tb87ybQ5dbjRcDD7Y
	 m3KOaBoleIg+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398B3930A06;
	Fri, 15 May 2026 19:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/4] Allow rdma dev netns to take a pid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177887341139.127669.4836697961792204536.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 19:30:11 +0000
References: <20260512193412.32019-1-dsahern@kernel.org>
In-Reply-To: <20260512193412.32019-1-dsahern@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, leonro@nvidia.com,
 linux-rdma@vger.kernel.org, dahern@nvidia.com
X-Rspamd-Queue-Id: 101AC556F3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20788-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 12 May 2026 13:34:03 -0600 you wrote:
> From: David Ahern <dahern@nvidia.com>
> 
> Avoid the extra hurdle of creating an entry in /var/run/netns
> and allow the netns argument to be a name or a pid.
> 
> v2
> - update netns_get_fd to handle the pid fallback
> - update devlink code
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/4] namespace: Add fallback to netns by pid
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=d6a1612bacfe
  - [iproute2-next,v2,2/4] iplink: Drop pid fallback code for netns
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=22061a6354c0
  - [iproute2-next,v2,3/4] rdma: Allow netns to be specified by pid
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=2a8b53446ff5
  - [iproute2-next,v2,4/4] devlink: Drop now duplicate pid fallback for netns
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



