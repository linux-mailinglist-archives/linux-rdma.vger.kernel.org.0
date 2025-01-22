Return-Path: <linux-rdma+bounces-7166-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC5FA18A8D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 04:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582CC3A46C6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 03:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C3155312;
	Wed, 22 Jan 2025 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4R4kXqQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD4137775;
	Wed, 22 Jan 2025 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737515969; cv=none; b=sULh3ArLBVXk1MGw+KI7b/2jG24Q848ZEb2CXKyVPaPb4YAdGHXUxpRBmc5eb0sG/HAoZb3u0gacnH4gxGFV7+pilD40k01/dQv9F2uE3HVqiwG4lP84ncvloRG4gltCcDQLqIyF99TQhj4YfZ03k5G1ArHEQokBYpSinqlX2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737515969; c=relaxed/simple;
	bh=ycCJe4iHPRkD54eEU7PyOP9GUqchf9MNTCeZuUiby6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCkv24+izyGBC0eOuGnuaArGxueg9frZjCOq8voB4gmzs6+cBTBN5cEihcSHZRKfM3f+78zuNfy6mFdvtp8rqWZYUtqIaYGiDN2jmB2CA1DaZsLb/eVJM7R/RppbtPmQQZC6p6S1+mZe0GE98Apkjo8SBgX2YGkWAc4fqrw1kaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4R4kXqQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21670dce0a7so133398705ad.1;
        Tue, 21 Jan 2025 19:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737515967; x=1738120767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ycCJe4iHPRkD54eEU7PyOP9GUqchf9MNTCeZuUiby6c=;
        b=j4R4kXqQfHhTuQz8NgQ1SDPntc/Yc6svmaKBtagipRhdT79FP5rAtG8MFkrzdGWeXK
         TchLaK7aBAT8FlxiLkWTjRH1hdweK20YPIyuLi473xf13NmdMDzRbEat5TGbUBY8atDS
         AFb54p8Cba4rNR6CSO7T+YjJxdHYrsKudpc50Edpy3eZQVa7cpBT6/6nLam2OGAydjHF
         yVUp+WoBIBvKaqV6DQzoVNjt3oCzXK7SFc9QerEh7SNyV45MVP7XvYvu5QY1PdrDvL2B
         0fOMZlWEQ+opgtNLqbBWmWOArstCHr/GKVoa5N7m0T2l2LP0TFovu+ZlU8+8F41HUdD2
         gW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737515967; x=1738120767;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycCJe4iHPRkD54eEU7PyOP9GUqchf9MNTCeZuUiby6c=;
        b=Byrb6cz8JyVi29MLN8/ok2ZRx9dxLiRGgpcMiZXJ3reiM/CQabVhY5S36htFaODUXJ
         UhIQt6cGQ51NmDef/KSWsszuaGsQG/zs1WMr3/tDZ86Wqelhvp+eD9184ovvNNi0rhun
         SqjtBGSvAMTG8rODqpKkl5h0o3PKDFMEpDfLvq4ywBTj0NjbVpNTjW+nX8vKXWrmNXZs
         UY71PFykwCbua9UubsY30p9OB3f2SKuTryExEgWspUr3s0urWkJTryYQS2v9KPJpx1oj
         WesPx08BiINS5rwQVOzR02dCPUBTj+Lmi8AUR9rWwf+AxH7Ui1rl0ilERTQXV/ifSBeO
         3Q9w==
