Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC172D7127
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 09:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391934AbgLKH7Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 02:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388352AbgLKH7C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Dec 2020 02:59:02 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621C1C0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 23:58:22 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id c7so8369345edv.6
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 23:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idK54W9lvFx3S6x99CaLmuc/dB7117sinF4RSZ38yYs=;
        b=fhMAT9mdCWPEUXPLIQHXCOYDX6HC8E6xs3Tafg3vHv9XfRqLNemfvYIlUPHAc6XfXc
         BsfRRhtdZSBFX4zaJCRnO7kblVirlt6vedYDzU5zy8v9VDsbwR3KLawOld9jy0rCRuII
         Rysqbm/9FIOCFehOLcmbBMyPpLM1eoB40NFnCvz5ZaoE/sL+qQkV6mMRZopq5Eb74ZIC
         gFpwf+Iyy9HNAJCx+XzOhGkuSf1TcvkCtoSCGBgR24KQZt2dX40lSATTMYbfNM6Ah4pX
         yL+RU5Ir+hzOEYCS4xPxbv7R//MzwKl1rtPtma6DLvkAatGgA6Bc/S4e4/iPY+JwWjWN
         niCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idK54W9lvFx3S6x99CaLmuc/dB7117sinF4RSZ38yYs=;
        b=uIEZNIVsDk0wqVmrxT1GGjLd+jTB2nTAAB4J00brBfqSpEkmVpGDv0inczrdBradiP
         XZkJPv/2xXxXP57DvQk0XIXBMqbbB3SEYdGAK/Nsoe9KCzA1TKWFmcbeDjIK2hc1tOZg
         f6gIWlVqGWVHekL1U4wnDtk80aLRojRLyna2/glWML7XoCjv10kiqRcMcbiC+1Tu4HN1
         FJ6gHpHkJIfcbRTTIUJf555LXjDjsb/mpKuGV9LqD14NKVp0h0YdkKwL87uqUBps2RVD
         ygQUVFSWqDSEf1bwiO5+3yp8R0XBP9RjH2GPhgxWz0R0g+GMzQBRh5LccGfbj5bKPAUg
         sr1A==
X-Gm-Message-State: AOAM531C4F+JbiFLLZAHsAbzgebZzYQWvDzl8pq9gRvAjhOJIJ7ExbDu
        LOtGApVBvRmoExMqBjNo9gQSn/9TRHFTweOxv4Lmuw==
X-Google-Smtp-Source: ABdhPJyGWzzkvVayfiIOQhc+HbjbPaNbW/0jwJHVfOcTaDRTTb5f0c26XqluI4Uslxmvb5I5hwq+SvV6xzvqkshgw+0=
X-Received: by 2002:a50:9a83:: with SMTP id p3mr10548655edb.42.1607673501175;
 Thu, 10 Dec 2020 23:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
 <20201209164542.61387-3-jinpu.wang@cloud.ionos.com> <CAMGffE=_axtHU=pAV3qx5FVY2pB786z3kffQwDzinOaH=yS5Ag@mail.gmail.com>
 <e841a2c3-2774-ca8f-302a-cd43c3b3161e@cloud.ionos.com> <CAMGffEmKAzy3dXVKhoZDAqLpZ6DiQiaYNQn8_0Fd+MQUXbn_eA@mail.gmail.com>
 <20201211072600.GA192848@unreal> <CAMGffEn4fbTud3qrrwnrS6bqxcpF6sueKb=Qke8N9yLvDeEWpA@mail.gmail.com>
In-Reply-To: <CAMGffEn4fbTud3qrrwnrS6bqxcpF6sueKb=Qke8N9yLvDeEWpA@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 11 Dec 2020 08:58:09 +0100
Message-ID: <CAMGffEnuNHacxqqdZsF0JMk3kTUqT9KdzNK_QzBF_FWjPWLN8Q@mail.gmail.com>
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 11, 2020 at 8:53 AM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> On Fri, Dec 11, 2020 at 8:26 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Dec 11, 2020 at 07:50:13AM +0100, Jinpu Wang wrote:
> > > On Fri, Dec 11, 2020 at 3:35 AM Guoqing Jiang
> > > <guoqing.jiang@cloud.ionos.com> wrote:
> > > >
> > > >
> > > >
> > > > On 12/10/20 15:56, Jinpu Wang wrote:
> > > > > On Wed, Dec 9, 2020 at 5:45 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
> > > > >>
> > > > >> If there are many establishments/teardowns, we need to make sure
> > > > >> we do not consume too much system memory. Thus let on going
> > > > >> session closing to finish before accepting new connection.
> > > > >>
> > > > >> Inspired by commit 777dc82395de ("nvmet-rdma: occasionally flush ongoing controller teardown")
> > > > >> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > >> Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > > > > Please ignore this one, it could lead to deadlock, due to the fact
> > > > > cma_ib_req_handler is holding
> > > > > mutex_lock(&listen_id->handler_mutex) when calling into
> > > > > rtrs_rdma_connect, we call close_work which will call rdma_destroy_id,
> > > > > which
> > > > > could try to hold the same handler_mutex, so deadlock.
> > > > >
> > > >
> > > > I am wondering if nvmet-rdma has the similar issue or not, if so, maybe
> > > > introduce a locked version of rdma_destroy_id.
> > > >
> > > > Thanks,
> > > > Guoqing
> > >
> > > No, I was wrong. I rechecked the code, it's not a valid deadlock, in
> > > cma_ib_req_handler, the conn_id is newly created in
> > > https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/core/cma.c#L2185.
> > >
> > > Flush_workqueue will only flush close_work for any other cm_id, but
> > > not the newly created one conn_id, it has not associated with anything
> > > yet.
> > >
> > > The same applies to nvme-rdma. so it's a false alarm by lockdep.
> >
> > Leaving this without fix (proper lock annotation) is not right thing to
> > do, because everyone who runs rtrs code with LOCKDEP on will have same
> > "false alarm".
> >
> > So I recommend or not to take this patch or write it without LOCKDEP warning.
> Hi Leon,
>
> I'm thinking about the same, do you have a suggestion on how to teach
> LOCKDEP this is not really a deadlock,
> I do not know LOCKDEP well.
Found it myself, we can use lockdep_off

https://elixir.bootlin.com/linux/latest/source/drivers/virtio/virtio_mem.c#L699

Thanks

>
> Thanks
> >
> > Thanks
> >
> > >
> > > Regards!
> > > Jack
