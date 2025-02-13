Return-Path: <linux-rdma+bounces-7713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B534A33C3A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 11:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C624C1883150
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 10:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BFB212D79;
	Thu, 13 Feb 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEtG5sMd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7620B21A
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441588; cv=none; b=HXqrtld1Veq7Js3Zu3DWXepihZZJsBYc3F/PZOgvnXOODGvXX6ckj3CnjeeD55eeasShLOREjhFL5+O9YzIDk/je49hGKLkvgtlp5nrltZ1zbI5UUgiisSK5ZrYPUuY3uP4kCvfQ+FZzcT26FiEOlO7rVgkJhCYHlHh81CTY/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441588; c=relaxed/simple;
	bh=TPJ/nTIknPS5cx18/Sqpw2qu6ixwnIbzogcI8kwGoP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoibrIkoESsAAfezzhWGDAUX7bTpEuYCRTtKU4PrfKwgicGmkluyCpz2F57ZDfDOwC5bsHiHck0MkcNJnB+7zRnv20zYUruwDZktQzjJl2Grr3KmK8g4yV6m4vsSYV1zgTrtXG6892GoqPfp10IfpUSu6lzaq8LpLCKe8/DZIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEtG5sMd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739441586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kir0xP/eZn19J/5p1I2ZFGYt8Aw6idVAPW8577Id44g=;
	b=UEtG5sMdVaabwnNkpE+fweK0GZvaxOYNJ5PznfQqss50V0b9KeFylLnXMBsVOtqNp9n29h
	VHeC6cKMDDp3bXp1D/1zxS74koh8lnJG8IPXfZ1EttJ5m9tXMKWdXwoXsg7xIpBHPntTLl
	vfDeAIAr+lfO5yoz2PMDrdoI4vkU/Ck=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-kWsw7usVPIqC_vQ1JuZdsQ-1; Thu, 13 Feb 2025 05:13:04 -0500
X-MC-Unique: kWsw7usVPIqC_vQ1JuZdsQ-1
X-Mimecast-MFC-AGG-ID: kWsw7usVPIqC_vQ1JuZdsQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so5113845e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 02:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441583; x=1740046383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kir0xP/eZn19J/5p1I2ZFGYt8Aw6idVAPW8577Id44g=;
        b=TT9CvrUPOEobHG9eLOuR9uSyPawDS5gMjReZ8Ay63kn3gkYuK58u3/jRfAmOT/35b3
         lTWPYaeBPN+MylDO3kJZZV3jq1mnpsVjtYjArmnZJJyNtJeeyKN72NxBZw8Um+loV9uh
         csKBJ9PcQaunArhU0CLLB53hz93+EUJRszC8dqPZKc12edkHtCFk+hZQVDyoQFIY7S9f
         kQFyJfIXoigVqP4NF6fnc1zmXRMjYErFAMlWll+1/+Jb0e+x1H4vCpJ8PiNrfdXr9rvO
         Ft6hgGrgF2VrXa15z6znI9XFNTo3tm3OFxU0GHRPnCPuQJ4KmqTEMbbfYUyE42S0YyyK
         KFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW07wCUWuGKDReK0qg7vD8u+PmXhzlBqNDAfX7PPaiVk7tlAY3IYfHlk1t0+7k/jxdThLcVzeZZGcsL@vger.kernel.org
X-Gm-Message-State: AOJu0YwiDzCKlSLn/brN3iKsYflG+G11MfeTZLvwMqQuF1SaKU2qJPRi
	IUDB7IcPluRZk3cl+jBYOFPUj8CVH6WwgN71XH3boaxET+oXkd6Wk+EPguLZYv+xOkUbjRG5UIY
	Nejw6jBmNt7KInslI9OsrzSWtoJma9Mh9kCcNdUWwb2RMkM3E0WATbPqxm2c=
X-Gm-Gg: ASbGncsC66hhRfd5hCeMEiXv4IIh/XW5Jhd1sMcWkY40+VNeXEjoI4f6IYaoqKT3msk
	TSnjg8uUUS8BxpZU0RgkXSZe+vs+0ipvenYav9SZomHWPYj3Oz7KTsmpFlRqgB9/hcp89XMZba6
	GZYDoOOgYdW321Dt1aPjcIombBCnNNC2s2VjVKbwikiQVpQ5uAT0d6TguSkymtInPfLSSrQ4SsW
	nIODEzM9JeI64VIySsUv046y2MMUN//92zEjpnyqVV+HrT7yHvBqhThMTcKQLPZfSA0YJVslzg7
	oigfiGnq6ndQZLBKYPtcGY8Y/ET04KRZ+uA=
X-Received: by 2002:a05:600c:1d85:b0:436:f960:3428 with SMTP id 5b1f17b1804b1-439581c9cffmr67587525e9.29.1739441583340;
        Thu, 13 Feb 2025 02:13:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr/ZoioARrAtsjEX0T4uArnjm6HRk8PKz7oSXppRfbi28wR4BrFT3aKjCq8hOmcWroASjtgw==
X-Received: by 2002:a05:600c:1d85:b0:436:f960:3428 with SMTP id 5b1f17b1804b1-439581c9cffmr67587045e9.29.1739441582954;
        Thu, 13 Feb 2025 02:13:02 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618a9970sm12953035e9.33.2025.02.13.02.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:13:02 -0800 (PST)
Message-ID: <3bd1622d-438a-4903-b87a-08987f98c449@redhat.com>
Date: Thu, 13 Feb 2025 11:13:00 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx4_core: Avoid impossible mlx4_db_alloc() order
 value
To: Justin Stitt <justinstitt@google.com>,
 Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250210174504.work.075-kees@kernel.org>
 <3biiqfwwvlbkvo5tx56nmcl4rzbq5w7u3kxn5f5ctwsolxpubo@isskxigmypwz>
 <d11de4d4-1205-43d0-8a7d-a43d55a4f3eb@gmail.com>
 <CAFhGd8om_1W7inq+V4a4EP3e5y1y+qw7C3wi3DR4WpspYzZenQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAFhGd8om_1W7inq+V4a4EP3e5y1y+qw7C3wi3DR4WpspYzZenQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/25 1:10 AM, Justin Stitt wrote:
> On Tue, Feb 11, 2025 at 6:22 AM Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>> On 11/02/2025 2:01, Justin Stitt wrote:
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
>>>> index b330020dc0d6..f2bded847e61 100644
>>>> --- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
>>>> +++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
>>>> @@ -682,9 +682,9 @@ static struct mlx4_db_pgdir *mlx4_alloc_db_pgdir(struct device *dma_device)
>>>>   }
>>>>
>>>>   static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
>>>> -                                struct mlx4_db *db, int order)
>>>> +                                struct mlx4_db *db, unsigned int order)
>>>>   {
>>>> -    int o;
>>>> +    unsigned int o;
>>>>      int i;
>>>>
>>>>      for (o = order; o <= 1; ++o) {
>>>
>>>    ^ Knowing now that @order can only be 0 or 1 can this for loop (and
>>>    goto) be dropped entirely?
>>>
>>
>> Maybe I'm missing something...
>> Can you please explain why you think this can be dropped?
> 
> I meant "rewritten to use two if statements" instead of "dropped". I
> think "replaced" or "refactored" was the word I wanted.

IMHO that would be a significant uglification, not worthy to address an
issue that could be solved with the patch proposed here.

@Tariq: are you ok with this patch?

Thanks,

Paolo


