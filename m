Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE80028482A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 10:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgJFINf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 04:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFINf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 04:13:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E72C061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 01:13:34 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qp15so16309442ejb.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21suOWzGvtiXIUaWUS8NNn/Bz3Sh2Gav5vv5gRb5Dx4=;
        b=OpGBZ/9LMBAPOvIqSvXSBXAwet0C+S2rsJo37zwRwlfpbyt7qHPTMiMV8b2qbT8a4q
         itftwU5LpUfka9lE0GXxaG+vZr1sVWxCooXJMnoDwR16fKJ+h/4EVaoYkCPL6a5TQhmO
         o5fpmDF5Pwkn2VvdELWj16PRw4Js5M82LQ2f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21suOWzGvtiXIUaWUS8NNn/Bz3Sh2Gav5vv5gRb5Dx4=;
        b=m//YGFZfUTwK2kE0oCJT2lfZ8zUy17oEDsI8wPdvACrol1w0oA16H+gB8n/5AijRR7
         M+f0ahk/noQI6OuSbmX27hL36LshsOghEoKZpeSNA3+dUlJ+ORPz1NhC3oc3EeMgawff
         p4jxKJYKAhORoALDxZMtjPlJEBpnbuhFjgF3kmEjKdNhYBo3Y8zgZnlBVzdYBVFRVkQC
         VjV1rgPECumqBL+gD+EMD/OaxQGZXD8prsNkRZYkHGLKnHPGsgu12Ox+HPXaHHBGtAuD
         I+iCTieaaODmNaK08FyqhrwCiwxBMUKinR3ubtZyigWJll0Q/y71Ju2/4M0pUdtyinZt
         xIAA==
X-Gm-Message-State: AOAM531mi6g6Lk6KL+QwWuU3kgUd97jBzHc/18fCA6qD23tpGgSoGHSv
        WbDyOTM+E5hDjcvCFLqQs5aO6e7qZB38RhT8GAMDs7ZcPOOl/Q==
X-Google-Smtp-Source: ABdhPJz4nhieg/j8xyvh/bQVd2rX6AI29OCF8yw2fC015LKKS2/C4l2NLp5wIvZ/XZ06m2mzj7eh+RLFAHgHrcV+VYo=
X-Received: by 2002:a17:906:a2d9:: with SMTP id by25mr4034603ejb.326.1601972013222;
 Tue, 06 Oct 2020 01:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <0-v1-b37437a73f35+49c-bnxt_re_dma_block_jgg@nvidia.com>
In-Reply-To: <0-v1-b37437a73f35+49c-bnxt_re_dma_block_jgg@nvidia.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Tue, 6 Oct 2020 13:43:21 +0530
Message-ID: <CA+sbYW3A6as9ekAjVdyVz5SdQu1uBo_nsOJi40wnNf8kcipw1Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Use rdma_umem_for_each_dma_block()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d21bae05b0fc2c03"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000d21bae05b0fc2c03
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 30, 2020 at 5:54 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> This driver is taking the SGL out of the umem and passing it through a
> struct bnxt_qplib_sg_info. Instead of passing the SGL pass the umem and
> then use rdma_umem_for_each_dma_block() directly.
>
> Move the calls of ib_umem_num_dma_blocks() closer to their actual point of
> use, npages is only set for non-umem pbl flows.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Tested-by: Selvin Xavier <selvin.xavier@broadcom.com>

Thanks

> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 18 +++-----------
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 30 +++++++++++++----------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  3 +--
>  3 files changed, 22 insertions(+), 29 deletions(-)
>
> This is part of the umem cleanup. It is a bit complicated, would be good for
> someone to check it. Thanks
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index a0e8d93595d8e8..e2707b27c9500c 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -940,9 +940,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
>                 return PTR_ERR(umem);
>
>         qp->sumem = umem;
> -       qplib_qp->sq.sg_info.sghead = umem->sg_head.sgl;
> -       qplib_qp->sq.sg_info.npages = ib_umem_num_dma_blocks(umem, PAGE_SIZE);
> -       qplib_qp->sq.sg_info.nmap = umem->nmap;
> +       qplib_qp->sq.sg_info.umem = umem;
>         qplib_qp->sq.sg_info.pgsize = PAGE_SIZE;
>         qplib_qp->sq.sg_info.pgshft = PAGE_SHIFT;
>         qplib_qp->qp_handle = ureq.qp_handle;
> @@ -955,10 +953,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
>                 if (IS_ERR(umem))
>                         goto rqfail;
>                 qp->rumem = umem;
> -               qplib_qp->rq.sg_info.sghead = umem->sg_head.sgl;
> -               qplib_qp->rq.sg_info.npages =
> -                       ib_umem_num_dma_blocks(umem, PAGE_SIZE);
> -               qplib_qp->rq.sg_info.nmap = umem->nmap;
> +               qplib_qp->rq.sg_info.umem = umem;
>                 qplib_qp->rq.sg_info.pgsize = PAGE_SIZE;
>                 qplib_qp->rq.sg_info.pgshft = PAGE_SHIFT;
>         }
> @@ -1612,9 +1607,7 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
>                 return PTR_ERR(umem);
>
>         srq->umem = umem;
> -       qplib_srq->sg_info.sghead = umem->sg_head.sgl;
> -       qplib_srq->sg_info.npages = ib_umem_num_dma_blocks(umem, PAGE_SIZE);
> -       qplib_srq->sg_info.nmap = umem->nmap;
> +       qplib_srq->sg_info.umem = umem;
>         qplib_srq->sg_info.pgsize = PAGE_SIZE;
>         qplib_srq->sg_info.pgshft = PAGE_SHIFT;
>         qplib_srq->srq_handle = ureq.srq_handle;
> @@ -2865,10 +2858,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>                         rc = PTR_ERR(cq->umem);
>                         goto fail;
>                 }
> -               cq->qplib_cq.sg_info.sghead = cq->umem->sg_head.sgl;
> -               cq->qplib_cq.sg_info.npages =
> -                       ib_umem_num_dma_blocks(cq->umem, PAGE_SIZE);
> -               cq->qplib_cq.sg_info.nmap = cq->umem->nmap;
> +               cq->qplib_cq.sg_info.umem = cq->umem;
>                 cq->qplib_cq.dpi = &uctx->dpi;
>         } else {
>                 cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> index 7efa6e5dce6282..fa7878336100ac 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> @@ -45,6 +45,9 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/if_vlan.h>
>  #include <linux/vmalloc.h>
> +#include <rdma/ib_verbs.h>
> +#include <rdma/ib_umem.h>
> +
>  #include "roce_hsi.h"
>  #include "qplib_res.h"
>  #include "qplib_sp.h"
> @@ -87,12 +90,11 @@ static void __free_pbl(struct bnxt_qplib_res *res, struct bnxt_qplib_pbl *pbl,
>  static void bnxt_qplib_fill_user_dma_pages(struct bnxt_qplib_pbl *pbl,
>                                            struct bnxt_qplib_sg_info *sginfo)
>  {
> -       struct scatterlist *sghead = sginfo->sghead;
> -       struct sg_dma_page_iter sg_iter;
> +       struct ib_block_iter biter;
>         int i = 0;
>
> -       for_each_sg_dma_page(sghead, &sg_iter, sginfo->nmap, 0) {
> -               pbl->pg_map_arr[i] = sg_page_iter_dma_address(&sg_iter);
> +       rdma_umem_for_each_dma_block(sginfo->umem, &biter, sginfo->pgsize) {
> +               pbl->pg_map_arr[i] = rdma_block_iter_dma_address(&biter);
>                 pbl->pg_arr[i] = NULL;
>                 pbl->pg_count++;
>                 i++;
> @@ -104,15 +106,16 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
>                        struct bnxt_qplib_sg_info *sginfo)
>  {
>         struct pci_dev *pdev = res->pdev;
> -       struct scatterlist *sghead;
>         bool is_umem = false;
>         u32 pages;
>         int i;
>
>         if (sginfo->nopte)
>                 return 0;
> -       pages = sginfo->npages;
> -       sghead = sginfo->sghead;
> +       if (sginfo->umem)
> +               pages = ib_umem_num_dma_blocks(sginfo->umem, sginfo->pgsize);
> +       else
> +               pages = sginfo->npages;
>         /* page ptr arrays */
>         pbl->pg_arr = vmalloc(pages * sizeof(void *));
>         if (!pbl->pg_arr)
> @@ -127,7 +130,7 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
>         pbl->pg_count = 0;
>         pbl->pg_size = sginfo->pgsize;
>
> -       if (!sghead) {
> +       if (!sginfo->umem) {
>                 for (i = 0; i < pages; i++) {
>                         pbl->pg_arr[i] = dma_alloc_coherent(&pdev->dev,
>                                                             pbl->pg_size,
> @@ -183,14 +186,12 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
>         struct bnxt_qplib_sg_info sginfo = {};
>         u32 depth, stride, npbl, npde;
>         dma_addr_t *src_phys_ptr, **dst_virt_ptr;
> -       struct scatterlist *sghead = NULL;
>         struct bnxt_qplib_res *res;
>         struct pci_dev *pdev;
>         int i, rc, lvl;
>
>         res = hwq_attr->res;
>         pdev = res->pdev;
> -       sghead = hwq_attr->sginfo->sghead;
>         pg_size = hwq_attr->sginfo->pgsize;
>         hwq->level = PBL_LVL_MAX;
>
> @@ -204,7 +205,7 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
>                         aux_pages++;
>         }
>
> -       if (!sghead) {
> +       if (!hwq_attr->sginfo->umem) {
>                 hwq->is_user = false;
>                 npages = (depth * stride) / pg_size + aux_pages;
>                 if ((depth * stride) % pg_size)
> @@ -213,11 +214,14 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
>                         return -EINVAL;
>                 hwq_attr->sginfo->npages = npages;
>         } else {
> +               unsigned long sginfo_num_pages = ib_umem_num_dma_blocks(
> +                       hwq_attr->sginfo->umem, hwq_attr->sginfo->pgsize);
> +
>                 hwq->is_user = true;
> -               npages = hwq_attr->sginfo->npages;
> +               npages = sginfo_num_pages;
>                 npages = (npages * PAGE_SIZE) /
>                           BIT_ULL(hwq_attr->sginfo->pgshft);
> -               if ((hwq_attr->sginfo->npages * PAGE_SIZE) %
> +               if ((sginfo_num_pages * PAGE_SIZE) %
>                      BIT_ULL(hwq_attr->sginfo->pgshft))
>                         if (!npages)
>                                 npages++;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> index 9da470d1e4a3c2..ceb94db20a786a 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> @@ -126,8 +126,7 @@ struct bnxt_qplib_pbl {
>  };
>
>  struct bnxt_qplib_sg_info {
> -       struct scatterlist              *sghead;
> -       u32                             nmap;
> +       struct ib_umem                  *umem;
>         u32                             npages;
>         u32                             pgshft;
>         u32                             pgsize;
> --
> 2.28.0
>

--000000000000d21bae05b0fc2c03
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQUQYJKoZIhvcNAQcCoIIQQjCCED4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2mMIIE6DCCA9CgAwIBAgIOSBtqCRO9gCTKXSLwFPMwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UE
CxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMT
Ckdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAwWhcNMjQwNjE1MDAwMDAwWjBdMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpZok2X9LAHsYqMNVL+Ly6RDkaKar7GD8rVtb9nw6tzPFnvXGeOEA4X5xh9wjx9sScVpGR5wkTg1
fgJIXTlrGESmaqXIdPRd9YQ+Yx9xRIIIPu3Jp/bpbiZBKYDJSbr/2Xago7sb9nnfSyjTSnucUcIP
ZVChn6hKneVGBI2DT9yyyD3PmCEJmEzA8Y96qT83JmVH2GaPSSbCw0C+Zj1s/zqtKUbwE5zh8uuZ
p4vC019QbaIOb8cGlzgvTqGORwK0gwDYpOO6QQdg5d03WvIHwTunnJdoLrfvqUg2vOlpqJmqR+nH
9lHS+bEstsVJtZieU1Pa+3LzfA/4cT7XA/pnwwIDAQABo4IBtTCCAbEwDgYDVR0PAQH/BAQDAgEG
MGoGA1UdJQRjMGEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAwkGCisGAQQBgjcUAgIGCisG
AQQBgjcKAwQGCSsGAQQBgjcVBgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFGlygmIxZ5VEhXeRgMQENkmdewthMB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMGcGA1UdIARgMF4wCwYJKwYBBAGgMgEoMAwGCisG
AQQBoDIBKAowQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNp
Z24uY29tL3JlcG9zaXRvcnkvMA0GCSqGSIb3DQEBCwUAA4IBAQConc0yzHxn4gtQ16VccKNm4iXv
6rS2UzBuhxI3XDPiwihW45O9RZXzWNgVcUzz5IKJFL7+pcxHvesGVII+5r++9eqI9XnEKCILjHr2
DgvjKq5Jmg6bwifybLYbVUoBthnhaFB0WLwSRRhPrt5eGxMw51UmNICi/hSKBKsHhGFSEaJQALZy
4HL0EWduE6ILYAjX6BSXRDtHFeUPddb46f5Hf5rzITGLsn9BIpoOVrgS878O4JnfUWQi29yBfn75
HajifFvPC+uqn+rcVnvrpLgsLOYG/64kWX/FRH8+mhVe+mcSX3xsUpcxK9q9vLTVtroU/yJUmEC4
OcH5dQsbHBqjMIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4G
A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aE
yiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5
uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bL
yCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg
6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkW
qQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+
yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5
RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpYKBov
Hd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX42
68NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o
2HLO02JQZR7rkpeDMdmztcpHWD9fMIIFUzCCBDugAwIBAgIMKiSIRRfesYqFvLBOMA0GCSqGSIb3
DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMwHhcNMjAwOTIxMTQ1
MTQ2WhcNMjIwOTIyMTQ1MTQ2WjCBnDELMAkGA1UEBhMCSU4xEjAQBgNVBAgTCUthcm5hdGFrYTES
MBAGA1UEBxMJQmFuZ2Fsb3JlMRYwFAYDVQQKEw1Ccm9hZGNvbSBJbmMuMSIwIAYDVQQDExlTZWx2
aW4gVGh5cGFyYW1waWwgWGF2aWVyMSkwJwYJKoZIhvcNAQkBFhpzZWx2aW4ueGF2aWVyQGJyb2Fk
Y29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANqzadW0/yOQaEN6JQ913E1A
qwuLkRxyCYYCajkqDMrYVY1SjcJX/e53ER/L+FZKafnRX9YNemzaRHR4vevD3fO1lW94Lp6Af1Yc
ntj6Fh39AuKwqxFRjgmPxGRgZJ7QanBeDb2/FPA0wT4d2BLt1H5XD8GVdFflnPcq4SwA5Vne7j07
8FiCffeHJWoQjKQNLCaYXQAHXRlpa7/Oz1cOfJU6MrfUYCl8bKGzFPzTrsWCkLTSePmEOKjkQswO
E57pwqmNNXKez5LsgWg0MCcM26jqs8SBTJIA/6zJgjW8nK8WLLIPfCZO1NGVxIkHTjVy2Du2fAKX
qPfnml4GF/qROS0CAwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEw
gY4wTQYIKwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVy
c29uYWxzaWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFs
c2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0
MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNV
HRMEAjAAMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJz
b25hbHNpZ24yc2hhMmczLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAd
BgNVHQ4EFgQUKr67/GLyV/C27HDAeg3i3tW9facwDQYJKoZIhvcNAQELBQADggEBABQEPPwx33W2
mW8bSM5/AERxpztkHy4343YTHPsNXO/WrC+SuEQTYhV1eMrJbh1tZduP2rKgvZskl65mPF3qkRWi
J4J0DABOqmcJmyNoeIeXxcZx9bJqjiQWTT2iV+cCTYuiDrA+JUVKoMnmGwh2aSz6BH9Jsv2PFCNS
A6WyTEkC5z+3rM1f91ynuoPZCsYw/V1Hm5Nb+8lCB+0vqbUNUU3vlsiCuyym/XpDULrdf+qAGK+z
fntrEGyEOXbwpxyp5YGNdslhesuWawlpJUy3JSzRI9vx1SS2UaXG1+tsbKMkc1OyML6gl7W2AGPy
KN/Okg/+FqXwVaCbzR83sc69+FYxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENB
IC0gU0hBMjU2IC0gRzMCDCokiEUX3rGKhbywTjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0B
CQQxIgQgWB6bbIGhzpvuBHz4hWEzsOtMvtO19QRdioXLkx5wQdcwGAYJKoZIhvcNAQkDMQsGCSqG
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAxMDA2MDgxMzMzWjBpBgkqhkiG9w0BCQ8xXDBaMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3
DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEGIFamJNP7l
hdetp7StwgFU19UCwphlUHyxin5WwjDonVuykggcaf5Ek490CaboGJZsfSU9UJipvfmOfh94QXYn
xIOxzQDpYuvBbmpyae0glBg6pyPmsIZF/PB5XNJs93ERZHFsL4MDjUeDVx5cC55eS+/JQTCgcBJh
66VPxcA0zcf9fJ40cKrBt9+H5IJ139Q6dC7dh2HQ99CKQkSOH8AVswdfwcUpyJpe/Y1olvlT0mVA
C67sv2v4ysecnshyFFya5XXbiXM3wEjYK5lsMQfznOtdskKZ3G5hEXgUdvtD4RvdROUdeZi5gev3
e13l9VRKa7ROW1sMC2av7JyZeyA=
--000000000000d21bae05b0fc2c03--
