Return-Path: <linux-rdma+bounces-12850-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA6EB2EE31
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 08:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E357E7BBE36
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 06:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEF62D47EE;
	Thu, 21 Aug 2025 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UHkBUtdl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE559199FD0;
	Thu, 21 Aug 2025 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757587; cv=none; b=P5C9atDb/L4L78TOskqsKj+HiV7M07Gt2eQDcqTGrScy20CB4Oj2f0um4RyeG9voMX9TVDA3pL7bnnWw1uPBv54LhcbJEBw0x2VD19f34QRSHLNl2tWnQNmfyUoWhVqeDEwSjKK8o/NuBt5XQhk6V1iN7R1O1fk3pEvBC0zZXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757587; c=relaxed/simple;
	bh=T54dbVxZQ4XI8T3aS3SwX7vh/BCJNqs/4kn27QOpeL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a474gNAPR/yr8qTUJsABIFCAGTB+tkBcT/eaumH6JrgqOAZ9fLKJvfsU6PufV89bBPhZiXrObP1AlfOhyc4tVDPrZiHRZfDwUC8h+Jb5Ex7LeFmtK7ZQGnHySPC4fFIQvcbZxtRYLLi9lYU+tpKMWo7EVeY4jOM25e+UjM0yYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UHkBUtdl; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755757581; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0wpP37FFrGwfkc4hERAmWFOQlCcGuSri8vUf11HqOEQ=;
	b=UHkBUtdl0ZKailM1p6B2xKCWEXZ2LuKShagYeDdKBV8pqRISQ6GZOlkhjFSxY1N2LDR2fTIJqCHck3zP9dw99GQBlzkGjIGXh8/VVIsLfK+GtNT4LC1N8H2Lp5o44VXXKIwK7H0MiDZmN2D9ImjK1dc5WCTFVt3HCGtBH4ue6UQ=
Received: from 30.221.115.63(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WmEy4iA_1755757579 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 14:26:20 +0800
Message-ID: <176d4590-6cfd-8a39-a855-ee21105496b5@linux.alibaba.com>
Date: Thu, 21 Aug 2025 14:26:19 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] RDMA/erdma: Use vcalloc() instead of vzalloc()
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Qianfeng Rong <rongqianfeng@vivo.com>, linux-rdma@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kai Shen <kaishen@linux.alibaba.com>, Leon Romanovsky <leon@kernel.org>,
 Liao Yuanhong <liaoyuanhong@vivo.com>
References: <20250820132132.504099-1-rongqianfeng@vivo.com>
 <e8a8404b-b524-4d9e-b0de-d743acf8d7b4@web.de>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <e8a8404b-b524-4d9e-b0de-d743acf8d7b4@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/20/25 10:34 PM, Markus Elfring wrote:
>> Replace vzalloc() with vcalloc() in vmalloc_to_dma_addrs(). …
> 
> 
> 
> …
>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
>> @@ -671,7 +671,7 @@ static u32 vmalloc_to_dma_addrs(struct erdma_dev *dev, dma_addr_t **dma_addrs,
>>  
>>  	npages = (PAGE_ALIGN((u64)buf + len) - PAGE_ALIGN_DOWN((u64)buf)) >>
>>  		 PAGE_SHIFT;
>> -	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
>> +	pg_dma = vcalloc(npages, sizeof(dma_addr_t));
> …
> 
> How do you think about to adjust also the size determination?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.17-rc2#n944
> 
> 	pg_dma = vcalloc(npages, sizeof(*pg_dma));
> 

Hi Qianfeng and Markus,

Both your changes look good to me.

Qianfeng, Could you send v2 including Markus's change?

Thanks,
Cheng Xu

> 
> Regards,
> Markus

