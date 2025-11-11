Return-Path: <linux-rdma+bounces-14401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5CCC4E8FE
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 15:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F2B74F433C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9DB33E36E;
	Tue, 11 Nov 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zydxsuLt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C133BBA2
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871954; cv=none; b=lkRCBxklz/DMwKR3aPiEUPUCGmgG9Kqx6qlUzQ2RrX5nAk99mWq1nCGOpF5ZxlE6zPJCI7m0Qs9YpVBH01omRrYDQuLfKId9JYRdeGoRUIV35xY7IUKB8GA7U+Aa7NKqjvwIgfUoekCpfsdOgv2fdvh76L2N1CsgDWx9M4v/7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871954; c=relaxed/simple;
	bh=NDXnNMmrl03vXv9oqm07S6qgAhQq+R4B4/0FFECMY6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddJu2pkEoyYZif6FqqWFqZc7yeCQXSXPuUL0t497ZSgi7ZsnM0CLh1CGU3AO7MTmNcpA94ZLSC7D77IrZ/6sQ6MTAaV/o0tPGgh50oje4mSMQCa3Gby0wgD9ukptZ6hvRVnYb3DoE1JYF0aU+8oXMrTGKDN6V1K+0IEwwIlIoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zydxsuLt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775638d819so24421985e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 06:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1762871950; x=1763476750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BbZiM31j3hF7yHeWrzWbDvWSfA60EWmb9ONaywmv4Bg=;
        b=zydxsuLtdh2kkOZQG/hKh2nTOHu/pOz5n8UTfDY3URMsOhxICjsTG9nQ2GLZjb95Dz
         CZFMM+qzmcwXfp9XBLYAiQAMGVp2kX3UOHTd5s1DFN56t7xvDh9SEgFHJvXCijUoZrvJ
         bzSkFRHZLz6RuthkjdZhi3oOMGjtqx7VpuAXLHStTMVM4jnCvPASd/Tmci22l0gvTc3F
         sOB1NQMSlBOnhuhMS1m8jpQ/dpfzIEfhkFImwhZhccLCymdcvZOc8TLFMytuBm3tQ/l2
         /9XN4p6DxjzUvl6S2yXBREJTbzAdyWMDr/8sxuQaQv8GowZWnIvwwY2ebplOB2EmM+zn
         WiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871950; x=1763476750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbZiM31j3hF7yHeWrzWbDvWSfA60EWmb9ONaywmv4Bg=;
        b=R6Ev2Fc2nS3+OhY2kUSQQAPbkiRv7uXIwWx4A58m1Q63P1TwScaglGzI2CZAwRgxz6
         WWcw9Gr/W17da4ayjq2i5QKX5x74yt5xpCs7LxacwlT4yocMuGEhbqQUwSn5XIzEW2+d
         tjWdgemHIgvzUrPoFMx7KeP6h+JNj66bPBnDtXpQtOumfI1GvkvRAZaBWxTsCkSVqLa1
         3O6B+hfasFek6IhfZRAK1pROugiUqQ1U/7pSSTZhHcaVcva2FFZ3MB6AtqrYJjbYyqWP
         CZ9bXE971OZLa10aRFGykhCfmbXjIPDWLUU3DBcTdSVLHAQZlm/WdD3ypLcfxRuQ0Lmf
         VrBw==
X-Forwarded-Encrypted: i=1; AJvYcCVS9Rnv/KHR08TuVoe3D4Ak3sM4h5rZspiUBF8ZwaIgEg6BNtPuKoxG6O2YGFODzXq4UAaDsdJ/m5w/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+yKfpw1lwJPi75nG3mj0rj70t+kVGUXq7CZXKarxrSsViVjPX
	D7QJxV12q2r3CmMXC2DRLJqYckWKecEkcxmsKxZf6p7Q2dJuOoOIxWrP7H1CFVd8WWY=
X-Gm-Gg: ASbGnctfE6ZW8o0sQpuqnkG/XsRBkHtpk2aflYKOUHcMbjFS1rt85BxEWLXL14opWfu
	JhS5VHKHZ7dxQBeyR+RT8Pl2Zaf7f36oMf2+6U1oBQdKTCSPEBmhx4nhoD1hsA5JDdqM5V6+qwT
	eGOz+OOMIDuKpIU24d4gMOTghFNsZhFZn1kF/naaLQZIbQp57eUMR4D61w0ouvkwNugbtRTfAy1
	Uv1FnzY1768c3Y1LpvB19+MJlk/nRaudynTmtJPtkWSNO0Gytjeo3t2vvcGm2K9TbO7fYD3bBZO
	cS4E8flgWHxUpPBPxXbWUCVMJHkU/e6swBBN1ZctMgJhwZPIiMNaiqA2wcNnA4npBVmesu069qO
	sTSJst+uoY1i7Yd6mAPVp9PT/1Z4+q2H7rIIFVnx3N3SHr5fAH/C9DG5piswhPbMNa3C9ZiVr37
	uTQDx9OqZn
