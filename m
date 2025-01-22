Return-Path: <linux-rdma+bounces-7180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D66AA19410
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 15:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9B716BBF2
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 14:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4267214216;
	Wed, 22 Jan 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQQxuy0r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9581212D69;
	Wed, 22 Jan 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556582; cv=none; b=fdCxk+IMrZKSSWPM08ZHB9UiulwVqBafOh/wY8wLxovS9pUNcCvyjrVihXIHyHAJT+9bQexrWdhr6zLnyTCU1lbUUgjaDqX25mVjInSbS0VbWDHuuOHe0fY07oZY3LSXjtQPJI4JJslok1RVEYrBrQNkzssTuemGm+Nd3jZ5YfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556582; c=relaxed/simple;
	bh=SMDAbuQwzc7MzSRZ8aXUBMVB6Jsmdf7IOz/yWT+L480=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMj69AUkbuOfUTZ3m/uHsPIwcYK+ZmAyB87c6Y5gJYd1AsdhAlNPVzIUfk/ejlpiqOQQdmYK15342sQk5DDFhgcW8XzElDrqd+boAE6WUdy81ocew9XestKp8exzdsREVcGjamVhDnMz3mOZpN2BHbWRpJU+o7pC3CrBqyVhVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQQxuy0r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2161eb95317so126448005ad.1;
        Wed, 22 Jan 2025 06:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737556580; x=1738161380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MUvXvaO0Ss+nXb466/o7COpKXUbAueaXJWixHz+8ykQ=;
        b=SQQxuy0rrY0f5yE17Bvxd4cCYwvkWqgYl66D6PC5Qsb6Vw+Px5o9uQGv5CabPHWWKX
         wsZPi/yn96zzCSckak13j/O5HeiI7QjTjJRHHwBc2Ji7mGIoE8gGxC9Fe1k0ph0ltIHh
         cXL38wRvZHuHSvbNz/6p7s8XoasIstJoi8LapqX4sBd4CaWQ6n9XAmtWBY9XyUcPBOcV
         br9APH9oZZrmQiyturDVw9Y6bF3nP5OD7/RZCyz4B0JWA8igWBs+MNs1je1rKVp5DC93
         zMHhsdMt7ABN8+7guIQxUaegGyrgINCB0ElhrBfhuvBuuuiW05wqUN9jJKpUujzhwVc4
         2iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737556580; x=1738161380;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUvXvaO0Ss+nXb466/o7COpKXUbAueaXJWixHz+8ykQ=;
        b=rQdEaXGXY0F4jZpvl6UNScjWAo0yGya2w2+K7ifhYONO5DBJrRo0bV1EJtw+50NpXb
         clknCeekRiGu484+xogAFngsT+FJACRtpougcggFYH5ezsmnQak5y+tTRFGaz3thsKA/
         VElqxDtlT4ko6Kx+xcxRb6qs6oCClM5AP1mv9cqKkhcU0js31Hru4n6JWW4DfIwdBJ1F
         wqWk9YIv151w8tAEBrDR8FiTUyb1IAhLtzbhCAiVgYYXw1j5Zzr098+LCwBlU4Ujyhhw
         n9keJdJFK9OT012LISkXZ4iT64zoKZ0wAiwUCnx3OsuniaOD7tDNHGcgNhPV+7tnN2fG
         7d0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3KfOBiCyMppxjRiUEckMV+Q+/8CgYPgAIxoqIHPAPT4aNvvKuWPp8nLjv/gl4M7xti7EkuwWTNs5Pch4=@vger.kernel.org, AJvYcCV/LxnrqJoPbjKBK7w2z//l7YJmm/nbTcJBHAQN3e7xvfSKBMRUa5TLgjZN3Ki9HQrQZLTCuve4UzMP@vger.kernel.org, AJvYcCVC6D6U6QPN3pCNNQDeVDVWGHeF6ndlJ8RmOlaeIVADVTtI+6aYrtjj8K2yzmE902LqTA7tNFs0yQZl6w==@vger.kernel.org, AJvYcCVCqfF9/W0wdz6c4X3/LinQNekUzd5aravVvJIY2ZVo8oEl/P/elyjfptmXOYivr4vcqiSIC7JhTt3P1zs=@vger.kernel.org, AJvYcCX8+iZ9S1eg2A7Leru7pvel+B1OeJswa9yBAIXNWgP7PfG9YOnviDIWaWxeYeZZ+2MtJa98c0se@vger.kernel.org, AJvYcCXH+bJwSd7Qc8sec4/KWgeS/j0hK/By51d+qAgDvvHpm+GLahSzqTJRV4z3TAxwojOZ65cQW8RTnxlnfmddnunuKgTy1Q==@vger.kernel.org, AJvYcCXm18C5S+SAde06h7XGay4ucLK8vbTn/zf2uT/Wfv3d1d+3lhoYBEPE5N0QF+5z84lxUEIozKVVcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6kzTk8V7SUVZmCm2GczSiN1hsRN7G/5Vnfu+T+RKqIZUYVAd
	0LkFCwPhgjoQQAC7ADQcK63XiHz23oGRgPH4slFGGDbAA4/y/I/39ngqHg==
