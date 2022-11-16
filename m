Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A80C62BE9D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 13:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKPMtz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 07:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiKPMth (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 07:49:37 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7072E1740A;
        Wed, 16 Nov 2022 04:49:36 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c1so29314248lfi.7;
        Wed, 16 Nov 2022 04:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/ZEkkFoZNu6RnKy8matJeXDIgkx3kAaQOPRGjjYlqM=;
        b=Cp/SARYYvehei0mJeJSPv/kEkzMtef9ODZxBz5mhI7AgieoOdp/GnQqo28vU7+W973
         eRqld0eSF6F2ilJGKYMRALZXsVym2lIx7masmoUoOCdrf0ymTxECYNTlNGq9jlsKqmoB
         TlFxCoaN/Lkwj3rDOKjVuCnKZOPFWSJfztDpL39CYfMsehkSbdp0drZgZ2qiqS7e96sN
         HSMOblV5G8BrFN7lmwH51NcCATsnRgx372RVJxvY6p+ZtfMwdchrRvvL+LxO7VawOXHd
         H9zXUzByDQUcGtQo+6kYO+pN0r/gZKfk2dO9r53qv1yYoqcEn4TwA+wEDgKRMASaTjGB
         dcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/ZEkkFoZNu6RnKy8matJeXDIgkx3kAaQOPRGjjYlqM=;
        b=aO833KxOlGOoXE5I5A/jfKW81tjhNnCVZP9swdb7sf0o1fyQDBlX3Lf+rflezlGv7m
         UabrNmccoxXBys9i+Jr6FsyYQGKN5tqhxeWp8Att/E1ZogXo5ow/qqVCqR4vASTw5A5I
         FuUENXBXUwd1a0lKoi/7dOQRb8bfJiAhbmKNso9idRWlakrUPKOxBI/CeR+vXutlGC8p
         RkvPfqxNdkBsmEJkBNgai6oTxPNZI6mZ0z8rV8XJXt4lu4eTpNroMESHLLTPAVTMi4AT
         NvkxD2DdWcmEUpN9l0Fgqp8QkuUAMebO7G7A/Yq1Mh1FmhLWyuIy88AH6OwIbIbj1C3P
         APaQ==
X-Gm-Message-State: ANoB5plzSHvZA2z2jM62KFC6T3gmEetph4OI+yLM9sS3Fr5/GzkbqAdp
        MWzUEy4NF8H/sqay+IEC7+RoAS15dzmG33rcmjU=
X-Google-Smtp-Source: AA0mqf6ctDeOsVzraRVQs3yfqcRABVSBaaW3jWPDzBpQr1sfElUwVUZFFhqzZxSrULLq2kBPZB+b+9wUukS73y0On9k=
X-Received: by 2002:ac2:4bcb:0:b0:4b4:210d:7d2e with SMTP id
 o11-20020ac24bcb000000b004b4210d7d2emr7518271lfq.450.1668602974707; Wed, 16
 Nov 2022 04:49:34 -0800 (PST)
MIME-Version: 1.0
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com> <1668141030-2-5-git-send-email-lizhijian@fujitsu.com>
In-Reply-To: <1668141030-2-5-git-send-email-lizhijian@fujitsu.com>
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Date:   Wed, 16 Nov 2022 13:49:18 +0100
Message-ID: <CAPj211sEjccp41cq=gsEkmc-5X_oYEoN8G6kHOQWKy95ysOY0Q@mail.gmail.com>
Subject: Re: [for-next PATCH 4/5] RDMA/rxe: refactor iova_to_vaddr
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On venerd=C3=AC 11 novembre 2022 05:30:29 CET Li Zhijian wrote:
> For IB_MR_TYPE_USER MR, iova_to_vaddr() will call kmap_local_page() to
> map page.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 38 +++++++++++++++------------
>  drivers/infiniband/sw/rxe/rxe_resp.c  |  1 +
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  5 +++-
>  4 files changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h
> b/drivers/infiniband/sw/rxe/rxe_loc.h index c2a5c8814a48..22a8c44d39c8
100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -73,6 +73,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr=
,
int
> length, int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info
> *dma, void *addr, int length, enum rxe_mr_copy_dir dir);
>  void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
> +void rxe_unmap_vaddr(struct rxe_mr *mr, void *vaddr);
>  struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>                        enum rxe_mr_lookup_type type);
>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> b/drivers/infiniband/sw/rxe/rxe_mr.c index a4e786b657b7..d26a4a33119c 100=
644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -120,9 +120,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, =
u64
> length, u64 iova, struct ib_umem              *umem;
>       struct sg_page_iter     sg_iter;
>       int                     num_buf;
> -     void                    *vaddr;
>       int err;
> -     int i;
>
>       umem =3D ib_umem_get(&rxe->ib_dev, start, length, access);
>       if (IS_ERR(umem)) {
> @@ -159,18 +157,9 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start,
u64
> length, u64 iova, num_buf =3D 0;
>                       }
>
> -                     vaddr =3D
page_address(sg_page_iter_page(&sg_iter));
> -                     if (!vaddr) {
> -                             pr_warn("%s: Unable to get virtual
address\n",
> -                                             __func__);
> -                             err =3D -ENOMEM;
> -                             goto err_cleanup_map;
> -                     }
> -
> -                     buf->addr =3D (uintptr_t)vaddr;
> +                     buf->page =3D sg_page_iter_page(&sg_iter);
>                       num_buf++;
>                       buf++;
> -
>               }
>       }
>
> @@ -182,10 +171,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start,
u64
> length, u64 iova,
>
>       return 0;
>
> -err_cleanup_map:
> -     for (i =3D 0; i < mr->num_map; i++)
> -             kfree(mr->map[i]);
> -     kfree(mr->map);
>  err_release_umem:
>       ib_umem_release(umem);
>  err_out:
> @@ -246,6 +231,12 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova,
int
> *m_out, int *n_out, }
>  }
>
> +void rxe_unmap_vaddr(struct rxe_mr *mr, void *vaddr)
> +{
> +     if (mr->ibmr.type =3D=3D IB_MR_TYPE_USER)
> +             kunmap_local(vaddr);
> +}
> +
>  static void *__iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
>  {
>       size_t offset;
> @@ -258,9 +249,21 @@ static void *__iova_to_vaddr(struct rxe_mr *mr, u64
iova,
> int length) return NULL;
>       }
>
> -     return (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
> +     if (mr->ibmr.type =3D=3D IB_MR_TYPE_USER) {
> +             char *paddr;
> +             struct page *pg =3D mr->map[m]->buf[n].page;
> +
> +             paddr =3D kmap_local_page(pg);
> +             if (paddr =3D=3D NULL) {
> +                     pr_warn("Failed to map page");
> +                     return NULL;
> +             }

I know nothing about this code but I am here as a result of regular checks =
for
changes to HIGHMEM mappings across the entire kernel. So please forgive me =
if
I'm objecting on correct changes.

1) It looks like this code had a call to page_address() and you converted i=
t
to mapping with kmap_local_page().

If page_address() is related and it used to work properly, the page you are
mapping cannot come from ZONE_HIGHMEM. Therefore, kmap_local_page() looks l=
ike
an overkill.

I'm probably missing something...

2) What made you think that kmap_local_page() might fail and return NULL?
AFAIK, kmap_local_page() won't ever return NULL, therefore there is no need=
 to
