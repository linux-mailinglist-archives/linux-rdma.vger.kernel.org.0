Return-Path: <linux-rdma+bounces-6255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DA89E47C9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9C81671F4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8C1F5415;
	Wed,  4 Dec 2024 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoGaxHkT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936B1F03E2;
	Wed,  4 Dec 2024 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351132; cv=none; b=pdKwOAZ4AdfvUN0dwzJ0aHIDp43Gw/BzWSFPp6WtXi1f3ihigOGiXdXdN/VccLp5rAYIE5LUcNltJhAfB5FcH9dURYskJospEVpxLJC7aUXZqcQjnSZYuxDp2xekAx/eTJtIJx1tAI5THKi/h1qiJ10Sg1Mu9Ojbz77FpknlWKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351132; c=relaxed/simple;
	bh=/kXNbBsDI0L2KwpmZLv0VGEWtIQhE3f47pZS+9FhwwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wv7bsDHP7WxweaDIvWc/YnPdRlz9eE6RtJzzxKskEf/tOeAYDnMVQ/3vJprafSC3vBZa3+B9txKNQGPuuUCUML+UO2CnP+V4bw5O+1ECm+5KQ9L9XjPY5IMo/WMrmZi3/nudNDBBeMEZhscIxCBmTuBT2N+TaruowmGnZPDEaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoGaxHkT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43494a20379so2803195e9.0;
        Wed, 04 Dec 2024 14:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733351129; x=1733955929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLIONRbcTeQtSvUowcDR4/PAHfAT0F7pZhey5wVnZqM=;
        b=aoGaxHkTPAHruUTPbul4tkopqu6G8lPgDIS9Sogpl6WOGC4BnoW5Be3QVcNP8LLxFj
         pU+5X+85QCKludSIetQ/NIayw23hWuGDndfr8u5yu0MSmlPEfp//ZNZUva44LeFiqOg4
         5BnCyrcTjlHaCAMxEzMtdCoPyOMkQNNs+O9lf0yv++Q1jTqlJU49U4kTK3lUZbvO/D3n
         p6RDAQKzriJlLlvaBxAbkcK6CvA1m/Fweu+5kltBmukJXU5TscKsMmqyZ+6he7W2V0Ql
         J5hBmEl0A1n6RhJQB2L4qJbvOS3fr4j3JcZsRrDvDfjrIQ7oE/GER5f+BjP55i7h0s2j
         8ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733351129; x=1733955929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLIONRbcTeQtSvUowcDR4/PAHfAT0F7pZhey5wVnZqM=;
        b=canyoh4UAEx27LwCCmUW3vtDAXdEtEYcZ41KgPlQUhS5nh3kmL8cQiOOaok+wEYJvR
         /CS3Z1u0cuj98sXJFJ7bF9uGyL89SdPSk3Zb7RdMdONIKQ6YiwEvMMbK353uJzpFbQHo
         VDQy3sBJpQKOteWQ/8qYTy/Gk5B8vRu6cCf10TsqX7HdQ3fRIc083rwdkSULkKKpeTFg
         FHbt+1zSlnPy9s4ox74ZK03i6zUgqbSNX1A/tshNa83E1GGwu4+3tturRHUBXy70HeRt
         yx5PMue1UgPGYAq2YAFILIvcnVV/FydOFeDQ2GbfOZbab4m+VugWv1NTzkcCxa3RXJof
         GvwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVntW/oljRDXgfe6t0kJEF0gBWqh3nMj3JIt+MTrL92SARyzhkYqMNAQ6CyHdcQJX2DLcD8nmAOfFMK@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFQ/OVnomIitF4txf9BydQaE1DCFLKtM17MICj6Xu5q++kfFm
	wa4C+vHs2MNEpBFDtPWoj7eDtaLHzKa+oTR6TunaHnZhSJS8o82w
X-Gm-Gg: ASbGncv+kNycJv6ZztSXozO6zTpM6v8y7XrCzkmEEjiFoz457uPEql27ljxddL0QTk1
	/ZjrjcSYqzVtsGxPTLMU2sBhRwTCX1SSCbxuLUXvsTr1DY6/BzlAGOl6dbE3r2dyCpnMyCdUgeM
	LXPAkpJZxHUdGd6FJQBNfrmunu1Ie6lPFAe3mm7p8wfNHgGp/uJX76q7JZbWF7LOpvQScbiP6+S
	AlnwF08QvthKZtMN1x/1LG8Z4pBCtdqdDtZIPyPtq96CZjjvyBnT2CC2DNmLzI+euL0tyI=
X-Google-Smtp-Source: AGHT+IFO1wx+E19GaF4F9bkyOhO/Cya2PfIB/njD7N/1R0zFIrqvtPC+Y7aev+bYnh76ONWJRJxOOQ==
X-Received: by 2002:a05:600c:1c82:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-434d4178987mr48458405e9.8.1733351126529;
        Wed, 04 Dec 2024 14:25:26 -0800 (PST)
Received: from [172.27.34.104] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b375sm38709065e9.9.2024.12.04.14.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 14:25:26 -0800 (PST)
Message-ID: <175d7ebd-336c-4e02-b494-3d5580f99111@gmail.com>
Date: Thu, 5 Dec 2024 00:25:18 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 00/11] net/mlx5: ConnectX-8 SW Steering + Rate
 management on traffic classes
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-rdma@vger.kernel.org
References: <20241203202924.228440-1-tariqt@nvidia.com>
 <b466b028-018b-4ae2-9b96-994081e4ebf6@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <b466b028-018b-4ae2-9b96-994081e4ebf6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/12/2024 15:47, Zhu Yanjun wrote:
> On 03.12.24 21:29, Tariq Toukan wrote:
>> Hi,
>>
>> This patchset starts with 3 patches that modify the IFC, targeted to
>> mlx5-next in order to be taken to rdma-next branch side sooner than in
>> the next merge window.
>>
>> This patchset consists of two features:
>> 1. In patches 4-5, Itamar adds SW Steering support for ConnectX-8.
>> 2. Followed by patches by Carolina that add rate management support on
>> traffic classes in devlink and mlx5, more details below [1].
>>
>> Series generated against:
>> commit e8e7be7d212d ("mctp i2c: drop check because 
>> i2c_unregister_device() is NULL safe")
> 
>  From the link https://people.kernel.org/monsieuricon/all-patches-must- 
> include-base-commit-info,
> 
> If we use --base=auto or the commit id (in this patch, the commit id 
> should be e8e7be7d212d), then we will notice that the commits will have 
> the base-commit: tailer at the very bottom.
> 
> This seems somewhat professional compared to the above. ^_^
> 
> Best Regards,
> Zhu Yanjun
> 

Thanks for your comment!
Noted. I'll use it in my next submissions.

