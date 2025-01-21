Return-Path: <linux-rdma+bounces-7153-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74359A1806D
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 15:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E915D7A3D52
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C081F470C;
	Tue, 21 Jan 2025 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo+HdtmR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6E1F4702;
	Tue, 21 Jan 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737471007; cv=none; b=kBlzNDWN3W/l0I8nYutMRumqF/KQa+OH3Nlz8mXIHR+pfrMsLXHCTIAXik8mQdv9QBVa2gKR/rxEVjU3aDYN5ItEVLUUr1a5mlRn35v2EmeSr+92Y2o8qhpZhfwK9PXLy87+kukFgTtLJ/EXz5FEG+y5vgAsObe6s5IWgbu/oBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737471007; c=relaxed/simple;
	bh=q6PU2aBXSMpfGHMKa+L/pm+2nb+G4SbfY+qlKO4QeRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIOtJWjhTA5Humzh9Tv/tvq5aPu/5Z/DoATMZcjLzVhe6PFha4/u8AeP0R2LbufIcg4xV9q06hcqT/sh7GDJCJ1POl7whju8OqRckYX+B8+2CbSeamR3u/pJxbDv7us8s1DpqVBnJW7oTUW5Ffo5UYk67hiMKC9OGCITO32UN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo+HdtmR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166360285dso109838185ad.1;
        Tue, 21 Jan 2025 06:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737471004; x=1738075804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tyjXj6/KNDcVjaCHEulSXz/uI9P6HE6Zw6E3MuTClVs=;
        b=Oo+HdtmRLSvLSOJI4QdT3vAI75MUcHUzbaIiaLKwdvukB3O7xdLS+BL7UyHN+XYdet
         HYQKrUswleYb1JgwS7XZJVUT7QgRE2Z3fzNQNAx+vXArYmyZZwI7sDaq5Tf0h9mpHMQq
         z7BJm/KpPMiLNffNExveKU+Qia5xI/wuq/0fbdKiWjAqlZsCrebVDAdKNH6nuw0gKViv
         Jx3BRKOxrZzbHOS06MMwGnCLaQmorNe2PJiLw/lHh4q2oFgclQWwPaEHVQ+KTIz55hOI
         7N4jvBITy1DQOYP0SDkwrpZbjeoFHLizM4hMt8l4ZJEjqpr/nX+xHtgMN3VUSDMcSFN/
         beHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737471004; x=1738075804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyjXj6/KNDcVjaCHEulSXz/uI9P6HE6Zw6E3MuTClVs=;
        b=FhwARtTXVVR3gXth/BJS6R8k/ZCpL+H97AJtmF87PcR8m3+Us+4ZgP7AgiIXV0n0Bg
         2n2Qz1vtsx/LG2zLFynpRz9nXcb5B7/Uchbl9q7YodMYhGWDU6HPPqP3+FaL4pLxSBMC
         zMqjqvSN/jfFEtaMXliOY+hdO3sSIjoo/t114ujq7xFUeU0r6+iaRvpUJd5wTmloYlyH
         zvrsjfDeQj10FOOTJAXvZ5AJMGi5W3KgZsn+8EDk6lmF5fdNPFB2UTsGy+f/kDDYT+9D
         82JvLbCQ+RyLwLgYHuKI+eIDQqDCvIMXgoyeW3p7x07XUGmslGRw/0T5FtSRmvGxyVfW
         wp9A==
X-Forwarded-Encrypted: i=1; AJvYcCUD447SpzEZ5ZWoIaAG4yQ/VJuW0UsZgx3vJhpoKRi1ncIxVWgVNtV4R0vSHK//Q+z6EAHJe2zW@vger.kernel.org, AJvYcCV4p31UaWq2ODZqTC5kaasgZdBxKdu78gqoVJ7+g+6jf2Bip/rLURUQ37wHZ+4kgiC/z8EEWBVKMwwgjg==@vger.kernel.org, AJvYcCVHDBcuNofP9K+rLaVQZmpe2U0UCeQjkIG9/RPHa3Jq5XB5OzqmqgjlMi5uRQf8xbLL+7Yod3imeXpl+s0=@vger.kernel.org, AJvYcCVHf4guPA+D5OzBZwKjPpga7AtEjQuICu13ZGdTqp1cYHGIDzujmVaVGwC86BmPaPJuw1fNZNDoOA==@vger.kernel.org, AJvYcCVR4A5KI9LymffVfzWUNB+bxn3E2fsk++gNg7Dz43l7u5mDsN5F+sNFESYlaFiIdQdaQXHtLB8YB2ZM@vger.kernel.org, AJvYcCW+oGgAi0Q/zj1ZDkfY28wqls1jh1DSYt0GTVOoR+ZmTlNoUwdC6xPr622okinqcARsMYwbLLI1a80ZQhU=@vger.kernel.org, AJvYcCXGG0KbtMjpPh8/dWxiaud/QXL7V/hXa+Em+C87WAWCGqkd8DLJa19ye5tY9mSoT2kSadaYOtJ7CQltaNTEYr1M+yehOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWyOf8nMBPu4rmyRx+KqLyw59habpOBDemFy5DW82YCeBOOuaT
	dso77kSmk8xVBHzL/wksAkMXza6MhZ+As9W2WuZO1XIFnqK4ZVE0
