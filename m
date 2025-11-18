Return-Path: <linux-rdma+bounces-14600-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 645ECC69D9A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 15:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6921D4F854D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBDB3563E0;
	Tue, 18 Nov 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3XZy0qZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DD34EF17
	for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474728; cv=none; b=tKGEdqUBVGNPHOSpSoBWpo9+iehNZMqNFsiod3xkqZTtGGdO4aabeI1Flcj2UCr2Ux15DtqmjLNc0hoNefYoTkISTNHYZHd4bXAxXvKJlW2Z8fAp/Ge2mAZjsoLsTtt/buB+JO/kx6kKxTCMouRt62aqbjgXttBWIfutaPXml4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474728; c=relaxed/simple;
	bh=E+jYnOJomhGTFm7NkfOOIwqCgJ1q2q1ZygofwCO9Ns0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzwZ0+zcJK7iWwO6/lielTXccUHjL7Th6+0SozBUzvF+oV+/mNZlJ/lMmtlaoVjmj0KnDT/DVLHGJXUwLIMVWqfAV3PLS8XF49B7XeK84UuECH5SP5g8AxU4bTSkAzb1d6rq5lBSo0svD8Jqr0jng2eQ5a3/2yEPGi7T8rSR5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3XZy0qZ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b28f983333so574010685a.3
        for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 06:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763474726; x=1764079526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Re4uEMK9pbB6nXMCVKg6V3EBHF8WVApPveIrVqjfMWg=;
        b=F3XZy0qZaA0kMqgIA/lk3AhUBRXNbkBQCk6/ow3DWnuOIwYsFwh6YZUF7AFKPMFeA8
         WeTuOzYXC1034kSJIz5OY4h7c1TZJa4Yy4hS1bRNmQwSEm57Dm5ZcocgEYQwxl+Rtoas
         wzog71vC/OkwYPvAW70k9vzTLACI3gvgLA4cs3ZbWi4gb6l+jvR/i2SxE0030IVm2Lwy
         ri5IJQ4etnb5Sw6JeykEn31Aei6vmGe9forwVyg9bbnY28VRKWRsjRIMqob/7DANTdh2
         gGBtumxSDet0PDHv3Id3bQ4YGzABq4pBsfC9BAg/h+PeRruy+TXRJeTcEXFCpzp8/cSg
         /lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763474726; x=1764079526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Re4uEMK9pbB6nXMCVKg6V3EBHF8WVApPveIrVqjfMWg=;
        b=JQaXdwg/EuOFUhusBS0v8y60h4sjAhJURnk7N75debBZrcdsd6BQfv6BJ6YZPJu90j
         y5+h/jZGHMnT5gvr6Wu6ELnFWxo73HdcElniS65mJjxFqIWQN0OVXs2SuMgpRjmuGvo9
         UJXsRLcTFBN5bARM+ie17hkkBz43ZFMdqxES1f2vcND+0qkmcHI48UESrt8/J/VT065X
         xxakJR7ktpKbMkKi4hcxJhktiYd4TwhT9Lfw/FCBdeA4oZytQKPB78E+3HEiYKE/76Ks
         AM8NDtDt7L1g9YwMknhqH9ZlDy18G8iegkFTny3+VjzZ96faPRQRqlVYCEdG7l2hqdbf
         l39w==
X-Forwarded-Encrypted: i=1; AJvYcCW0BJvlAycVpJQsgjuulC00wo9OD0wK7gjkQFnR8g6xhyzUvZ34LdfXMdEd/OH+48BgYwCqQ7UMEirg@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcpQrK/C/oWNbPHz3MW0ctP14YMvwdHfrYW5EyT2KyTXGgulw
	TTYMgMWiKHa4bdQkIqMCr3QIQUcOv2STVjutFhrbKMFhYSYebE7siFCo
