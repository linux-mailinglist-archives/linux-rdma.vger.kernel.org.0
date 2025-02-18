Return-Path: <linux-rdma+bounces-7808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D2A3A1D1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 16:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB473B44A1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E726E14F;
	Tue, 18 Feb 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUBNhI2A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362D26B2CA;
	Tue, 18 Feb 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894002; cv=none; b=hbNf3a4Wb/M/NjxmY5yfNqEFtnTR3KbUauaC5nwcT7FTcTUK1nAqkpk5m/IiKQCUYVqXfXSxxR/h74UkNT+IRNOeNPnD1DlUcFaHM8cD0DED0CVtI7BD6C/LpCwRsscjtk4l+zOHgF5Hzd9bEa3fFQaG3+LPvtW9uosgcxyFvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894002; c=relaxed/simple;
	bh=lCnsm57wRkVUEr2EYPs5vpTf1bNso+B5yxBbk30D+pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7Ql1azARroCgQrtLV5HAjk8ZJSBfIeExrQWyVU13tMCuXkyqlDsBNYNxuyXf+sNEE1PTcKmFqNeEUdEiZao3X62ddQdtLaBiAwj19dSwMLJJ4uBv8CcWPBAVgT7hN4SAYw8Z9sj9Y0qiLJTF0KebyMlZZD3NY1Dwf/EjSSGLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUBNhI2A; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so39418005e9.0;
        Tue, 18 Feb 2025 07:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739893999; x=1740498799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gqq6g37S92FLqCn0P6nMDUdXCxzDP3LeI/hVC3lXB8c=;
        b=HUBNhI2AYnjjwtquo61X4gw2bp04tv2qWyriaGka3YI6y42U4NVLpNm1WLYuI/40Gc
         v/xstmOiZwWYvUdbwrACIwo2/hUaG22dIuB5HQh8cw4B45opimPWbS+t0Qk6PUEn47qS
         f/tmoU+OyZHazuXeQ0OkeUwSdg1O3X4+1t3yVJ+f3xwLccmrhNoe44kXCFGTGR/LzXab
         ABjNu5MSp2QOiAIyWINQWcoBK83rLgl+/Qyj73+d3A1rwQ+3AcLt4Q4kY2rhcxbjLthi
         zh9sTmVS8XdbYn1oXYTkR1U9PCrbr+bgLYTkjnHbm7LsZ5GMrjpBhRL5fcqjG8O6rj7G
         T6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739893999; x=1740498799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gqq6g37S92FLqCn0P6nMDUdXCxzDP3LeI/hVC3lXB8c=;
        b=FUIZjySM5dmywrRXSb4Gpf5CXYTCKq0iKau1Q6kYIyTF7urwWVtJ561I3M2DsMTdJE
         5Rs2qpRCrd7A6ntCDnh/EczllZK42AJlUVS2DFDYodfVE9Il4wN0v91ki9ASGNEofSTO
         uCU6wDCMXERS0JRni31aQosysKBayY3me3IPj2a3udUquInCqGw3mBwy4fmDuaUAOlNb
         Ilbb1Ajp4YXD5z37MTifhZTS2tknJU5ObBrpq73AMeXRMu7sPMLkT78aJpocueVny017
         81YXgXBjJ6v7HfbVlpl0XuSrfAU9T3WldBlfQo8lJnskRADW8Z3cMBrrI7zr0TIZExxw
         kDFg==
X-Forwarded-Encrypted: i=1; AJvYcCUJmQYKScCJnZjbf7VE/+Xglp5uywti2IZ098xR3xpW1PGS6s7TV0CiwxPu5uFHiUDemDV0dVs8bmrTrg==@vger.kernel.org, AJvYcCVArl9UPU3lNSeL9P3FJweUs3A1wrnOCmeUdig1Zt5akqaB+W/2cwbVDue3E72oIolzWs7d9lQT@vger.kernel.org, AJvYcCVPaNk/jGml3365bDFyyg/osn6zBjgt2yqpnwt4koWpNlINNDrDTcEKp27gfC12ydT9KSBZP6AgDp2G/OxniVE=@vger.kernel.org, AJvYcCWmGmiSvfBD9H6Zqel/BMbz05jiYwx1jDGivlnIJQfCZXwjY+E/QS63CRqG5CdRj9q+ilqAwiPo6WY0GeyD@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtW/3mrlSWNv4mc+DPXCbcCGrqfvwTiZFwb+GJe5fEFeEJP0M
	1ZJfyeWRkaOh/YD62TC6C+lIiA79mSQtR8x+92+wSZrtGKOYTNHw
X-Gm-Gg: ASbGnct3G4v8hMwNCIQx3E8F2E8yWntl0NB+HdkFb9Y8NClcUaJ2CUm3QIsSS+fOq3M
	zbLrZXpfekSedOUD3voHgEGVpUcucsNyP2nyCrCrrHVOWp0PxIJp4JMdGpVSoQfTjSwGUls7TFg
	DRgGTCORNPcgUvAQsUr9Xkmsbyb0BIKrhosQ5Ad7ZxwJwhTfzHKAVsREA+wCsdRowHCt61M37j5
	BRERLcFN8BFQ3fHrbKl1Q/IOztKOo0T+RxzviYWnFbVTGh+d90utWH3CMCdl4uMKoQqM2nUNgYt
	mT6WikI6bzmzr1SKBKow+xaSoN+ePp6GnZMu
X-Google-Smtp-Source: AGHT+IEGYm8rYjcBUuXhxOcUcfHVpS6MHONd1DTQowTqDCAeZYwIxDgYTNFQpOLKVNys1bEsUJCtOg==
X-Received: by 2002:a5d:584e:0:b0:38d:cdac:fc02 with SMTP id ffacd0b85a97d-38f33f117bbmr8635842f8f.4.1739893998482;
        Tue, 18 Feb 2025 07:53:18 -0800 (PST)
Received: from [172.27.59.237] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b296afesm103260615e9.0.2025.02.18.07.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:53:18 -0800 (PST)
Message-ID: <59b075bc-f6e6-42f0-bc01-c8921922299d@gmail.com>
Date: Tue, 18 Feb 2025 17:53:14 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z6GCJY8G9EzASrwQ@kspp>
 <4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
 <8d06f07c-5bb4-473d-90af-5f57ce2b068f@gmail.com>
 <7ce8d318-584f-42c2-b88a-2597acd67029@embeddedor.com>
 <5f2ca37f-3f6d-44d2-9821-7d6b0655937d@gmail.com>
 <36ab1f42-b492-497f-a1dc-34631f594da6@lunn.ch>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <36ab1f42-b492-497f-a1dc-34631f594da6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/02/2025 17:37, Andrew Lunn wrote:
> On Tue, Feb 18, 2025 at 11:49:14AM +0200, Tariq Toukan wrote:
>>
>>
>> On 18/02/2025 10:14, Gustavo A. R. Silva wrote:
>>> Hi all,
>>>
>>> Friendly ping: who can take this, please?
>>>
>>> Thanks
>>> -- 
>>> Gustavo
>>>
>>
>> net-next maintainers, please pick it.
>> I provided the Reviewed-by tag.
> 
> The alternative patch was not formally submitted, it is just embedded
> in the discussion. It needs posting as an actual patch for merging.
> 
>      Andrew
> 
> ---
> pw-bot: cr
> 
> 

Maybe it wasn't clear enough.
We prefer the original patch, and provided the Reviewed-by tag for it.

Thanks,
Tariq

