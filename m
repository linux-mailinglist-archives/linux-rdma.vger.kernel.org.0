Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF31134614
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 16:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgAHPYZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 10:24:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35228 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPYX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 10:24:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so3831858wro.2
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jan 2020 07:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WY8LswhWtBe+DJC/DEGAG0v0KweIWUFyKsy0DnI+itc=;
        b=ZXUvw/vhiVbJH+1wtwf5xxWbV9B3EDKLGgk9nZLyC9y0XZMJuFRdJO5tuYwtkFbOyP
         FralA2sMLvFQDB14ET8u6vgtQdJbh4cvA9p55FRNByr2yf3FXy/NIY9nTBGpK5LUxcq4
         1by3MPlRENUwrEj+Sezq+4Hy2bCik9nFCqlZYFmw9NvFsGy8I8giq3+itv9gstEAWAmQ
         2kV7+GrmtGpLDfnI2DKBBwsLOzcLLw9vSGgYAxKhrEejMx8BPnZpMfueADS0lPsoEpQB
         1Wb/L2J/vP/di06i2RyNw0jRZM8kmLnNDOKlFV52GSMVHcCpiwYy7ZVl2Hil9XybPnRb
         zn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WY8LswhWtBe+DJC/DEGAG0v0KweIWUFyKsy0DnI+itc=;
        b=Izs93z6L5CmYn0ePVoRkTBin1T6B+3XlxR2bBrHRT0h5D25P023YpydFDoLeEyacub
         As7GY5ff/XrlH/sKAO59d45c1pWRA+l0wDVSl2kUp790fzyqvFmjzcZB7Vacksn2HKFG
         5/4ExW11S8xsMR1M20zJ4elNJrBO5/lMgRgrR7siE9/xIi9qfCuGMbaCxROKaA7v+1Uh
         ZYD0mmokqURapOxzwZz7eCQk0NglikwIzJTg61kEPRPEYlFuSLXhAIUmSbL0X9wqqQvK
         RD1WdEOEmhUEn5CSJuvWgi9pjxxu9JB+AM2z9c2F5SEWZK/eT3QIGPBhXgCTnKGKQisz
         SJXw==
X-Gm-Message-State: APjAAAXu7Ijt1u0FGNVc453pIlKAc0vt6ogR1Rt/c9JWy1SDcQ0giDYa
        ICR0JThwBAXiT6eXAL8I2Hmumg==
X-Google-Smtp-Source: APXvYqy/vleudjcx/xMUWMn9iSG/9C+uIhSD3GlJinfMIalsB8y/BxdVFOkayIHlOLB7/RHQFVWGOw==
X-Received: by 2002:adf:b605:: with SMTP id f5mr4964464wre.383.1578497061827;
        Wed, 08 Jan 2020 07:24:21 -0800 (PST)
Received: from [10.80.2.221] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id o16sm4337490wmc.18.2020.01.08.07.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 07:24:21 -0800 (PST)
Subject: Re: [PATCH rdma-rc 3/3] IB/core: Fix ODP with IB_ACCESS_HUGETLB
 handling
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-mm@kvack.org
References: <20191219134646.413164-1-leon@kernel.org>
 <20191219134646.413164-4-leon@kernel.org>
 <alpine.DEB.2.21.2001081352560.23971@ramsan.of.borg>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <ff4da6a1-609a-546c-e56c-e3ac529d4496@dev.mellanox.co.il>
Date:   Wed, 8 Jan 2020 17:24:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001081352560.23971@ramsan.of.borg>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/8/2020 2:56 PM, Geert Uytterhoeven wrote:
>      Hi Leon,
> 
> On Thu, 19 Dec 2019, Leon Romanovsky wrote:
>> From: Yishai Hadas <yishaih@mellanox.com>
>>
>> As VMAs for a given range might not be available as part of the
>> registration phase in ODP, IB_ACCESS_HUGETLB/page_shift must be checked
>> as part of the page fault flow.
>>
>> If the application didn't mmap the backed memory with huge pages or
>> released part of that hugepage area, an error will be set as part of the
>> page fault flow once be detected.
>>
>> Fixes: 0008b84ea9af ("IB/umem: Add support to huge ODP")
>> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
>> Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
>> Reviewed-by: Aviad Yehezkel <aviadye@mellanox.com>
>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/infiniband/core/umem_odp.c
>> +++ b/drivers/infiniband/core/umem_odp.c
>> @@ -241,22 +241,10 @@ struct ib_umem_odp *ib_umem_odp_get(struct 
>> ib_udata *udata, unsigned long addr,
>>     umem_odp->umem.owning_mm = mm = current->mm;
>>     umem_odp->notifier.ops = ops;
>>
>> -    umem_odp->page_shift = PAGE_SHIFT;
>> -    if (access & IB_ACCESS_HUGETLB) {
>> -        struct vm_area_struct *vma;
>> -        struct hstate *h;
>> -
>> -        down_read(&mm->mmap_sem);
>> -        vma = find_vma(mm, ib_umem_start(umem_odp));
>> -        if (!vma || !is_vm_hugetlb_page(vma)) {
>> -            up_read(&mm->mmap_sem);
>> -            ret = -EINVAL;
>> -            goto err_free;
>> -        }
>> -        h = hstate_vma(vma);
>> -        umem_odp->page_shift = huge_page_shift(h);
>> -        up_read(&mm->mmap_sem);
>> -    }
>> +    if (access & IB_ACCESS_HUGETLB)
>> +        umem_odp->page_shift = HPAGE_SHIFT;
>> +    else
>> +        umem_odp->page_shift = PAGE_SHIFT;
>>
>>     umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
>>     ret = ib_init_umem_odp(umem_odp, ops);
> 
> noreply@ellerman.id.au reports for linux-next/m68k-allmodconfig/m68k:
> 
>      drivers/infiniband/core/umem_odp.c:245:26: error: 'HPAGE_SHIFT' 
> undeclared (first use in this function); did you mean 'PAGE_SHIFT'?
> 
> Should this depend on some HUGETLBFS option?
> 

Thanks for pointing on,
We would expect to use #ifdef CONFIG_HUGETLB_PAGE as done in below 
kernel code [1] that also used HPAGE_SHIFT.

I'll send some patch to 'for-next' to handle it.

[1] 
https://elixir.bootlin.com/linux/v5.3-rc7/source/drivers/misc/sgi-gru/grufault.c#L183
