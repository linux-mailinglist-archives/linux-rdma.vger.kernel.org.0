Return-Path: <linux-rdma+bounces-14445-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 888A4C525CB
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 14:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66E514F88C4
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEDB306482;
	Wed, 12 Nov 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pVgLXN8a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D7530DD0C
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952161; cv=none; b=MBof2svdXCokzPeHPWu1S4QOM9b94p4pku/N7E5FMEqEvW5O9dbpvuyN/jUIKCBHmQ88TUelaeGwX/2UTzACqASxe21WO1gEdZuURHuVtfqKosjLJtvIi91dmTCPRbFG2yvWV2k/7gg3i/vZturN/by2fax2fOMJ9KlKIS8fx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952161; c=relaxed/simple;
	bh=sENMFaOTiPp3GLzYTCw/evBvLlUpOrcoBJmofrVicTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOKVeOAtv6VneWwICw0EbkOUOrKSSKGLnTNhMm0XLprP3lwtL/HqO+0cqOukf0sc80+ly9ADGVp5IcFOJPiyMGC4LOfmp/3wM4fHYF5QURM/fKojs4xA+i1DuKVgl9/K4uRf+eUhWQre0JAk6eAjrz1d0giuodt/mQyF54uFvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pVgLXN8a; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47755de027eso6032555e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 04:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1762952157; x=1763556957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A80WAQe3AW2nzkVsGi+KVpzdPKIqa6v/ng1l0VNgHGY=;
        b=pVgLXN8aRGDpfIhezKOEuTIT2ntO/rFg+njH5aU5NGXiZV+6GR2uKapRMI5sE65vyW
         eNHPeAhASf5hn5gDw7aAjh8FPgdhy0IK6EVkNLtppcap5kpp3g0F/VKBrc8I+7yjKYqk
         GPNhX+Wnm8AGpwJsjJei18HdXFu8ssX1kVNCtq+5+GJ7BnZL8AYSF/Fcc9RV8DxQCx/e
         E6VAL/OpXJlJZJPG3+EtywGOahkpb5QhkPD2Oyjk1znyKpHKFp/JC1FBKVJVDoSAppP8
         WuZZL4Ewsc8UHd+j37z9e4me28Z2eftTjiO4Y0Ifc5msgYgr6IfMbl6boCLncCyXfoy8
         86Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762952157; x=1763556957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A80WAQe3AW2nzkVsGi+KVpzdPKIqa6v/ng1l0VNgHGY=;
        b=HRWO4AjrC9CkJuEpumCB6z10RR1votj1vkJDHmVmoC5S1GHvv8eViZYdxpOdUmr5Rl
         SYihlQJPidFl8h/RdfEBiV9XesB7/d7fV/lghOqQGV6xzAPZ0e42C8RAscseo4ddfLFT
         aj9z21G94MZqQKoJmaBRFCT9FUbDZZp3pjypJS8UTPikIUPo3kLAkk41BXXEzLRNixch
         DgvC4BkHAOEEPAHi2RKodSt9gtK6iD/0O+zoeHu6sVm6H95g91bbwtnlikRaZf5szGdm
         18bdk6D2YCcCJZBx0Zy/iUnmIXgLNksYUpwMI3CPATkqVq23Jx1cpbuZi1YATf1HjHSk
         DT+g==
X-Forwarded-Encrypted: i=1; AJvYcCW+9LwOBFW2ONnDjwGpMQVARFAEJ+oWDqE0RcrRAKtCy06pw8PJvj/TCaEpW5h50BVc9rmBRRyEm6r2@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0AzleM5dDag5PMf/nprrHVjHYTqt7YDl59T1MNgZOaxAarAL
	0MPhVhRPsqdJWY1lyPyk0qhIwbNW5JDXWaqXa2saPu1gCvXZzAFXkLJGgLmqwyY5sYM=
X-Gm-Gg: ASbGncsK2oQ8pDAFKJQL5C89gu2ghUIod61Hjw5QKqoHRfGCGnpbCw2xkrwDYLHdS3g
	tJRDhBrlkib0Twz7uYVehUka1Y+oLY91yff0nUMd8+OCHTZW3HiuB6rvjr4xEuxgWormhwxbTcG
	K/8RX1HdwVGS+OKaPfIdSJBvHSS8bWu3teQkZdWMIV87/V+noof+yCNhDLF+tK0XoG4WF5e/Ua/
	ezhLP6BWovTPdaBwatJBq6M2OdTMwAAStJ7VFJzhmWlgXrqtBUjHEtkOUjTmcCyRpjRy9UggWpL
	G89jqyE0SPtc5jUdurzijAcAadTzUsTNZVW1XjxWEa1HEN0WV7KonPrOxlKKLy+lBHUE6nByE1Q
	X0RUMIjeW7/+NmICXI5BWRc5HlYx/T4oIzhCvIS1cb09Nsv7+s/vajVec4qnQwsDo66wNyfw5Lq
	Z7Auo5LcpHsJCr/Rf4VaJXRQmGOG+X688u
X-Google-Smtp-Source: AGHT+IGvn5MnDKrsdjSlOwaf4VLanh206hYMee2HJIoWYve/+AkIQGjBhZo9ebky2LIV8M51IDP3QA==
X-Received: by 2002:a05:600c:4593:b0:475:dd7f:f6cd with SMTP id 5b1f17b1804b1-477870b92f6mr27315285e9.35.1762952156890;
        Wed, 12 Nov 2025 04:55:56 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477894d53dcsm10809695e9.14.2025.11.12.04.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 04:55:56 -0800 (PST)
