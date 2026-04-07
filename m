Return-Path: <linux-rdma+bounces-19072-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG7eMo1s1GmatwcAu9opvQ
	(envelope-from <linux-rdma+bounces-19072-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 04:31:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FBF3A915B
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 04:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB604302D0B1
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 02:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0E351C18;
	Tue,  7 Apr 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyB9y6I1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5E34F497;
	Tue,  7 Apr 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775529027; cv=none; b=gwu2K/M5PsLgeIyN2lIccKlXHxCzxVE53gVpXLuDNS8GNi/n8RACgbgBG5Wf+FlfE21Mo6CdYotml2vpWAICqKWyEOXLFeJPOyT3f62QD3VSb7iWUHf7NxxiiHpubyvPsTj0UmnUaC9SEEFaHqQmY1VG71/SPhr5G/mh4Sj1doQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775529027; c=relaxed/simple;
	bh=mZ3uY486A1qHU8NVBKPstw2sALiJlVUGNsNBRlP6Usk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qL7hMX8BjPvG+U3qt9UmPoe8uT6pwe7xdCYxYZeVUr0CU/YzAyZQxTRdfrFVgf80Vpa8HL3Naymky7SJjbm4TUGwMOikV0QkaJF+gUVO/LMcIMX2hhEcOemXYOWurbZ3xPqbEP0o26JxA51Tlf/iECvnw4pG9No4BzL3eJk08YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyB9y6I1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347F4C4CEF7;
	Tue,  7 Apr 2026 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775529027;
	bh=mZ3uY486A1qHU8NVBKPstw2sALiJlVUGNsNBRlP6Usk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oyB9y6I1L4XASOJNLu4lqmAwO/TIwqvKhllNeV6NgLL1P5EmZT+VbzAv1gO1QaQym
	 iLCQHndfK6Xs4OYHT7qGcrMcoUKNSVEaSKcomMvnrNSOa0bLtJcuJlfP83OPUOY5Ih
	 qXq3XsHUha8l0c7tTsz9YiM1xpEuB/sA420U6Pap+ECXOEi9smCpBZWRR4IdA1pKJT
	 EKRqE5FeiWMyXtnu8KMYDFu5TQ0rfSOoaXgRTXiTUTfvAfUvN+cUCesBS0rfonP7vY
	 r6opEP99DtAafedUhW8R37QC/G3xk4y/OitadWRJN+YbdDGW+uBekbclA3G/AjwTUh
	 Q+bPYuAp5IB5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E723809A28;
	Tue,  7 Apr 2026 02:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: Update the list of the PCI supported
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552900555.3349888.9239225042307354768.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 02:30:05 +0000
References: <20260403091756.139583-1-tariqt@nvidia.com>
In-Reply-To: <20260403091756.139583-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 michaelgur@nvidia.com, stable@vger.kernel.org, phaddad@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19072-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33FBF3A915B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 3 Apr 2026 12:17:56 +0300 you wrote:
> From: Michael Guralnik <michaelgur@nvidia.com>
> 
> Add the upcoming ConnectX-10 NVLink-C2C device ID to the table of
> supported PCI device IDs.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: Update the list of the PCI supported devices
    https://git.kernel.org/netdev/net/c/a9d4f4f6e65e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



