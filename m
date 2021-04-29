Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8B36E37F
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 05:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhD2DHv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Apr 2021 23:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhD2DHu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Apr 2021 23:07:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63FC06138B
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 20:07:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y32so46135677pga.11
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 20:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QbOPmPeXe6ADKGIu+0Q4p6BVnXSUnlY8u8de31gP5AM=;
        b=ZMN6EqsCTIro88jIgkGhGNAyYA2SsfO3Lls6BSmaT80v1Bo1eC+GBlamFaxz5Y+nSH
         DBexnPaRktY1ckmIXvV+Uj92ARDEtxDFsAkG/E4N1E00P3c0Cf1ffcF9E8A6uM4uhyhj
         9nufzuf9VGgCrDoh+PHoATxhbYcxQweSYbI/Cu4CULe0XMZWTs25gp6Yt7387Sa7eo14
         4op6hWEb13+2GVxibgDHGrc/vce/wT2FNc46on9AVBw5p4KzPDcfN9ybJlq74bKlqJRB
         MFpDdJdGIGbveuJIio+W8G7Bv3/G8afGHa0VoB5g7XVeHvkzZiUh3bHmjJu1BLgmcg2T
         k4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QbOPmPeXe6ADKGIu+0Q4p6BVnXSUnlY8u8de31gP5AM=;
        b=PGX6PupcOMtp0FgwhFBKyWrW5I7j3UGvZMbOT3MsZ/cWR8sjPcA2CDsc3bhqzwOyyX
         cxRKsJQj4KXgEo65Hg5OYOCt0hp+39u3fd6+0A9kO4cEvXjad52dnHKDJcNdCek0Fqx/
         dG0cv7u5Y4T2xhBvFPWxGKfyXreNfQ54mYuCjVehiqP/L0MY2JHN/HGZemi1poG2KN/n
         WdxDBUYgiQA4Ac7ZGh6SByMILKFb7FvXgtTxFfwsoHFcaPPgZjG3cyIeW1CD1MeEIkaT
         2SeoVGLU1yb8Vjd/vA5Q2eZ6TNq37SKKV++XEOEL0HvqgYt3hzWMlWpKGr6VWtQ1eUFI
         vz3w==
X-Gm-Message-State: AOAM530yVpAp/gQNHrDQZb2sEGj16yCoLhKrlVXj8PMAEHmPNegYva1y
        6dDP5aJHh0YuEip58Kr0Gfw=
X-Google-Smtp-Source: ABdhPJzC1eDHloWx8GzJcwf0IuiHIHLzVHs5p8m3+99EQSO/72B+HjnwLe3fZZV+kzy00AL/zPVKCQ==
X-Received: by 2002:a05:6a00:1c54:b029:261:fc0f:15f7 with SMTP id s20-20020a056a001c54b0290261fc0f15f7mr31092222pfw.30.1619665624247;
        Wed, 28 Apr 2021 20:07:04 -0700 (PDT)
Received: from [192.168.0.25] ([97.99.248.255])
        by smtp.gmail.com with ESMTPSA id 80sm905156pgc.23.2021.04.28.20.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 20:07:03 -0700 (PDT)
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
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <4c176a90-0712-e8f7-222a-36cf87f899d7@gmail.com>
Date:   Wed, 28 Apr 2021 22:06:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENdeuNZ7WXkXtV7BqbE0gP34=YH_gbn7odyq-GiAVccesA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/28/2021 7:54 PM, Zhu Yanjun wrote:
> Adding a prefix makes debug easy. This can help filter the functions.
> And a prefix can help us to verify the location of the function.
>
> Zhu Yanjun

For comparison here are all the subroutine names from a well known 
driver file. As you can see, 100% of the non static subroutines *do* 
have mlx5 in their name but the majority of the static ones *do not*, 
and these are by definition not shared anywhere else but this file. This 
is representative of the typical style in linux-rdma.

Bob

