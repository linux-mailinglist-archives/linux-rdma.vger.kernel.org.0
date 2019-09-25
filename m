Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0D9BE6A6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 22:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfIYUuY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 16:50:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38208 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388480AbfIYUuY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 16:50:24 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so533686iom.5
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcFUvFaH4ulivYzeGS479DJAENi2H4dlEkA8NFTiWc0=;
        b=W5Qm2AFqUYSvhuhK7ZqZOPrzToQu1C/VZ+y13OxYJu35LWB64zEI/409nj4rz6l6sG
         6hHSXfqdzzUIk5EsOKOFAQxffpdqrSrjCgOD3KMdUlcB342AzLrRZ3SC9dGq+Fu5wifz
         nOvObF3QG3fM+OPgopuWkv/P/ZbqoVPQDPGswcUNpBwYxdPI0V/sOf4fLUWghAZolLRU
         m8hK+a8MOZxr65A9QXJPzkBeS5UefIdU7aoEe9cLgkW3b1wolobPK0mKDLZwa7Cco4Pb
         PmkktCZfHso5tEIYdkBj0Rd1wtrf3Thnq7NBBkPMM946PQiVRRFKWbn702rKn++sEJlZ
         NK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcFUvFaH4ulivYzeGS479DJAENi2H4dlEkA8NFTiWc0=;
        b=p2eQSYE5zhn4FuFVpu5fBV61ujv+59lnYVRzue+oZPobyD4qZwkOgGNJ9qbf0N5LlS
         4VUageaSVLA02/hrYIxQCKnetcofvC9xjQ6IEm2kF1fUxNJUuRkh/3u47wy7GwLGvS3c
         7vnPyOtWLoUaAVLI6Gd/KGxccC3qucKjIrh8XUnGQIJgdefQSXhTGbrt5rblPgcmGeHv
         RAnEaDxh8IR7LehrMcmC8ZCMocce4gJ0Uk9Np9mE/bmhjlCedxbyiJAStv3TB+v2IEmm
         BjFLDv+Fsa3GOmaW4kEjKvcsqXht5xx02SVZKdspqJg0Wq9hSx6atNEMhrUno0eS2ATg
         /Wfw==
X-Gm-Message-State: APjAAAXWfc32/SBpVvwglnQcobu0wtwZOYIvWUHUpttfV5xK0nvraO9A
        fz0ILA9wibrs9Xm5xNwNG7CRngqSr86fSJkbU7mfN9jWwQ==
X-Google-Smtp-Source: APXvYqwHES/K3I4GpIgMIDafwi7SGBRgVz3/wmDIAHguQHK4gfin6SB67ILVzXnUEqiF8G6tIFOF+N3Oey8gTAnYnbE=
X-Received: by 2002:a6b:c348:: with SMTP id t69mr1550460iof.66.1569444623081;
 Wed, 25 Sep 2019 13:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-7-jinpuwang@gmail.com>
 <d0bc1253-4f3d-981b-97f1-e44900fffb44@acm.org> <CAHg0HuzDGgmFKykAmBuAwJXoP1OGq-pQteS=vYMjcbp=cwu9GQ@mail.gmail.com>
 <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org>
In-Reply-To: <ee692ec2-7f65-19f5-f122-fed544074f5f@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 25 Sep 2019 22:50:12 +0200
Message-ID: <CAHg0HuyMekqFehsU+-O_X8-1j1Bwu6rJzvuAwVV4LQs06ZJsFw@mail.gmail.com>
Subject: Re: [PATCH v4 06/25] ibtrs: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 25, 2019 at 8:55 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/25/19 10:36 AM, Danil Kipnis wrote:
> > On Mon, Sep 23, 2019 at 11:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 6/20/19 8:03 AM, Jack Wang wrote:
> >>> +static void ibtrs_clt_dev_release(struct device *dev)
> >>> +{
> >>> +     /* Nobody plays with device references, so nop */
> >>> +}
> >>
> >> That comment sounds wrong. Have you reviewed all of the device driver
> >> core code and checked that there is no code in there that manipulates
> >> struct device refcounts? I think the code that frees struct ibtrs_clt
> >> should be moved from free_clt() into the above function.
> >
> > We only use the device to create an entry under /sys/class. free_clt()
> > is destroying sysfs first and unregisters the device afterwards. I
> > don't really see the need to free from the callback instead... Will
> > make it clear in the comment.
>
> There is plenty of code under drivers/base that calls get_device() and
> put_device(). Are you sure that none of the code under drivers/base will
> ever call get_device() and put_device() for the ibtrs client device?
You mean how could multiple kernel modules share the same ibtrs
session...? I really never thought that far...

> Thanks,
>
> Bart.
>