check.

Regards,

Fabio

P.S.: I just noticed that the second entry in my list was missing from the
other email which should be discarded.



> +             return paddr + offset;
> +     } else
> +             return (void *)(uintptr_t)mr->map[m]->buf[n].addr +
offset;
>  }
>
> +/* must call rxe_unmap_vaddr to unmap vaddr */
>  void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
>  {
>       if (mr->state !=3D RXE_MR_STATE_VALID) {
> @@ -326,6 +329,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *ad=
dr,
> int length, dest =3D (dir =3D=3D RXE_TO_MR_OBJ) ? va : addr;
>
>               memcpy(dest, src, bytes);
> +             rxe_unmap_vaddr(mr, va);
>
>               length  -=3D bytes;
>               addr    +=3D bytes;
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
> b/drivers/infiniband/sw/rxe/rxe_resp.c index 483043dc4e89..765cb9f8538a
> 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -636,6 +636,7 @@ static enum resp_states atomic_reply(struct rxe_qp *q=
p,
>
>               *vaddr =3D value;
>               spin_unlock_bh(&atomic_ops_lock);
> +             rxe_unmap_vaddr(mr, vaddr);
>
>               qp->resp.msn++;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h
> b/drivers/infiniband/sw/rxe/rxe_verbs.h index acab785ba7e2..6080a4b32f09
> 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -280,7 +280,10 @@ enum rxe_mr_lookup_type {
>  #define RXE_BUF_PER_MAP              (PAGE_SIZE / sizeof(struct
rxe_phys_buf))
>
>  struct rxe_phys_buf {
> -     u64      addr;
> +     union {
> +             u64 addr; /* IB_MR_TYPE_MEM_REG */
> +             struct page *page; /* IB_MR_TYPE_USER */
> +     };
>  };
>
>  struct rxe_map {
> --
> 2.31.1
