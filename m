Return-Path: <linux-rdma+bounces-7157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6183CA182F4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 18:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A270E168F86
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6CC1F540F;
	Tue, 21 Jan 2025 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze6i0c5l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E2185935;
	Tue, 21 Jan 2025 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480751; cv=none; b=EWLVHwVIbCe5TKrjayMWWx0jo4S6UhVg/UQGr2NuryudP9KHCnepTYRsx7I0tvBeQ6uSHt6Qv2EMEIcnIZlb/zDkvGfhCMizsF5iYJaZWS0OW7FLd/5wevFDag893VUoglLzIvhFE8yAil2yMmRPWxUHtkHfhHF7fBkYDGnZHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480751; c=relaxed/simple;
	bh=dTZWB5gA2aH7Tg7qjPQ2eXnkVx1GW10/+mBHDafwFoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+6k25xqJs/zPZSQOjVxbEbG4s/7kVClNSK/yfz12aOQNwRbtRV5HiLtZgEZu6lP+BmpYaBcblQDNX64JrbC/OT4MvmBxUej+Ldgt6hTlwOaCJ9GVUpKpu5h5gFrAceP8Aa02Eajx7MF7DZxSSv4LmPllwhtOo/BAdvNJnI3mNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze6i0c5l; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2165448243fso129696455ad.1;
        Tue, 21 Jan 2025 09:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737480748; x=1738085548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tjzENzNcJI3kMv2wJNKt36aOtMgEQTQOR9G5/GIQJis=;
        b=Ze6i0c5l3LnIb9RN8ieCaM1duJVraOmIFzD0F5LOI8nuYpowKLv8kyXYA1cLZbHaX9
         lZRO6NBO2Lm3bpF/Yn5Umk4lkP6mQ7OO6rIAFCk3W3Sos5KRA9ohsUiWIRvtSYxpQ8b4
         MyYuHAg8Ewhu+/eEXCb+9cnOJM6cNQMCmZR7gaASuOj5vhWDbOvjw4HLh1tsu5wjQ6LK
         SUsCkr6FeyZUmf435SNYHetbhtuf/FW4AgO8Q8HY2hd1ExTcR4vnrvZDCswEWOn+QqQa
         0+nLpSf8nR6/Z3NHnuu0R0TdiKWLQvnlxdk4GONYL+rpTa8lJF2+LFF8KhMFEHV2aGyi
         h2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737480748; x=1738085548;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjzENzNcJI3kMv2wJNKt36aOtMgEQTQOR9G5/GIQJis=;
        b=pi0Wua03KonTJ1nxrjl+EPmtUNvdAGp4tvvDZH+Uto8xpvcH1ZSSqyNKfJxndMzXmE
         BhxzxoXq7/GTcAzJQCzQSkAAFKDmI5S7Nc30wu1q1SZcu7ta5LAkXGSRJniA3REob6da
         1lFxvp4W27KOgUA9scXK15NXwbXITgoKzX/hGBaFzdrGN/ZaHVW9UeI5dN9Zukbf/cOE
         8TU705CmvgyQCFBXsEMrnfY3pjUZbvz4JOsBYHf4AbfY1Mo+mvkuc3yFN5odLP6fZkdk
         R+5tpZCbRFLkKi7x57LWRVwztbJaCAWQSFmmqDGY/LvPD36xhboE1T+g/6irtQHDPnLC
         OzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeUa8Wcqj8+pEEvubLFnuTSkjaKYMCsw2KjIvDXhhgtM7oQuOhtNgvvf5BxEPqbR8StJ/gSPKGheKu@vger.kernel.org, AJvYcCUpQlKuhJ18G4qH4QGdyyZQNIp2Z5uLu9ccawDlvonpyLMxlybqKrPkSHYBSZR1HQR4UhKRsSMEOmXTPg==@vger.kernel.org, AJvYcCUw/dWXiNgSeUTtIiyVsg+1UMbUZw6vYuu49uyW3kO5EgejIrmc0tW8gL2CukcCfUua3CQTT2yjSR6wuJzSk/wz0VFDzQ==@vger.kernel.org, AJvYcCVENE8f5anXmTJJ2ReEeb3EtEiKOvFKab/VT0vGpYzXj4Iw2bZmTRw4E1XtXgDVgJovHQxorzUF@vger.kernel.org, AJvYcCVac9070jpQPtA+u2VexL0BdUn+/SEgcmQSI9u3w9Krox1WRmuny8N/+A+gyEuWd1cpOKshfxtGofZIirBp@vger.kernel.org, AJvYcCVzMkwx08WUgfF+u4gWz4cGmgEPMtAjAC/Rbj1ARsX7IvWAiGOIwG7/TqrRYbkNdDLtJlSJIAYrnLoRgW8=@vger.kernel.org, AJvYcCWaopZBiiB/PL3xo1uOiTiNLpcDrMEw2J0GcDoLNkG1x0J0gYy5ydylu7ufQb6o8UzWbEV3MVu/Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBk9OC8+qrcps5m/s3BXgokhT3ZiLRYvlBXrKSgi6IX4Fe9VBx
	H5wFn7PLzw+0mC0KpI2aoBnhdtaJ08HUmYMFP24RHAfVVWvSFytp
