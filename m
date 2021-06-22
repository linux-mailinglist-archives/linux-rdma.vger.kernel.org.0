Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB43B0925
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhFVPdy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhFVPdv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Jun 2021 11:33:51 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE443C061574;
        Tue, 22 Jun 2021 08:31:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d19so24194248oic.7;
        Tue, 22 Jun 2021 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ACobuG9GBL6iTgJMQGUeQ4NnxCVUdn2UEz4s51ScZk=;
        b=FbRKl08RV+5aNUCIy+bm9R79y0vvn1Fqntx11lMKc7uBstykFXlpjoeTaLfrm6HFII
         +HEgrFz1c8I98k1PfPI2oRB/vJPXDmZ7gYDvk98AWo4x8o7v0B2KGaLjrV+spIPFeNoQ
         +dZfs7yBimI8raW3JRyWsffkiQa2vHSo1DFmxWvweSeHp1PLh8ThPMpJQRWXeK66Evlo
         pDd+cX8OKOIU4tq3oOJn8fvNkOqv8BF2KExwwBZXTVAi9/BNVYgDv1Etlgr4Jnfm2zDG
         U15DMNfGUTB+tKLKilihttsdLp7AKs76NKs/jFR6oW+8c3b50Hh6Ou4jaazsw8Vz58YB
         FpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ACobuG9GBL6iTgJMQGUeQ4NnxCVUdn2UEz4s51ScZk=;
        b=oayfKpb4MRx3dcQRgpcIfn+g7sqocwgu0nn406s0pMEfrSJDwwp9UnHn/ytfKHIC3S
         RL0a0XepO4cSypLvS4/Y8civPdDduqJFVSWSnp8easzXMoOleQeCVRpVPEZxl1G1Jr/k
         7lU1gyolTmMnXBd6n9A3OGiDrcVvNV58lYTGI9PDUILaXsbZkYsjAq3USJNTiiqmkYiC
         HZKWNQ38JL8j7gtPzk0JlY+KSAkcBUIIis3GeD29cYUHbUHKgyQwKilTR6W8BPlaU4fR
         05ZRu7gXn6h/TzYplVNIiIcG1BSQCnvfVZQ2nYbtNcAO1UPmy0dTV1goo6Hod9POjVCv
         xl3Q==
X-Gm-Message-State: AOAM531zK5nW+DkAJ9q99tbmnBI76ChBUOU91WtrJcohQOdFFuKQd/di
        N7XndFyVP7NZTdwWE319LEiZYIqYe3IdWteI6aA=
X-Google-Smtp-Source: ABdhPJxWKRZiOyy1GQQeMKz5oOkBqbf2aVaRbiEZ6YA+N5BKZTQCBdtNW4NVGB7tYtQeE5WiBYa8ZoPrLTug+PhQCMk=
X-Received: by 2002:aca:ac02:: with SMTP id v2mr3623956oie.154.1624375891987;
 Tue, 22 Jun 2021 08:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca> <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca> <CAFCwf10GmBjeJAFp0uJsMLiv-8HWAR==RqV9ZdMQz+iW9XWdTA@mail.gmail.com>
 <20210622121546.GN1096940@ziepe.ca> <CAFCwf13BuS+U3Pko_62hFPuvZPG26HQXuu-cxPmcADNPO22g9g@mail.gmail.com>
 <20210622151142.GA2431880@ziepe.ca> <4a37216d-7c4c-081e-3325-82466f30b6eb@amd.com>
 <20210622152827.GQ1096940@ziepe.ca>
In-Reply-To: <20210622152827.GQ1096940@ziepe.ca>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 22 Jun 2021 18:31:04 +0300
Message-ID: <CAFCwf132jue+0ZOEd+3U-NPQuVt+ry1hz6FB=oZ4g_8J4pAqpw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Doug Ledford <dledford@redhat.com>,
        Tomer Tayar <ttayar@habana.ai>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 6:28 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 22, 2021 at 05:24:08PM +0200, Christian K=C3=B6nig wrote:
>
> > > > I will take two GAUDI devices and use one as an exporter and one as=
 an
> > > > importer. I want to see that the solution works end-to-end, with re=
al
> > > > device DMA from importer to exporter.
> > > I can tell you it doesn't. Stuffing physical addresses directly into
> > > the sg list doesn't involve any of the IOMMU code so any configuratio=
n
> > > that requires IOMMU page table setup will not work.
> >
> > Sure it does. See amdgpu_vram_mgr_alloc_sgt:
> >
> >         amdgpu_res_first(res, offset, length, &cursor);
>          ^^^^^^^^^^
>
> I'm not talking about the AMD driver, I'm talking about this patch.
>
> +               bar_address =3D hdev->dram_pci_bar_start +
> +                               (pages[cur_page] - prop->dram_base_addres=
s);
> +               sg_dma_address(sg) =3D bar_address;
>
> Jason
Yes, you are correct of course, but what will happen Jason, If I will
add a call to dma_map_resource() like Christian said ?
Won't that solve that specific issue ?
That's why I want to try it...

Oded
