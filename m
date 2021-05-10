Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18AF378E99
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbhEJNXC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237828AbhEJLy1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 07:54:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D6F161260;
        Mon, 10 May 2021 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620647600;
        bh=S/frYV+RL+gPG/czDS1AZnCnH7N9Us8XlnPZZt8DouE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyyqaPpShifpm3+DvC/xMWWpTE6D6ioh4bHqN0I8n7cXHAmLXt5pGbu8kWiCCFnFo
         qmszlMT/REpWHma/7WJtmKIR5M+X3VH7SUxea8zyKI6BKvvy/LnyCbDXDPEb/2swcM
         qbzhVkhFYC7e55zHxqOnQNkahK29ZNS2uycmTVIqSrJq/Zo03tjuXtzapp9NBAPUab
         k3zF5MxiGgTAr7JkCLjViKdBATNsyCxFv3cJhOvtpXMTaL1C4LKFugIpyb6AivbN2d
         IN7kw+HJQNtlF2Pl2UWqNhn1T9FTU3mcfgCnu+WI7D/lHZJ6kH9/rMy3JAeJ4mN6dh
         thEndIqa0kJpQ==
Date:   Mon, 10 May 2021 14:53:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH for-next 03/20] RDMA/rtrs-clt: No need to check
 queue_depth when receiving
Message-ID: <YJkerTfjpXOGW7X+@unreal>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
 <20210503114818.288896-4-gi-oh.kim@ionos.com>
 <YJfGcFlJCHrf2quT@unreal>
 <CAJpMwyiXbqTK-pB=nQ4sfzXeeo8=dd5KJVZ_57apGF5cbpM5dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyiXbqTK-pB=nQ4sfzXeeo8=dd5KJVZ_57apGF5cbpM5dA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 01:00:33PM +0200, Haris Iqbal wrote:
> On Sun, May 9, 2021 at 1:24 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, May 03, 2021 at 01:48:01PM +0200, Gioh Kim wrote:
> > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > >
> > > The queue_depth size is sent from server and
> > > server already checks validity of the value.
> >
> > Do you trust server? What will be if server is not reliable and sends
> > garbage?
> 
> Hi Leon,
> 
> The server code checks for the queue_depth before sending. If the
> server is really running malicious code, then the queue_depth is the
> last thing that the client needs to worry about.

Like what? for an example?

Thanks
