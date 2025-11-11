Return-Path: <linux-rdma+bounces-14406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 342B2C4EDC1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2388F4EAD68
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D57336A011;
	Tue, 11 Nov 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDuUJTI5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049FD34AAE0;
	Tue, 11 Nov 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876141; cv=none; b=XLw5QO8PM7WBx6NxCXsM7qysulCGROLhTpz0rO7preYEg+9G0V4AXpT8JNPLhsZBfUhX2/IvPlaDadugSkDqzTEbz0YLo2Hirutc8zMWHDJN8u9yaf1QojliWnSGXhnirJO4CQjGjaXl2cHe7ILpulwQFiJaZdYzvdgzFK8he5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876141; c=relaxed/simple;
	bh=Gd488RsUGSpxyLROhr/DeWbJLb69PP0AZLYMgSD5IeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOSr5zJKrDQUQ7NwVn0ZL/wWyrO5120bIt028oXrFcsXez/Egze05TcxQ7x5lZ6ExAdGlIWxhFZqwXQWM3unUqDgYsqtBgsTNeiI2J9Wj/cbvK5kEKC7WzFdfANMTm4CWGFqAJqYc+ridIIbtdliiqoRltE35HuIKHzVuUVfhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDuUJTI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC01C16AAE;
	Tue, 11 Nov 2025 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762876140;
	bh=Gd488RsUGSpxyLROhr/DeWbJLb69PP0AZLYMgSD5IeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QDuUJTI5rcGRBMT8WX8HL0Z8Irit8SyhSKMs6hhQNmT3MJFpqKEPCFRhBHJ0lcXPQ
	 R+KcnFRHHlDqku8Yg/Y3LYomSmAi35QZ57Jyf+SUfECgXj6KvMZGg0qZAxxOY2d9OF
	 ocGwd+Q4E1Zkenr/EQWsFJlrgLqY0fXOYajg8rDKN6qRKFWn7/KFdaucXnYoVvfiD0
	 gl3FZEosbxMS8rga/mc6vUc2hCoFYoYpzqNTJiLCYc23k/Yqfo5zYbcDC1rr2GvjmV
	 GwAQrmp4Y6MGvKYrLy0pMtFLvC78r/cmHbSlVPSHWmYOa4gQJO4ZGjAiZZ5bA7Q10a
	 +onXuhoxqZ2rA==
Date: Tue, 11 Nov 2025 07:48:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, Daniel Zahka
 <daniel.zahka@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Srujana Challa
 <schalla@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Tariq Toukan <tariqt@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Loic Poulain
 <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean
 <olteanv@gmail.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Dave Ertman <david.m.ertman@intel.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode
 via devlink params
Message-ID: <20251111074857.7fdb7e88@kernel.org>
In-Reply-To: <cgg6fxjjf6zq6yyzx4njhjmetrlhjgor4lzktwe6nls6rgqd6s@c3abd3ehlzvr>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
	<20251107204347.4060542-3-daniel.zahka@gmail.com>
	<aQ7f1T1ZFUKRLQRh@x130>
	<jhmdihtp63rblcjiy2pibhnz2sikvbm6bhnkclq3l2ndxgbqbb@e3t23x2x2r46>
	<20251110154643.66d15800@kernel.org>
	<aRKs6jXqSvC3G_R0@x130>
	<cgg6fxjjf6zq6yyzx4njhjmetrlhjgor4lzktwe6nls6rgqd6s@c3abd3ehlzvr>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[stripping some of the bouncy CCs.]

On Tue, 11 Nov 2025 15:39:03 +0100 Jiri Pirko wrote:
> Tue, Nov 11, 2025 at 04:26:34AM +0100, saeed@kernel.org wrote:
> >On 10 Nov 15:46, Jakub Kicinski wrote:  
> >> On Sun, 9 Nov 2025 11:46:37 +0100 Jiri Pirko wrote:  
> >> > >So, I checked a couple of flows internally, and it seems this allows
> >> > >some flexibility in the FW to decide later on which mode to pick,
> >> > >based on other parameters, which practically means
> >> > >"user has no preference on this param". Driver can only find out
> >> > >after boot, when it reads the runtime capabilities, but still
> >> > >this is a bug, by the time the driver reads this (in devlink), the
> >> > >default value should've already been determined by FW, so FW must
> >> > >return the actual runtime value. Which can only be one of the following  
> >> > 
> >> > I don't think it is correct to expose the "default" as a value.
> >> > 
> >> > On read, user should see the configured value, either "full_csum" or
> >> > "l4_only". Reporting "default" to the user does not make any sense.
> >> > On write, user should pass either "full_csum" or "l4_only". Why we would
> >> > ever want to pass "default"?  
> >> 
> >> FWIW I agree that this feels a bit odd. Should the default be a flag
> >> attr? On get flag being present means the value is the FW default (no
> >> override present). On set passing the flag means user wants to reset
> >> to FW default (remove override)?

Y'all did not respond to this part, should we assume that what 
I described is clear and makes sense? I think we should make that
part of the series, unlike the pending indication.

> >> > Regardless this patch, since this is param to be reflected on fw reboot
> >> > (permanent cmode), I think it would be nice to expose indication if
> >> > param value passed to user currently affects the fw, or if it is going
> >> > to be applied after fw reboot. Perhaps a simple bool attr would do?  
> >> 
> >> IIUC we're basically talking about user having no information that
> >> the update is pending? Could this be done by the core? Core can do
> >> a ->get prior to calling ->set and if the ->set succeeds and
> >> cmode != runtime record that the update is pending?
> >>   
> >
> >Could work if on GET driver reads 'current' value from FW, then it should
> >be simpler if GET != SET then 'pending', one problem though is if SET was
> >done by external tool or value wasn't applied after reboot, then we loose
> >that information, but do we care? I think we shouldn't.
> >  
> >> That feels very separate from the series tho, there are 3 permanent
> >> params in mlx5, already. Is there something that makes this one special?  
> 
> Agreed. That is why I wrote "regardless this patch". But I think the
> pending indication is definitelly nice to have.

Yes, I've been wondering why it's missing since the day devlink params
were added :)

> >In mlx5 they all have the same behavior, devlink sets 'next' value, devlink
> >reads 'next' value. The only special thing about the new param
> >is that it has a 'device_default' value and when you read that from 'next' it
> >will always show 'device_default' as the actual value is only
> >known at run time ,e.g. 'next boot'.
> >
> >I think the only valid solution for permanent and drv_init params is to
> >have 'next' and 'current' values reported by driver on read. Or maybe go just
> >with  'set' != 'get' then 'pending' as discussed above ?  
> 
> Hmm, is it possible to rebind the driver without fw going through
> next-boot phase? I'm wondering if it wouldn't be safer to have this
> pending flag set to be responsibility of the driver...

The downside is that drivers may either have bugs or not implement 
the new feature. So when there's no indication of pending change
the user will have no idea whether its because there's none or the
driver simply does not report both. 

My experience implementing the pending FW version in a couple of
products is that it takes a lot of "discussions" to get FW people 
to implement this sort of a thing right. mlx5 already has the right 
FW APIs so we should allow their full use. But I don't think the 
"what if user change the setting with fwctl", "what if user reloaded
the driver" corner cases should stop us from trying to get the core
to implement 99% of the cases right.

FTR I'm not aware of any Meta-internal products having permanent knobs.
I just don't think we can depend on the random people that submit
drivers these days to get this right. And devlink users will assume
that it's Linux that sucks if it doesn't work right, not vendor X.

Long story short I think we can add the reporting of both values via GET
but I'd definitely still like to see the core trying to do the tracking
automatically.

