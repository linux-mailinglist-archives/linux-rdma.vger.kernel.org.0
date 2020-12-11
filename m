Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6E2D8037
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 21:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394276AbgLKUuY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 15:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgLKUuR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Dec 2020 15:50:17 -0500
Date:   Fri, 11 Dec 2020 22:49:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607719776;
        bh=J47tb1OLs75Yh/YtR9XOTDK4Wi9qkYSvNNNgTJdQRK4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjUVooxm/b+kImM2vgIkTn/YyHIpNT6I3UwdCPiEDH2kwNn6iJWHLLdqBo3LSInbp
         BX4uFlDHPtRUc8wHlarJA35Yamb9LjiC4iyusoVlYqmaP9RsxzZpeyOkz9gdDLh6JO
         gYF/DYmTbLTPaUuSTS1dFlnILaDvCx/ji7MkgXSe8Qz1fTn0DHjfIAb2jPjvq5EznX
         JSMnwZ645JFPC1EEAdkYRNiF/XIoZ+bsVGwOIcgo3kqvjpMbcc2/Dy6OQu0p+oQ9jk
         fv2e5scDEGAkmf242/wlwa0iMkPV7hWwVerRRaHDLY1rUs7y1fIlRZXyzgqhEdM/BP
         yUkT6Qql0JcYw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
Message-ID: <20201211204932.GB192848@unreal>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
 <20201209164542.61387-3-jinpu.wang@cloud.ionos.com>
 <CAMGffE=_axtHU=pAV3qx5FVY2pB786z3kffQwDzinOaH=yS5Ag@mail.gmail.com>
 <e841a2c3-2774-ca8f-302a-cd43c3b3161e@cloud.ionos.com>
 <CAMGffEmKAzy3dXVKhoZDAqLpZ6DiQiaYNQn8_0Fd+MQUXbn_eA@mail.gmail.com>
 <20201211072600.GA192848@unreal>
 <CAMGffEn4fbTud3qrrwnrS6bqxcpF6sueKb=Qke8N9yLvDeEWpA@mail.gmail.com>
 <CAMGffEnuNHacxqqdZsF0JMk3kTUqT9KdzNK_QzBF_FWjPWLN8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEnuNHacxqqdZsF0JMk3kTUqT9KdzNK_QzBF_FWjPWLN8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 11, 2020 at 08:58:09AM +0100, Jinpu Wang wrote:
> On Fri, Dec 11, 2020 at 8:53 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> >
> > On Fri, Dec 11, 2020 at 8:26 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Dec 11, 2020 at 07:50:13AM +0100, Jinpu Wang wrote:
> > > > On Fri, Dec 11, 2020 at 3:35 AM Guoqing Jiang
> > > > <guoqing.jiang@cloud.ionos.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 12/10/20 15:56, Jinpu Wang wrote:
> > > > > > On Wed, Dec 9, 2020 at 5:45 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
> > > > > >>
> > > > > >> If there are many establishments/teardowns, we need to make sure
> > > > > >> we do not consume too much system memory. Thus let on going
> > > > > >> session closing to finish before accepting new connection.
> > > > > >>
> > > > > >> Inspired by commit 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
> > > > > >> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > > >> Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > > > > > Please ignore this one, it could lead to deadlock, due to the fact
> > > > > > cma_ib_req_handler is holding
> > > > > > mutex_lock(&listen_id->handler_mutex) when calling into
> > > > > > rtrs_rdma_connect, we call close_work which will call rdma_destroy_id,
> > > > > > which
> > > > > > could try to hold the same handler_mutex, so deadlock.
> > > > > >
> > > > >
> > > > > I am wondering if nvmet-rdma has the similar issue or not, if so, maybe
> > > > > introduce a locked version of rdma_destroy_id.
> > > > >
> > > > > Thanks,
> > > > > Guoqing
> > > >
> > > > No, I was wrong. I rechecked the code, it's not a valid deadlock, in
> > > > cma_ib_req_handler, the conn_id is newly created in
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/core/cma.c#L2185.
> > > >
> > > > Flush_workqueue will only flush close_work for any other cm_id, but
> > > > not the newly created one conn_id, it has not associated with anything
> > > > yet.
> > > >
> > > > The same applies to nvme-rdma. so it's a false alarm by lockdep.
> > >
> > > Leaving this without fix (proper lock annotation) is not right thing to
> > > do, because everyone who runs rtrs code with LOCKDEP on will have same
> > > "false alarm".
> > >
> > > So I recommend or not to take this patch or write it without LOCKDEP warning.
> > Hi Leon,
> >
> > I'm thinking about the same, do you have a suggestion on how to teach
> > LOCKDEP this is not really a deadlock,
> > I do not know LOCKDEP well.
> Found it myself, we can use lockdep_off
>
> https://elixir.bootlin.com/linux/latest/source/drivers/virtio/virtio_mem.c#L699

My personal experience from internal/external reviews shows that claims
about false alarms in LOCKDEP warnings are almost always wrong.

Thanks

>
> Thanks
>
> >
> > Thanks
> > >
> > > Thanks
> > >
> > > >
> > > > Regards!
> > > > Jack
