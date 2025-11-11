Return-Path: <linux-rdma+bounces-14377-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DC1C4B569
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 04:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31641891242
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 03:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DE1347FEC;
	Tue, 11 Nov 2025 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbJY+8Ou"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BB313526;
	Tue, 11 Nov 2025 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762832082; cv=none; b=G62nFeM9K42yusM1avXNCVbkMKRvd7Ke7aCxdqrrB7mK3eaX16qxwuJYprIsNJFA3P9gSgKB2n2GAcYbJRWU4X6jOfdO/PMP/pyU/B5l4uXd/KutdHji7eGSXFtVKkAaxeFm46pRom96oE/0a6OJbAwow1PkamemvJw5qRORXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762832082; c=relaxed/simple;
	bh=rl4quI5CP3hR4drgVFblTgTJWg1WQ4rTS/8XInVRBRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uB5PqkXGXLZdHiCrzrDTupqyOqy6Rs+HTanCdDC61dIyjJWvWYklPLXdvO8OM6bITBgOjFFLWNJlFDqQ6v6LewXPXCxgF2SB4i19PQZrJ/82xdonb5N+46Mw8dpeBKIdIv4j0R77RbuwlSibgvScJpOE98yVM0LUMrNy5cdFA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbJY+8Ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2054FC16AAE;
	Tue, 11 Nov 2025 03:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762832082;
	bh=rl4quI5CP3hR4drgVFblTgTJWg1WQ4rTS/8XInVRBRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbJY+8OuCVAtsk/Qd+DQWuoyHMS9NkjdFKRoJpxSnvZSQFA/3FKgriuCuQ1hTdk6Z
	 VjuCJv1ZBON+kwFu3S0k4zhP38utHIs06bxZk/JxbAL4MgY4WZ0b0K66OKFnUgq+Y8
	 na1I/6IureNbUb3dwmULna0Fv/98r43yq4TloLeCSGlwnK6LXR8Ab2BJu7lVc8lFno
	 wtCf1NiGMqYg2vS4c9AvQiH0rVaCy3zm03oauR/L3PhKsqwYnqFnrGy9EZ8rIKpYJc
	 dh1MzY663AuvvZCqkzxOkymtEHga8UogMw9P81gLVBAMYDeOTuCflwVQRDTzh9isAq
	 sc2+TiU77i4ig==
Date: Mon, 10 Nov 2025 19:34:40 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Message-ID: <aRKu0Iknk0jftv2Z@x130>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
 <20251107204347.4060542-3-daniel.zahka@gmail.com>
 <aQ7f1T1ZFUKRLQRh@x130>
 <20251110150133.04a2e905@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251110150133.04a2e905@kernel.org>

On 10 Nov 15:01, Jakub Kicinski wrote:
>On Fri, 7 Nov 2025 22:14:45 -0800 Saeed Mahameed wrote:
>> >+	err = mlx5_nv_param_read_sw_accelerate_conf(dev, mnvda, sizeof(mnvda));
>> >+	if (err) {
>> >+		NL_SET_ERR_MSG_MOD(extack,
>> >+				   "Failed to read sw_accelerate_conf mnvda reg");
>>
>> Plug in the err, NL_SET_ERR_MSG_FMT_MOD(.., .., err);
>> other locations as well.
>
>Incorrect. extack should basically be passed to perror()
>IOW user space will add strerror(errno) after, anyway.
>Adding the errno inside the string is pointless and ugly.

ernno set by stack. err set by driver. we can't assume err will propagate
to errno, this is up to the stack.

And not at all ugly, very useful debug hint to the user, unless you
guarantee err == errno.



