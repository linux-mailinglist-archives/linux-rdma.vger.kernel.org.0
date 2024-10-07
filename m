Return-Path: <linux-rdma+bounces-5279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385E9934CA
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AA12809D7
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D511DD536;
	Mon,  7 Oct 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qsn0INb7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F811DCB20
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321661; cv=none; b=nNbfHf91l2l1TgI6sSB4rc+KiJbuwrw3Q7SODGXsHfJD8WfvcZAy+MQ3lC9pMEQ+nsNjDRdWERbABWQvNHqWQwKsm5LJ6wgFgzn1gJ/yyagS88ggL9hoILPBEXNtouBMCITqZvtWX/lebAugHR8HKc9nIJHb+JlyHxAzOs/N3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321661; c=relaxed/simple;
	bh=uEMVFVjKMHg/BvG37muuBGKEOSFc3zl9DQSYYvtqAO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RW/EJDtotvRq26tdYUiaVeakaYjwPkpyWrgd51zdtmCZdzQQ9LZx1LYuVd0L2xX4IJVx3hl8o5r/5yM4+8OMGXEMiyzTmLQc+iR+ZmXH+fEcYYK8VMx5DhMtZBenDxxNTLnwaf9ot+p9y4TFRqszwwwfwZhtbhR5oLlXT9gc70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qsn0INb7; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cd869453eso165651539f.0
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2024 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728321658; x=1728926458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HM/eNQVp9sS4pRv6Kkwi+3Ezf+Z5zDLYdRJi3sz9pR0=;
        b=qsn0INb70hvqxg0O9QnmFo9rRGsyvsoX/GMxLwKcgGXRCPtk6wnJzuYspu3Tqmk9+T
         /erXDSWjcjN19fhF7uDcutpbaMqwuk5GzO9keYQMYVjDLTKo+iQ6qAJArnPRIyf+dwmf
         YuAUFkoI1kJlAf9BX4IdtW8nJ6jBJvEp9q6/HJhmabnSIycnBjiQXeM0Cwx3ICO6w0fL
         It1tJsAvLYcfBHNnI9h6xZMCsfvYjuwzBiDhNgTn6by5SsOQZSitus7WCq+AlKoD3NxU
         KJQL5X9XLb89GlL2UQiyCTaYL6Auvsime6KcE4CE54pEk8W2naxKHMVfksywaFlHckil
         rT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321658; x=1728926458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HM/eNQVp9sS4pRv6Kkwi+3Ezf+Z5zDLYdRJi3sz9pR0=;
        b=H9LGEnnWT8tj0ei3pziJQZ5ixigKWc3xS+qt1vWmJLW3re1I5FaGE9tHV1b4F4bZj8
         936Fjqw4dTqwZktZ/kUPseENzxzCw6P+Jdu78Tl6v39Ke1lCNBjIMy7GJa3FJz0WwL6h
         cYaEAD9j/fhGaAfVNEGSfB83l0cOMf012fFYVkJCtmlrHyd52UVdaQ9QJX9nDi5ag1n7
         7J1MAVFK6o/2B5Yi8Jhm/d+bS23TjoshygznHY/qi0KUahYUF28V6h3uoTs27YbFH66H
         nw5wmdK1FWzs0od4tEcT8NJp9T4OVphFPFo4/z3PECuSO+l2y5eworhR6f5kp6d2DM8t
         t6+w==
X-Gm-Message-State: AOJu0YwSQf0mVERzqLTGvKhLKY5SRKtUPhETyhD7JNFikArlQDnqEOPO
	INdV+8vNC/9pJbN1++8Y8PtIqnosrRHkAuzez5ucX9BF0mmZjpcJTDv7Sloa6u0=
X-Google-Smtp-Source: AGHT+IHQQ1eK2yoPU61vrGJpZjDagJrSQr7Q5nZeGf2sYzTNsyAIG0qjJxS5RFmMOdttEW/fnX7r6g==
X-Received: by 2002:a05:6602:1593:b0:82a:173a:3cd0 with SMTP id ca18e2360f4ac-834f7dc1cc8mr1178754139f.16.1728321658084;
        Mon, 07 Oct 2024 10:20:58 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503aacb18sm133537339f.30.2024.10.07.10.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:20:57 -0700 (PDT)
Message-ID: <d6df2c28-467d-458e-9b53-4cb7abcf682f@kernel.dk>
Date: Mon, 7 Oct 2024 11:20:56 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
 <e9778971-9041-4383-8633-c3c8b137e92e@kernel.dk>
 <09ffcd22-8853-4bb3-8471-ef620303174b@acm.org>
 <09aa620c-b44b-41d2-a207-d2cc477fdad2@kernel.dk>
 <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <04daaf4c-9c62-404e-8c5e-1fffb3f2ecbd@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 10:52 AM, Bart Van Assche wrote:
> On 10/7/24 9:28 AM, Jens Axboe wrote:
>> On 10/7/24 10:14 AM, Bart Van Assche wrote:
>>> On 10/7/24 7:06 AM, Jens Axboe wrote:
>>>> Still seems way over engineered, just use an atomic_long_t for a
>>>> continually increasing index number.
>>>
>>> Even an atomic_long_t can wrap around and hence can result in duplicate
>>> slab cache names. With my patch it is guaranteed that slab cache names
>>> are unique. I'm not claiming that this patch is the best possible
>>> solution but it's a working solution and a solution that doesn't require
>>> too many changes to the ib_srpt driver.
>>
>> Come on... The current patch doesn't even check if ida_alloc() got an ID.
>> Without that, using some mechanism to alloc+free an index is surely less
>> than useful.
> 
> Is it necessary in this case to check the ida_alloc() result? ida_free()
> ignores negative values. So if ida_alloc() fails, the worst that can
> happen is that a slab name with a negative number is passed to kmem_cache_create(). Additionally, if my interpretation of the ida code
> is correct, it allocates memory in 128 byte chunks. So if allocation of
> an ida fails, it means that less than 128 bytes of memory are left. More
> than 128 bytes are required by kmem_cache_create(). Hence, if ida
> allocation fails, the kmem cache creation will also fail and the slab
> name with the negative number will not become visible in procfs.
> 
> Do you agree that in this case it is safe not to check whether
> ida_alloc() succeeds?

I'm not worried about OOM, what if you run out of space? And yes the
free part deals with it fine, but you're right back to having duplicate
slab names in that case. I'm done arguing about this silly thing, I
stand by my comment that using ida for this is overengineering. And that
yes there are 3 slab caches, but having 3 per whatever instance is silly
and you should share those 3 across instances. And guess what, if that
was done, then you would not need to worry about creating silly indexes
to avoid conflicts in slab names. Not only would it be more efficient in
terms of overhead, it'd also fix this problem at the same time rather
than paper over it.

-- 
Jens Axboe

