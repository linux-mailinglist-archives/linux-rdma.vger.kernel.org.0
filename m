Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C8E25146E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgHYIiy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 04:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgHYIiy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 04:38:54 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA2E207D3
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 08:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598344733;
        bh=J1lveOt5y7x1sZ1lM7LnIoBOwZQu0TdO0bLEYkbqNTU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I3ec9TUg4y77udDbh/fn6P2XHtFTq7Dmxx8pXKsHXiniuHBKJvkUpbJCli2v68Jwl
         2UulJfFZSjAIBXO43xSULH0q7eQiah6lX+0kFVBtMpN9GP63zS0XY6cS7WBlkWPuXw
         ZAB7C/cSjdjYKBvIvKnN/ZZqx/VsE7qa9YYnyXrM=
Received: by mail-io1-f43.google.com with SMTP id h4so11630877ioe.5
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 01:38:53 -0700 (PDT)
X-Gm-Message-State: AOAM5301rYsLlzcArKBf3Rgyw/gGi4p3bAzPpIpDMoD1IAX1yVmu5Hod
        /weS5VT2SfvPAQFG6JnksRbtfnMlTnvsLmHkr+SYQg==
X-Google-Smtp-Source: ABdhPJxLvhf8WZq2ua734Ww7luETbXh0Ev4U7Nw0/kI1CPqo3w56+/5AeJbzerBKEojZ4pF9mEtmaXHEQeR7ti6UeFU=
X-Received: by 2002:a02:6066:: with SMTP id d38mr9578087jaf.105.1598344732539;
 Tue, 25 Aug 2020 01:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200824103247.1088464-1-leon@kernel.org> <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
In-Reply-To: <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
From:   Leon Romanovsky <leon@kernel.org>
Date:   Tue, 25 Aug 2020 11:38:41 +0300
X-Gmail-Original-Message-ID: <CALq1K=JR2MjzJuNSKxXGcy8FTEUVtxOiBzL2jC+-AmnqaLxxOg@mail.gmail.com>
Message-ID: <CALq1K=JR2MjzJuNSKxXGcy8FTEUVtxOiBzL2jC+-AmnqaLxxOg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD deallocate
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
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
> > diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> > index 1889dd172a25..8547f9d543df 100644
> > --- a/drivers/infiniband/hw/efa/efa.h
> > +++ b/drivers/infiniband/hw/efa/efa.h
> > @@ -134,7 +134,7 @@ int efa_query_gid(struct ib_device *ibdev, u8 port, int index,
> >  int efa_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
> >                  u16 *pkey);
> >  int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> > -void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> > +int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> >  int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
> >  struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> >                           struct ib_qp_init_attr *init_attr,
> > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > index 3f7f19b9f463..660a69943e02 100644
> > --- a/drivers/infiniband/hw/efa/efa_verbs.c
> > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > @@ -383,13 +383,14 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >       return err;
> >  }
> >
> > -void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> > +int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >  {
> >       struct efa_dev *dev = to_edev(ibpd->device);
> >       struct efa_pd *pd = to_epd(ibpd);
> >
> >       ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
> >       efa_pd_dealloc(dev, pd->pdn);
> > +     return 0;
> >  }
>
> Nice change, thanks Leon.
> At least for EFA, I prefer to return the return value of the destroy command
> instead of silently ignoring it (same for the other patches).

The problem with returning error is that ib_core will retrigger
deallocation again,while it was supposed to succeed
from the first try. See our discussion over bnxt_re patch.
https://lore.kernel.org/linux-rdma/1598292876-26529-2-git-send-email-selvin.xavier@broadcom.com

Thanks
