Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F53AC6AD
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2019 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406600AbfIGM55 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Sep 2019 08:57:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34725 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406595AbfIGM55 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 7 Sep 2019 08:57:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id a13so10597873qtj.1;
        Sat, 07 Sep 2019 05:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhiCADZkNTCl+mm69LYUXtAdkguFcYYbHWtAbXegPkM=;
        b=HWwNllgxl2B7QRXENDzO2VLH1y/AZFNTcUOM0EVmpAfco4x+wr8afvNL9z9D9eiXAR
         eFlmQT8m4HzH5/yENm7M6f7aKUeovbYJHLyJX26RIaLguHgNFzCIi11/UyCJz3n9sU9F
         MS/lFJgFx+Kmt++JtAM++Entu9ESOZD/Tq2uSXp4eAe6nugp+O6cLu9NBEk2fGAAJPKz
         HzLXLAckqy5aQseFo5RDmGcV5eY+xJzsu3Og997SdInztlsfLuwpH46p+ikZ16FWlpAa
         NqaYk3EnSmEyDNkMKAQI1ZZr4hSfdFkgm+BmN/srtErlUovBaEBr+BM4MWhoXpwYQGzj
         4Cuw==
X-Gm-Message-State: APjAAAUYUlPf9VtHPhP0HMGhdCm4Y8sCR1+zquGoVRkx7i8T5HOjeb+2
        c2Zw3FBMGmBlssNaKc11h+wyTvMA+qyivtiuiBU=
X-Google-Smtp-Source: APXvYqw7dfoTYXQwYJdtzA6jA6FZqRmNasLKy5B2BO+iWICFBiVzzPZ43kTTDxIulAH3bIsGUDOu99EI8pTHRL0SBVY=
X-Received: by 2002:ac8:342a:: with SMTP id u39mr14294033qtb.7.1567861076453;
 Sat, 07 Sep 2019 05:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190906151028.1064531-1-arnd@arndb.de> <20190907073444.GB3873@mellanox.com>
In-Reply-To: <20190907073444.GB3873@mellanox.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 7 Sep 2019 14:57:40 +0200
Message-ID: <CAK8P3a1jy9gmyM=8LDTVep_zqxfhG05dgCyxvn=69NVR+Xmnqw@mail.gmail.com>
Subject: Re: [PATCH] rdma/siw: fix NOMMU build
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 7, 2019 at 9:34 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > @@ -374,7 +374,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
> >       unsigned int foll_flags = FOLL_WRITE;
> >       int num_pages, num_chunks, i, rv = 0;
> >
> > -     if (!can_do_mlock())
> > +     if (!IS_ENABLED(CONFIG_MMU) || !can_do_mlock())
> >               return ERR_PTR(-EPERM);
>
> I feel like !CONFIG_MMU should provide a dummy inline stub for can_do_mlock
> instead?

Fair enough. I've added that to my test tree in place of my first patch
and will send it after some more build testing.

     Arnd
