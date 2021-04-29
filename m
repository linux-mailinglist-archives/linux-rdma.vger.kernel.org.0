Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9500536E3B4
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 05:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhD2Dcv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Apr 2021 23:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2Dcv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Apr 2021 23:32:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49ADC06138B
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 20:32:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p17so5997995pjz.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Y+q3IF8tJyKHeS5JQ5JBGS77KPP0WHntU+vxjpNtsNY=;
        b=TFWIlDwGL5kyLCMbcOew7jIHTsBDj5YvlSrR1aYiv5nMma+8Tmu4z6ZYPlRHT8Y4Sx
         wHk6/vlsIoaJ5iLBOCpCoh+lfIjOikHRmpUiuRxYIzln0ysqfm+Hch9kn4JpVAMJ32rd
         I0m0pRahHurJH6eMbpWKTkW+SovzNuoqtGnEzimiIDCUHmx0mXjLypBDbNKBSBRGMFyZ
         Xgjuq6lkKh8X9v92mkcOI9giKS7z3IplWBV5MGnSjIWRBU0LiDRrF1poCw2H5K9C9UiF
         AWinoa7g1QnmT/q/NicqcE/8o/3SjayINLnigFPpdiqLAG5KnSATO88tuTT22S4EDMc+
         ORsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y+q3IF8tJyKHeS5JQ5JBGS77KPP0WHntU+vxjpNtsNY=;
        b=eLwAaFjELcfK679dzgSuhOzGv/corS5MoMLVAbXXQR+sM2dLabBes0VlZMYj4TKppR
         AUMRk9w+M4ukwhohjfhoJkbkD3Lc/OlActaUo2uUskqPGFZEdoTjLn7RqKqLFgTTJh9Y
         7HBKHrKS7QCOsQq4JcRsxSU2qzkBQYBrb/B2YeT7YBsF8UTMsk5h45t3CdlnenBuCwKc
         tqOc53UFx9RAf+yxLy7tytU8oSOI6di7hnavzTY1chVyODivnKyTcVfYG/+DBxC2g2yA
         rdEqGwherJlAvOu/VD6K3cZxrijaEmiFvtPJ7GLufpfnxspyGAlHYkOa1LcutHukt2dD
         9wuw==
X-Gm-Message-State: AOAM5335gs6d35yPXK8U+J1N6bwDVO0izaFW4pZFCEeb5PMsn7ORDVey
        HqI+N6ZhuodSDKYzOACnjSE=
X-Google-Smtp-Source: ABdhPJxjHM5MQ6yZ71VVjtv5Y0UvWtGH3WATeciY3azVvLhXKThvkQhOowiiLyD+wDN2cgxn6uvJ2Q==
X-Received: by 2002:a17:90b:3689:: with SMTP id mj9mr18836380pjb.154.1619667125278;
        Wed, 28 Apr 2021 20:32:05 -0700 (PDT)
Received: from [192.168.0.25] ([97.99.248.255])
        by smtp.gmail.com with ESMTPSA id z13sm941802pgc.60.2021.04.28.20.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 20:32:04 -0700 (PDT)
Subject: Re: [PATCH for-next v5 08/10] RDMA/rxe: Implement invalidate MW
 operations
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210422161341.41929-1-rpearson@hpe.com>
 <20210422161341.41929-9-rpearson@hpe.com>
 <CAD=hENeB_XJQOy-6tvNwe6+ZyAmw6LBe16ePT4DtcEpu+hOKTg@mail.gmail.com>
 <eb46fc9c-cc72-b928-f4ee-258fd10f2437@gmail.com>
 <CAD=hENdeuNZ7WXkXtV7BqbE0gP34=YH_gbn7odyq-GiAVccesA@mail.gmail.com>
 <4c176a90-0712-e8f7-222a-36cf87f899d7@gmail.com>
 <CAD=hENcr_LuhgdSdXLcZSi97AyBof51xntDGyTKutmv5be_iXQ@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <e1a4821b-dc2d-3adf-536e-62970048bcf1@gmail.com>
Date:   Wed, 28 Apr 2021 22:31:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENcr_LuhgdSdXLcZSi97AyBof51xntDGyTKutmv5be_iXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/28/2021 10:20 PM, Zhu Yanjun wrote:
> On Thu, Apr 29, 2021 at 11:07 AM Pearson, Robert B
> <rpearsonhpe@gmail.com> wrote:
>>
>> On 4/28/2021 7:54 PM, Zhu Yanjun wrote:
>>> Adding a prefix makes debug easy. This can help filter the functions.
>>> And a prefix can help us to verify the location of the function.
>>>
>>> Zhu Yanjun
>> For comparison here are all the subroutine names from a well known
>> driver file. As you can see, 100% of the non static subroutines *do*
>> have mlx5 in their name but the majority of the static ones *do not*,
>> and these are by definition not shared anywhere else but this file. This
>> is representative of the typical style in linux-rdma.
> With perf or ftrace debug tools, a lot of functions will pop out.
> A prefix can help the developer to locate the functions source code easily.
> And a prefix can help the developer filter the functions conveniently.
>
> This is why I recommend a prefix.
>
> Zhu Yanjun

