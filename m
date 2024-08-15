Return-Path: <linux-rdma+bounces-4374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8869952CCB
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 12:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915FE1F21289
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8C17C983;
	Thu, 15 Aug 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsyjYcq6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A51714C6;
	Thu, 15 Aug 2024 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718400; cv=none; b=aMVL3o4HQK9ZFlPCeW4xjprvggdELYMaJC8LrhnaQH+AN6OCWPRodwdwk5KYSpGFuH9UlEmAtikbsiTJQevYIkAymPKMPKajKIct1woRir9qNXqD7g1UvtTThnfVLjncxbMYoKMhV5GNKiX4Az0mnksr9vFv6Zz8wFYO7ekDdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718400; c=relaxed/simple;
	bh=xqO0Ol2avSbfwFsgwBlQuyMDHd/wBEwR5huQ6/028OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptjKWVRsKgTzzHS7bxGAzjVlNPz3DS+CSQmeK1Bcsz/9XuEJKkZqcZvAvwIjAS47gL1/cLvV4WSEttNnZOKhy2SoqkRcspP8eEAHD26co3fRvch6OS9nAl6fgmDY1HYHkHUvUJudq9J08gM6i97CyTa3Pc8eJIlWMPLtI2h6qKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsyjYcq6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso6783785e9.2;
        Thu, 15 Aug 2024 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723718397; x=1724323197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfWoff+tUYg/ZGlgaFI4bJe0Y/24oPzd8yBxlcOc8Y8=;
        b=CsyjYcq6CFjrI2f1dJQnMmU5YZ1foHtCIRhbTKE0xGdwpUyL3OLdAeptgu8AYKsh1/
         shECYVEEJLj+irFjPzqv8UI5S8AUCkxRWVeMUzDANdvekrnCBr7k8qmS1lT2DQ0GBKvn
         GHRZPLwpG8Lfetwz6eQwe83nh6SKBQRMYv7QLE0G2UVN06ms7Kddjk/XTDAfDYmT4Bww
         m6+SIq2MTtDU6v/SaVpa05tOyRCeOcvyjY7Ec0u5Uq2HyQXEaoa9fOX2Bx9WMBt1FwYu
         ncdrlEWdSqg900KTLj5lcxF0def1btyqfYBUIjOJ+UY1x2evV+RTkrVHayu9VV2Dcc7R
         pwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718397; x=1724323197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfWoff+tUYg/ZGlgaFI4bJe0Y/24oPzd8yBxlcOc8Y8=;
        b=hcqZYxz9KdiYrnws+QCoTQWW0vLudA/TmgyxLYDg+cd/SXQE2nkmseibOchq3wy5yM
         P4+NPmLS9TLaPy+EKOkxvyUYTd/5WDeukw6aaY78NZ28ioKOB+R9KeW4e5dH6iKi6ekz
         3gBKo0c7OcgpBHcnAwESX7GmPTj2aUBauBqLvWnW0sSwCqcSzgT5ZVewx832nU8cl8KS
         0ePy2stFQ+Bh6nbzFFEdpzQm5R20G9hctI5cbq+mGTa5dV8nwGH28GTQnNLzwk4zdR2/
         +0wfr5A2ZTkTzkJr4OirYVvtaSJtwWdiRrawoLxFyb5w6+OvAQv3tIyi9FPfrYeVHT+S
         NXBA==
X-Forwarded-Encrypted: i=1; AJvYcCVbFAqV7ay/dEA0vcecRKrTvdtjzJP5evB6HNEWRmH4FCd6kQ6w17WqIBjGIKIiad05oDmHyANZPux/9uX2fvJnthis/YJp0zuRqNatS74R0wqq5kA7BzxpbecOhP80LJnuXkOE2P6FwZhSb40/wfVhfijlaMwSx7ZzoGcR5eUsng==
X-Gm-Message-State: AOJu0YwQkwriSP4B26E1MXksQCyyxTY9qtGibC/MXx2iYUbulPwVGfQG
	qA8rtumpsvfO2+NXf1QEVOO9wJ8H8Y6VBz2ssheorvzc9PUQl936
X-Google-Smtp-Source: AGHT+IGEAvdLdRgmy0otoJ3sYc57FKhn9/y7oQRaWqUyv0pRzRyfdp0OJYjX0Ob1efExjfcNjdrfPw==
X-Received: by 2002:a05:600c:35cb:b0:428:29e:8c42 with SMTP id 5b1f17b1804b1-429dd2365b6mr46271105e9.9.1723718396658;
        Thu, 15 Aug 2024 03:39:56 -0700 (PDT)
Received: from [172.27.51.48] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e8521f90sm13787815e9.37.2024.08.15.03.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:39:56 -0700 (PDT)
Message-ID: <1a3208e3-a692-4d72-8705-7367b0bc4468@gmail.com>
Date: Thu, 15 Aug 2024 13:39:51 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Use cpumask_local_spread() instead of custom
 code
To: Yury Norov <yury.norov@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Yury Norov <ynorov@nvidia.com>, Rahul Anand <raanand@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240812082244.22810-1-e.velu@criteo.com>
 <3dcbfb0d-6e54-4450-a266-bf4701e77e08@gmail.com>
 <ZrzDAlMiEK4fnLmn@yury-ThinkPad>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ZrzDAlMiEK4fnLmn@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2024 17:45, Yury Norov wrote:
> On Wed, Aug 14, 2024 at 10:48:40AM +0300, Tariq Toukan wrote:
>>
>>
>> On 12/08/2024 11:22, Erwan Velu wrote:
>>> Commit 2acda57736de ("net/mlx5e: Improve remote NUMA preferences used for the IRQ affinity hints")
>>> removed the usage of cpumask_local_spread().
>>>
>>> The issue explained in this commit was fixed by
>>> commit 406d394abfcd ("cpumask: improve on cpumask_local_spread() locality").
>>>
>>> Since this commit, mlx5_cpumask_default_spread() is having the same
>>> behavior as cpumask_local_spread().
>>>
>>
>> Adding Yuri.
>>
>> One patch led to the other, finally they were all submitted within the same
>> patchset.
>>
>> cpumask_local_spread() indeed improved, and AFAIU is functionally equivalent
>> to existing logic.
>> According to [1] the current code is faster.
>> However, this alone is not a relevant enough argument, as we're talking
>> about slowpath here.
>>
>> Yuri, is that accurate? Is this the only difference?
>>
>> If so, I am fine with this change, preferring simplicity.
>>
>> [1] https://elixir.bootlin.com/linux/v6.11-rc3/source/lib/cpumask.c#L122
> 
> If you end up calling mlx5_cpumask_default_spread() for each CPU, it
> would be O(N^2). If you call cpumask_local_spread() for each CPU, your
> complexity would be O(N*logN), because under the hood it uses binary
> search.
> 
> The comment you've mentioned says that you can traverse your CPUs in
> O(N) if you can manage to put all the logic inside the
> for_each_numa_hop_mask() iterator. It doesn't seem to be your case.
> 
> I agree with you. mlx5_cpumask_default_spread() should be switched to
> using library code.
> 
> Acked-by: Yury Norov <yury.norov@gmail.com>
> 
> You may be interested in siblings-aware CPU distribution I've made
> for mana ethernet driver in 91bfe210e196. This is also an example
> where using for_each_numa_hop_mask() over simple cpumask_local_spread()
> is justified.
> 
> Thanks,
> Yury

Thanks Yuri.

For the patch:
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Targeting net-next.
The patch subject should've t stated this clearly.

Jakub,
Please note that this patch is also mistakenly marked 'Not Applicable' 
already...

Regards,
Tariq