X-Forwarded-Encrypted: i=1; AJvYcCUBaszACbYHxsyVm/GGNqMx0V1ZkfSOl6r+z6c2AyubeCTlPfmNOz2OPawa/Et40I84x52sLyPoS8F6@vger.kernel.org, AJvYcCUJVZPmQlMirN8mhpNuBLrj0/V5CTNjLaZwwrpOizAJbBnAHrIGWrivgyChVVU7R4fRo2BGcehyzg==@vger.kernel.org, AJvYcCVERr5FZ+qDhZO4yuvLZkzCETM1NStODKHh4XQscH9TI59KXZ30OlEjylYg/cMqZXFIGUnKErQRgdk2VEE=@vger.kernel.org, AJvYcCVIc7eZrBMt6qNGIHQzeI8puLrvykmsG1K81RwSES1AyNe9xW6IYX4MwDHLLi8u0XZ90K80rPvpWANkUSc=@vger.kernel.org, AJvYcCVkSxtH6ibhnkskRZLPAh4Tv8kcmFb9QN5BlOPDxf0rUfk7//nQ4qi7Thy6vVffsGm0iID87CAr@vger.kernel.org, AJvYcCWWVYtsxyLEG7obYtmnhXNtzuiXR26j6b0JGdN9UWmT86jZ54VjwgIwsVtPfDRoSMUBr+oMIMOT2lcH1Q==@vger.kernel.org, AJvYcCX0uRGaxUlO6a2ohNzyN+i0WjrSbhU6bF60GwRsmncoGoy0HWFXpQ0aVBrdTENAQFVNMMw8cwHELSq0GBzE1YDP69b3+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLfOJ6Gq3bkBKNT3W40z6sGsGjyYnC1KJWlVWrHt+HtjQIOap
	m/LqBrzKK2nLvf2T5vg295Ez4FkingCXSTwhW/8DzMc1sRnhhJ3lX8ENhg==
X-Gm-Gg: ASbGncvis2MF7zxnEM/pfF1rEGTRCGK3ml/olIRnPCrv3zAJ8W11m4bb4L8Z4W+bnDF
	7hG7851Y0dbIeS3isOdjgXLHJGTPbiFUgUZ1Ac6x6MnCIaFTXk5Tb5A+3yG6BLz+fxumWwnRqNe
	R1+vziGoV579MChsFcqFBefQvqYCQD9ubKKYvUGVhU2PwCcL1CqNSMGxx7riwfrybMuRLntT994
	0gcig3HM6mnAWT4hiuVKr9CTiWYxRvjSEY0AXWcrqux4APb1ggCoxWOPWCzRFcZ/pVYY4n8srDS
	tj40nJFqK7ofnNqwP2fe4kXHr1DixQLGJZnGgfdChd4=
X-Google-Smtp-Source: AGHT+IEOuQB/DKea8GblfO+5X1HYu9hNJgnmEWoKRQBMmJDQJ7xU3ANrN9lhrrI96HZOMNUSbHisWw==
X-Received: by 2002:a05:6a20:748f:b0:1e1:a06b:375a with SMTP id adf61e73a8af0-1eb2160f41fmr35258743637.35.1737515967111;
        Tue, 21 Jan 2025 19:19:27 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba4eaacsm10183893b3a.135.2025.01.21.19.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 19:19:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b965f04e-a706-4abf-89ed-4749a2c0b9b9@roeck-us.net>
Date: Tue, 21 Jan 2025 19:19:21 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/21] hwmon: Fix the type of 'config' in struct
 hwmon_channel_info to u64
To: "lihuisong (C)" <lihuisong@huawei.com>, Armin Wolf <W_Armin@gmx.de>,
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
 <9add68ac-7d10-4011-9da8-1f2de077d3e9@roeck-us.net>
 <fd412ce2-ec40-fe73-6b1b-284a99a39f12@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <fd412ce2-ec40-fe73-6b1b-284a99a39f12@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/25 18:52, lihuisong (C) wrote:

>> Those are not hwmon attributes and should not be (or have been) exposed
>> as sysfs attributes in the first place, but (if really wanted/needed)
>> through debugfs files. Even _if_ exposed as sysfs attributes they should
>> not have the power1_ prefix (except maybe for the last one).
> I plan to accept the suggestion Armin proposed that acpi_power_meter can use the "extra_groups" parameter for these "not generic hwmon power attributes".
> Should we drop the power1_ prefix? But this will lead to the change of these attributes.
> Do you mean 'power1_is_battery' can be added to hwmon power attributes in hwmon.h?

No; power1_is_battery is still not a hardware monitoring attribute,
much less one to standardize. Also, don't change any attribute names.
They are wrong, but they are the ABI for this driver.

Guenter


