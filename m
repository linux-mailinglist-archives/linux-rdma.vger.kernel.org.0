Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1081A2D70CE
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 08:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389940AbgLKH1P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 02:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391088AbgLKH0p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Dec 2020 02:26:45 -0500
Date:   Fri, 11 Dec 2020 09:26:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607671564;
        bh=wPM/e4FxQZ57VShGTv7k0oXLRsOlweYMYRoU781O0BE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlSAcMpVV1C7k6EViObekSZfMCKeTCAqJ2aX3+5/hQF63esB9KDaP9gfUyUIn+9bt
         7yRc+0UnJE+PkGw7CVZ8/3Ip4IqaJ601JZ0JW9tfBAoGGQyaymm7/Z9GM+sCgJY4+6
         GWN7uh/0qMJpzPTt5fO9AwodtYtU8GwONg+Y7vydz/0tOXQp4oo0zD8NT3AtavXZMU
         i6fG68Nttfb30qz5YuSis2RmoT3hMemY87tIzoyro+kVgLA+8u/f8X/eb9AloOZBvE
         MePRISjaNegOJQvDYKM9U3gRqczd93PTmcftwtiPaUIoVQijGNtSXHTKYRh3mF+6CO
         ptPvmlrfQYrBQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
Message-ID: <20201211072600.GA192848@unreal>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
 <20201209164542.61387-3-jinpu.wang@cloud.ionos.com>
 <CAMGffE=_axtHU=pAV3qx5FVY2pB786z3kffQwDzinOaH=yS5Ag@mail.gmail.com>
 <e841a2c3-2774-ca8f-302a-cd43c3b3161e@cloud.ionos.com>
 <CAMGffEmKAzy3dXVKhoZDAqLpZ6DiQiaYNQn8_0Fd+MQUXbn_eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmKAzy3dXVKhoZDAqLpZ6DiQiaYNQn8_0Fd+MQUXbn_eA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 11, 2020 at 07:50:13AM +0100, Jinpu Wang wrote:
> On Fri, Dec 11, 2020 at 3:35 AM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
> >
> >
> >
> > On 12/10/20 15:56, Jinpu Wang wrote:
> > > On Wed, Dec 9, 2020 at 5:45 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
> > >>
> > >> If there are many establishments/teardowns, we need to make sure
> > >> we do not consume too much system memory. Thus let on going
> > >> session closing to finish before accepting new connection.
> > >>
> > >> Inspired by commit 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
> > >> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > >> Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > > Please ignore this one, it could lead to deadlock, due to the fact
> > > cma_ib_req_handler is holding
> > > mutex_lock(&listen_id->handler_mutex) when calling into
> > > rtrs_rdma_connect, we call close_work which will call rdma_destroy_id,
> > > which
> > > could try to hold the same handler_mutex, so deadlock.
> > >
> >
> > I am wondering if nvmet-rdma has the similar issue or not, if so, maybe
> > introduce a locked version of rdma_destroy_id.
> >
> > Thanks,
> > Guoqing
>
> No, I was wrong. I rechecked the code, it's not a valid deadlock, in
> cma_ib_req_handler, the conn_id is newly created in
> https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/core/cma.c#L2185.
>
> Flush_workqueue will only flush close_work for any other cm_id, but
> not the newly created one conn_id, it has not associated with anything
> yet.
>
> The same applies to nvme-rdma. so it's a false alarm by lockdep.

Leaving this without fix (proper lock annotation) is not right thing to
do, because everyone who runs rtrs code with LOCKDEP on will have same
"false alarm".

So I recommend or not to take this patch or write it without LOCKDEP warning.

Thanks

>
> Regards!
> Jack
