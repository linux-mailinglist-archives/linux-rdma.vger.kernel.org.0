Return-Path: <linux-rdma+bounces-16663-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PXJFDCnhmnHPgQAu9opvQ
	(envelope-from <linux-rdma+bounces-16663-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 03:45:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B642104B22
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 03:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9B75300BC5D
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Feb 2026 02:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D34331A53;
	Sat,  7 Feb 2026 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUKJcntz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44185B21A;
	Sat,  7 Feb 2026 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770432297; cv=none; b=iu6E8TPYwgfXw93AEAk5Cil5HecElTLXalOV24YCDwG6kMAQu3pV2W6EA5Wy1uOkd3Q0+dW4idszjeJ7k6kuo5W1v+N2xg0b+rC+kBZUh7nUqLxGj1Tjl6IvdN/Ov1NKAp8K5Fy4TAmG3y1UknoP2ccv8QsEfkZK7aExT2HUvzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770432297; c=relaxed/simple;
	bh=8n0PeIUOU9EPtDVGJ6Xp3Wu0ihsHM67WoiZUou48kQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWbRzr9iwu1iGGjADycEYX6Q3HGgRUpZk1+/aXXtUVc26/hogadHMr2A15yy8ebyyLPyokpRlwzEZvbClcVILKsd9xNreH9O5u8yLWLwzSxHraYWakbxASL9knHtQrA8It0dTB4pnFPyAQYUZ8ivSAEkMhho5muf2bsFqYDT9fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUKJcntz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1CCC116C6;
	Sat,  7 Feb 2026 02:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770432297;
	bh=8n0PeIUOU9EPtDVGJ6Xp3Wu0ihsHM67WoiZUou48kQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GUKJcntzevb7KwsE/N58rPyn1ZbfzQK2J0w+llxGYUXtAhpA8CI2YpPQ33mrbewJ2
	 64LIVODLLzTcDUSL7yF47tH2kXlSpEj4Ymz75MQkfhcpWA+X10dm+/8Ye/eVb8UrXa
	 Sqk3cgonsLUiungjB4CYjAwjeENV7YQz9Z2XH1F1+bls4HEnn8rX3ua4PliZz2nkJz
	 LU/loLURej4qiaJPS0wVmbSyzM5BWSh5DZ0zekOVxcYR5CDbYcsKQi/cIWNKnS9Qub
	 rC/f1MyYpKRWlx1qVgb7m8HFlMmhySPm1zk8qNP54RfBzZ3AmHvd6e4uNk23hASXZc
	 hrkYCYVSXJXxA==
Date: Fri, 6 Feb 2026 18:44:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: patchwork-bot+netdevbpf@kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 leon@kernel.org, jgg@ziepe.ca, saeedm@nvidia.com, mbloch@nvidia.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, gal@nvidia.com, moshe@nvidia.com,
 ychemla@nvidia.com, shshitrit@nvidia.com, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5: Fix 1600G link mode enum naming
Message-ID: <20260206184456.01f46d4e@kernel.org>
In-Reply-To: <68fe9c87-c8e3-43eb-a40b-4b05267fa236@linux.intel.com>
References: <20260204194324.1723534-1-tariqt@nvidia.com>
	<177034620683.657894.2565367947070195735.git-patchwork-notify@kernel.org>
	<68fe9c87-c8e3-43eb-a40b-4b05267fa236@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16663-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdevbpf,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email]
X-Rspamd-Queue-Id: 6B642104B22
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 11:48:58 +0100 Dawid Osuchowski wrote:
> > Here is the summary with links:
> >    - [net-next] net/mlx5: Fix 1600G link mode enum naming
> >      https://git.kernel.org/netdev/net-next/c/215b53099b60
> > 
> > You are awesome, thank you!  
> 
> Hey Kuba,
> 
> I noticed that in the commit message on the net-next tree the following 
> tags are duplicated:
> 
> Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Yael Chemla <ychemla@nvidia.com>
> 
> Is that by design or did the bot break something? This is purely out of 
> my curiosity.

Oh damn :( This is what patchwork produces:

    Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
    Signed-off-by: Yael Chemla <ychemla@nvidia.com>
    Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
    Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
    Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
    Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
    Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
    Signed-off-by: Yael Chemla <ychemla@nvidia.com>
    Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
    Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
    Signed-off-by: Yael Chemla <ychemla@nvidia.com>

I fixed it up manually but clearly not well enough.

Patchwork needs so much work..

