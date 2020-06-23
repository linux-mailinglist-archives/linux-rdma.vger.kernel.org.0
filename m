Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9BE2053BE
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbgFWNpS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732658AbgFWNpR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 09:45:17 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44104C061573
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 06:45:16 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so7295069eje.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXQlqAlZZofDT5Ye539eWDUhLoUgjm6BXLgW5TxtpJ0=;
        b=fo6Nhbf9Qp5QqAKLeva6nObIzuA0/vRkKJf3ZJjJ9LeVoOFZ4jvUrIS1QCH9V3NMmT
         ahxk0oq4a3L9B25QFQ9pYrQ4NCGpqNaHCUm8TI+3WY6mpMNvFuk8p/Wqlh43JKlGQnf8
         0qLLDqfsY0qW9ACTJaehNTTi9alKf22JP5i3gvDlNMiJaFsi+RCN55CtQVOB7GxeG0Nr
         3UlcUMj4YTUjqpx6px/kCug2sy9/BwgzKfBNIhRZjHwcSHUGkXxOt8W9f8FEdM5wa2Js
         Pzk4etXFVaTSJlUtdz8tlxil6LM9R8tbw/rXU+uu/EoWXsCpx2LsDJ9ENy1n8fSzMuev
         z/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXQlqAlZZofDT5Ye539eWDUhLoUgjm6BXLgW5TxtpJ0=;
        b=WuwrGXuNkAVwJGhJ0kb7/QJlwIKmIvUlJQ/Z0OIswaB1yTNVk/nZLD94HdSNLmQGne
         MghFKQDSCjaBirjqLX8rVRaw6c4dGS3G7gQFJXYM+BvG76QWC+wsMLnzQ9RDr+LZPIVf
         DVO6dpF1ZjIpW/+c9mri5788RR0yRk5p/UuAyFJcvYDM4ClwQmSf/R3qOBUs+c5TT4OW
         XN3CIbnNC00tyZUGcWvKYfk0uYLlRAJ4a8b6t7WwXOrJELksV/nl8gkxqUBV/qyuFDhR
         YqaDismO9PN58GpT5YIDB5F0Wy1sbBMrokNin4KHyS8+PBduKo08e+4zpq4upxnof1JU
         O6TA==
X-Gm-Message-State: AOAM532WVz01YPH+Ms5qd1W33a14UXshrLI297t0h568Qpu7Hg7+H8Cp
        aZbaiqgukDC6UdDGVZkthcBBEv9UaJgntCCe6EFY7Q==
X-Google-Smtp-Source: ABdhPJwdX6lc/Gi/7j4howCM+pxkij0TtKRONe71HZ75ub6P3aifFGVKJptcy75yC6WcZMxsL6owSUNPjQePjVIhvy4=
X-Received: by 2002:a17:906:1682:: with SMTP id s2mr11554590ejd.532.1592919914915;
 Tue, 23 Jun 2020 06:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
 <20200617112811.GL2383158@unreal> <20200617182046.GI6578@ziepe.ca>
 <20200617190756.GA2721989@unreal> <20200617192642.GL6578@ziepe.ca>
 <CAJpMwygeJ7uaNUKxhsF-bx=ufchkx7M6G0E237=-0C7GwJ3yog@mail.gmail.com>
 <CAJpMwyjJSu4exkTAoFLhY-ubzNQLp6nWqq83k6vWn1Uw3eaK_Q@mail.gmail.com>
 <CAJpMwygqz20=H7ovSL0nSWLbVpMv-KLOgYO=nRCLv==OC8sgHw@mail.gmail.com> <20200623121721.GZ6578@ziepe.ca>
In-Reply-To: <20200623121721.GZ6578@ziepe.ca>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Tue, 23 Jun 2020 19:15:03 +0530
Message-ID: <CAJpMwyj_Fa6AhYXcGh4kS79Vd2Dy3N7B5-9XhKHn4qWDo-HVjw@mail.gmail.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>, dledford@redhat.com,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 5:47 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 23, 2020 at 03:20:27PM +0530, Haris Iqbal wrote:
> > Hi Jason and Leon,
> >
> > Did you get a chance to look into my previous email?
>
> Was there a question?

Multiple actually :)

>
> Jason

In response to your emails,

> Somehow nvme-rdma works:

I think that's because the callchain during the nvme_rdma_init_module
initialization stops at "nvmf_register_transport()". Here only the
"struct nvmf_transport_ops nvme_rdma_transport" is registered, which
contains the function "nvme_rdma_create_ctrl()". I tested this in my
local setup and during kernel boot, that's the extent of the
callchain.
The ".create_ctrl"; which now points to "nvme_rdma_create_ctrl()" is
called later from "nvmf_dev_write()". I am not sure when this is
called, probably when the "discover" happens from the client side or
during the server config.

It seems that the "rdma_bind_addr()" is called by the nvme rdma
module; but during the following events
1) When a discover happens from the client side. Call trace for that looks like,
[ 1098.409398] nvmf_dev_write
[ 1098.409403] nvmf_create_ctrl
[ 1098.414568] nvme_rdma_create_ctrl
[ 1098.415009] nvme_rdma_setup_ctrl
[ 1098.415010] nvme_rdma_configure_admin_queue
[ 1098.415010] nvme_rdma_alloc_queue
                             -->(rdma_create_id)
[ 1098.415032] rdma_resolve_addr
[ 1098.415032] cma_bind_addr
[ 1098.415033] rdma_bind_addr

2) When a connect happens from the client side. Call trace is the same
as above, plus "nvme_rdma_alloc_queue()" is called n number of times;
n being the number of IO queues being created.

On the server side, when an nvmf port is enabled, that also triggers a
call to "rdma_bind_addr()", but that is not from the nvme rdma module.
may be nvme target rdma? (not sure).

Does this make sense or am I missing something here?


> If the rdma_create_id() is not on a callchain from module_init then you don't have a problem.

I am a little confused. I thought the problem occurs from a call to
either "rdma_resolve_addr()" which calls "rdma_bind_addr()",
or a direct call to "rdma_bind_addr()" as in rtrs case.
In both the cases, a call to "rdma_create_id()" is needed before this.


> Similarly they are supposed to be created from the client attachment.
I am a beginner in terms of concepts here. Did you mean when a client
tries to establish the first connection to an rdma server?


-- 

Regards
-Haris