Yes, I can tell. We're still debating this. Obviously the developers of 
mr.c don't entirely agree and I don't either. There are places where it 
makes sense but the code is ugly IMHO. I think you should let developers 
write in the style they are most effective with, especially in the 
context of a local static subroutine which have a very narrow scope.

Bob

>
>> Bob
>>
>> static    TYPE add_keys()
>> static    TYPE alloc_cacheable_mr()
>> static    TYPE alloc_cache_mr()
>> static    TYPE assign_mkey_variant()
>> static    TYPE __cache_work_func()
>> static    TYPE cache_work_func()
>> static    TYPE can_use_umr_rereg_access()
>> static    TYPE can_use_umr_rereg_pas()
>> static    TYPE clean_keys()
>> static    TYPE create_cache_mr()
>> static    TYPE create_mkey_callback()
>> static    TYPE create_real_mr()
>> static    TYPE create_user_odp_mr()
>> static    TYPE delayed_cache_work_func()
>> static    TYPE delay_time_func()
>> static    TYPE destroy_mkey()
>> static    TYPE get_cache_mr()
>> static    TYPE get_octo_len()
>> static    TYPE limit_read()
>> static    TYPE limit_write()
>> static    TYPE mlx5_alloc_integrity_descs()
>> static    TYPE mlx5_alloc_mem_reg_descs()
>> static    TYPE _mlx5_alloc_mkey_descs()
>> static    TYPE mlx5_alloc_priv_descs()
>> static    TYPE mlx5_alloc_sg_gaps_descs()
>> static    TYPE mlx5_free_priv_descs()
>> static    TYPE __mlx5_ib_alloc_mr()
>> static    TYPE mlx5_ib_alloc_pi_mr()
>> static    TYPE *mlx5_ib_alloc_xlt()
>> static    TYPE mlx5_ib_create_mkey()
>> static    TYPE mlx5_ib_create_mkey_cb()
>> static    TYPE *mlx5_ib_create_xlt_wr()
>> static    TYPE mlx5_ib_dmabuf_invalidate_cb()
>> static    TYPE mlx5_ib_free_xlt()
>> static    TYPE mlx5_ib_get_dm_mr()
>> static    TYPE mlx5_ib_init_umr_context()
>> static    TYPE mlx5_ib_map_klm_mr_sg_pi()
>> static    TYPE mlx5_ib_map_mtt_mr_sg_pi()
>> static    TYPE mlx5_ib_map_pa_mr_sg_pi()
>> static    TYPE mlx5_ib_post_send_wait()
>> static    TYPE mlx5_ib_sg_to_klms()
>> static    TYPE mlx5_ib_umr_done()
>> static    TYPE mlx5_ib_unmap_free_xlt()
>> static    TYPE mlx5_mr_cache_debugfs_cleanup()
>> static    TYPE mlx5_mr_cache_debugfs_init()
>> static    TYPE mlx5_mr_cache_free()
>> static    TYPE mlx5_set_page()
>> static    TYPE mlx5_set_page_pi()
>> static    TYPE mlx5_set_umr_free_mkey()
>> static    TYPE mlx5_umem_dmabuf_default_pgsz()
>> static    TYPE mr_cache_ent_from_order()
>> static    TYPE mr_cache_max_order()
>> static    TYPE queue_adjust_cache_locked()
>> static    TYPE reg_create()
>> static    TYPE remove_cache_mr_locked()
>> static    TYPE resize_available_mrs()
>> static    TYPE revoke_mr()
>> static    TYPE set_mkc_access_pd_addr_fields()
>> static    TYPE set_mr_fields()
>> static    TYPE size_read()
>> static    TYPE size_write()
>> static    TYPE someone_adding()
>> static    TYPE umr_can_use_indirect_mkey()
>> static    TYPE umr_rereg_pas()
>> static    TYPE umr_rereg_pd_access()
>> static    TYPE xlt_wr_final_send_flags()
>>       TYPE mlx5_ib_advise_mr()
>>       TYPE mlx5_ib_alloc_mr()
>>       TYPE mlx5_ib_alloc_mr_integrity()
>>       TYPE mlx5_ib_alloc_mw()
>>       TYPE mlx5_ib_check_mr_status()
>>       TYPE mlx5_ib_dealloc_mw()
>>       TYPE mlx5_ib_dereg_mr()
>>       TYPE mlx5_ib_get_dma_mr()
>>       TYPE mlx5_ib_map_mr_sg()
>>       TYPE mlx5_ib_map_mr_sg_pi()
>>       TYPE mlx5_ib_reg_dm_mr()
>>       TYPE mlx5_ib_reg_user_mr()
>>       TYPE mlx5_ib_reg_user_mr_dmabuf()
>>       TYPE mlx5_ib_rereg_user_mr()
>>       TYPE mlx5_ib_update_mr_pas()
>>       TYPE mlx5_ib_update_xlt()
>>       TYPE mlx5_mr_cache_cleanup()
>>       TYPE mlx5_mr_cache_init()
>>
