Return-Path: <linux-rdma+bounces-1196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293A86F62E
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 17:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6762862BB
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 16:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FDE6CDA5;
	Sun,  3 Mar 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnGRDdKK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48833F7;
	Sun,  3 Mar 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484227; cv=none; b=nsR41GwzrsGJpymHIRS0GuGbWhCqa18OUK2C9ma7DeRAoybgDrfGX1BzVjp3XPX1dt/kQlxVHG8XUQ/OLFL6zJ3i+V56iXztRV9c6xjJcae4wsMyfCKNG7NiuxqO+PQ7l/rWE+aIGtC0px9giJPIE0cDdpmJUb5uHH/4h9FcXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484227; c=relaxed/simple;
	bh=AylZCUlrBr6sCkdNJuqFPFI5HrOKw1Lt/qRw1U+EUO0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dzy8/M1jH8aKl90/HEd8QfO8Lm87/LcUlle611cIJX4SfahHgUeQ9egrUNLBVnhXa2rmXQlpB2058IzIARo+vJM6uZBzFWoSVZOAPxnZ9G7fFbGlh3lUptaIvZmQ1OlFUTKMFh6+RDA1VU9dsLELzcYYBi+WxtjW4Qmb+Xg2PhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnGRDdKK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d9c3f36c2so1868679f8f.2;
        Sun, 03 Mar 2024 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709484224; x=1710089024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikfe6o+inj4dMrhzQCM91BE0ram1wt5jM+ElrBh+ocw=;
        b=BnGRDdKK0SSMXOoTRwXmN4r9kyC7wKgGxTKOM+1yT3dNjxa2kRmg15jGD0fYzSrtRN
         9rB+aJQIikqfBRl9kipyoljdSpNyLMUj8kLEEmnoMhZ4IJDbDfuGW/1S1WLIJuzqjjIA
         u0qK3s/u94zIWfQ5Yjuyzm11A/VcAzs6QDS/XCpv+OjGVoGAvvP8qx/OfDacbafUGBre
         UkfUaHjW1z+9LwLHd5NhML1ZGYuPnQpzut462SMWN76TpFuXae8GxCaDWk/NBc9cbdom
         BVONPMvayRTMTaZEafSq1BXChpxs2USwuAbVPZbeU0oL9bjoaug4trwNVytHDkStsk1z
         NQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709484224; x=1710089024;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikfe6o+inj4dMrhzQCM91BE0ram1wt5jM+ElrBh+ocw=;
        b=BEjmFiLaIGhYGGzBjBBGMJMj6GBIE1GmHEgkoZODAbNSa1L+nYjs55RTzuMAtQ0Vac
         AB8FBSMoX5lpRPOkS2QsVeXoZf7Ch4DC51TtLRMwAWe18GK09hG7NlII8mcdqalKlfPz
         vfh3f0j9897DK3cwrWeHNh92zJp6LPJwZd1L4DhiJjJaRoPDHqGXSSDfHxmwcyfcn7m3
         1rfCZ7+aDqK0LLVDJCFnfzyEdSC+YvCvSJZEji7I5XUgI9TDnewaMudGabbwecaV5tI0
         At36NLp4UmA6Xx1XHCVdLAn8X8Lp7ffcfSAH/9UwPLMu+XMtA/+KQ2tQ87cDGZZF5F2X
         S++g==
X-Forwarded-Encrypted: i=1; AJvYcCWu5pbsg1L6AQFGKvwpxBBT84NynDXymA7hxSNxi6NCeE5yd0m0OGDAnSnIzXlnbxHXmG2uS/UATQ1SsJpFQz1xqf8wVzs1/5qAYpEhIPT1GvuBVZ2ZQGU810l5YhtYuj6zph7L6Sri
X-Gm-Message-State: AOJu0YxhPRiyniNt3lBe77fRQqXb5sVx71awQ3G5PJnPC2dQmOf1B6/J
	nh5Xk4atvv1uVa+bnOixmlWNRykJkXlDaHR/nvDkDVOGjFaZdFQN
X-Google-Smtp-Source: AGHT+IEan7Mnlup0Dsmz/hl+Nfxoss34Q+iDIhW40VewxV5OR6PZ3luhS7QypruxneaihlG33uJrxQ==
X-Received: by 2002:a05:6000:12c8:b0:33d:747a:1e94 with SMTP id l8-20020a05600012c800b0033d747a1e94mr4376321wrx.41.1709484223538;
        Sun, 03 Mar 2024 08:43:43 -0800 (PST)
Received: from [10.8.18.71] ([62.214.99.74])
        by smtp.gmail.com with ESMTPSA id cr14-20020a05600004ee00b0033dd06e628asm9995441wrb.27.2024.03.03.08.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 08:43:42 -0800 (PST)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <be75fe5b-9901-425c-8dbb-771dcb084e2e@linux.dev>
Date: Sun, 3 Mar 2024 17:43:41 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] : Two stage IOMMU DMA
 mapping operations
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <bvanassche@acm.org>, "kbusch@kernel.org"
 <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Amir Goldstein <amir73il@gmail.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, Christoph Hellwig
 <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 "jack@suse.com" <jack@suse.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Chuck Lever <chuck.lever@oracle.com>
References: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
 <20240227113007.GD1842804@unreal>
In-Reply-To: <20240227113007.GD1842804@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.02.24 12:30, Leon Romanovsky wrote:
> On Tue, Feb 27, 2024 at 08:17:27AM +0000, Chaitanya Kulkarni wrote:
>> Hi,
> 
> <...>
> 
>> In order to create a good platform for a concrete and meaningful
>> discussion at LSFMM 24, we plan to post an RFC within the next two weeks.
> 
> The code can be found here https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dma-split

Thanks a lot. I will delve into it. An interesting topic.

Zhu Yanjun

> 
> Thanks
> 
>>
>> Required Attendees list :-
>>
>> Christoph Hellwig
>> Jason Gunthorpe
>> Jens Axboe
>> Chuck Lever
>> David Howells
>> Keith Busch
>> Bart Van Assche
>> Damien Le Moal
>> Martin Petersen
>>
>> -ck
>>
>> [1]
>> https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net
>> [2] https://lore.kernel.org/linux-iommu/20200708065014.GA5694@lst.de/
>>
>>
>>