X-Gm-Gg: ASbGncta9y4CFF9B+cSyzO2M5LQiHEF66Ih8TUc0nB1JjN7NodLSpIAtmjLJfEMMKn2
	PcvoD3AsTP5GhxTKZ4DrBxZv9zgrks+MHDD+Wq93tv5IXTV7FPg3SYpJPFjKpYBszILBhJdLS42
	niMttA9i8P0/cE//t8uo1i0TxcJiAhnwDADGHz3DhzcoX+MiwY+nOfF5XB/m8gpZMirOhbo2knQ
	Kq3Tc0cv7yB20049CZLkWP6O+8fOqaxlNUnJeQaCSFWBbHhBEQntab7vqcVGgBiY6Q6b+ts3/L+
	zSPNNbW/Jd7cHKbNg9S0kjQoOmTL9FR7pza2eFeWoilHwMlW9T2UC3bixyZF0sYHPLVv8UgNfwd
	WRQ2Y5JyUn/sMjQr+DrkumJXB12lBeJUDGi2Io7vyu06YR9vyzQznyI7GGP3MaEfIen3UnUyRWt
	wRb6ortxnN9t5HgS2XqwAfC/LxCL6XUWY4iOiuDaU0qg==
X-Google-Smtp-Source: AGHT+IGE7fxQHZHegwj0qm3RM+qDAgOLCHIdGKF+IHSvr1DbeTA6VOTo1ilyxGjX8IZGClnfARMqPw==
X-Received: by 2002:a05:620a:3f8c:b0:8b2:d2c9:f6a with SMTP id af79cd13be357-8b2d2c91248mr1065407985a.89.1763474724046;
        Tue, 18 Nov 2025 06:05:24 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:ac1c:73e3:7a8:e3e5? ([2620:10d:c091:500::6:af4e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aee9e519sm1221938385a.5.2025.11.18.06.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:05:22 -0800 (PST)
Message-ID: <a56cc76f-7278-49d5-a9ca-5d04d61cb8f8@gmail.com>
Date: Tue, 18 Nov 2025 09:05:20 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/6] devlink: support default values for
 param-get and param-set
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Goutham, Sunil Kovvuri" <sgoutham@marvell.com>,
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Tariq Toukan <tariqt@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vladimir Oltean <olteanv@gmail.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 "Ertman, David M" <david.m.ertman@intel.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
 <20251118002433.332272-4-daniel.zahka@gmail.com>
 <IA3PR11MB89861F9E74B15B19734A12A1E5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <IA3PR11MB89861F9E74B15B19734A12A1E5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/18/25 2:27 AM, Loktionov, Aleksandr wrote:
>> diff --git a/include/uapi/linux/devlink.h
>> b/include/uapi/linux/devlink.h index 157f11d3fb72..e7d6b6d13470 100644
>> --- a/include/uapi/linux/devlink.h
>> +++ b/include/uapi/linux/devlink.h
>> @@ -639,6 +639,9 @@ enum devlink_attr {
>>
>>   	DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,	/* u64 */
>>
>> +	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
>> +	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
>> +
> The patch introduces a new UAPI attribute DEVLINK_ATTR_PARAM_VALUE_DEFAULT but Documentation/netlink/specs/devlink.yaml only documents param-reset-default.
> The spec should also describe the output attribute that appears in the nested param-value dump ("default" value), otherwise the generated tooling/specs are out of sync with UAPI and the committed generated C (netlink_gen.c).
>
> I'm afraid you forgot to add a YAML entry for the nested attribute (e.g. under the param-value attribute set, typically alongside param-value-data and param-value-cmode), describing its type per param and the bool/u8 encoding rule covered in the commit message.
> Am I right?

Hello. Thank you for the review.

As I understand it, devlink.yaml omits entries of enum devlink_attr that 
are annotated as "dynamic". This is what creates two of the holes in the 
devlink attribute set in devlink.yaml where the "TODO: fill in the 
attributes in between" comments appear. Dynamic types are basically 
tagged unions, where the tag is held by a different attribute: 
DEVLINK_ATTR_PARAM_TYPE. The netlink yaml schema doesn't have a good way 
to encode this. That is why param-value-data, and now 
param-value-default cannot be in devlink.yaml. The best that could be 
done for now would probably be to add them with 'type: binary'.


