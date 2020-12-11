Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E102D76D7
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 14:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgLKNqs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 08:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732259AbgLKNq0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Dec 2020 08:46:26 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC2C0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 11 Dec 2020 05:45:46 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id a6so6385701qtw.6
        for <linux-rdma@vger.kernel.org>; Fri, 11 Dec 2020 05:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vSt2SsNlWFXsX9I97ohoMymmKvj2//PHey09huy6uo0=;
        b=MPyvoghPtZPdN073/KR+AU9kTYiB+PSv88O7Z5QuOjFGgPYR2ATSujiqdq6sVCfWD4
         qhbdcJ4UGwtFYRzhYOgLYLYn+DG61ignGi3KwyvAE1KLvEP5ksuuyFYr7C0o9YgJUoSC
         vU1TyFsxyXZUBBh06Y9z6GRJY9SwyDCQuzthOkTwtT1oS0Et0ImE4d94/sG5ENhycnuW
         ULd561NbyJeUnkS5rPtwNKABDmLom1WCNlDDts9cEXywzOfqsDwUR5u+U88NS0K1vCRR
         EKXiX5kOdaZHA9jXp9vzm+HP2J//zhiPUOcqcdue9+vwHXsSZMDf6moV0wtHrUsc9SdY
         gknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vSt2SsNlWFXsX9I97ohoMymmKvj2//PHey09huy6uo0=;
        b=L5z275Rnmff2iPPz3qK/fvp4/VIsLcc/OFUP6yuxd3ynDMWDQPK1eZDhNxbfE4AaMO
         jqb4s7olXZVprKAmhrI/xf5mWBM3Z9kVwZ+pbx2a1K3UDGO0gB8ssQSb5nOy9VY1AblZ
         mZRAvqkDhQ7I/iA6wH0sSdwZdf4kiN3IQjZiXRO4tCD6bpK/RuFdcdW+o+ZL0VVaYYzL
         lyO5jDQyEGEWPqKlreqrRH07Ih8VDMsbRs4km6usZTyQklGLwdrNYFQ0ziaImGtGlYiZ
         hOPtSXQkxowSzN2LJWbLOZP6c8jOgLS91nJTzbDgfHwZjAdrHzCcelynfgNlXfmhyxob
         nOZQ==
X-Gm-Message-State: AOAM531MIWwLVTLnPgA3G6pgXWeWYNhUL3z8jllAuPBsDUfFcE2orEY8
        a4Amwi2PDoq8ztMrtmztafYUsw==
X-Google-Smtp-Source: ABdhPJy33m9G5ZzJ/u+kn6MsBh8JqyE3bGCr+pGWletyrd0PX8+hEn/SKjgFO5dIa5vb2aq9B38/Bg==
X-Received: by 2002:ac8:5a8c:: with SMTP id c12mr15483732qtc.97.1607694345797;
        Fri, 11 Dec 2020 05:45:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id r14sm7125076qte.27.2020.12.11.05.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 05:45:44 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1knijv-009DWW-LI; Fri, 11 Dec 2020 09:45:43 -0400
Date:   Fri, 11 Dec 2020 09:45:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
Message-ID: <20201211134543.GB5487@ziepe.ca>
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

Gah, that is horrible.

I'm not completely sure it is false either, at this point two
handler_mutex's are locked (listening ID and the new ID) and there may
be locking cycles that end up back on the listening ID, certainly it
is not so simple.

Jason
