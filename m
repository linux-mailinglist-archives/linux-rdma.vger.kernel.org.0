Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAED154960
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 17:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBFQjc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 11:39:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFQjc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 11:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=kOnzmlqacbR2EY8sLWfURzRzYlOaOYf9ui2nKYbQJNc=; b=LVhHaimUTg8zvT9iIZDn5rL3sH
        cAUrz3bfud7dDw2YGGNuEoFiB57jifuOpK5UVIrkzhh9836/p4gxDUiu5+9dNPAkL4KUYBKEB5uiZ
        4ynWGM1Lkp6yXrduEVBRYXp9NSEL0EWNWhN98NBY/jycni7wmnMa910BRDMl/Ep2Faw66QyXSLIxW
        KWjO7mKGj/a6G0plVy8ST8rDtOcDckdXgRIc1G3P7byzfT/YbhkC9LzXARNFjymmTUIgcAu+gGAIk
        wQM2DAnUl9njbx8aNHPPyadpf5bq7+DqivqgIrVqE6y+xdzTCLgjWXEwr5u6J7eJtYG+hMWFu4NF6
        r0VZ3BLw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izkBf-0002gh-8c; Thu, 06 Feb 2020 16:39:31 +0000
Subject: Re: linux-next: Tree for Jan 30 + 20200206
 (drivers/infiniband/hw/mlx5/)
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20200130152852.6056b5d8@canb.auug.org.au>
 <df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org>
 <ee5f17b6-3282-2137-7e9d-fa0008f9eeb0@infradead.org>
 <20200206073019.GC414821@unreal> <20200206114033.GF414821@unreal>
 <20200206143201.GF25297@ziepe.ca>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <488a5c93-904a-9ccd-4c19-7e67663f5cdd@infradead.org>
Date:   Thu, 6 Feb 2020 08:39:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206143201.GF25297@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/6/20 6:32 AM, Jason Gunthorpe wrote:
> On Thu, Feb 06, 2020 at 01:40:33PM +0200, Leon Romanovsky wrote:
>> On Thu, Feb 06, 2020 at 09:30:19AM +0200, Leon Romanovsky wrote:
>>> On Wed, Feb 05, 2020 at 09:31:15PM -0800, Randy Dunlap wrote:
>>>> On 1/30/20 5:47 AM, Randy Dunlap wrote:
>>>>> On 1/29/20 8:28 PM, Stephen Rothwell wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Please do not add any v5.7 material to your linux-next included
>>>>>> branches until after v5.6-rc1 has been released.
>>>>>>
>>>>>> Changes since 20200129:
>>>>>>
>>>>>
>>>>> on i386:
>>>>>
>>>>> ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
>>>>> ERROR: "__divdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
>>>>>
>>>>>
>>>>> Full randconfig file is attached.
>>>>>
>>>>>
>>>>
>>>> I am still seeing this on linux-next of 20200206.
>>>
>>> Sorry, I was under wrong impression that this failure is connected to
>>> other issue reported by you.
>>>
>>> I'm looking on it right now.
>>
>> Randy,
>>
>> I'm having hard time to reproduce the failure.
>> ➜  kernel git:(a0c61bf1c773) ✗ git fixes
>> Fixes: a0c61bf1c773 ("Add linux-next specific files for 20200206")
>> ➜  kernel git:(a0c61bf1c773) ✗ wget https://lore.kernel.org/lkml/df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org/2-config-r9621
>> from https://lore.kernel.org/lkml/df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org/
>> ➜  kernel git:(a0c61bf1c773) ✗ mv 2-config-r9621 .config
>> ➜  kernel git:(a0c61bf1c773) ✗ make ARCH=i386 -j64 -s M=drivers/infiniband/hw/mlx5
>> ➜  kernel git:(a0c61bf1c773) ✗ file drivers/infiniband/hw/mlx5/mlx5_ib.ko
>> drivers/infiniband/hw/mlx5/mlx5_ib.ko: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), BuildID[sha1]=49f81f5d56f7caf95d4a6cc9097391622c34f4ba, not stripped
>>
>> on my 64bit system:
>> ➜  kernel git:(rdma-next) file drivers/infiniband/hw/mlx5/mlx5_ib.ko
>> drivers/infiniband/hw/mlx5/mlx5_ib.ko: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), BuildID[sha1]=2dcb1e30d0bba9885d5a824f6f57488a98f0c95d, with debug_info, not stripped
> 
> You need to link to see it..
> 
> From bee7b242c2c6a3bfb696cd5fa37d83a731f3ab15 Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@mellanox.com>
> Date: Thu, 6 Feb 2020 10:27:54 -0400
> Subject: [PATCH] IB/mlx5: Use div64_u64 for num_var_hw_entries calculation
> 
> On i386:
> 
> ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> ERROR: "__divdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> 
> Fixes: f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR capabilities")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 0ca9581432808c..9b88935f805ba2 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -6543,7 +6543,7 @@ static int mlx5_ib_init_var_table(struct mlx5_ib_dev *dev)
>  					doorbell_bar_offset);
>  	bar_size = (1ULL << log_doorbell_bar_size) * 4096;
>  	var_table->stride_size = 1ULL << log_doorbell_stride;
> -	var_table->num_var_hw_entries = bar_size / var_table->stride_size;
> +	var_table->num_var_hw_entries = div64_u64(bar_size, var_table->stride_size);
>  	mutex_init(&var_table->bitmap_lock);
>  	var_table->bitmap = bitmap_zalloc(var_table->num_var_hw_entries,
>  					  GFP_KERNEL);
> 


-- 
~Randy

