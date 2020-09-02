Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7525A273
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIBAvO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIBAvO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:51:14 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C750C061244
        for <linux-rdma@vger.kernel.org>; Tue,  1 Sep 2020 17:51:14 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k20so2850348otr.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Sep 2020 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/wj1L7PQ+SmAdlcCCCWXSQxCZDrR4+Valrau5ZJcRQ=;
        b=svjdornuRl4wx4eAru1NiPsXHr1di5YpMJCV2m+8WMCWBG7ucd4+1HBqL7PQsgKl7J
         NS8+a6EMr/AA3Em+zuUw/h22ntrsshn/3g0XX1+GNLUTKeIP/Vhlea7CXo3UYu55M0T6
         5KYbT8STqqXknfgR/7BexAQ1Xnvxt8qLHQ0HCsgOP1Kej2ECOE4EZ3ksBdCT/fVAqpEn
         2M5kSqZZWfDlt5xQb5VxORNKlIR0Pxu03UV3/sFF+Zmw6ZLfHbwKPylhTKgyIfprJRNM
         bV0HLkc5/KayMbwrEcEhMg8cymtrwqT6XaBptmeS9Xvf36dqxs5iRyahDhtn7ab3doFo
         sMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/wj1L7PQ+SmAdlcCCCWXSQxCZDrR4+Valrau5ZJcRQ=;
        b=J8nK/5OBZS/JCOhZ89rsfLaJxHrt8fYOOL9730Htg4RMTcCa/YZg8XwV/5dF/0QB3t
         COueG6/aLHOquKuuPK08EdxYuw7qyxG8OjI34obvJyCHxzZqnbfZTYXLbAwo7GqlrwXf
         oVBCvy/NsfSXAIRTuHZ2i83pE395cpMypwJ37G4xa6c5vAIhI2huO7m8g7gZH+vIRNgk
         3Jnop23RIYdyeZ7b2dVvC+zd5/+4z2YDsYQRslfeM9IVzk8cvLmRxKv3Mfqo/6y2BU1c
         nhvq1qnTquC0nzLVN0kSexnRzPxw/4azAqPd0oOHivdryusIgcBe0f5aU6mQM4XN9y4w
         2lRg==
X-Gm-Message-State: AOAM533e+Vm2/PADxA6RthI0a8vfpzs3To5w0/R3afd+5G5zkEVhGHI+
        w9pACpb/S34l8Wo9UFXaJWvnj4SldCFyLdbDtpk=
X-Google-Smtp-Source: ABdhPJxuSbmJmEwrauQnnaFul83FOy04jSrNSjKd0T8U7zdqF37znC100KnZVQ/kdUrac0alYQKGGgB8kJatkr2+aYA=
X-Received: by 2002:a9d:644e:: with SMTP id m14mr3603968otl.278.1599007873523;
 Tue, 01 Sep 2020 17:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com> <14-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <14-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 2 Sep 2020 08:51:02 +0800
Message-ID: <CAD=hENcDFDKfAMwt-ArLnG2EdoAU6tYzO5OuOG8aOvpvjGQ=kQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] RDMA/umem: Rename ib_umem_offset() to ib_umem_dma_offset()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 2, 2020 at 8:46 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> This function should be used to get the offset from the first DMA block.
>
> The few places using this without a DMA iterator are calling it to work
> around the lack of setting sgl->offset when the umem is created.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c              | 2 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
>  drivers/infiniband/hw/qedr/verbs.c          | 2 +-
>  drivers/infiniband/sw/rdmavt/mr.c           | 2 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c          | 2 +-
>  include/rdma/ib_umem.h                      | 9 ++++++---
>  6 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 49d6ddc37b6fde..c840115b8c0945 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -369,7 +369,7 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>         }
>
>         ret = sg_pcopy_to_buffer(umem->sg_head.sgl, umem->sg_nents, dst, length,
> -                                offset + ib_umem_offset(umem));
> +                                offset + ib_umem_dma_offset(umem, PAGE_SIZE));
>
>         if (ret < 0)
>                 return ret;
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index 1fb8da6d613674..f22532fbc364fe 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -870,7 +870,7 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
>                 goto umem_err;
>
>         mr->hwmr.pbe_size = PAGE_SIZE;
> -       mr->hwmr.fbo = ib_umem_offset(mr->umem);
> +       mr->hwmr.fbo = ib_umem_dma_offset(mr->umem, PAGE_SIZE);
>         mr->hwmr.va = usr_addr;
>         mr->hwmr.len = len;
>         mr->hwmr.remote_wr = (acc & IB_ACCESS_REMOTE_WRITE) ? 1 : 0;
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index 278b48443aedba..daac742e71044d 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -2878,7 +2878,7 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
>         mr->hw_mr.pbl_two_level = mr->info.pbl_info.two_layered;
>         mr->hw_mr.pbl_page_size_log = ilog2(mr->info.pbl_info.pbl_size);
>         mr->hw_mr.page_size_log = PAGE_SHIFT;
> -       mr->hw_mr.fbo = ib_umem_offset(mr->umem);
> +       mr->hw_mr.fbo = ib_umem_dma_offset(mr->umem, PAGE_SIZE);
>         mr->hw_mr.length = len;
>         mr->hw_mr.vaddr = usr_addr;
>         mr->hw_mr.zbva = false;
> diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
> index 2f7c25fea44a9d..04f7dc0ce9e44d 100644
> --- a/drivers/infiniband/sw/rdmavt/mr.c
> +++ b/drivers/infiniband/sw/rdmavt/mr.c
> @@ -404,7 +404,7 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>         mr->mr.user_base = start;
>         mr->mr.iova = virt_addr;
>         mr->mr.length = length;
> -       mr->mr.offset = ib_umem_offset(umem);
> +       mr->mr.offset = ib_umem_dma_offset(umem, PAGE_SIZE);
>         mr->mr.access_flags = mr_access_flags;
>         mr->umem = umem;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 708e2dff5eaa70..8f60dc9dee8658 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -196,7 +196,7 @@ int rxe_mem_init_user(struct rxe_pd *pd, u64 start,
>         mem->length             = length;
>         mem->iova               = iova;
>         mem->va                 = start;
> -       mem->offset             = ib_umem_offset(umem);
> +       mem->offset             = ib_umem_dma_offset(umem, PAGE_SIZE);

Thanks,
Zhu Yanjun

>         mem->state              = RXE_MEM_STATE_VALID;
>         mem->type               = RXE_MEM_TYPE_MR;
>
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index 4bac6e29f030c2..5e709b2c251644 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -27,10 +27,13 @@ struct ib_umem {
>         unsigned int    sg_nents;
>  };
>
> -/* Returns the offset of the umem start relative to the first page. */
> -static inline int ib_umem_offset(struct ib_umem *umem)
> +/*
> + * Returns the offset of the umem start relative to the first DMA block returned
> + * by rdma_umem_for_each_dma_block().
> + */
> +static inline int ib_umem_dma_offset(struct ib_umem *umem, unsigned long pgsz)
>  {
> -       return umem->address & ~PAGE_MASK;
> +       return umem->address & (pgsz - 1);
>  }
>
>  static inline size_t ib_umem_num_dma_blocks(struct ib_umem *umem,
> --
> 2.28.0
>
