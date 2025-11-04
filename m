Return-Path: <linux-rdma+bounces-14243-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A1C31981
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 15:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5EA188800A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C58732E6AE;
	Tue,  4 Nov 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2MnCpc1K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5E832B99E
	for <linux-rdma@vger.kernel.org>; Tue,  4 Nov 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267207; cv=none; b=Vxju+Llp/sR9O5+KXtVkKcMEM6v3lsyeQ+5Ufb5nsCZOBYNw24Yq92MfF6yVj8PQplrL2CZTcZZXJnvLvhPPAZBz/ki8vpke6g4d/G3IJ6T5E3Xtvp14mEfjNYoQBzy3upQjJ6h+vlOq9uM/5XYjiSOxWNbbLxVQB2bXU5NK4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267207; c=relaxed/simple;
	bh=ZsrPvleOI3xxeiQePS3/NpD1qyrQbrxTc8ZEeW2EnYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU7X6d60hWECN2/88auc/eDEtgVR0w/F3v6vjJ7HThH48h7mGJKK4VYIYYtSAuINCknhK4myFAPcn88UECrKMA+Int0TwjEhAMpikL1RQjhabpAZWmPAbrDcGi7hV81cMgqOm3SVprqw2Uii1wNLRm6MzZaKZdQi+f/T1SsQT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2MnCpc1K; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47755a7652eso6591115e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 04 Nov 2025 06:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1762267203; x=1762872003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rEkFVWT5NBv3AWUofiDX8hOm3L/6oD6jZrSiQV9+dPY=;
        b=2MnCpc1KYsJrOEdIyvwTisGdFiQuVqXmpc1WZErYJNmqxwTnfqYA54Ttfybi1d0PvI
         yAukgegu/2jJDatfU1C0raa16Mf0YercoXFgtgYZ5d9oDYQdrsFDQAn60kaOic39W8Ea
         N6CAKwemTNPaAUUN7gSOZGitxre0qm3hjPVA6i+n0TIM4jAMJWZ+rdPJJ2QzepzxJCeF
         k3l4DBiDB47poDRUHlSgMfe2gTTPv258dFM2+NPMXK9+ciCmIS8+gdrzwkenie1wIbSC
         0fno23PnaWTBZZ9555pWUVQKPtiUCdQaLhThO2mWEFHoASnHonksnbu6CMykeO4CKIX4
         oi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762267203; x=1762872003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEkFVWT5NBv3AWUofiDX8hOm3L/6oD6jZrSiQV9+dPY=;
        b=s3y6NE77i4JiNkfNHNOPbnWMDCIif5tJuqqOEAUevQ2mC/xUVVt6RrKWEWuqBPQfqQ
         u7jDhUAxpNp0T9ed34ybI+Gxu9rMx0sg7s3OH+8LwgLjCa87Ev7nQcGa3D3XVeZndsUd
         DIyNo3iKFkwInPBS+jHbMdiTECaDbgeMITuSQ3w/CkKhfXGVMZ21uBG2/jH6jTzxEbDf
         Jm+sf3wpMluAKjKjrZ3QVPTLeqs9shjHjTgH3Uq+BF+SYVr2u7Bp6AIUKcXblRMzTrn3
         FwLe3KVyg5vzOvohkhAJu1O4ypQclAug3mpgmMWVQ5h62G5T4Ls5AmgucUE+7DQca5b/
         kPwg==
X-Forwarded-Encrypted: i=1; AJvYcCVvP4T9aJ/MoMqdXlgERqcARjSuExqn+mzDC7jubHHoyqEzvVzqK3ndUu4WDt+KWzD5ffFizcd51MC9@vger.kernel.org
X-Gm-Message-State: AOJu0YyzgydoxFJW2i1kwT/9D7nFWi/CLB0AtsOuA80OqE17VHInsiLo
	kmVmFyJfpyMIK8HEcmjpOuuFKVA5J/oSPgEdyella1UzYXhXAsf2i26+xB0nV/iuYIg=
