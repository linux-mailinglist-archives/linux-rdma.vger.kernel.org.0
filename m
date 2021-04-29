Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349E036E3A6
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 05:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhD2DVw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Apr 2021 23:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhD2DVv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Apr 2021 23:21:51 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354DCC06138B
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 20:21:06 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u80so31586581oia.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 20:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHlqGEN5HrNzbx4hx1SdiOwSCPjZc4fyfLxm4SOofjA=;
        b=kyhOlVW62h6gj/bRRfKokGaaiMtV95dr+aBDudnqhkavtQumZBY3jb0nmKRRBKAsHQ
         7NiLVn2cAlzoj1btGr386xh8/QNc4qVU2+6Lh70lo//gUN0dZYgRYZDpwkMLDMb8L9E9
         02QU+37Hmr7Ez85bCR7QrM3tTMLZTcJX8iQNP/C84AQYtJObOuHy2Isl1jkneFwYcRsD
         BC+QXfjtwge6UfT/8F105RkJIp2gd0/U+KZy7lQJy6q2JSA4k3wNp01O1GrxVlj7kKb6
         aXGB6hFvKg4nCb9yvC23bxo3RnL43shJxXugXtWCyBOKzLDQdGtHjiDcrI9/hvPCxgFd
         btPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHlqGEN5HrNzbx4hx1SdiOwSCPjZc4fyfLxm4SOofjA=;
        b=eZyeBa+Jvjbh3fFaU4dHfMvTGHk7k0T7zG+2PghDhi2K5jm2VDvhNN0+gtwh5f+Psn
         7I6e70QVBSUsIED4IqGfkekVVf8YXaw12/ZL371UJFAf79QN780FPuIYxZG0ZjOdIo5m
         teO6qQZqeui09lDmXJEgdqUXW6dRE+bJ6UpUvEMN0OtwCaicBZq2/T4KJ8UYOjhsO9Fi
         vlSAfo7rX9TWW1HQ9/KDad5+7tr3tmnJMw9YrmDbA4/wrdfnev9NBlCZRyfGhAuAcrtx
         PcHg/LKLQsz+v7VwmuzR8WxzVnzT7hBMjIMZlGRid+k6PSMljfrjP+9RYPSrCUSAReSJ
         PROA==
X-Gm-Message-State: AOAM532QacK/MfXnANMUHYPn4UAhZYwuFzkrlCOwpFMmaoynt8BczLxk
        HIoJWQblQDqRrUF0OVgWhJGDEa1L1QraCnkwiB4P3YDc
X-Google-Smtp-Source: ABdhPJzQz/7FwSOD9NZAaxM/kifkZAWX2+elhI/7eNt52NvzdqDTigS2cdE1eJTLi14pNkHW2D2oK8dwC+Fqp0eZrIU=
X-Received: by 2002:aca:fd06:: with SMTP id b6mr5360138oii.89.1619666465579;
 Wed, 28 Apr 2021 20:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210422161341.41929-1-rpearson@hpe.com> <20210422161341.41929-9-rpearson@hpe.com>
 <CAD=hENeB_XJQOy-6tvNwe6+ZyAmw6LBe16ePT4DtcEpu+hOKTg@mail.gmail.com>
 <eb46fc9c-cc72-b928-f4ee-258fd10f2437@gmail.com> <CAD=hENdeuNZ7WXkXtV7BqbE0gP34=YH_gbn7odyq-GiAVccesA@mail.gmail.com>
 <4c176a90-0712-e8f7-222a-36cf87f899d7@gmail.com>
In-Reply-To: <4c176a90-0712-e8f7-222a-36cf87f899d7@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 29 Apr 2021 11:20:54 +0800
Message-ID: <CAD=hENcr_LuhgdSdXLcZSi97AyBof51xntDGyTKutmv5be_iXQ@mail.gmail.com>
Subject: Re: [PATCH for-next v5 08/10] RDMA/rxe: Implement invalidate MW operations
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 29, 2021 at 11:07 AM Pearson, Robert B
<rpearsonhpe@gmail.com> wrote:
>
>
> On 4/28/2021 7:54 PM, Zhu Yanjun wrote:
> > Adding a prefix makes debug easy. This can help filter the functions.
> > And a prefix can help us to verify the location of the function.
> >
> > Zhu Yanjun
>
> For comparison here are all the subroutine names from a well known
> driver file. As you can see, 100% of the non static subroutines *do*
> have mlx5 in their name but the majority of the static ones *do not*,
> and these are by definition not shared anywhere else but this file. This
> is representative of the typical style in linux-rdma.

