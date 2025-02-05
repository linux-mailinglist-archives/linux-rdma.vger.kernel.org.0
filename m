Return-Path: <linux-rdma+bounces-7419-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24A7A28535
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 09:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7321681D9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67721228C9E;
	Wed,  5 Feb 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E70ahhN0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010F20F09B;
	Wed,  5 Feb 2025 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742541; cv=none; b=QVRu+utl7UiZwZTHIFqWGAitworjSYTkqA47UoelA+oRDt8Tu4S2h7bublC4YWuYGfMzBmpGWSmu8wtWgB9q3f5RZs1Vnh4ljne3/H3ne7VkuFqNIk+wUISojzQKZS00D4kIqGPUczuM0qZZorTYSrBgmJFMz/nYDfhcFncI71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742541; c=relaxed/simple;
	bh=bajsZH221Y3VTUhidxd3s33nRkwjETf7ApGS19h9Ur4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0P6LtfS0n1fbx+2eg8MpG9hMm5jC7vpLGXHeysZ+dIs2DH0bUJN/wFKJUWwhD8qKlPSKHi333/gRJYLtXD1yabnx6kyIoBkwluwBnuFCtKfwW5MO/Gcu1b835OsSEeFJuDlNn693Saeea9mnF+h9kxzcRBbn53qIZKhq4UQKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E70ahhN0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3863494591bso3270405f8f.1;
        Wed, 05 Feb 2025 00:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738742538; x=1739347338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rI0+KsZOu0kNMdDfrnhMO1ES+W3lHGiY/0iXGJPo704=;
        b=E70ahhN0sn0fUvktJNzFiyN4x/ivAxUsezwxAY0aOIKgR7z7nmY0Hygk1wGEDcowIm
         N9mH4fb9obqKipLc8Rsnd+WbeTbkJDB6F9Pljao0jQ9x4SzB4AHDIujJX7GR6TPjrCDM
         yVkKgKfvdSmrHXjYPYADB5atkhchziuzE2jXy8DOXDQHH5iLgsBu6n6MEHblqTR7uh7M
         frmvfy+oodxIAm3u2dgjGJyqYznac3b5uP9joGAzdHzMz7HUg0z8y02JVxq5m5x9IYVl
         owBZB7eblibgtiFndH3J9IpyS0gcjMN+0taJ39+LuyOIvxdaBF3bFUJP4V7GN1IWKxoV
         YUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738742538; x=1739347338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rI0+KsZOu0kNMdDfrnhMO1ES+W3lHGiY/0iXGJPo704=;
        b=hFU/rduPmTGq5f3lBh4kShPm8kb5wOrFvD0aHLdzDJzy4HZDqZTopmWPd5ypinTzDi
         NlRSt+WGYHQCrA8tVTapBVA5THPesrWu+LCwqmgucxJitlZ4CuW60LqPY7gIrn4L4rkC
         Xgu/A3fAdEdVJsAJC3tBBHfRUdFUp0xlOq4Vrznw/73qjtXCK2Kkw9FRCy6fZ0a8VbG9
         kyRDWwS6JkJr9tENru3w3kI1pjC0SqPKmOihIb3eaM2oYRytqFP3cmlMsPrj1Qpe8xLu
         88HsKKSdyzM9Sc8L0TWTroIWfGAAtDMQj8/dT2WltONG6TT9aSsjyX5emdy0UncWCFMy
         +ceg==
X-Forwarded-Encrypted: i=1; AJvYcCUxceFcP3eZC+jocJHHmVSozi2DhFRe38Wamvo1b3WIEDSsCsDP4I6jTPm9UYiUoh2KlIfpNUz+@vger.kernel.org, AJvYcCV5zRjL8RGyY2h0RPPYKpLOPWrAQPIIiO54aNTxIvxwlkt+jFcvoc+bRl7vhV2S2cTdUR4gmIeit/P0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjo9wwLJM+sGKOJKtbsovePzs/oJHvFSK2EgLZMKw/3dAMGqT1
	epo7cgiKo3P09JFJu/pCE/8IKCkN15LZAXMKU/CRQ7XP6+jCXyjL
X-Gm-Gg: ASbGncvRMF4CSOb5V88VZnePvWn164FTVMmrHbyK8cxdloL9he647SH57ntsSCQHvNp
	Uu/Az3bzL/xlRaKmt4WJXviumN8BAXOG5agxTIwLKUqbGxX1DLFma2LoQCeXnJfUNCAW6UIGUvh
	Aq+7P0r5XsjQsa4aSQKPIoLqOIkvy2mwpMjskAa5XWRW8cvBeGwttRFNyelEVuc9RGK4fq7vj5O
	+tTWHa8JdUyHnIJjwHtmkiEMYrnw8WaVcjSIWXjn0qeA5smNXelUOsupDYh90jq/4tY59d3fQcP
	FesiLOWJnOiQbnx8G8ht9Gq7hZQPjqBMeDY2
X-Google-Smtp-Source: AGHT+IET7oHad/XSXl54/XJZYNkUEmejP2EytknXBFj18L8f2jENtK49WUNEvn7mXKWnx3wjXSGqUg==
X-Received: by 2002:a5d:4106:0:b0:38b:dbf0:34f2 with SMTP id ffacd0b85a97d-38db4921159mr892795f8f.52.1738742535807;
        Wed, 05 Feb 2025 00:02:15 -0800 (PST)
Received: from [172.27.21.225] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38da59470b2sm4505609f8f.40.2025.02.05.00.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 00:02:15 -0800 (PST)
Message-ID: <9ef3beae-6de4-4d44-a1fd-d10bc8627e20@gmail.com>
Date: Wed, 5 Feb 2025 10:02:12 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <ttoukan.linux@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, linux-rdma@vger.kernel.org,
 Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
 <20241204220931.254964-8-tariqt@nvidia.com>
 <20241206181056.3d323c0e@kernel.org>
 <89652b98-65a8-4a97-a2e2-6c36acf7c663@gmail.com>
 <20241209132734.2039dead@kernel.org>
 <1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com>
 <20250120101447.1711b641@kernel.org>
 <a76be788-a0ae-456a-9450-686e03209e84@nvidia.com>
 <8dbc731c-2cff-4995-b579-badfc32584a1@nvidia.com>
 <20250122063037.1f0b794a@kernel.org>
 <0f3ac6e2-80be-4df2-9b4d-61433549cc2d@gmail.com>
 <e1bc347a-a705-4518-a826-3a90c4c61f9a@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <e1bc347a-a705-4518-a826-3a90c4c61f9a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/02/2025 8:56, Gal Pressman wrote:
> On 05/02/2025 8:22, Tariq Toukan wrote:
>>
>>
>> On 22/01/2025 16:30, Jakub Kicinski wrote:
>>> On Wed, 22 Jan 2025 14:48:55 +0200 Carolina Jubran wrote:
>>>> Since this worked and the devlink patch now depends on it, would it be
>>>> possible to include the top two patches
>>>> https://github.com/kuba-moo/linux/tree/ynl-limits in the next submission
>>>> of the devlink and mlx5 patches?
>>>
>>> I'll post the two patches right after the merge window.
>>> They stand on their own, and we can keep your series short-ish.
>>
>> Hi Jakub,
>>
>> A kind reminder, as we have dependency on these.
> 
> They're submitted already:
> https://lore.kernel.org/netdev/20250203215510.1288728-2-kuba@kernel.org/

I see. Patch was renamed.
I searched for the old name "don't output foreign constants".

Great!

Thanks,
Tariq