X-Gm-Gg: ASbGncv+TAkzPcLHmFTlUROCZB97+Kf5YD6CkXoXXtz1Iu3m4w48p6iWHQyNj7f8OuR
	56o/GrRrxy+sV6mhwbY9+ExNeX/tCdD+KWffx1c15v1+qjfYuqZt4/ofch0RTMsxkCLvGnJHonQ
	uGvADaVOJnRWzrrCbXmX/tYn+LLqJDqxlNwTpziqgST8Ece7GLNQ7FyjL64SrOBqDmKsjL+og8R
	YUm9JnQl4RICMUJHXnxYTtJRyzEBqLYE+4cpskPI6Hlr4FuHa8AnsAV8Ww9ITTh2B47qJlB6+3r
	0U0iubkcQxqMXW5qpvUrmH5J2G2tJ0lNZZprlCuJMJk=
X-Google-Smtp-Source: AGHT+IEuvg3vAcQfjXET6AR8ux8wjRA5zzJlIOjxyWZLfufb5XYvWraoCGwicb2vYnn92H36vXW25w==
X-Received: by 2002:a05:6a00:340c:b0:728:e906:e446 with SMTP id d2e1a72fcca58-72dafbda6ddmr28903077b3a.24.1737480747843;
        Tue, 21 Jan 2025 09:32:27 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab81336esm9324395b3a.38.2025.01.21.09.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 09:32:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <193f1583-973e-4d5b-8a9f-559622b16441@roeck-us.net>
Date: Tue, 21 Jan 2025 09:32:23 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/21] hwmon: Fix the type of 'config' in struct
 hwmon_channel_info to u64
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Huisong Li <lihuisong@huawei.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 W_Armin@gmx.de, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 alexandre.belloni@bootlin.com, krzk@kernel.org, jonathan.cameron@huawei.com,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, liuyonglong@huawei.com
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <20250121064519.18974-2-lihuisong@huawei.com>
 <Z4_T3s7zn3UQNkbW@shell.armlinux.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z4_T3s7zn3UQNkbW@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/25 09:05, Russell King (Oracle) wrote:
> On Tue, Jan 21, 2025 at 02:44:59PM +0800, Huisong Li wrote:
>>    */
>>   struct hwmon_channel_info {
>>   	enum hwmon_sensor_types type;
>> -	const u32 *config;
>> +	const u64 *config;
>>   };
>>   
>>   #define HWMON_CHANNEL_INFO(stype, ...)		\
>>   	(&(const struct hwmon_channel_info) {	\
>>   		.type = hwmon_##stype,		\
>> -		.config = (const u32 []) {	\
>> +		.config = (const u64 []) {	\
>>   			__VA_ARGS__, 0		\
>>   		}				\
>>   	})
> 
> I'm sorry, but... no. Just no. Have you tried building with only your
> first patch?
> 
> It will cause the compiler to barf on, e.g. the following:
> 
> static u32 marvell_hwmon_chip_config[] = {
> ...
> 
> static const struct hwmon_channel_info marvell_hwmon_chip = {
>          .type = hwmon_chip,
>          .config = marvell_hwmon_chip_config,
> };
> 
> I suggest that you rearrange your series: first, do the conversions
> to HWMON_CHANNEL_INFO() in the drivers you have.
> 
> At this point, if all the drivers that assign to hw_channel_info.config
> have been converted, this patch 1 is then suitable.
> 
> If there are still drivers that assign a u32 array to
> hw_channel_info.config, then you need to consider how to handle
> that without causing regressions. You can't cast it between a u32
> array and u64 array to silence the warning, because config[1]
> won't point at the next entry.
> 
> I think your only option would be to combine the conversion of struct
> hwmon_channel_info and the other drivers into a single patch. Slightly
> annoying, but without introducing more preprocessor yuckiness, I don't
> see another way.
> 

This is moot because the series does not explain which attributes
would be added ... and it turns out the to-be-added attributes would be
non-standard and thus not be acceptable anyway. On top of that, if the
size of configuration fields ever becomes an issue, I would look for a
much less invasive solution.

The author of this series did not contact me before submitting it,
and I did not have a chance to prevent it from being submitted.
Still, sorry for the noise.

Guenter


