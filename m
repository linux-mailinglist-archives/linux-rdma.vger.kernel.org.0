Return-Path: <linux-rdma+bounces-14376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F3C4B506
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 04:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0545F1885E78
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 03:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7993491D4;
	Tue, 11 Nov 2025 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arA+s8Lc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6D303CB4;
	Tue, 11 Nov 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831596; cv=none; b=qEq8VJH4C4KoVsZ8saLYPHUEzy9GOY+4HR+hi8msBtlKG1XLHUJe3FayQ9O43ymx4BhaxIZpkLLEdH//DOzBp9QmDD/wCi+tUJreLIk+UWiwa6a8HO+9tyVkxQu9z0nYUtuZNnh4upc6ZMAcWeWprw049ZpBx7IDFHy0tWJ7AkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831596; c=relaxed/simple;
	bh=SF8ejBUx63BEWVbo35HrIhmuFlhum3NF91vPz7W/S9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZM6UNWBKH0FlF2NIi3btEZG+m5MDLhQNAVCRVpYLgwKotyyjQJtzA4gdIjzsebNpTFgikf/oElWGeaSdhLZ2ps8C0tkLieqvI44BAnalS5A8mbfKZmg+KrNj24EnRIEf1d+sgH/iGD4q1cHNbwUm9MiZVm2mJcVlqPc311xI9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arA+s8Lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37601C4CEF5;
	Tue, 11 Nov 2025 03:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762831596;
	bh=SF8ejBUx63BEWVbo35HrIhmuFlhum3NF91vPz7W/S9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arA+s8Lck9ZMVhIL7OYtfs+oWUJRLcttj4EpE7KRk7v1UFN/ft+8fCUgtsMc9gd76
	 xbz4H/FDW92jLwUvPHG1/WqhhK/z+mVldQc2od6H+BtjiQB5JxvQ4gM5lD1vbzg+pb
	 OIGUaErFPL8HlyvrJVGOJSgG6krBoN0V6JHOlVSp76LaFGEO6EWU5piCu0OvjblFrG
	 F1/jjUCtMmVj/39yjWouTOw7gaRBlyA5oyUIXix6w4uHaltQIts5/VuBnRuBzJrWIH
	 Cq/wXocuXrdrwYG9qhGNsItJ2oZ+mWg1KHT70AM/kbW2xbJC2oehFU+RZ7t/XXG9uM
	 4U13e4tZIDmyA==
Date: Mon, 10 Nov 2025 19:26:34 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Daniel Zahka <daniel.zahka@gmail.com>,
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
Message-ID: <aRKs6jXqSvC3G_R0@x130>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
 <20251107204347.4060542-3-daniel.zahka@gmail.com>
 <aQ7f1T1ZFUKRLQRh@x130>
 <jhmdihtp63rblcjiy2pibhnz2sikvbm6bhnkclq3l2ndxgbqbb@e3t23x2x2r46>
 <20251110154643.66d15800@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251110154643.66d15800@kernel.org>

On 10 Nov 15:46, Jakub Kicinski wrote:
>On Sun, 9 Nov 2025 11:46:37 +0100 Jiri Pirko wrote:
>> >So, I checked a couple of flows internally, and it seems this allows
>> >some flexibility in the FW to decide later on which mode to pick,
>> >based on other parameters, which practically means
>> >"user has no preference on this param". Driver can only find out
>> >after boot, when it reads the runtime capabilities, but still
>> >this is a bug, by the time the driver reads this (in devlink), the
>> >default value should've already been determined by FW, so FW must
>> >return the actual runtime value. Which can only be one of the following
>>
>> I don't think it is correct to expose the "default" as a value.
>>
>> On read, user should see the configured value, either "full_csum" or
>> "l4_only". Reporting "default" to the user does not make any sense.
>> On write, user should pass either "full_csum" or "l4_only". Why we would
>> ever want to pass "default"?
>
>FWIW I agree that this feels a bit odd. Should the default be a flag
>attr? On get flag being present means the value is the FW default (no
>override present). On set passing the flag means user wants to reset
>to FW default (remove override)?
>
>> Regardless this patch, since this is param to be reflected on fw reboot
>> (permanent cmode), I think it would be nice to expose indication if
>> param value passed to user currently affects the fw, or if it is going
>> to be applied after fw reboot. Perhaps a simple bool attr would do?
>
>IIUC we're basically talking about user having no information that
>the update is pending? Could this be done by the core? Core can do
>a ->get prior to calling ->set and if the ->set succeeds and
>cmode != runtime record that the update is pending?
>

Could work if on GET driver reads 'current' value from FW, then it should
be simpler if GET != SET then 'pending', one problem though is if SET was
done by external tool or value wasn't applied after reboot, then we loose
that information, but do we care? I think we shouldn't.

>That feels very separate from the series tho, there are 3 permanent
>params in mlx5, already. Is there something that makes this one special?

In mlx5 they all have the same behavior, devlink sets 'next' value, 
devlink reads 'next' value. The only special thing about the new param
is that it has a 'device_default' value and when you read that from 
'next' it will always show 'device_default' as the actual value is only
known at run time ,e.g. 'next boot'.

I think the only valid solution for permanent and drv_init params is to
have 'next' and 'current' values reported by driver on read. 
Or maybe go just with  'set' != 'get' then 'pending' as discussed above ?


