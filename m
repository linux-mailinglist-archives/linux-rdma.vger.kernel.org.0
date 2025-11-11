Return-Path: <linux-rdma+bounces-14403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052EAC4EC64
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 16:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2A33A36C3
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C9364EB6;
	Tue, 11 Nov 2025 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfPf0wyZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0700B361DCC
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874397; cv=none; b=qNjEhrHgA13kloFesqdX+4rUXt0bIh/zNKPYGH77UKcNGXxrbiY6RdLZBD3pqIPZ84W0+sxr0WEg322CaopY7AkbJoHKb8RfS0mEjJwhRxqF6WdTsNEq0Ddv8noxAipcuPNXRcs2BIiuh+/YJoUpTEEd7h8fjI40Th8D92EeWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874397; c=relaxed/simple;
	bh=94GtY5KZjXmZPjl12JvyfDt0aWegthwLuMtBUxxbiGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPv7Wc7hB5vZoncp8QVc1EZ97Jrftpy97tGN3domuW/uqQMtLFtarZXVau4vp7OTiRZs+bPQMyqxkC2NILmwptKt2DJZRoi1HDKhFc0OdpZBZMhks6CxGCC+twMqXWdi9h5I/rCAagYlfn0xtG3AJN+Yy0YVbjMgNp6J0Hu4TGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfPf0wyZ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8823dfa84c5so34953666d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 07:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762874395; x=1763479195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5SVOaFDlCV2uNNJy3v3HZSAyck/afp0AOlD6vgrWKk=;
        b=gfPf0wyZuFA8eXSbBfB6sx8zsYhWsjzbtWIuwEJV9QsCbdj4lXEiwvy14oPL+BLR2i
         QoEiHfQzIwTYN7EOvavJICHoG90ewvQHqv2A5+mZTlcQVHT0Bwq8BeuHKaiiY2YIkfH6
         NoONLltZShp6fB6OmgBJrTPgxGV30KCdEVYtKj4fg7C1Zv3oIsahUCJUvUqDH36SPkiY
         +DyJtYml+nBfyd+3kh4/vrh3arhdTbJLi+O5KNgKBtcOphhOTksm0+o/xDNaRzuzMLrc
         229Jgt2BIDuxOfk5BW7pXpQtjKh/X3gF2Wz784UJx/Dsofz3nIyK2Xo20SAtmnA+VQ6B
         0vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874395; x=1763479195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5SVOaFDlCV2uNNJy3v3HZSAyck/afp0AOlD6vgrWKk=;
        b=OmglRgzK36ysduTJsv10KTPFIITm+JxqkE4yODFBXDRt3c7cDErWeFA30bwXaa8Aiy
         VFOwCYc2CHWJdywCy5SeIbvVL9whB+ONhdwJGkGOOEb36zcCDzcpV51RhfEKTcabGOXB
         ko4jMWXeQosH7frQckaUdnZTy/keeJUWe6xg6kVyW1a9C9LsIgBHHzcJnyaL/69X4rzY
         ZptY2fpiOeuZeHA3nOFLIlG3P60kavg57UiWLeD6hBtaRMnYX6XmGVEIA/Cpfo8ZYzFD
         Kw6166+FlpK4YLTkDgT3wiy4CF1aE8stPZFjU3NXeRTbQODnuV0oo7vrXA6mKAZGbqZP
         ncEg==
X-Forwarded-Encrypted: i=1; AJvYcCUGv+YUL2wqQHRUYYxOunkTqOaO7gmyAHhm8Mah94EZOFM2mv30QXZQCgEuC3G81bxrEUYVYiLpc0xn@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkCJobuyxP0wcTOSHHS5agdD1MdPJKvjx/zk8NmWd1GlYSmYC
	EJfLt1gD8qZjyhQozrtkwBKES8zOBC/Nfy4aESnt7snVfN5i8SWC2F65
X-Gm-Gg: ASbGncvT1GrZcHsvY3pnaQLRtDZq1YwHDVEm7X4Hw/xlJ3iLVBo5vNDTmhC4Gd59//B
	w4LDyoHqbrRZ5t4jCLFmItMwhZ/I3+q89sXOT6CENQnXy5uPIeGtbvfLMFpuDxmhss3T+V1kfPi
	KI5tKSFVCEgGrq4KGfUyrAiCdptfE2ipHFkw903o8ZyQ4/30cq5qGwDdXgGivxzYPfAtLFdAejC
	c85S/AmGub/ukKEjPquYkF+bGj1LgRstmXf29kQQRTamZcZPyYnkJSw/Os9hrvnh33AVf5C4rV2
	neSxU236qy1LxnUQUoaR/1lN4b/WEB1DWkAy8UTrN4E5y3xT7CxmaHFGlVQ+X1NmENpR5Caog8q
	gWjvrWZwfh/4O9vekKvV0iQEZEH/l0LLSZHGVX23nhf+hFhWPLdMjB3URQU+gWtKJEJ6oQuEAD7
	S4xg/sl8Asx/8m4FdeMiFveKhL
