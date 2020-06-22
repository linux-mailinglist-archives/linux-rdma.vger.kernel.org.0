Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09299203475
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 12:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgFVKDt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 06:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgFVKDp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 06:03:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37422C061794
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 03:03:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v3so8537468wrc.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u+MdrdIcK4/3j9aNMGpZmPTI95IvtmOFAtS9OgOQO14=;
        b=gYeyRqKAB51e31L4xRhb3SrI5ivh2fP5RFuErHGfolBJhbGYXrLLPnONw9jMDdUNiA
         ubLATD2hS8QH03bNi+fOrWlIDHNzd8PQI4rRNr17fR7c218hN3Qz8zwDBAzj/V7p9JHT
         zKJM9PyyLlmKxE3LoK5jRo9tpuVidsbEKOoIUABIIEF8XWQo1E2+ZTBMy7/+CBMsCCm2
         4WU/Arvy8O4seJuvw/JUOzbSl9utzpq5m7Q2Q4oUyuONjbgfW9dGvTPc/q7/Bz9GAboV
         onPW2QRo8IaT76ASuuNEduzYvNxVV+0+ebgeWRIJ7PG8m8Ovq9hDyKgNL8AqWNFcCRs9
         PyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+MdrdIcK4/3j9aNMGpZmPTI95IvtmOFAtS9OgOQO14=;
        b=cHashK87DUPRlCRR3N9kxpn7gCvE9Zd00EWoBemDCijdfVKt8G7lgPJRY1xV5/cZR1
         N0fB7enBQ3KtDCJAiw4188Iz3TcGtIOzdfiFwTjhponSaTr7BhSFrsBr9d9NTtm6xax5
         GLZRVWWbSc+ZxR1tBgC29Aya9N7q7gTu0UvFJkt+RjLcNgMYUD3IfHCfTlRI4Xt4Zc6T
         JPpGb0VYdqgus2KDu1+NoPtRq85FantfOTDNS3moO/p99GvBl+yrCW8InNaHYt7HnCC3
         xC+5BGjOCmEQSuwwhzyvrfZrGZn5uGV6z7E3wAaYMV+ugCnXUBPztsx+K07yc/02jbet
         02hg==
X-Gm-Message-State: AOAM531UIh15w5CLCWQu4bsjxK3RNTLl6pOzrS29GVKjxwjYG+OjTR0A
        LkABjCX79E0lfb+DLteznhQ=
X-Google-Smtp-Source: ABdhPJz23R6PqmslOrfCa5GsNL7IeWi4rOHycWY4JmMcXF78sKacyMBLOhXBrmt8i+soj4Kvidvr+Q==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr17749252wrv.330.1592820223813;
        Mon, 22 Jun 2020 03:03:43 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id x13sm17778330wre.83.2020.06.22.03.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:03:43 -0700 (PDT)
Date:   Mon, 22 Jun 2020 13:03:40 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Zhu Yanjun <yanjunz@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Remove unused rxe_mem_map_pages
Message-ID: <20200622100340.GA26223@kheib-workstation>
References: <20200622093131.9238-1-kamalheib1@gmail.com>
 <CAD=hENe62hemUGm6m_ecp_RH5qMYua5d8F=1Lxuh6mob8xe5Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENe62hemUGm6m_ecp_RH5qMYua5d8F=1Lxuh6mob8xe5Pg@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 22, 2020 at 05:52:35PM +0800, Zhu Yanjun wrote:
> On Mon, Jun 22, 2020 at 5:32 PM Kamal Heib <kamalheib1@gmail.com> wrote:
> >
> > This function is not in use - delete it.
> >
> Add:
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> 
> Is it better?
>

I agree, I'll post a v2.

Thanks,
Kamal


> Zhu Yanjun
> 
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_loc.h |  3 --
> >  drivers/infiniband/sw/rxe/rxe_mr.c  | 44 -----------------------------
> >  2 files changed, 47 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> > index 775c23becaec..238d6a357aac 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > @@ -132,9 +132,6 @@ struct rxe_mem *lookup_mem(struct rxe_pd *pd, int access, u32 key,
> >
> >  int mem_check_range(struct rxe_mem *mem, u64 iova, size_t length);
> >
> > -int rxe_mem_map_pages(struct rxe_dev *rxe, struct rxe_mem *mem,
> > -                     u64 *page, int num_pages, u64 iova);
> > -
> >  void rxe_mem_cleanup(struct rxe_pool_entry *arg);
> >
> >  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > index e83c7b518bfa..a63cb5fac01f 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -587,47 +587,3 @@ struct rxe_mem *lookup_mem(struct rxe_pd *pd, int access, u32 key,
> >
> >         return mem;
> >  }
> > -
> > -int rxe_mem_map_pages(struct rxe_dev *rxe, struct rxe_mem *mem,
> > -                     u64 *page, int num_pages, u64 iova)
> > -{
> > -       int i;
> > -       int num_buf;
> > -       int err;
> > -       struct rxe_map **map;
> > -       struct rxe_phys_buf *buf;
> > -       int page_size;
> > -
> > -       if (num_pages > mem->max_buf) {
> > -               err = -EINVAL;
> > -               goto err1;
> > -       }
> > -
> > -       num_buf         = 0;
> > -       page_size       = 1 << mem->page_shift;
> > -       map             = mem->map;
> > -       buf             = map[0]->buf;
> > -
> > -       for (i = 0; i < num_pages; i++) {
> > -               buf->addr = *page++;
> > -               buf->size = page_size;
> > -               buf++;
> > -               num_buf++;
> > -
> > -               if (num_buf == RXE_BUF_PER_MAP) {
> > -                       map++;
> > -                       buf = map[0]->buf;
> > -                       num_buf = 0;
> > -               }
> > -       }
> > -
> > -       mem->iova       = iova;
> > -       mem->va         = iova;
> > -       mem->length     = num_pages << mem->page_shift;
> > -       mem->state      = RXE_MEM_STATE_VALID;
> > -
> > -       return 0;
> > -
> > -err1:
> > -       return err;
> > -}
> > --
> > 2.25.4
> >
