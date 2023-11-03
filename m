Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB61D7E0058
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347633AbjKCKOX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 06:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347768AbjKCKOW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 06:14:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9E8D45;
        Fri,  3 Nov 2023 03:14:20 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5b9a453d3d3so1483321a12.0;
        Fri, 03 Nov 2023 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699006460; x=1699611260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+65RYNQvrsYrl13TceHEcGyzemoLF4Zru1PnHMz1K0=;
        b=JN/mzlqVVL/9mkVYtjPLsDAAqIR5JIBrKqxQP9BtZiQs1VCHZF1QGXTWjPjWjz6f0m
         zHqF/bc6a445reEQ+7pzhX0zgz2qteNEZDHZMkrEdJWp2HVygTef7nTDtlW5WouyyOtZ
         seitizdWBPUIx3Fe4RxadyJ430i1PNhjdIm2xHcz1S4k1Oplt5JLoUtFWvFOhcHsSmDH
         EN2R9TX78mnih06ObNuHx5N25B+W9AuXyBPuKT9OYCZQf0/jy0QdBTOUGikkRIQiO7RP
         Xgy1cG+rzhJ8nq5QSrwKajdN89Cg6EudpuA4j/HfkSxQpeiS+q4brfq3E9JY9+0b6H+o
         oyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699006460; x=1699611260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+65RYNQvrsYrl13TceHEcGyzemoLF4Zru1PnHMz1K0=;
        b=SqcKWJ44A6FKJofE/0oqLTvDhBUIlOK4ClqCcqdR+EMGmx7HKcOIHOeNE8+2socMne
         XNmnWtemHN8V9uAYnIjpxi948oc6geq93uXtwgF65KT7FwogSTe3vBeYmhCTIpj0/eCM
         8oIjEvEWAad1qz/mpefHeKH7xoRcNt7NDnFycjZGF4dqt77aL4Xqb14o5tSdJ90FbC7I
         DZqUn/cftoTZcGOB8byWCs4b3J1EruMS+kOSBNqTu3XTnVNKLLsay3LaaX7vaetuRMo4
         nsUxIsbV2FXyO7OaDYnRh7jmWV97mUO789z+f19jDAudM2xU6Pj2pMixvQ4hp1WLgMmT
         4ATw==
X-Gm-Message-State: AOJu0YzaT5zbiTx90RrxGwA0KgXQjNi0fx1VXRfvWVU5pILoOg/32XOZ
        YFtibEoRebUMEEJ6NXtEjnvoBdKJ+prQZoFW4tM=
X-Google-Smtp-Source: AGHT+IEfXBZkMD60Ek69aexCEMY0kuPUwQUkokIY0a8ul1daeS5gkXGiQtacM1dJw2OBh7enk1ei3a+HfozZN6rDsE0=
X-Received: by 2002:a17:90a:4b07:b0:27f:f260:ceaf with SMTP id
 g7-20020a17090a4b0700b0027ff260ceafmr17099164pjh.10.1699006459735; Fri, 03
 Nov 2023 03:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231103095549.490744-1-lizhijian@fujitsu.com> <20231103095549.490744-2-lizhijian@fujitsu.com>
In-Reply-To: <20231103095549.490744-2-lizhijian@fujitsu.com>
From:   Greg Sword <gregsword0@gmail.com>
Date:   Fri, 3 Nov 2023 18:14:09 +0800
Message-ID: <CAEz=Lcu012KvkJbEC=ZeTFZk1vg51B2h66E6Hoh0JOcez58a=w@mail.gmail.com>
Subject: Re: [PATCH RFC V2 1/6] RDMA/rxe: RDMA/rxe: don't allow registering
 !PAGE_SIZE mr
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, matsuda-daisuke@fujitsu.com,
        bvanassche@acm.org, yi.zhang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 3, 2023 at 5:56=E2=80=AFPM Li Zhijian <lizhijian@fujitsu.com> w=
rote:
>
> rxe_set_page() only store one PAGE_SIZE page by the step of page_size.
> when page_size !=3D PAGE_SIZE, we cannot restore the address with wrong
> index and page_offset.
>
> Let's take a look how current the xarray is being used.
>
> 0. offset =3D iova & (page_size -1); // offset is less than page_size
>                                       but may not PAGE_SIZE
> 1. index =3D (iova - mr.iova) >> page_shift;
> 2. page =3D xa_load(&mr->page_list, index);
> 3. page_va =3D kmap_local_page(page) // map one page only, that means onl=
y
>                                       memory [page_va, page_va + PAGE_SIZ=
E)
>                                       is valid for this mapping.
> 4. memcpy(addr, page_va + offset, bytes);
>
> - when page_size > PAGE_SIZE, the offset could be beyond PAGE_SIZE,
>   then page_va + offset may be invalid.
> - when page_size < PAGE_SIZE, the offset may get lost.
>
> Note that this patch will break some ULPs that try to register 4K
> MR when PAGE_SIZE is not 4K. SRP and nvme over RXE is known to be
> impacted.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>
> ---
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/r=
xe/rxe_mr.c
> index f54042e9aeb2..3755e530e6dc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -234,6 +234,12 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatter=
list *sgl,
>         struct rxe_mr *mr =3D to_rmr(ibmr);
>         unsigned int page_size =3D mr_page_size(mr);
>
> +       if (page_size !=3D PAGE_SIZE) {
> +               rxe_err_mr(mr, "Unsupport mr page size %x, expect PAGE_SI=
ZE(%lx)\n",
> +                          page_size, PAGE_SIZE);
> +               return -EINVAL;
> +       }

Are you kidding us? What problem you are fixing? Do you make tests in your =
host?

A  rubbish patch.

> +
>         mr->nbuf =3D 0;
>         mr->page_shift =3D ilog2(page_size);
>         mr->page_mask =3D ~((u64)page_size - 1);
> --
> 2.41.0
>
