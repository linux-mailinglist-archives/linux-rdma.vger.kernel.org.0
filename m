Return-Path: <linux-rdma+bounces-7158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0EA18312
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 18:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D4A3A19E4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3F1F5432;
	Tue, 21 Jan 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCWG+GmJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB113213E;
	Tue, 21 Jan 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737481079; cv=none; b=UeoiLVcUpVA/ZNKOKUpnbCpi/M9MCe+VtCJ4CxpXxdSdxZ/AZmThdqiwKhF9e6pOaGMsWvEdzcgViHQLl0XwGyOPb20DnvdYRMu6IOfeOmRjNT31EEpnrd70PtynoC2rIJgTv/fqBKxkFAfi08uZVM4pePdykd3rUVqTF1yuq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737481079; c=relaxed/simple;
	bh=M/XrGSUsxs1D+fGUTmUTE3TVHjLRKTcWBkuR8eI2Kd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etr1wXZXUNjLA4CR+NrF9vvHYpToSFMaVvpHJpux+7/R7X+Q9Ns7SW8iqvyhpg34a3Bqs+vrVMj6kJyEboVCYKJeMTmadspKC8AWgNp1n072SNPZ75wCmEVHfOnfw430dq+mVBf5HKFGWLj4Z4vd5U/WcSWeVSCKP2vw/WYHlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCWG+GmJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21670dce0a7so124536785ad.1;
        Tue, 21 Jan 2025 09:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737481077; x=1738085877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=njrMv7/v3hrxrqYA6u5qEwMI8KFQ0dRUo1yYjGE3JFk=;
        b=DCWG+GmJtBrypejro/X/nQo8UA6127TRlNccpsISAzCOw3L21pX342p2RCJIfzI2MK
         goTMMGj6jKIMnwbF2tpS3OadTdZpxv8Y2xMe/DiOwO1DEtYtRKFQBOMOP+Ub9DBhVpIB
         tLaeEL9x7bU8+i9W19DHCVgQZm0+BXFZiNyVDK0J8FEgaEs+J3CCTlLDK7ls9/xwr9zX
         1Jqtqo7ZFs0Hlf+j7DkU+fZsBxIuLl0Aeeo4TV3AH0xHFeQL0ChS4aH3uGO0+Hlxipx0
         iIG/+g0GuY9xidsqNyzf2breITFbCLm0JIq54mHO33dzKaXhRIvqSqBMMRyv6Nnr1XCe
         0LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737481077; x=1738085877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njrMv7/v3hrxrqYA6u5qEwMI8KFQ0dRUo1yYjGE3JFk=;
        b=mFCVTIuTy1rFtPURNZKCzamiaiYRxtRNkMjfA8+OaNL/neOGuSrhd5l+nDZz+2fJAC
         H7I2RLD1M+/JHqnXpX4T8ABHwUqL0izwLIT8VyKiGQPj7eMnzcd/u58NrVRT+GQirOQ5
         koa2qfZ5rNnr5hKPbh2ga4alX04+eKLQyFOVVytyaniGPFLUYJpUoSlmLuLdgOIim6N8
         xz2eSlT3qhObPn1AnBMPc7oZW1OJdR1FCtXetvSULnCuR5wZ2RiyuX7rGZQnTDaodGUx
         Nc9fxKD80+Gtq3u2tzX++5kOeub9Y+SODWjEDlbBu+TSaUgDQC/kzOi66qHAvdesCE7O
         /YHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLU49w8eZTQMSGBwZqe6DAdLZj4yExJyYU9ZXUT5kXBaKi/Z4o12eTZGNecIRxRuDF1I40HUfi@vger.kernel.org, AJvYcCVmiptKQwoSQJaR/iC8wDKeILVZ5IQi8xCt8rrjXuvhZe50Ab6vVdtJg6mwVTXDncIwUWWgHJUrSvKD7Z8=@vger.kernel.org, AJvYcCVr69SFEmC5k+ML7nzBCVg7DFHhEdbmdKHW5nPRwRlcxciKEpn378dUV6VB5y1FOVScxCuPOXkN78uEVzY=@vger.kernel.org, AJvYcCW5kbKil7Tm+V17gEjCOyBkp1Fvx8hnMn/+OgByEX7Motf6sKaVfoZlTd6022l09n3i05RRxsuv/U6rBExN@vger.kernel.org, AJvYcCWiKDf/WTW5W2cL/f/YIN77NQQXghh+ioeFCu4+FqgSKGuymC69TMots9kXgNtU+lk5VswghRAB3Ws6juXyOYW68g2jZw==@vger.kernel.org, AJvYcCWohTyckOa2BKTDi8BMkqcdK/z7qAk/22lyutjNHcA/Am4qwLQIctwjJdKoDg+pjMKzqMmWKajzHm6B@vger.kernel.org, AJvYcCXSJAJmp6wEh8zMoAnnUCVvQvrfPiMgAArZDOxwscYFwtGrmuW0YyHlP4nNW7Ci6i6m+5AsgEgVuraX+w==@vger.kernel.org, AJvYcCXuVxgu8DL8eWH95clLXQ+qbnGioLxxXLR65kA7yyxXdkbUohKqJdS0oSEK7CT5oMNhHliy0wYKuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSuR6OYHngw/cfWznysQvWILQ4FLLZutpgNmckfIBW1VLXAYdQ
	bsWisV1bTuqPw9W7hW6V3Hu823lp3NSntbK5fggIBtlQFDpdbykz
