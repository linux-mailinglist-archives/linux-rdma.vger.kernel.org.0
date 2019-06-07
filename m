Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB90A3958D
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 21:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfFGT2r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 15:28:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42484 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbfFGT2r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 15:28:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so2686287lje.9
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlRPeDHi0azRjVmRRuBjAHPXJeSQOwNdzPjbtxE4i9M=;
        b=Yx6/1xClyrNGnGwCp4vb40gTIiQEiT7t05SlLTqVZcMEQhYlLSI8rZkhaccouoWuKt
         3KTwRnenBAzMekmve3HaSZM1Xxhy1STO3OyDhj3uxF+wjNs8B7DJMTYfTkqju+4RKqh+
         xS0GZHyZIdPcosGREWWk4ZAguMzFHhg8ogolkfeX/XsdavqASaLQVF6WxJahTwwU9SPO
         ovDhj5ekAjKE0M/nJ/eC4dTZueY1h1oaCt2Dd2lCEHM47gqwel4ftYl8BhG9TgmQIHNt
         51fuNGW4m1K513Xd4gzA0q4C9VpoetO6p5VPZ5VkW1b2UdijJhit9lw9g1psUWCXcYGs
         lFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlRPeDHi0azRjVmRRuBjAHPXJeSQOwNdzPjbtxE4i9M=;
        b=LC3ut6csd+Y08tJuIkyBe3QbJvglADOkbnuYTb7NaE+MW1MILdH17oHlDSujNO1ZbL
         uD+VU+8Zln+BMKgClBkeMPJub9m5O1KpGPvSCWuJcpwQVY3k8YZ9IzesjK4BLo8g0ac+
         wcNVm2I7QBqW/YSHFmm30JBml2lbxKZczKZdpwfvATl0EkrnIl0OEGkD2cD/uS02Uxjv
         GOAaEjQXT0Y6YOOJwJZbppZMBd52rejCDGZ3THvf44Ez/9DJUS68mQhbO8W2NeqGp4fF
         8hJAIObWlUMBSJKM5eXwYj7bDn9QDobPFX15pbbNUfGvIB1FoXxeLY8YWUsTBw0Z6b0C
         ufuQ==
X-Gm-Message-State: APjAAAUS3zf4AEHYtX26IW8hJ3pIXIyOUOHBNudRzlw06ZwlQ+XQyf7l
        RmAiQiAZpqqivFfjvjI3PWr31xCRCpiGnEJ7g9Y=
X-Google-Smtp-Source: APXvYqx0qKprLQ87qlAbjtmXQEdXhJ8KkH2DSH0IxBEmNEYteKaq5Dm3xiR623NTFVEHjgmvhg0VhLekU5O8P34Ripw=
X-Received: by 2002:a2e:9747:: with SMTP id f7mr27943424ljj.34.1559935724712;
 Fri, 07 Jun 2019 12:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190523153436.19102-1-jgg@ziepe.ca> <20190523153436.19102-9-jgg@ziepe.ca>
In-Reply-To: <20190523153436.19102-9-jgg@ziepe.ca>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 8 Jun 2019 01:03:48 +0530
Message-ID: <CAFqt6zakL282X2SMh7E9kHDLnT9nW5ifbN2p1OKTXY4gaU=qkA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/11] mm/hmm: Use lockdep instead of comments
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 9:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> So we can check locking at runtime.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  mm/hmm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 2695925c0c5927..46872306f922bb 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -256,11 +256,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
>   *
>   * To start mirroring a process address space, the device driver must register
>   * an HMM mirror struct.
> - *
> - * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
>   */
>  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
>  {
> +       lockdep_assert_held_exclusive(mm->mmap_sem);
> +

Gentle query, does the same required in hmm_mirror_unregister() ?

>         /* Sanity check */
>         if (!mm || !mirror || !mirror->ops)
>                 return -EINVAL;
> --
> 2.21.0
>