With perf or ftrace debug tools, a lot of functions will pop out.
A prefix can help the developer to locate the functions source code easily.
And a prefix can help the developer filter the functions conveniently.

This is why I recommend a prefix.

Zhu Yanjun

>
> Bob
>
> static    TYPE add_keys()
> static    TYPE alloc_cacheable_mr()
> static    TYPE alloc_cache_mr()
> static    TYPE assign_mkey_variant()
> static    TYPE __cache_work_func()
> static    TYPE cache_work_func()
> static    TYPE can_use_umr_rereg_access()
> static    TYPE can_use_umr_rereg_pas()
> static    TYPE clean_keys()
> static    TYPE create_cache_mr()
> static    TYPE create_mkey_callback()
> static    TYPE create_real_mr()
> static    TYPE create_user_odp_mr()
> static    TYPE delayed_cache_work_func()
> static    TYPE delay_time_func()
> static    TYPE destroy_mkey()
> static    TYPE get_cache_mr()
> static    TYPE get_octo_len()
> static    TYPE limit_read()
> static    TYPE limit_write()
> static    TYPE mlx5_alloc_integrity_descs()
> static    TYPE mlx5_alloc_mem_reg_descs()
> static    TYPE _mlx5_alloc_mkey_descs()
> static    TYPE mlx5_alloc_priv_descs()
> static    TYPE mlx5_alloc_sg_gaps_descs()
> static    TYPE mlx5_free_priv_descs()
> static    TYPE __mlx5_ib_alloc_mr()
> static    TYPE mlx5_ib_alloc_pi_mr()
> static    TYPE *mlx5_ib_alloc_xlt()
> static    TYPE mlx5_ib_create_mkey()
> static    TYPE mlx5_ib_create_mkey_cb()
> static    TYPE *mlx5_ib_create_xlt_wr()
> static    TYPE mlx5_ib_dmabuf_invalidate_cb()
> static    TYPE mlx5_ib_free_xlt()
> static    TYPE mlx5_ib_get_dm_mr()
> static    TYPE mlx5_ib_init_umr_context()
> static    TYPE mlx5_ib_map_klm_mr_sg_pi()
> static    TYPE mlx5_ib_map_mtt_mr_sg_pi()
> static    TYPE mlx5_ib_map_pa_mr_sg_pi()
> static    TYPE mlx5_ib_post_send_wait()
> static    TYPE mlx5_ib_sg_to_klms()
> static    TYPE mlx5_ib_umr_done()
> static    TYPE mlx5_ib_unmap_free_xlt()
> static    TYPE mlx5_mr_cache_debugfs_cleanup()
> static    TYPE mlx5_mr_cache_debugfs_init()
> static    TYPE mlx5_mr_cache_free()
> static    TYPE mlx5_set_page()
> static    TYPE mlx5_set_page_pi()
> static    TYPE mlx5_set_umr_free_mkey()
> static    TYPE mlx5_umem_dmabuf_default_pgsz()
> static    TYPE mr_cache_ent_from_order()
> static    TYPE mr_cache_max_order()
> static    TYPE queue_adjust_cache_locked()
> static    TYPE reg_create()
> static    TYPE remove_cache_mr_locked()
> static    TYPE resize_available_mrs()
> static    TYPE revoke_mr()
> static    TYPE set_mkc_access_pd_addr_fields()
> static    TYPE set_mr_fields()
> static    TYPE size_read()
> static    TYPE size_write()
> static    TYPE someone_adding()
> static    TYPE umr_can_use_indirect_mkey()
> static    TYPE umr_rereg_pas()
> static    TYPE umr_rereg_pd_access()
> static    TYPE xlt_wr_final_send_flags()
>      TYPE mlx5_ib_advise_mr()
>      TYPE mlx5_ib_alloc_mr()
>      TYPE mlx5_ib_alloc_mr_integrity()
>      TYPE mlx5_ib_alloc_mw()
>      TYPE mlx5_ib_check_mr_status()
>      TYPE mlx5_ib_dealloc_mw()
>      TYPE mlx5_ib_dereg_mr()
>      TYPE mlx5_ib_get_dma_mr()
>      TYPE mlx5_ib_map_mr_sg()
>      TYPE mlx5_ib_map_mr_sg_pi()
>      TYPE mlx5_ib_reg_dm_mr()
>      TYPE mlx5_ib_reg_user_mr()
>      TYPE mlx5_ib_reg_user_mr_dmabuf()
>      TYPE mlx5_ib_rereg_user_mr()
>      TYPE mlx5_ib_update_mr_pas()
>      TYPE mlx5_ib_update_xlt()
>      TYPE mlx5_mr_cache_cleanup()
>      TYPE mlx5_mr_cache_init()
>