X-Google-Smtp-Source: AGHT+IEWdT0uV5uWHBTGFPHzbW80DutwkV0QHsEFy4zvFBG9BlThbgSAanJ2aRukrqMaWzzZN+v30Q==
X-Received: by 2002:a05:600c:350b:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-4777327e71bmr107922525e9.23.1762871950232;
        Tue, 11 Nov 2025 06:39:10 -0800 (PST)
Received: from jiri-mlt ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477815faadesm21513965e9.0.2025.11.11.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:39:08 -0800 (PST)
Date: Tue, 11 Nov 2025 15:39:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
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
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Message-ID: <cgg6fxjjf6zq6yyzx4njhjmetrlhjgor4lzktwe6nls6rgqd6s@c3abd3ehlzvr>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
 <20251107204347.4060542-3-daniel.zahka@gmail.com>
 <aQ7f1T1ZFUKRLQRh@x130>
 <jhmdihtp63rblcjiy2pibhnz2sikvbm6bhnkclq3l2ndxgbqbb@e3t23x2x2r46>
 <20251110154643.66d15800@kernel.org>
 <aRKs6jXqSvC3G_R0@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRKs6jXqSvC3G_R0@x130>

Tue, Nov 11, 2025 at 04:26:34AM +0100, saeed@kernel.org wrote:
>On 10 Nov 15:46, Jakub Kicinski wrote:
>> On Sun, 9 Nov 2025 11:46:37 +0100 Jiri Pirko wrote:
>> > >So, I checked a couple of flows internally, and it seems this allows
>> > >some flexibility in the FW to decide later on which mode to pick,
>> > >based on other parameters, which practically means
>> > >"user has no preference on this param". Driver can only find out
>> > >after boot, when it reads the runtime capabilities, but still
>> > >this is a bug, by the time the driver reads this (in devlink), the
>> > >default value should've already been determined by FW, so FW must
>> > >return the actual runtime value. Which can only be one of the following
>> > 
>> > I don't think it is correct to expose the "default" as a value.
>> > 
>> > On read, user should see the configured value, either "full_csum" or
>> > "l4_only". Reporting "default" to the user does not make any sense.
>> > On write, user should pass either "full_csum" or "l4_only". Why we would
>> > ever want to pass "default"?
>> 
>> FWIW I agree that this feels a bit odd. Should the default be a flag
>> attr? On get flag being present means the value is the FW default (no
>> override present). On set passing the flag means user wants to reset
>> to FW default (remove override)?
>> 
>> > Regardless this patch, since this is param to be reflected on fw reboot
>> > (permanent cmode), I think it would be nice to expose indication if
>> > param value passed to user currently affects the fw, or if it is going
>> > to be applied after fw reboot. Perhaps a simple bool attr would do?
>> 
>> IIUC we're basically talking about user having no information that
>> the update is pending? Could this be done by the core? Core can do
>> a ->get prior to calling ->set and if the ->set succeeds and
>> cmode != runtime record that the update is pending?
>> 
>
>Could work if on GET driver reads 'current' value from FW, then it should
>be simpler if GET != SET then 'pending', one problem though is if SET was
>done by external tool or value wasn't applied after reboot, then we loose
>that information, but do we care? I think we shouldn't.
>
>> That feels very separate from the series tho, there are 3 permanent
>> params in mlx5, already. Is there something that makes this one special?

Agreed. That is why I wrote "regardless this patch". But I think the
pending indication is definitelly nice to have.


>
>In mlx5 they all have the same behavior, devlink sets 'next' value, devlink
>reads 'next' value. The only special thing about the new param
>is that it has a 'device_default' value and when you read that from 'next' it
>will always show 'device_default' as the actual value is only
>known at run time ,e.g. 'next boot'.
>
>I think the only valid solution for permanent and drv_init params is to
>have 'next' and 'current' values reported by driver on read. Or maybe go just
>with  'set' != 'get' then 'pending' as discussed above ?

Hmm, is it possible to rebind the driver without fw going through
next-boot phase? I'm wondering if it wouldn't be safer to have this
pending flag set to be responsibility of the driver...


>

