Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2EE251449
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 10:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHYIdM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 04:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgHYIdL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 04:33:11 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1936820706
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598344391;
        bh=kuQKQf202UE0TKyoyz1uRJmfXibtfOKTGE5HeSECdkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P19/ceCViaMIifZC7P+ezJvwz4BuhMW7erYZ2ATLbRlk1Iogo+cJawDZB7xQCiWHF
         v68ezx5ZbjdLU4qjF4hj9XD/1eF1Xk4o+c9GMdopLQoieYDY4piTfd38C3D6pwzbuL
         +RxiRVKYXNt5/UrzCurCR02NdLDGdyH54ccgx/SI=
Received: by mail-io1-f46.google.com with SMTP id z17so11609307ioi.6
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 01:33:11 -0700 (PDT)
X-Gm-Message-State: AOAM5337PWHfeAzHQES1Y6EAJjuowY+4Y2tP34Wf0mLlIcjGQm6VbOLY
        LR5IlbaGKINpbctiEnQoF+O2hhuXcib+Kqh0osd76g==
X-Google-Smtp-Source: ABdhPJz9sAYFR5eC0rDv5ZJxeyZIbtxq3tq2qsPRQljwjUw3G/UESm6UwAVprIIeP99XbKDF+3wNaYp6Ive6RkWNyC4=
X-Received: by 2002:a05:6638:130d:: with SMTP id r13mr9082690jad.89.1598344390542;
 Tue, 25 Aug 2020 01:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200824103247.1088464-1-leon@kernel.org> <20200824103247.1088464-3-leon@kernel.org>
 <ae7907f6-f392-10e2-642a-9e34f1ff9c37@amazon.com>
In-Reply-To: <ae7907f6-f392-10e2-642a-9e34f1ff9c37@amazon.com>
From:   Leon Romanovsky <leon@kernel.org>
Date:   Tue, 25 Aug 2020 11:32:59 +0300
X-Gmail-Original-Message-ID: <CALq1K=+KJoaVxP08hFASxn1feihv932e=rY9bn6MEyjxZiB_Nw@mail.gmail.com>
Message-ID: <CALq1K=+KJoaVxP08hFASxn1feihv932e=rY9bn6MEyjxZiB_Nw@mail.gmail.com>
Subject: Re: [PATCH rdma-next 02/10] RDMA: Restore ability to fail on AH destroy
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 11:13 AM Gal Pressman <galpress@amazon.com> wrote:
>
> On 24/08/2020 13:32, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Like any other IB verbs objects, AH are refcounted by ib_core. The release
> > of those objects is controlled by ib_core with promise that AH destroy
> > can't fail.
> >
> > Being SW object for now, this change makes dealloc_ah() to behave like
> > any other destroy IB flows.
>
> Maybe I'm misreading this, but AH isn't necessarily a software object. It's a HW
> object as well in some of the drivers.

We are working to introduce AH HW object.

>
> > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > index 660a69943e02..426c5f687c7b 100644
> > --- a/drivers/infiniband/hw/efa/efa_verbs.c
> > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > @@ -1875,7 +1875,7 @@ int efa_create_ah(struct ib_ah *ibah,
> >       return err;
> >  }
> >
> > -void efa_destroy_ah(struct ib_ah *ibah, u32 flags)
> > +int efa_destroy_ah(struct ib_ah *ibah, u32 flags)
> >  {
> >       struct efa_dev *dev = to_edev(ibah->pd->device);
> >       struct efa_ah *ah = to_eah(ibah);
> > @@ -1885,10 +1885,11 @@ void efa_destroy_ah(struct ib_ah *ibah, u32 flags)
> >       if (!(flags & RDMA_DESTROY_AH_SLEEPABLE)) {
> >               ibdev_dbg(&dev->ibdev,
> >                         "Destroy address handle is not supported in atomic context\n");
> > -             return;
> > +             return -EINVAL;
>
> -EOPNOTSUPP.

Thanks, I'll fix.

>
> >       }
> >
> >       efa_ah_destroy(dev, ah);
> > +     return 0;
> >  }
