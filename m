Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A10145492
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2020 13:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAVMwR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jan 2020 07:52:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46973 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgAVMwQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jan 2020 07:52:16 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so6460643ioi.13
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2020 04:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyEqoE1cBRj4Tnu9o17cDo7KOBzKfVc7rH8CRyHUH6M=;
        b=JqTKdqISTmyQnas3GxL8Fk/lQG/f4qinU1zIb0g2IpyFunWwUZvsW/EvsYvdjVM+Bv
         nu3V2Rc4n2uDBlx4RTvIE96wo0/MVNXhg7rLoygcV4K0T8wtrSNwHF+xTtzI0Nk0P22a
         eZnLXT2r1JBOxZlt5sK3eDR0FDjA3TG++1N51T70IJMlF+USOcHppVHsxGSTwDqEkbRK
         Gviw9c19oPSeFJqJujGAgEqlCMp+uyrzCwpDAAAr6LM3QSjFd5+1JYX/P6icU23c0eMz
         mnxCsc/2L6IPfpsS9ic+BZ7zExWKDBlQcLAoPCYFJwI5IVaLVB1fGZqu2c5MeycWKGyF
         +gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyEqoE1cBRj4Tnu9o17cDo7KOBzKfVc7rH8CRyHUH6M=;
        b=GTSxGTXjRCgbypGFT29LW9b82qhEuMBbDxrKY0cQ/Hs+1KdTECI5UKUCN0XEq0gQss
         Mcetjcxz4UeAEqYOKMb/EtnrOBPZW5GJtMWl9sKA4OaTTA4bJD9zHoCVy6Fjy62drtEK
         ZOMHOtlLaU54svFAjIk08DqgS/J+QfSOFcE20z9bfQ9LZoR97lrvuhhyU0JZgjpE9D9Z
         RZGtHbPB3Ydx9igsN7S6aiflWNI+j9PDTWCDV+tkXgWxdKcD45OM8nYkb+NA8J5axC7H
         0dIdDar8YuyWrNM5l/Zoygjqr3hed9GKTHqeSsg9G6AA7iAjSCznUPTUoW+cceaLvH7/
         tBjw==
X-Gm-Message-State: APjAAAU1WzH1PZhVYIy/Nc4w1baNq8qZD5w6L4MintOw585mC/9qqzH3
        WD7JbP9OyFdmqvuYpODLFne6viBUaYyATXXK0KMdIQ==
X-Google-Smtp-Source: APXvYqxID7Q54LszheaS02fViYtPI2sHLFaFa53vmLJsRK30UqbYvBxn+oKpLOtdx004tpasSf7dszUamb48MDjNhLY=
X-Received: by 2002:a6b:600f:: with SMTP id r15mr6548900iog.54.1579697534119;
 Wed, 22 Jan 2020 04:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-18-jinpuwang@gmail.com>
 <20200120134815.GH51881@unreal> <CAMGffE=+wX2h6bSp+ZwTowWq8NOutVnCfXFqxMupZNCGGOh0sg@mail.gmail.com>
 <20200122123119.GC7018@unreal>
In-Reply-To: <20200122123119.GC7018@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 22 Jan 2020 13:52:03 +0100
Message-ID: <CAMGffEn_q9862+CwfRb3WjWzuy6wnCwdgqmtHOoAfqNVeGC-2w@mail.gmail.com>
Subject: Re: [PATCH v7 17/25] block/rnbd: client: main functionality
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > > Please no vertical alignment in new code, it adds a lot of churn if such
> > > line is changed later and creates difficulties for the backports.
> > It does look nicer when it can be aligned. I don't get why backport is
> > an argument here.
>
> The backport thing will be problematic once some fix is needed which
> will require addition of extra variable.
>
> Imagine such situation, where you will need to add such variable.
>
>      struct rnbd_clt_dev *dev        = rq->rq_disk->private_data;
>      struct rnbd_clt_session *sess   = dev->sess;
> +    struct rnbd_clt_session *sess_very_long_variable = ....;
>
> You will need to update vertical alignment for all variables and it
> can create huge churn out of nowhere. The standard approach is to
> avoid vertical space alignments from the beginning.

Thanks for the explanation,  I get your points now, but in that case,
you can also choose a not so
long name to keep the alignment. Even you have no choice for a shorter name,
breaking the alignment is the last thing we have to worry about.
