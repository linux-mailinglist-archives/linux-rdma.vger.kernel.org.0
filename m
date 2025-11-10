Return-Path: <linux-rdma+bounces-14370-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5753C49CEC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 00:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A183AD1B0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 23:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014583043D8;
	Mon, 10 Nov 2025 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP2yrdDG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811D1DE8AE;
	Mon, 10 Nov 2025 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762818406; cv=none; b=G78Lfrd/3ZmONF4M4j+JBaWGvLxY5O+X2ipAjb/ErHsPoXg2+92PiTj6Y0TLB0sINRyUmAW1Td8VthevJIcUQ6tpJp5jc6kH1NU3xSUnq/wvg1XHOuk84cKS9fuZOr1eU2gPH+9dPr0Y+z8fsGU0kTZrDX2RaLME2wakO+BJR4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762818406; c=relaxed/simple;
	bh=4e1bgpUV/iimHsy8hCdENWKdiFeyy00W/2NkO5sEUAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hc1vpq+YHIP7Y6K9fhHX8A5AH0KpARdFzL522+BGIzcq0Jk3oZ8u4ZR3r4SEfU24yDaDp9Z/8SHQEStF6jp/wXKDuIurX25JUSwhZOJs67aup0Sjc/KhbLGyE8/4u8t+SYQynXhPehsl2cuRo4A6fQ+5DXzI7fxm6vK023A39t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP2yrdDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E6FC4CEF5;
	Mon, 10 Nov 2025 23:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762818406;
	bh=4e1bgpUV/iimHsy8hCdENWKdiFeyy00W/2NkO5sEUAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oP2yrdDG0/mUFvFidbKQaKe6gJ9F/49YmJX2dk2zIRQVnLBAUt5Bk09EXUhtxHglT
	 RAHcKDqMcD6UbGffywoOsfuUPYOzyut01P+a224sUF9Q/lCufFp9yx3N1QHe8hHzQ1
	 h1Gcdd3ZW0XNvLVdJLo0EU9+29ceM4l9zpj0MH6jJCfTtB7C1/yevHRx8d/7412s8d
	 I7WAj66CpWa5b2UnoISnNm/NI/L7rkfg3Llh78AlgAm4kaqySG0bWidh4Tqr8v6nCf
	 UIrKMk8d7m0dQaOHa+KAQEtIcdyh5ignOrmz8lLJaeASJcxf/Y4qB4NfmGN21hdN5y
	 KC7cNoFQCREBw==
Date: Mon, 10 Nov 2025 15:46:43 -0800
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
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode
 via devlink params
Message-ID: <20251110154643.66d15800@kernel.org>
In-Reply-To: <jhmdihtp63rblcjiy2pibhnz2sikvbm6bhnkclq3l2ndxgbqbb@e3t23x2x2r46>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
	<20251107204347.4060542-3-daniel.zahka@gmail.com>
	<aQ7f1T1ZFUKRLQRh@x130>
	<jhmdihtp63rblcjiy2pibhnz2sikvbm6bhnkclq3l2ndxgbqbb@e3t23x2x2r46>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Nov 2025 11:46:37 +0100 Jiri Pirko wrote:
> >So, I checked a couple of flows internally, and it seems this allows
> >some flexibility in the FW to decide later on which mode to pick,
> >based on other parameters, which practically means
> >"user has no preference on this param". Driver can only find out
> >after boot, when it reads the runtime capabilities, but still
> >this is a bug, by the time the driver reads this (in devlink), the
> >default value should've already been determined by FW, so FW must
> >return the actual runtime value. Which can only be one of the following  
> 
> I don't think it is correct to expose the "default" as a value.
> 
> On read, user should see the configured value, either "full_csum" or
> "l4_only". Reporting "default" to the user does not make any sense.
> On write, user should pass either "full_csum" or "l4_only". Why we would
> ever want to pass "default"?

FWIW I agree that this feels a bit odd. Should the default be a flag
attr? On get flag being present means the value is the FW default (no
override present). On set passing the flag means user wants to reset
to FW default (remove override)?

> Regardless this patch, since this is param to be reflected on fw reboot
> (permanent cmode), I think it would be nice to expose indication if
> param value passed to user currently affects the fw, or if it is going
> to be applied after fw reboot. Perhaps a simple bool attr would do?

IIUC we're basically talking about user having no information that 
the update is pending? Could this be done by the core? Core can do 
a ->get prior to calling ->set and if the ->set succeeds and 
cmode != runtime record that the update is pending?

That feels very separate from the series tho, there are 3 permanent
params in mlx5, already. Is there something that makes this one special?

