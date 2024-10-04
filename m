Return-Path: <linux-rdma+bounces-5206-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D93698FC61
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 04:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223D6283D28
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 02:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AD321340;
	Fri,  4 Oct 2024 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iApDyG15"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843E33FD
	for <linux-rdma@vger.kernel.org>; Fri,  4 Oct 2024 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728009356; cv=none; b=dQKzf3eGsAL1ZrY3hvw2zoHQ3qu4zNgELLvtoMoEpdNuKJjvbfNND3JmXBeeMf/NP0gzYeS2C46C2lUxTfS+kmb/IePpKJ9FbxSZWzCZjASWydOGgbVjAUhrTGD0qwpst/LELvL6cjel9Hvc0vaBldhdwXBkl9pvwHK+YI4zCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728009356; c=relaxed/simple;
	bh=Q+/mUUWKiNG2+IsDs3j9++TToCvr4rKhVypFi77aAjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TIN9u+b4nMcYYdonc+zaxNc40WA9ikM0N6OkFmYfb/EaJikuayQPyWh++C+6YJkV3RrFChGODgrWJqYcDAIiANxby4pCm3r/vqoQAshhoBtTW/mmSkk+9W3WlnmZW5+v0HwjAsRuNm+taGqbc2qhpinK5rvb8lyI1SWQNw69QYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iApDyG15; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <734623a7-c8c3-46f9-a564-c2265fb79ff1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728009352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymFwru73XfTHz1sVaFBcyx39mulsMFBjrH0H1o5NdvA=;
	b=iApDyG15i7FbLMDIaZ0ZF8bgQoeL5WtU9qypE2SWWluHBERlWAX1PAeLeixqM3x2/vlLXz
	JmdkYvjWUHZ52QioGrHtACKhxMKA09aiMLw/gFN8fLM7S39gAXE/20uuPsb7b7dBYnauqq
	p/ll/LjrmZPnOGg1ZkIWU4d3hlYja9k=
Date: Fri, 4 Oct 2024 10:35:33 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Bart Van Assche <bvanassche@acm.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/4 4:56, Bart Van Assche 写道:
> On 10/3/24 1:02 AM, Shinichiro Kawasaki wrote:
>> #3: srp/001,002,011,012,013,014,016
>>
>>     The seven test cases in srp test group failed due to the WARN
>>     "kmem_cache of name 'srpt-rsp-buf' already exists" [4]. The 
>> failures are
>>     recreated in stable manner. They need further debug effort.
> 
> Does the patch below help?

Hi, Bart

What is the root cause of this problem?

The following patch just allocates a new memory with a unique name. Can 
we make sure that the allocated memory is freed?

Does this will cause memory leak?

Thanks,
Zhu Yanjun

> 
> Thanks,
> 
> Bart.
> 
> 
> Subject: [PATCH] RDMA/srpt: Make kmem cache names unique
> 
> Make sure that the "srpt-rsp-buf" cache names are unique. An example of
> a unique name generated by this patch:
> 
> srpt-rsp-buf-fe80:0000:0000:0000:5054:00ff:fe5e:4708-enp1s0_siw-1
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ 
> ulp/srpt/ib_srpt.c
> index 9632afbd727b..c4feb39b3106 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2164,6 +2164,7 @@ static int srpt_cm_req_recv(struct srpt_device 
> *const sdev,
>       u32 it_iu_len;
>       int i, tag_num, tag_size, ret;
>       struct srpt_tpg *stpg;
> +    char *cache_name;
> 
>       WARN_ON_ONCE(irqs_disabled());
> 
> @@ -2245,8 +2246,13 @@ static int srpt_cm_req_recv(struct srpt_device 
> *const sdev,
>       INIT_LIST_HEAD(&ch->cmd_wait_list);
>       ch->max_rsp_size = ch->sport->port_attrib.srp_max_rsp_size;
> 
> -    ch->rsp_buf_cache = kmem_cache_create("srpt-rsp-buf", ch- 
>  >max_rsp_size,
> +    cache_name = kasprintf(GFP_KERNEL, "srpt-rsp-buf-%s-%s-%d", src_addr,
> +                   dev_name(&sport->sdev->device->dev), port_num);
> +    if (!cache_name)
> +        goto free_ch;
> +    ch->rsp_buf_cache = kmem_cache_create(cache_name, ch->max_rsp_size,
>                             512, 0, NULL);
> +    kfree(cache_name);
>       if (!ch->rsp_buf_cache)
>           goto free_ch;
> 
> 