static    TYPE add_keys()
static    TYPE alloc_cacheable_mr()
static    TYPE alloc_cache_mr()
static    TYPE assign_mkey_variant()
static    TYPE __cache_work_func()
static    TYPE cache_work_func()
static    TYPE can_use_umr_rereg_access()
static    TYPE can_use_umr_rereg_pas()
static    TYPE clean_keys()
static    TYPE create_cache_mr()
static    TYPE create_mkey_callback()
static    TYPE create_real_mr()
static    TYPE create_user_odp_mr()
static    TYPE delayed_cache_work_func()
static    TYPE delay_time_func()
static    TYPE destroy_mkey()
static    TYPE get_cache_mr()
static    TYPE get_octo_len()
static    TYPE limit_read()
static    TYPE limit_write()
static    TYPE mlx5_alloc_integrity_descs()
static    TYPE mlx5_alloc_mem_reg_descs()
static    TYPE _mlx5_alloc_mkey_descs()
static    TYPE mlx5_alloc_priv_descs()
static    TYPE mlx5_alloc_sg_gaps_descs()
static    TYPE mlx5_free_priv_descs()
static    TYPE __mlx5_ib_alloc_mr()
static    TYPE mlx5_ib_alloc_pi_mr()
static    TYPE *mlx5_ib_alloc_xlt()
static    TYPE mlx5_ib_create_mkey()
static    TYPE mlx5_ib_create_mkey_cb()
static    TYPE *mlx5_ib_create_xlt_wr()
static    TYPE mlx5_ib_dmabuf_invalidate_cb()
static    TYPE mlx5_ib_free_xlt()
static    TYPE mlx5_ib_get_dm_mr()
static    TYPE mlx5_ib_init_umr_context()
static    TYPE mlx5_ib_map_klm_mr_sg_pi()
static    TYPE mlx5_ib_map_mtt_mr_sg_pi()
static    TYPE mlx5_ib_map_pa_mr_sg_pi()
static    TYPE mlx5_ib_post_send_wait()
static    TYPE mlx5_ib_sg_to_klms()
static    TYPE mlx5_ib_umr_done()
static    TYPE mlx5_ib_unmap_free_xlt()
static    TYPE mlx5_mr_cache_debugfs_cleanup()
static    TYPE mlx5_mr_cache_debugfs_init()
static    TYPE mlx5_mr_cache_free()
static    TYPE mlx5_set_page()
static    TYPE mlx5_set_page_pi()
static    TYPE mlx5_set_umr_free_mkey()
static    TYPE mlx5_umem_dmabuf_default_pgsz()
static    TYPE mr_cache_ent_from_order()
static    TYPE mr_cache_max_order()
static    TYPE queue_adjust_cache_locked()
static    TYPE reg_create()
static    TYPE remove_cache_mr_locked()
static    TYPE resize_available_mrs()
static    TYPE revoke_mr()
static    TYPE set_mkc_access_pd_addr_fields()
static    TYPE set_mr_fields()
static    TYPE size_read()
static    TYPE size_write()
static    TYPE someone_adding()
static    TYPE umr_can_use_indirect_mkey()
static    TYPE umr_rereg_pas()
static    TYPE umr_rereg_pd_access()
static    TYPE xlt_wr_final_send_flags()
     TYPE mlx5_ib_advise_mr()
     TYPE mlx5_ib_alloc_mr()
     TYPE mlx5_ib_alloc_mr_integrity()
     TYPE mlx5_ib_alloc_mw()
     TYPE mlx5_ib_check_mr_status()
     TYPE mlx5_ib_dealloc_mw()
     TYPE mlx5_ib_dereg_mr()
     TYPE mlx5_ib_get_dma_mr()
     TYPE mlx5_ib_map_mr_sg()
     TYPE mlx5_ib_map_mr_sg_pi()
     TYPE mlx5_ib_reg_dm_mr()
     TYPE mlx5_ib_reg_user_mr()
     TYPE mlx5_ib_reg_user_mr_dmabuf()
     TYPE mlx5_ib_rereg_user_mr()
     TYPE mlx5_ib_update_mr_pas()
     TYPE mlx5_ib_update_xlt()
     TYPE mlx5_mr_cache_cleanup()
     TYPE mlx5_mr_cache_init()

