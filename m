Return-Path: <linux-rdma+bounces-14343-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E67C43C27
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 11:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D2E84E36F4
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686F42D6E4A;
	Sun,  9 Nov 2025 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ag2uWTmq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80563263C8A
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762685204; cv=none; b=bjZsftE7GbfB/dvG/by5ziQxbBL/eB+roDZYUhUgnyThx6ZIRq9FBTXw+wFsoKetS4/4RKHeCYCMmPgl8KXZO8IFBMBpMlQoD2YldOCkebB/x+rAAPwoabIDRmACGl2aKdblpPZ/KULAkM5N8YveeOZAmeL8iL+X6S29xUkSE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762685204; c=relaxed/simple;
	bh=Gw0g1frSlMFqGOfUOTrqn9WRh4UUBCaivw+F9BN+lJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMGSHYXsW7RMSa0Bb6YxfqMyE0R3Pv+K2VgYYnfA6/lyhwqrJgwQL6J5ZYRRuuoGH8x+9Mmp4dzIOuLw3NoWKE/UZbvZQHWIk/ocHu7EDQlw41gVxW2iW8BXqKiEmpAJE8SrumuGb+rWKmW5OjMJ4HIPsg9CVEMWkaEEa+/lr3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Ag2uWTmq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b729a941e35so244368366b.3
        for <linux-rdma@vger.kernel.org>; Sun, 09 Nov 2025 02:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1762685201; x=1763290001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LobDOj+CVtAhCKBNhLXMD5rH/KOzKtMHgkkQPmZQZqo=;
        b=Ag2uWTmqD09kBZlgvoYOgY6VrhyKsgtK3e83kiDzIN24+Fyll2ecIY77VjdqFkn1d6
         M4txSFvBFcaxACI+vogH1CyoiWHn+bkEYn2cyIO9fRfHOX0J1X+enwHvPCT/r9sLZDVO
         qSgItPzWqXGtfG9YFkCLO24zRMqrL8f+JKexS9TojFf4QtbjD1gS68uql43rXZTKDkMY
         5tNjeuR4EhuZorFrQpef41PjIizgs6aThpyNAR+BDHVuYrdUsYgDyxfBuxevuPz1Z501
         xlajPhNO3FHmAi450ZTwcx+/09/3TXG3kp4ddSvh5YdIymQEHpQN75H3EtYIDFtiMHEg
         kq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762685201; x=1763290001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LobDOj+CVtAhCKBNhLXMD5rH/KOzKtMHgkkQPmZQZqo=;
        b=jGlasZAPQccayF9y3V9sdcpHgIRMmH/7P4r/iEd7nXoL9s9hOaajVZRJku8C6+ApZO
         PAvPVbNL7/5Ws46Ua6EktDDrHBrYTNCjmS/jyUdFBNbfEMEaVpzxTdiS1sBYrWyGj/hN
         hb23E4M/yA2nvqV8Axk9AO9UbY4C8retrywCLnYTkeZDwLCNqF7ODGpobi6EKs7CZjvl
         Ao5hW5TStyxJeT8wS2+fSp4gcAYeBblvLKgSGGSTXR+T677AArpein6OqX4w3o1cs2vF
         MyJOyWB+c8Jg9N5KMFKaRbx6aLUVBP8walZFTPhHaqkTpV1CZdjxmL2SlGocCdofwDYA
         Xm1g==
X-Forwarded-Encrypted: i=1; AJvYcCUtcFeyh33lYJJZf+mhOnpaRuqBIAdpwhgj+We2e6iETu1Q+fJ0EX8dr4FQbz7Gxq82M/FkATzA61AK@vger.kernel.org
X-Gm-Message-State: AOJu0YxepGC77fU6M0oEKumA0axCL4hKJwSFZ09vNMxc1/LcxVbhh7e4
	LdFSuzlHOOp3bUtVyrI5o9jTGtGx3LHbD0kcQJngRE7gf9FikObbeWZg7wK8kRBG7mI=
