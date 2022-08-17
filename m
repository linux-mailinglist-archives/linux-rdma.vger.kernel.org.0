Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218DD596B94
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Aug 2022 10:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiHQIpk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Aug 2022 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiHQIpi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Aug 2022 04:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609694B0FF;
        Wed, 17 Aug 2022 01:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF5CE61362;
        Wed, 17 Aug 2022 08:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E93C433D6;
        Wed, 17 Aug 2022 08:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660725936;
        bh=Nl4ax/lyb7RpxEoNGNuW1AWeXdXLjVgCMAfaa08rBQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L339rJFtHf4UZSdKRcjJB8JkAPm5LKZaeoUlJIMenMcS8POHmcHZ12Hmt3bm4nLFv
         yt7x+rMDjp765fET+w4zrMVoIiuBP4XixZb01MI25U8gfcckfIVTB649GS8hLuvyKy
         WzEFq0xQH9bvOUnI65DSNYTUixjbyTRF4mILxFgr0GgNhRadOoHIivPaAwfdv3674J
         sbgsDgenLhSNa52qRNGbnQbgzNFJ4E2t2k7Usbf91qfK/zSP1Br4g0HmIGGTbkYry/
         sfxfC+BVcIBjMZlJao6CsdHyQLaNGmVdZLIXM6jD0uRisZ9w1NQ6QCykBH+CoLew+K
         FMZPb2YqwAviQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-11c5505dba2so925601fac.13;
        Wed, 17 Aug 2022 01:45:36 -0700 (PDT)
X-Gm-Message-State: ACgBeo2FhwE8KWmfCSBUC2wR8CBy8c0aFVa55sB4DstZyXVJxsK/Xtd+
        TOVbU9vgo7ouqBYQdx88MM3vlzItt0rCCHOdDzk=
X-Google-Smtp-Source: AA6agR5UK0nSUomkY8HQAeojh1Oyy4NrRyl664pTWXyUJbfC9S3o30KaZEymrrzcpQVOJ47FOUSQUkTlJozj4lG55Mg=
X-Received: by 2002:a05:6870:961d:b0:10d:7606:b212 with SMTP id
 d29-20020a056870961d00b0010d7606b212mr1147862oaq.166.1660725935417; Wed, 17
 Aug 2022 01:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <0-v1-d8f4e1fa84c8+17-rdma_dmabuf_fix_jgg@nvidia.com>
In-Reply-To: <0-v1-d8f4e1fa84c8+17-rdma_dmabuf_fix_jgg@nvidia.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 17 Aug 2022 11:45:09 +0300
X-Gmail-Original-Message-ID: <CAFCwf112pdMMuNBGEt9j5QR2Hq=X+=7KUZ-8hS-EF=BzzfEB7Q@mail.gmail.com>
Message-ID: <CAFCwf112pdMMuNBGEt9j5QR2Hq=X+=7KUZ-8hS-EF=BzzfEB7Q@mail.gmail.com>
Subject: Re: [PATCH rc] RDMA: Handle the return code from dma_resv_wait_timeout()
 properly
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Gal Pressman <gal@nvidia.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 16, 2022 at 5:03 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> ib_umem_dmabuf_map_pages() returns 0 on success and -ERRNO on failure.
>
> dma_resv_wait_timeout() uses a different scheme:
>
>  * Returns -ERESTARTSYS if interrupted, 0 if the wait timed out, or
>  * greater than zero on success.
>
> This results in ib_umem_dmabuf_map_pages() being non-functional as a
> positive return will be understood to be an error by drivers.
>
> Fixes: f30bceab16d1 ("RDMA: use dma_resv_wait() instead of extracting the fence")
> Cc: stable@kernel.org
> Tested-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/umem_dmabuf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> Oded, I assume the Habana driver will hit this as well - does this mean you
> are not testing upstream kernels?
Thanks Jason for letting me know.

You are correct, we don't use upstream kernels.
We use a back-ported EFA driver for 5.15 which in that version,
ib_umem_dmabuf_map_pages() calls dma_resv_excl_fence().
So I guess that's why we didn't encounter this issue.

Thanks,
oded




>
> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
> index fce80a4a5147cd..04c04e6d24c358 100644
> --- a/drivers/infiniband/core/umem_dmabuf.c
> +++ b/drivers/infiniband/core/umem_dmabuf.c
> @@ -18,6 +18,7 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
>         struct scatterlist *sg;
>         unsigned long start, end, cur = 0;
>         unsigned int nmap = 0;
> +       long ret;
>         int i;
>
>         dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> @@ -67,9 +68,14 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
>          * may be not up-to-date. Wait for the exporter to finish
>          * the migration.
>          */
> -       return dma_resv_wait_timeout(umem_dmabuf->attach->dmabuf->resv,
> +       ret = dma_resv_wait_timeout(umem_dmabuf->attach->dmabuf->resv,
>                                      DMA_RESV_USAGE_KERNEL,
>                                      false, MAX_SCHEDULE_TIMEOUT);
> +       if (ret < 0)
> +               return ret;
> +       if (ret == 0)
> +               return -ETIMEDOUT;
> +       return 0;
>  }
>  EXPORT_SYMBOL(ib_umem_dmabuf_map_pages);
>
>
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> --
> 2.37.2
>