X-Gm-Gg: ASbGncv6wVjbY/d+h3Ukaejd5Vlyv9PD0lXp6JoTRzd6dO9OqziQQOwMeQ8AlnPFq7j
	LU8ye5nMMzKmIxT0rAlr8idKVXFvR6b+JU6e6Y+gCS/MinLgoEaiBJRaqFC9El6JSaOyDSWeE34
	myjRmsgDFaV2jQG4Og3QLFUucpu+F6VFAj7q0wJTdAfzUlVjGsibH8MfIQ+huCcarovUos864EY
	ZuzRtB871xu+Ijq7KQrjeIdbadlUMa+5O/WhMxZMUodJSdMAd7qmctfffDlfYo+Rb4RAu5tLrUk
	PvXnPxzqpfKdfH4m/pNN8IFghfoVgzkZQfH5YZGojGt3CA9ZjbmYFpWcTJIwbpGs7apKCkfw6XM
	Ukb9irxnE++MM5YjHwVjuyX84hvxOSIrzVLTOkio6qj+m52uMJHKENHX5O6s7LHSFzTiw8bmycS
	4Xc6J7DbFA
X-Google-Smtp-Source: AGHT+IH+wSpO7CA7uoT1EyqMsmESkKjEBIh7MZyEYgnZ6s42MxUO4LQk7aoyZId0Y8Jc8HF2ped2Fw==
X-Received: by 2002:a05:600c:1f8f:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-477307e4885mr128649795e9.18.1762267202870;
        Tue, 04 Nov 2025 06:40:02 -0800 (PST)
Received: from jiri-mlt ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755932134sm18947015e9.14.2025.11.04.06.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:40:01 -0800 (PST)
Date: Tue, 4 Nov 2025 15:39:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
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
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Message-ID: <p3pj3mu4mabgninwowqikegeotxgzhc4yptf7qrfhns37bnkoz@ugkbgvlkxqxb>
References: <20251103194554.3203178-1-daniel.zahka@gmail.com>
 <20251103194554.3203178-3-daniel.zahka@gmail.com>
 <mhm4hkz52gmqok56iuiukdcz2kaowvppbqrfi3zxuq67p3otit@5fhpgu2axab2>
 <db5c46b4-cc66-48bb-aafb-40d83dd3620c@gmail.com>
 <6aa2f011-3ba5-4614-950d-d8f0ec62222b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6aa2f011-3ba5-4614-950d-d8f0ec62222b@gmail.com>

Tue, Nov 04, 2025 at 01:51:16PM +0100, daniel.zahka@gmail.com wrote:
>
>
>On 11/4/25 6:38 AM, Daniel Zahka wrote:
>> 
>> 
>> On 11/4/25 5:14 AM, Jiri Pirko wrote:
>> > I did some research. 0/DEVICE_DEFAULT should not be ever reported back
>> > from FW. It's purpose is for user to reset to default FW configuration.
>> > What's the usecase for that? I think you could just avoid
>> > 0/DEVICE_DEFAULT entirely, for both get and set.
>> 
>> I find that 0/DEVICE_DEFAULT is reported back on my device. I have
>> observed this same behavior when using the mstconfig tool for setting the
>> parameter too.
>
>e.g.
>$ dmesg | grep -i mlx | grep -i firmware
>[   10.165767] mlx5_core 0000:01:00.0: firmware version: 28.46.1006
>
>$ ./mstconfig -d 01:00.0 -b ./mlxconfig_host.db query SWP_L4_CHECKSUM_MODE
>
>Device #1:
>----------
>
>Device type:        ConnectX7
>Name:               CX71143DMC-CDAE_FB_Ax
>Description:        ConnectX-7 Ethernet adapter card; 100 GbE OCP3.0;
>Single-port QSFP; Multi Host; 2 Host; PCIe 4.0 x16; Crypto and Secure Boot
>Device:             01:00.0
>
>Configurations:                                          Next Boot
>        SWP_L4_CHECKSUM_MODE DEVICE_DEFAULT(0)

This is next-boot value. You should query current (--enable_verbosity)
to show in param get.