X-Gm-Gg: ASbGncsOzlAIEmv786J3vIUybTVyV9eQJ1kGc+GD+s/6luUowQIwEosqlBx3to0ibB/
	0U47JR11qRs0PsQu8ISBri3FyGW8dj9b/VMglbDBMZguMBJtQVlojZeG4FTusXiz97GgViP5eag
	d+YHgPQR2INas0EjZ/V5ZocvnXn9sZBVN6SKMrJKw1BJwwtd0UdcUsIULL1NOVf0EV6o2Y2hRFt
	9aHYBGrKqZmF0reS5IhEGY9FcLwZ6bbOPIk8bhdXsEJOtYP7VDZ8d419hHbEAxZgSmaO5lFJOFz
	Ev00jOzA3dIAttHA4UkqctktbrAPiMjIqV5xjYxgkV0=
X-Google-Smtp-Source: AGHT+IEJOI4zC1nxoJutJ0GIn7T5vVTBsqgozLgVRkp1XHIsrJ/AQjPAJdeaf4DFlti33uVCSnqVhw==
X-Received: by 2002:a05:6a00:4fd3:b0:72a:8461:d172 with SMTP id d2e1a72fcca58-72daf9becfamr29107128b3a.3.1737481076941;
        Tue, 21 Jan 2025 09:37:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabace1bdsm9639120b3a.171.2025.01.21.09.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 09:37:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d945ddc0-06e9-4ca3-a9c3-c19dd9457d15@roeck-us.net>
Date: Tue, 21 Jan 2025 09:37:52 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/21] hwmon: Fix the type of 'config' in struct
 hwmon_channel_info to u64
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Armin Wolf <W_Armin@gmx.de>, Huisong Li <lihuisong@huawei.com>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
 oss-drivers@corigine.com, linux-rdma@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linuxarm@huawei.com, jdelvare@suse.com,
 kernel@maidavale.org, pauk.denis@gmail.com, james@equiv.tech,
 sudeep.holla@arm.com, cristian.marussi@arm.com, matt@ranostay.sg,
 mchehab@kernel.org, irusskikh@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 louis.peens@corigine.com, hkallweit1@gmail.com, kabel@kernel.org,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 alexandre.belloni@bootlin.com, krzk@kernel.org, jonathan.cameron@huawei.com,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, liuyonglong@huawei.com
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <03b138e9-688f-4ebc-bd01-3d54fd20e525@gmx.de>
 <9add68ac-7d10-4011-9da8-1f2de077d3e9@roeck-us.net>
 <Z4_XQQ0tkD1EkOJ4@shell.armlinux.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z4_XQQ0tkD1EkOJ4@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/25 09:20, Russell King (Oracle) wrote:
[ ... ]
> 
> 1. convert *all* drivers that defines a config array to be defined by
>     their own macro in hwmon.h, and then switch that macro to make the
>     definitions be a u64 array at the same time as switching struct
>      hwmon_channel_info.config
> 
> 2. convert *all* drivers to use HWMON_CHANNEL_INFO() unconditionally,
>     and switch that along with struct hwmon_channel_info.config.
> 
> 3. add a new member to struct hwmon_channel_info such as
>     "const u64 *config64" and then gradually convert drivers to use it.
>     Once everyone is converted over, then remove "const u32 *config",
>     optionally rename "config64" back to "config" and then re-patch all
>     drivers. That'll be joyful, with multiple patches to drivers that
>     need to be merged in sync with hwmon changes - and last over several
>     kernel release cycles.
> 

Alternatively, add another sensor type for the overflowing field, such as
hwmon_power_2 (or whatever), and use it for the additional attributes.

> This is not going to be an easy change!
> 

Neither is it necessary at this time.

Guenter