Date: Wed, 12 Nov 2025 13:55:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	Daniel Zahka <daniel.zahka@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Dave Ertman <david.m.ertman@intel.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Message-ID: <rkyncpnstlsg4lt7hl47dly2ps7hbbj344wernpkekyruyo3yh@kpys6k5rmhbp>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
 <20251107204347.4060542-3-daniel.zahka@gmail.com>
 <aQ7f1T1ZFUKRLQRh@x130>
 <jhmdihtp63rblcjiy2pibhnz2sikvbm6bhnkclq3l2ndxgbqbb@e3t23x2x2r46>
 <20251110154643.66d15800@kernel.org>
 <aRKs6jXqSvC3G_R0@x130>
 <cgg6fxjjf6zq6yyzx4njhjmetrlhjgor4lzktwe6nls6rgqd6s@c3abd3ehlzvr>
 <20251111074857.7fdb7e88@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111074857.7fdb7e88@kernel.org>

Tue, Nov 11, 2025 at 04:48:57PM +0100, kuba@kernel.org wrote:
>[stripping some of the bouncy CCs.]
>
>On Tue, 11 Nov 2025 15:39:03 +0100 Jiri Pirko wrote:
>> Tue, Nov 11, 2025 at 04:26:34AM +0100, saeed@kernel.org wrote:
>> >On 10 Nov 15:46, Jakub Kicinski wrote:  
>> >> On Sun, 9 Nov 2025 11:46:37 +0100 Jiri Pirko wrote:  
>> >> > >So, I checked a couple of flows internally, and it seems this allows
>> >> > >some flexibility in the FW to decide later on which mode to pick,
>> >> > >based on other parameters, which practically means
>> >> > >"user has no preference on this param". Driver can only find out
>> >> > >after boot, when it reads the runtime capabilities, but still
>> >> > >this is a bug, by the time the driver reads this (in devlink), the
>> >> > >default value should've already been determined by FW, so FW must
>> >> > >return the actual runtime value. Which can only be one of the following  
>> >> > 
>> >> > I don't think it is correct to expose the "default" as a value.
>> >> > 
>> >> > On read, user should see the configured value, either "full_csum" or
>> >> > "l4_only". Reporting "default" to the user does not make any sense.
>> >> > On write, user should pass either "full_csum" or "l4_only". Why we would
>> >> > ever want to pass "default"?  
>> >> 
>> >> FWIW I agree that this feels a bit odd. Should the default be a flag
>> >> attr? On get flag being present means the value is the FW default (no
>> >> override present). On set passing the flag means user wants to reset
>> >> to FW default (remove override)?
>
>Y'all did not respond to this part, should we assume that what 
>I described is clear and makes sense? I think we should make that
>part of the series, unlike the pending indication.

I agree. The "default" flag sounds good to me.


>
>> >> > Regardless this patch, since this is param to be reflected on fw reboot
>> >> > (permanent cmode), I think it would be nice to expose indication if
>> >> > param value passed to user currently affects the fw, or if it is going
>> >> > to be applied after fw reboot. Perhaps a simple bool attr would do?  
>> >> 
>> >> IIUC we're basically talking about user having no information that
>> >> the update is pending? Could this be done by the core? Core can do
>> >> a ->get prior to calling ->set and if the ->set succeeds and
>> >> cmode != runtime record that the update is pending?
>> >>   
>> >
>> >Could work if on GET driver reads 'current' value from FW, then it should
>> >be simpler if GET != SET then 'pending', one problem though is if SET was
>> >done by external tool or value wasn't applied after reboot, then we loose
>> >that information, but do we care? I think we shouldn't.
>> >  
>> >> That feels very separate from the series tho, there are 3 permanent
>> >> params in mlx5, already. Is there something that makes this one special?  
>> 
>> Agreed. That is why I wrote "regardless this patch". But I think the
>> pending indication is definitelly nice to have.
>
>Yes, I've been wondering why it's missing since the day devlink params
>were added :)

Puzzles me. Nobody probably cared that much :/


>
>> >In mlx5 they all have the same behavior, devlink sets 'next' value, devlink
>> >reads 'next' value. The only special thing about the new param
>> >is that it has a 'device_default' value and when you read that from 'next' it
>> >will always show 'device_default' as the actual value is only
>> >known at run time ,e.g. 'next boot'.
>> >
>> >I think the only valid solution for permanent and drv_init params is to
>> >have 'next' and 'current' values reported by driver on read. Or maybe go just
>> >with  'set' != 'get' then 'pending' as discussed above ?  
>> 
>> Hmm, is it possible to rebind the driver without fw going through
>> next-boot phase? I'm wondering if it wouldn't be safer to have this
>> pending flag set to be responsibility of the driver...
>
>The downside is that drivers may either have bugs or not implement 
>the new feature. So when there's no indication of pending change
>the user will have no idea whether its because there's none or the
>driver simply does not report both. 
>
>My experience implementing the pending FW version in a couple of
>products is that it takes a lot of "discussions" to get FW people 
>to implement this sort of a thing right. mlx5 already has the right 
>FW APIs so we should allow their full use. But I don't think the 
>"what if user change the setting with fwctl", "what if user reloaded
>the driver" corner cases should stop us from trying to get the core
>to implement 99% of the cases right.
>
>FTR I'm not aware of any Meta-internal products having permanent knobs.
>I just don't think we can depend on the random people that submit
>drivers these days to get this right. And devlink users will assume
>that it's Linux that sucks if it doesn't work right, not vendor X.
>
>Long story short I think we can add the reporting of both values via GET
>but I'd definitely still like to see the core trying to do the tracking
>automatically.

I agree with tracking in core, allowing driver to opt-in with pending
flag value if it knows better overriding the core value.