X-Google-Smtp-Source: AGHT+IFAbbyQhephY+AI/cqoiVmNsBG/fPVAb6kdOEXVVnWOQfxDiV/20VWcE/IFvlGD21yeGrFzgA==
X-Received: by 2002:a05:6214:21c4:b0:880:5636:6241 with SMTP id 6a1803df08f44-88238769402mr175766236d6.65.1762874394765;
        Tue, 11 Nov 2025 07:19:54 -0800 (PST)
Received: from ?IPV6:2620:10d:c0a8:11d1::1065? ([2620:10d:c091:400::5:ddc])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b4c3c0sm72793516d6.33.2025.11.11.07.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 07:19:54 -0800 (PST)
Message-ID: <9fed6ab9-e748-4a78-b45b-5e6b3cc58006@gmail.com>
Date: Tue, 11 Nov 2025 10:19:51 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
To: Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Srujana Challa <schalla@marvell.com>, Bharat Bhushan
 <bbhushan2@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Manish Chopra <manishc@marvell.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
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
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
 <20251107204347.4060542-3-daniel.zahka@gmail.com> <aQ7f1T1ZFUKRLQRh@x130>
 <jhmdihtp63rblcjiy2pibhnz2sikvbm6bhnkclq3l2ndxgbqbb@e3t23x2x2r46>
 <20251110154643.66d15800@kernel.org> <aRKs6jXqSvC3G_R0@x130>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <aRKs6jXqSvC3G_R0@x130>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/10/25 10:26 PM, Saeed Mahameed wrote:
> On 10 Nov 15:46, Jakub Kicinski wrote:
>> On Sun, 9 Nov 2025 11:46:37 +0100 Jiri Pirko wrote:
>>> >So, I checked a couple of flows internally, and it seems this allows
>>> >some flexibility in the FW to decide later on which mode to pick,
>>> >based on other parameters, which practically means
>>> >"user has no preference on this param". Driver can only find out
>>> >after boot, when it reads the runtime capabilities, but still
>>> >this is a bug, by the time the driver reads this (in devlink), the
>>> >default value should've already been determined by FW, so FW must
>>> >return the actual runtime value. Which can only be one of the 
>>> following
>>>
>>> I don't think it is correct to expose the "default" as a value.
>>>
>>> On read, user should see the configured value, either "full_csum" or
>>> "l4_only". Reporting "default" to the user does not make any sense.
>>> On write, user should pass either "full_csum" or "l4_only". Why we 
>>> would
>>> ever want to pass "default"?
>>
>> FWIW I agree that this feels a bit odd. Should the default be a flag
>> attr? On get flag being present means the value is the FW default (no
>> override present). On set passing the flag means user wants to reset
>> to FW default (remove override)?
>>
>>> Regardless this patch, since this is param to be reflected on fw reboot
>>> (permanent cmode), I think it would be nice to expose indication if
>>> param value passed to user currently affects the fw, or if it is going
>>> to be applied after fw reboot. Perhaps a simple bool attr would do?
>>
>> IIUC we're basically talking about user having no information that
>> the update is pending? Could this be done by the core? Core can do
>> a ->get prior to calling ->set and if the ->set succeeds and
>> cmode != runtime record that the update is pending?
>>
>
> Could work if on GET driver reads 'current' value from FW, then it should
> be simpler if GET != SET then 'pending', one problem though is if SET was
> done by external tool or value wasn't applied after reboot, then we loose
> that information, but do we care? I think we shouldn't.
>
>> That feels very separate from the series tho, there are 3 permanent
>> params in mlx5, already. Is there something that makes this one special?
>
> In mlx5 they all have the same behavior, devlink sets 'next' value, 
> devlink reads 'next' value. The only special thing about the new param
> is that it has a 'device_default' value and when you read that from 
> 'next' it will always show 'device_default' as the actual value is only
> known at run time ,e.g. 'next boot'.
>
> I think the only valid solution for permanent and drv_init params is to
> have 'next' and 'current' values reported by driver on read. Or maybe 
> go just with  'set' != 'get' then 'pending' as discussed above ?
>

The driver reporting 'current' and 'next' makes the most sense to me. 
'pending' would just be implied then. The 'set' != 'get' then 'pending' 
approach would not work on my multi host CX7 system, where rebooting the 
hosts individually does not trigger a fw reset.

To be clear, are we willing to go forward with treating swp_l4_csum_mode 
like other permanent params in nv_param.c in this series, and then defer 
the 'pending' solution to another series?


