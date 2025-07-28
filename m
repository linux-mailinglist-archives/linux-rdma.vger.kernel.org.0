Return-Path: <linux-rdma+bounces-12508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B9FB13E07
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29E33B5F23
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9CE26FDB7;
	Mon, 28 Jul 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K16BHBpR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8272621;
	Mon, 28 Jul 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715871; cv=none; b=HNWVoRY2tg73zW99lcSG2JKWrBxBIlB+zxSm7AhwZXrKU/k6F80vG0mdt7btcHx/YXAMZ420JNjqpsSpwwnjgxe4/wO3xytoE1TkL5rLDrqQb7I2Nu7/wyngOA4pzJ5xayQ6gFmtYaAqdjNwDEOSiOy87mu/Kqnzubvfb6pPfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715871; c=relaxed/simple;
	bh=jV727T99qgnh1S0rwWU0da1unCUJvT2tB6hFm2F1/Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAC0SN+PEKGMFzq/P5EFjNlxB3opBixPIcA8nx4ac7904EwJz1ESbprGSQSBHAO3t3u3KMYqSjx2awITL7KAPb6cNaR1mYIXALfY/Eo49JAD75YHG2mipjpHpIp0jJXGdMaN3lBNk8PznVVl+OzggJFCcHDx5VfBZtrGwPPY6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K16BHBpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE4BC4CEE7;
	Mon, 28 Jul 2025 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753715870;
	bh=jV727T99qgnh1S0rwWU0da1unCUJvT2tB6hFm2F1/Mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K16BHBpRBWnNWZUczzVwEQX3lZbsX0KV0ELZ5BY2IxJt2tyDWbAVHAuddklKMUNL/
	 6rM5XsxGlU5XsvyfafnXLhXviqefHfmIhdkVa4KhSUuVBu5LLvJyWlrmzBbYzTNf7r
	 XaagVrZ+xz1j5nWqqz0Dq6TMa69amqwuKHy2tBc7XGfjMAtYeDFAjmIWDDjO9mhs8f
	 emOQG6011CW96Df3b3hpWWoGRNGVqcnLgxD0Zt/1bhC41PEILL3uJxhYqQAlwqsplD
	 h9vYZa57WBkTku3SZbAIM2C6rGXODXfrcZYVUdsjKWFLj1j2csHBKRuMMWkvR4cgjY
	 0VQLmrxuroWWQ==
Date: Mon, 28 Jul 2025 08:17:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
 Jiri Pirko <jiri@nvidia.com>, Saeed Mahameed <saeed@kernel.org>, Gal
 Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shahar
 Shitrit <shshitrit@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Brett Creeley <brett.creeley@amd.com>,
 Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Cai Huoqing <cai.huoqing@linux.dev>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] Expose grace period delay for devlink
 health reporter
Message-ID: <20250728081748.700ad46a@kernel.org>
In-Reply-To: <3bf6714b-46d7-45ad-9d15-f5ce9d4b74e4@gmail.com>
References: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
	<20250718174737.1d1177cd@kernel.org>
	<6892bb46-e2eb-4373-9ac0-6c43eca78b8e@gmail.com>
	<20250724171011.2e8ebca4@kernel.org>
	<3bf6714b-46d7-45ad-9d15-f5ce9d4b74e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Jul 2025 14:00:11 +0300 Tariq Toukan wrote:
> I get your suggestion. I agree that it's also pretty simple to 
> implement, and that it tolerates bursts.
> 
> However, I think it softens the grace period role too much. It has an 
> important disadvantage, as it tolerates non-bursts as well. It lacks the 
> "burstness" distinguishability.
> 
> IMO current grace_period has multiple goals, among them:
> 
> a. let the auto-recovery mechanism handle errors as long as they are 
> followed by some long-enough "healthy" intervals.
> 
> b. break infinite loop of auto-recoveries, when the "healthy" interval 
> is not long enough. Raise a flag to mark the need for admin intervention.
> 
> In your proposal, the above doesn't hold.
> It won't prevent the infinite auto-recovery loop for a buggy system that 
> has a constant rate of up to X failures in N msecs.
> 
> One can argue that this can be addressed by increasing the grace_period. 
> i.e. a current system with grace_period=N is intuitively moved to 
> burst_size=X and grace_period=X*N.
> 
> But increasing the grace_period by such a large factor has 
> over-enforcement and hurts legitimate auto-recoveries.
> 
> Again, the main point is, it lacks the ability to properly distinguish 
> between 1. a "burst" followed by a healthy interval, and 2. a buggy 
> system with a rate of repeated errors.

I suspect this is catching some very mlx5-specific recovery loop,
so I defer to your judgment on what's better.

As a user I do not know how to configure this health recovery stuff.
My intuition would be that we just needs to lower the recovery rate
to prevent filling up logs etc. and the action of taking the machine
out is really the responsibility of some fleet health monitoring daemon.
I can't think of any other error reporting facility in the kernel where
we'd shut down the recovery completely if the rate is high..

> > Now we add something called "grace period delay" in
> > some places in the code referred to as "reporter_delay"..
> > 
> > It may be more palatable if we named the first period "error burst
> > period" and, well, the later I suppose it's too late to rename..  
> It can be named after what it achieves (allows handling of more errors) 
> or what it is (a shift of the grace_period). I'm fine with both, don't 
> have strong preference.

Let's rename to "error burst period", reporter_in_error_burst etc.

> I'd call it grace_period in case we didn't have one already :)

Exactly :)

