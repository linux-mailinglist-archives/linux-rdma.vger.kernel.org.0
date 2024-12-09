Return-Path: <linux-rdma+bounces-6351-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A569EA0C7
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 22:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24103188679D
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72331991CA;
	Mon,  9 Dec 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQNBvEpG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4DF17BA5;
	Mon,  9 Dec 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778206; cv=none; b=gx3JEJs1Mfghf6iqtBFYLhxhfQ8S5z+NZd1KZ5qoUwgsAJc2wV9ukI08vVZdOwL/nEojUnbRfkw7ozAfboxQB0dcXFigaAaq01RbZMHD5ymi0xpluUyUo54y6WEl6HkrOYMQxAsWtPtGiRC4X56cdyZ53L0h0BeMQ8LoAHIJxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778206; c=relaxed/simple;
	bh=Vg9V/KFdH3MyDbYzao08lJam5ORvOKurRXssKoJLFZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGjzlbh3mOsWXWDsG1Vx+ZYvjSAABpWoqtbjjZy4RcMgePTmnQsX+iRFyM8Y3FbqxUPQxBx8PKeNFv9i84OQV+r3v9W9LeHc+Pinb12n19fzz8ABAz/l4LnOYXTaKfOEAngWU4eWHCBAJxKmusMb/xNzLjX6LLme+xX8afnmt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQNBvEpG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa692211331so199059766b.1;
        Mon, 09 Dec 2024 13:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733778203; x=1734383003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43nMCW4CLudPa3XNvsGhTyFaEa0j40gL/9PZfYhT6B4=;
        b=iQNBvEpGiuFdctCw6Wh5GdMseAUn2bcCbBSBIApukO0xjn7ne5LQNar8lSuplNKjjy
         WJ5wH7Vt69L795obGRv8ajJPseeEnlG0AAKHwirrCb6Tq1x/Qnd/9cR5EtKeJwofa6ue
         ipR2c/yc0gzqyP2AoSVHhUhd67AEQSvAuID3W8M266iLnPfVHOOYEPEvsjoBBMGMby6G
         PqWanCKNaCMPHm9nk2e/awDQy8gVSoVTcK7doNU5EA93JwdlkunH9M8rpI4fbxgEaZty
         nTwJ45vCs6OiVA96+x7vcq2Y+qoB+Pimc/FFnuukrN51FRyp3cMZ0emBcV4TtBPJ133e
         Tn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733778203; x=1734383003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43nMCW4CLudPa3XNvsGhTyFaEa0j40gL/9PZfYhT6B4=;
        b=E6N9/67A6HAlhKaUE4q/D6YtIMIwnY8A64clRdrOfxDK2iR5prEVd95sUMkSGXTHSh
         Jz7eto+gMzSdP/d6uyi2Gv7qi++LcBMeT2SVfMpsgP2OI6bBTOziFqTIHJCRcCJZJMkt
         p5uJBKgRhtmjcdMW4e8TOBCMCWWfk8en7IQH5RsSnKeKrPJbRMJ55qWA5yjoe6y6OqzL
         3Lv5KlO3GhyWbbKqIVVPHyH4/Wj0ES64208dPUDSiUT03ii3cmJWv0DnIy0XtsKVGYOj
         F7QSipwrVNZIE1baQ4H/IHlynJ1Y4KdPkLtpFF4BjdNlIQW12zanOd//EceiE/VZD04o
         rKdw==
X-Forwarded-Encrypted: i=1; AJvYcCUYy64AfotCB7k6WV4L4nxxA/T/kn3MHRSVvynsLoBUnornpclkMASQmApnRGi+e6A/dtNyg7SRk23t@vger.kernel.org, AJvYcCXCP/Mjo+w3DjtkpR/nEbhM8H2u17Gp0WqxFCEvnIitqqwBR7n61P4ENhf26nm7RRq0s6iGrWUa@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqOgXCze4Yz/n3+5dgLT6HfIybsemgst5YQ/XvEBRWcbB3i8q
	sRVYx80frqoq7fA2z0WbFaQY/nG6mOH20yd/TOZztYL4CtBgtC1U
X-Gm-Gg: ASbGnctgGodeozwsqwxEz8oxzCWcNiOE5jQSTkjl/Xk/4YCBCyz/mv517JfSAmh4noe
	tDCDZUc251FHURGCEq87IuYfT5jHqZ6iwIPtry1I5FmkviUb/kYuoIx4tM+/eIKqQ+lw6L5G5QH
	TkK0gr58F1vBwHexhZZKnhTgomGMpV6uTSowk45hz0HTNZC1p1RQNrY1Am8KzxVMsMkm5kdH7Ay
	BAXyVslfOKuDPSjA+eAvZfAiwMgg2ifZYi/D9G6z0LQOXNlPW6VVn6h1qut/GCOXHG4Zjp0vA==
X-Google-Smtp-Source: AGHT+IFRPHbUhmQtO6WD02oFAaHIdQA3ToTNK7uZnzrQbc3X6/4H8EqpAXJpFhhpyo4DzbFa/aafpw==
X-Received: by 2002:a17:906:3119:b0:aa6:950c:ae1a with SMTP id a640c23a62f3a-aa6a021a37fmr97521166b.30.1733778202854;
        Mon, 09 Dec 2024 13:03:22 -0800 (PST)
Received: from [172.27.51.67] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa650ea7369sm438445166b.74.2024.12.09.13.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 13:03:22 -0800 (PST)
Message-ID: <89652b98-65a8-4a97-a2e2-6c36acf7c663@gmail.com>
Date: Mon, 9 Dec 2024 23:03:04 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
 <20241204220931.254964-8-tariqt@nvidia.com>
 <20241206181056.3d323c0e@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241206181056.3d323c0e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/12/2024 4:10, Jakub Kicinski wrote:
> On Thu, 5 Dec 2024 00:09:27 +0200 Tariq Toukan wrote:
>> +          min: 0
>> +          max: 100
> 
> Are full percentage points sufficient granularity?
> 

Yes, we think so.

>> +	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {
> 
> NL_SET_ERR_ATTR_MISS()
> 
> Please limit the string messages where error can be expressed in
> machine readable form.
> 

I'll fix.

>> +		NL_SET_ERR_MSG(extack, "Traffic class index is expected");
>> +		return -EINVAL;
>> +	}
>> +
>> +	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
>> +
>> +	if (tc_index >= IEEE_8021QAZ_MAX_TCS) {
> 
> This can't be enforced by the policy?
> 

If we enforce by policy we need to use the constant 7, not the macro 
IEEE_8021QAZ_MAX_TCS-1.
I'll keep it.

>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "Provided traffic class index (%u) exceeds the maximum allowed value (%u)",
>> +				   tc_index, IEEE_8021QAZ_MAX_TCS - 1);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
>> +		NL_SET_ERR_MSG(extack, "Traffic class bandwidth is expected");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (test_and_set_bit(tc_index, bitmap)) {
>> +		NL_SET_ERR_MSG(extack, "Duplicate traffic class index specified");
> 
> always try to point to attr that caused the issue
> 

I'll fix.

>> +		return -EINVAL;
>> +	}