X-Gm-Gg: ASbGncth875r7JS0i1AZEDXd5a+3dfumrJQ5Y70j82gNbpRbsmKYoaBgWKyn30g22kG
	ydfl4Rem8xYablMzNl0YrOe8vMcwO7qGxXLnjn/bV32vAJwCGe+rG23zSfYhkLHNGgq9aE5+g1y
	Ig5v04ppgtiuCje3GRNuYF4yysLYu6RJJ1B1fRW5/y9Qk15x84dWD+zkk4H9hRxt9HVnnJthCUa
	Ed07A9mXfJxh3beE5JJ18ng4gQT8X9Tqtn+diaH46+wZRRvE46Bh4BLXW0ug4DjIjQvcZAWqeon
	P2lTh9SNy2+Aqg043BvO4+2ybFFeODvLsdINLe6AiWCQTIuQVRR6tmda7gvirAt3A/ODfRYKBId
	sQ0oeVLf2EKH0A7VE5fgeRPhkf613oPqH4JLYUDp7Oxc5Y0i1Yhef1bdkaIrqEbuy6w7E8ejDJW
	QB7RhUg3AiIPiqIuME
X-Google-Smtp-Source: AGHT+IEf3v9YSyb6OvnE4os4GAWYkoIF/Hz2buBIRvx1KU2RTdYxzUhIiX3St2MD76hgPlkL2ITw2Q==
X-Received: by 2002:a17:907:3fa8:b0:b72:afb1:fc4 with SMTP id a640c23a62f3a-b72e04c5bd6mr465868766b.50.1762685200809;
        Sun, 09 Nov 2025 02:46:40 -0800 (PST)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72de4f920bsm497418966b.67.2025.11.09.02.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 02:46:40 -0800 (PST)
Date: Sun, 9 Nov 2025 11:46:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
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
Message-ID: <jhmdihtp63rblcjiy2pibhnz2sikvbm6bhnkclq3l2ndxgbqbb@e3t23x2x2r46>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
 <20251107204347.4060542-3-daniel.zahka@gmail.com>
 <aQ7f1T1ZFUKRLQRh@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ7f1T1ZFUKRLQRh@x130>

Sat, Nov 08, 2025 at 07:14:45AM +0100, saeed@kernel.org wrote:
>On 07 Nov 12:43, Daniel Zahka wrote:
>> swp_l4_csum_mode controls how L4 transmit checksums are computed when
>> using Software Parser (SWP) hints for header locations.
>> 
>> Supported values:
>>  1. device_default: use device default setting.
>>  2. full_csum: calculate L4 checksum with the pseudo-header.
>>  3. l4_only: calculate L4 checksum without the pseudo-header. Only
>>     available when swp_l4_csum_mode_l4_only is set in
>>     mlx5_ifc_nv_sw_offload_cap_bits.
>> 
>> The l4_only setting is a dependency for PSP initialization in
>> mlx5e_psp_init().
>> 
>> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
>> ---
>> 
>> Notes:
>>    v2:
>>    - use extack in mlx5_nv_param_devlink_swp_l4_csum_mode_get()
>>    - fix indentation issue in mlx5.rst entry
>> 
>> Documentation/networking/devlink/mlx5.rst     |   9 +
>> .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
>> .../mellanox/mlx5/core/lib/nv_param.c         | 161 ++++++++++++++++++
>> 3 files changed, 172 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
>> index 0e5f9c76e514..675b5a1ec625 100644
>> --- a/Documentation/networking/devlink/mlx5.rst
>> +++ b/Documentation/networking/devlink/mlx5.rst
>> @@ -218,6 +218,15 @@ parameters.
>>        * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
>>        * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads
>> 
>> +   * - ``swp_l4_csum_mode``
>> +     - string
>> +     - permanent
>> +     - Configure how the L4 checksum is calculated by the device when using
>> +       Software Parser (SWP) hints for header locations.
>> +       * ``device_default`` : Use the device's default checksum calculation mode
>
>Let's omit the device, just "default".
>
>So, I checked a couple of flows internally, and it seems this allows
>some flexibility in the FW to decide later on which mode to pick,
>based on other parameters, which practically means
>"user has no preference on this param". Driver can only find out
>after boot, when it reads the runtime capabilities, but still
>this is a bug, by the time the driver reads this (in devlink), the
>default value should've already been determined by FW, so FW must
>return the actual runtime value. Which can only be one of the following

I don't think it is correct to expose the "default" as a value.

On read, user should see the configured value, either "full_csum" or
"l4_only". Reporting "default" to the user does not make any sense.
On write, user should pass either "full_csum" or "l4_only". Why we would
ever want to pass "default"?

Regardless this patch, since this is param to be reflected on fw reboot
(permanent cmode), I think it would be nice to expose indication if
param value passed to user currently affects the fw, or if it is going
to be applied after fw reboot. Perhaps a simple bool attr would do?


>
>> +       * ``full_csum`` : Calculate full checksum including the pseudo-header
>> +       * ``l4_only`` : Calculate L4-only checksum, excluding the pseudo-header

[...]

