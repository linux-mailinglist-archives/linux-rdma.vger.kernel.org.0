Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138E0378EAC
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbhEJNXJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239230AbhEJMTH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 08:19:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14E1961430;
        Mon, 10 May 2021 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620649080;
        bh=zWHSu9u2OMLIo2g7BmQGFLWCWqNqj2JgIWpWFJANtps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLHH345i8nKRDYMvCyyFuu6HW8LLeK4fjZc/DZSEFTO0RuEZLMexj8o0LTPLbWOXc
         r7HaMJBabgapF9uVhXWUtxwO4Y/vGTWzQjWQOCgVTToMHx8RhJ3CEQDWvGL4TsCXy6
         MGeGnxF6Yhz0qGIA04j996yO4ptovBMD0hjeo5YSY67WRlCL/MZEG0RLdri94wUBec
         uUA08i8oMAz+QfyzRregnqab7ho3XmmUrRZdKHhzGTTMhiUV61l9IB/7fmNxOYP+y5
         3yAYUP0sVaAHfn++cKEzOEsnGXoTELDjWKlDCjNw4U2mB6XmMEca129N58PUNxwveJ
         kRPWdNQ4ZTW+Q==
Date:   Mon, 10 May 2021 15:17:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH for-next 03/20] RDMA/rtrs-clt: No need to check
 queue_depth when receiving
Message-ID: <YJkkdKRCHC1mrR1M@unreal>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
 <20210503114818.288896-4-gi-oh.kim@ionos.com>
 <YJfGcFlJCHrf2quT@unreal>
 <CAJpMwyiXbqTK-pB=nQ4sfzXeeo8=dd5KJVZ_57apGF5cbpM5dA@mail.gmail.com>
 <YJkerTfjpXOGW7X+@unreal>
 <CAJpMwyitTn2oFxyWwr+bnFh3cQDdPwmN8L8JKPnBGqMc4a1aiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyitTn2oFxyWwr+bnFh3cQDdPwmN8L8JKPnBGqMc4a1aiw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 02:06:55PM +0200, Haris Iqbal wrote:
> On Mon, May 10, 2021 at 1:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, May 10, 2021 at 01:00:33PM +0200, Haris Iqbal wrote:
> > > On Sun, May 9, 2021 at 1:24 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Mon, May 03, 2021 at 01:48:01PM +0200, Gioh Kim wrote:
> > > > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > > >
> > > > > The queue_depth size is sent from server and
> > > > > server already checks validity of the value.
> > > >
> > > > Do you trust server? What will be if server is not reliable and sends
> > > > garbage?
> > >
> > > Hi Leon,
> > >
> > > The server code checks for the queue_depth before sending. If the
> > > server is really running malicious code, then the queue_depth is the
> > > last thing that the client needs to worry about.
> >
> > Like what? for an example?
> 
> Like accessing compromised block devices. If the queue_depth is
> garbage, the client would fail at allocation with ENOMEM; thats it.

The client will get wrong data, check it and discard. The case of ENOMEM triggered
by remote side is different. It can cause to DDOS on the client.

Thanks

> 
> >
> > Thanks