X-Gm-Gg: ASbGncsqaRtpRORiVerRnllJ5aU8Y9oD//nGasB+5yYN1T1l5kNNY+A+GGwZLvtPLyr
	uMAD5+V3eBs3G1LwalB9kUR2jwbdgj3UrLf0fRCBy7KPupC/201bnDvdc3AMdXUrbrdJq7vJWDB
	dtq8o8lyo0k53gXa11dZdfSXrTVhia684e9PP39mgAbus+wGOf2FebrT37Y+bWiAxowHG9nBnai
	3V+nhHOChWGePVN9oy7blBwVbpZamwXh7Ap8BoU9QG4m6aWaDHRUozEIDlBiNpFQhoK/Kh/3zUc
	FrEnPQadRphIxR3p7ToAIjBh+a7EaWRjlbXX0DF0P7o=
X-Google-Smtp-Source: AGHT+IGa8euy8ctdPku6RH9wn/ij1IoREIcMzIg1bS3C5EBD9/bby5gxudV4Xq/7CPl6KPAotuFPGA==
X-Received: by 2002:a17:902:e74b:b0:216:4cc2:b1e0 with SMTP id d9443c01a7336-21c35513386mr223610615ad.20.1737471004421;
        Tue, 21 Jan 2025 06:50:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d402d40sm78437145ad.231.2025.01.21.06.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 06:50:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9add68ac-7d10-4011-9da8-1f2de077d3e9@roeck-us.net>
Date: Tue, 21 Jan 2025 06:50:00 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/21] hwmon: Fix the type of 'config' in struct
 hwmon_channel_info to u64
To: Armin Wolf <W_Armin@gmx.de>, Huisong Li <lihuisong@huawei.com>,
 linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
 netdev@vger.kernel.org, linux-rtc@vger.kernel.org, oss-drivers@corigine.com,
 linux-rdma@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linuxarm@huawei.com, jdelvare@suse.com, kernel@maidavale.org,
 pauk.denis@gmail.com, james@equiv.tech, sudeep.holla@arm.com,
 cristian.marussi@arm.com, matt@ranostay.sg, mchehab@kernel.org,
 irusskikh@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, louis.peens@corigine.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, kabel@kernel.org,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 alexandre.belloni@bootlin.com, krzk@kernel.org, jonathan.cameron@huawei.com,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, liuyonglong@huawei.com
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <03b138e9-688f-4ebc-bd01-3d54fd20e525@gmx.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <03b138e9-688f-4ebc-bd01-3d54fd20e525@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/21/25 06:12, Armin Wolf wrote:
> Am 21.01.25 um 07:44 schrieb Huisong Li:
> 
>> The hwmon_device_register() is deprecated. When I try to repace it with
>> hwmon_device_register_with_info() for acpi_power_meter driver, I found that
>> the power channel attribute in linux/hwmon.h have to extend and is more
>> than 32 after this replacement.
>>
>> However, the maximum number of hwmon channel attributes is 32 which is
>> limited by current hwmon codes. This is not good to add new channel
>> attribute for some hwmon sensor type and support more channel attribute.
>>
>> This series are aimed to do this. And also make sure that acpi_power_meter
>> driver can successfully replace the deprecated hwmon_device_register()
>> later.
> 

This explanation completely misses the point. The series tries to make space
for additional "standard" attributes. Such a change should be independent
of a driver conversion and be discussed on its own, not in the context
of a new driver or a driver conversion.

> Hi,
> 
> what kind of new power attributes do you want to add to the hwmon API?
> 
> AFAIK the acpi-power-meter driver supports the following attributes:
> 
>      power1_accuracy            -> HWMON_P_ACCURACY
>      power1_cap_min            -> HWMON_P_CAP_MIN
>      power1_cap_max            -> HWMON_P_CAP_MAX
>      power1_cap_hyst            -> HWMON_P_CAP_HYST
>      power1_cap            -> HWMON_P_CAP
>      power1_average            -> HWMON_P_AVERAGE
>      power1_average_min        -> HWMON_P_AVERAGE_MIN
>      power1_average_max        -> HWMON_P_AVERAGE_MAX
>      power1_average_interval        -> HWMON_P_AVERAGE_INTERVAL
>      power1_average_interval_min    -> HWMON_P_AVERAGE_INTERVAL_MIN
>      power1_average_interval_max    -> HWMON_P_AVERAGE_INTERVAL_MAX
>      power1_alarm            -> HWMON_P_ALARM
>      power1_model_number
>      power1_oem_info
>      power1_serial_number
>      power1_is_battery
>      name                -> handled by hwmon core
> 
> The remaining attributes are in my opinion not generic enough to add them to the generic
> hwmon power attributes. I think you should implement them as a attribute_group which can
> be passed to hwmon_device_register_with_info() using the "extra_groups" parameter.
> 

I absolutely agree. More specifically, it looks like this is about the following
attributes.

 >      power1_model_number
 >      power1_oem_info
 >      power1_serial_number
 >      power1_is_battery

Those are not hwmon attributes and should not be (or have been) exposed
as sysfs attributes in the first place, but (if really wanted/needed)
through debugfs files. Even _if_ exposed as sysfs attributes they should
not have the power1_ prefix (except maybe for the last one).

On top of that, doubling the size of configuration bits for everything
because one sensor type needs more than 32 bits seems excessive.
If we ever get to that point I think I'd rather introduce a second
sensor type for power sensor attributes.

Guenter