X-Gm-Gg: ASbGncso2XhrClj/ZOaiQML1/uSrJ+j8TBo2n/1r3AT1yepKL2zdd9+sRGaTf8ReKmK
	A7/ZcR+0zX25htVlB5dRjXhhhMTBQ2a9JbyePWwynJkxvKNBKk2oZh4wFe+ND3oWuRnR+ZiLA5Y
	ddF98nVcvujv3vl/uOmUbUQU47Uq8k12/bWxCbAhA/2iK4dlKSIng32bZSeCmXXExvTLeKjFath
	sEH/bUGAIXoV5fcXVkz/WMAB3CLWLwQ2K1iIoH7uz2rqDeNwe+/QA1Wwt9/hy7VnOFongj1r6im
	PHW85dvPjFBe1dtlS0ysZDhoRWcBWoDjzRkRgBoXmvg=
X-Google-Smtp-Source: AGHT+IE5AzrnFf/Nma9OYi02LQfUZX52yZkuUVNniayLmYZBB0ifS+2Uz1Ehi/Gv2whWoMr2zKYJnw==
X-Received: by 2002:a17:902:c412:b0:215:ae3d:1dd7 with SMTP id d9443c01a7336-21c3540c88dmr336405415ad.19.1737556579588;
        Wed, 22 Jan 2025 06:36:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3aca8asm96019665ad.130.2025.01.22.06.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 06:36:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e9d0552-b565-48e0-8183-d9cb5a85c76a@roeck-us.net>
Date: Wed, 22 Jan 2025 06:36:15 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/21] hwmon: Fix the type of 'config' in struct
 hwmon_channel_info to u64
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "lihuisong (C)" <lihuisong@huawei.com>, linux-hwmon@vger.kernel.org
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
 W_Armin@gmx.de, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 alexandre.belloni@bootlin.com, jonathan.cameron@huawei.com,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, liuyonglong@huawei.com
References: <20250121064519.18974-1-lihuisong@huawei.com>
 <870c6b3e-d4f9-4722-934e-00e9ddb84e2e@kernel.org>
 <d42bf49b-e71b-d31e-2784-379076ebf370@huawei.com>
 <4959c2c0-564a-4e3c-9650-228dede9a1f9@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <4959c2c0-564a-4e3c-9650-228dede9a1f9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/21/25 23:51, Krzysztof Kozlowski wrote:
> On 21/01/2025 09:14, lihuisong (C) wrote:
>>
>> 在 2025/1/21 15:47, Krzysztof Kozlowski 写道:
>>> On 21/01/2025 07:44, Huisong Li wrote:
>>>> The hwmon_device_register() is deprecated. When I try to repace it with
>>>> hwmon_device_register_with_info() for acpi_power_meter driver, I found that
>>>> the power channel attribute in linux/hwmon.h have to extend and is more
>>>> than 32 after this replacement.
>>>>
>>>> However, the maximum number of hwmon channel attributes is 32 which is
>>>> limited by current hwmon codes. This is not good to add new channel
>>>> attribute for some hwmon sensor type and support more channel attribute.
>>>>
>>>> This series are aimed to do this. And also make sure that acpi_power_meter
>>>> driver can successfully replace the deprecated hwmon_device_register()
>>>> later.
>>> Avoid combining independent patches into one patch bomb. Or explain the
>>> dependencies and how is it supposed to be merged - that's why you have
>>> cover letter here.
>> These patches having a title ('Use HWMON_CHANNEL_INFO macro to simplify
>> code') are also for this series.
>> Or we need to modify the type of the 'xxx_config' array in these patches.
>> If we directly use the macro HWMON_CHANNEL_INFO, the type of 'config'
>> has been modifyed in patch 1/21 and these driver don't need to care this
>> change.
> 
> None of above addresses my concern. I am dropping the series from my
> inbox/to-review box.
> 

If you need help with that, and if it wasn't obvious:

NACK for the series

Guenter


