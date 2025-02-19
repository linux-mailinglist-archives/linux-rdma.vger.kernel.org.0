Return-Path: <linux-rdma+bounces-7850-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B9A3BF71
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 14:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C517AAE5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B51F1505;
	Wed, 19 Feb 2025 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkrTiSE8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA561EB1BC;
	Wed, 19 Feb 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970065; cv=none; b=ArHMovMynEXnGg2co5oAc3r8ZPNuZjHjltrFuLiGT9jAy72Zw/uW+OFY+tZFtDkDw1F1Ookck/rOy0YzkOK949PbhkmsoISKUSbfl+3kuFyzZLwZOtu2NH9gaBDA14cwMuuWLpTldVIBeJfVUTUGs0mdLvHTXS1RksDI2O09c2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970065; c=relaxed/simple;
	bh=pGOE535JPESVOkJalcuOjvOQHEl00UMEuL4t4kpsmTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUkqjkNgPOLW6GinOOuEes0MMObiSdTYMdVfAmHekoc9AhX6Jqh5M/5NSr9JKmpujluYmSihQVGn0BPt3t8LssUADJDdCzB5IjoUGENtqo2hocPAGU4L2Me0me87HGX1B/w2hkBhDxLZ0uwEkR+0zz6fjzhFw37gf1jKYJvhVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkrTiSE8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f378498b0so3407237f8f.0;
        Wed, 19 Feb 2025 05:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739970062; x=1740574862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3HpZLd+aYslb+R149ASLHhysO3/cTsAOVwWXC8DuTI=;
        b=MkrTiSE8WInnBb+yAPTwVV8m+kYfEAFocbGGKt5s8P1DNjMDRQJoCUWwJvo9RnBU5c
         bxSKfWMB5jODShGWVUMYIzpJwraU9g14lXOo9w+HCoiPcFe9IQrGxQTF6AwCavqLjTqB
         ZoeOCqgZK/VA5GRSSWsNRyN5Oh6riLVqhnoHp5PXaXnzlH3qHRRZF4vPLVP3Fj5NClIx
         REY4a1N1K2kzIb+DfMgIdMz0UL/61PJmvtTJ385kyf7BQAHIfEfbNQ0gCDarRMpFenGF
         sWs4qH5JjrimDwP5AOSHpZLsdxH6HfcESZMEkrBRHotnH3xQR3F5t2Mz4LxPjGlLHYwM
         bVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739970062; x=1740574862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3HpZLd+aYslb+R149ASLHhysO3/cTsAOVwWXC8DuTI=;
        b=vK2/MXKmORyHH/bTJ1pUglYnIuLdLmPzkVvSh1c4hUVL2OPyTMsAFSpeuLlhY7lbkt
         wXx/XMMo3PBa2dpDoKQ/kl0X7VBq+KUZbw446iSxLPLNhIrd4krlD/5UyBhKVO/2NB1J
         IkHOi+lOO3ubtysKxN6it1wA0Z970cKzXuXhiJB2U0eS4/rosslQn0MonGv0n3hgbzGc
         L1guig46nFCYPmozbVHCFdE/JBzwnOJhFXtCzGDtjI9eYqT8/JOl9VNiqJ9wwxLaWEJc
         fVkXGnFHo7IOZDH3tc4q6cRGutcxv3JimkKPdFM64+8h1be3JCfXeGqa78oM9YRMIzaH
         4HAA==
X-Forwarded-Encrypted: i=1; AJvYcCUbriJ4mS39TJJGMrk7IvRY6yma1nmZYNmAIpJ3WdzEVKLfkCV/a9PoWOnwZju70aCTkWvBeKQrs7mvLg==@vger.kernel.org, AJvYcCUpJn5dwXaBEmPV58WMQNxSm2zLC0gBpnYlgxrzA19vb92/DTr3DeADFNATAr7D9vd5abSiQa0D@vger.kernel.org, AJvYcCWPSNxbHy7bx8gqUdf38kApQIh+oQyeU+LXfi99V8ODX3HYFDx6yCOsQi7oQOAgnDtNG2MPtIfL8SMS+3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBB6WPrhua1Wpxb2Cf7eJM9ivQcFZHVSlHQYR1vNx50uvD8Wb
	dYB3pQ3NzEi/xKEuWDKP3yryhT9t63E4bQuDtqg77yDOC1A2hct1
X-Gm-Gg: ASbGncvsyDdT8kr4aokZg881hE0yG+ywqzgZpd2Ogcrmdtc0AsGEFRDhqzcWnl8r68a
	PaK4oENRWnJ8xzAKpSYI3F5D+60HzNAu4I/VFEpItYqEeUbA/il4reptLsyKVxCc+tmXIN0twAx
	k9sTZ9A01s3GfhvT8LrRxWklU7RV4Unrop1XlLINlCS/GZfsowSSEdLGflGnTv3jl5K5POvUXFW
	qpF0cJ52FbDSy7qPcdk46JSvz5ksa5wt8IYNQTI2gdbwTbIhlik3J1gFvG9Q6GbBWOqc1u7HYfM
	AKNSpyxVjOdzIEU59P4yAVMDv+tQ4XUjFUDy
X-Google-Smtp-Source: AGHT+IHxeWotohuf1kI7KK6w/ViTEakVBNdMfZ3xL3gBkPm8R3XNTmC3J7Prc/MrPjdWbeL1SbeFLg==
X-Received: by 2002:adf:e989:0:b0:38f:30a3:51fe with SMTP id ffacd0b85a97d-38f587ca4ebmr2482955f8f.42.1739970061532;
        Wed, 19 Feb 2025 05:01:01 -0800 (PST)
Received: from [172.27.59.237] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f8c4bsm17825416f8f.46.2025.02.19.05.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 05:01:01 -0800 (PST)
Message-ID: <8369b884-71c9-495a-8a1f-ab8ca4ee5f59@gmail.com>
Date: Wed, 19 Feb 2025 15:00:57 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net/mlx5: Add sensor name to temperature
 event message
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Shahar Shitrit <shshitrit@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Carolina Jubran <cjubran@nvidia.com>
References: <20250213094641.226501-1-tariqt@nvidia.com>
 <20250213094641.226501-5-tariqt@nvidia.com>
 <20250215192935.GU1615191@kernel.org> <20250217162719.1e20afac@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250217162719.1e20afac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/02/2025 2:27, Jakub Kicinski wrote:
> On Sat, 15 Feb 2025 19:29:35 +0000 Simon Horman wrote:
>>> +	for_each_set_bit(i, bit_set_ptr, num_bits) {
>>> +		const char *sensor_name = hwmon_get_sensor_name(hwmon, i + bit_set_offset);
>>> +
>>> +		mlx5_core_warn(dev, "Sensor name[%d]: %s\n", i + bit_set_offset, sensor_name);
>>> +	}
>>> +}
>>
>> nit:
>>
>> If you have to respin for some other reason, please consider limiting lines
>> to 80 columns wide or less here and elsewhere in this patch where it
>> doesn't reduce readability (subjective I know).
> 
> +1, please try to catch such situations going forward
> 

Hi Jakub,

This was not missed.
This is not a new thing...
We've been enforcing a max line length of 100 chars in mlx5 driver for 
the past few years.
I don't have the full image now, but I'm convinced that this dates back 
to an agreement between the mlx5 and netdev maintainers at that time.

80 chars could be too restrictive, especially with today's large 
monitors, while 100-chars is still highly readable.
This is subjective of course...

If you don't have a strong preference, we'll keep the current 100 chars 
limit. Otherwise, just let me know and we'll start enforcing the 
80-chars limit for future patches.

Regards,
Tariq

