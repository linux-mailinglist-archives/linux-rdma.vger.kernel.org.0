Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF941D4D5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 09:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348801AbhI3HzW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 03:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348793AbhI3HzV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Sep 2021 03:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B5D961452;
        Thu, 30 Sep 2021 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632988419;
        bh=wfufoGrDSlfUs9Me8/1bNDZ0YZoqlCww6ODrn49dbNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNI69UF4V1CvlWRm/QV6RJYhAKi4GlTMlqxuNG0fGjMGs44HuMD2nomQJT19yd48w
         M7p9jQH0lWhblY8T+9NlOALrKM4/+jsquy4eIaTM18tvBWBG53bGnzAop+dvHG2w7o
         iXkHuDU1T3USJA6nXrz2jBfWzS301xT7BRyjz81QaZwmMkp5slxYKpzUUi4jKwD1Oc
         tVUTTebjHZYqVYVUozHJ4pV3R/Ap/qGE/ml2ybDn2FNBOv1m19Xk1Z00hiGe+hQquS
         /tm4oPFd0zZf33u+wg9JvV44xtTiGSD8pivXYPQEyE3fGg0LhxVG0meTPzaTS5aPA8
         rp9Z2ZvumKPWg==
Date:   Thu, 30 Sep 2021 10:53:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Jack Wang <xjtuwjp@gmail.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Gioh Kim <gi-oh.kim@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: Re: [PATCH for-next 6/7] RDMA/rtrs: Do not allow sessname to contain
 special symbols / and .
Message-ID: <YVVtAFtOj0mPzSAR@unreal>
References: <20210922125333.351454-1-haris.iqbal@ionos.com>
 <20210922125333.351454-7-haris.iqbal@ionos.com>
 <YVG3cme0KX9CD4oh@unreal>
 <CAD+HZHWTZY=6W4MNEGwVi=e64MJtntVE1Hwm6Lt_m=UaAW2W-A@mail.gmail.com>
 <YVLEIVz1mCV0cZlC@unreal>
 <CAD+HZHW5u1MiB-+C784yYXZc9Q-F0yB+1EvRKb4sAQJe4p2Yeg@mail.gmail.com>
 <YVRWXim7T0mReBu/@unreal>
 <CAMGffE=mv8jJYeNC7BjiGbOt4qEFAQhXWROk4Uwzg5ED4a0sug@mail.gmail.com>
 <YVVgunT1hSIzu1tA@unreal>
 <CAMGffE=NP-iNcAQyVF57tbeJ1QcyMt7=savh=5BLxaC9TuAkTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffE=NP-iNcAQyVF57tbeJ1QcyMt7=savh=5BLxaC9TuAkTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 30, 2021 at 09:10:33AM +0200, Jinpu Wang wrote:
> On Thu, Sep 30, 2021 at 9:01 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Sep 30, 2021 at 08:03:40AM +0200, Jinpu Wang wrote:
> > > On Wed, Sep 29, 2021 at 2:04 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Wed, Sep 29, 2021 at 09:00:56AM +0200, Jack Wang wrote:
> > > > > Leon Romanovsky <leon@kernel.org> 于2021年9月28日周二 上午9:28写道：
> > > > > >
> > > > > > On Tue, Sep 28, 2021 at 09:08:26AM +0200, Jack Wang wrote:
> > > > > > > Leon Romanovsky <leon@kernel.org> 于2021年9月27日周一 下午2:23写道：
> > > > > > > >
> > > > > > > > On Wed, Sep 22, 2021 at 02:53:32PM +0200, Md Haris Iqbal wrote:
> > > > > > > > > Allowing these characters in sessname can lead to unexpected results,
> > > > > > > > > particularly because / is used as a separator between files in a path,
> > > > > > > > > and . points to the current directory.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > > > > > > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > > > > > > Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
> > > > > > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++++
> > > > > > > > >  2 files changed, 11 insertions(+)
> > > > > > > >
> > > > > > > > It will be safer if you check for only allowed symbols and disallow
> > > > > > > > everything else. Check for: a-Z, 0-9 and "-".
> > > > > > > >
> > > > > > > Hi Leon,
> > > > > > >
> > > > > > > Thanks for your suggestions.
> > > > > > > The reasons we choose to do disallow only '/' and '.':
> > > > > > > 1 more flexible, most UNIX filenames allow any 8-bit set, except '/' and null.
> > > > > >
> > > > > > So you need to add all possible protections and checks that VFS has to allow "random" name.
> > > > > It's only about sysfs here, as we use sessname to create dir in sysfs,
> > > > > and I checked the code, it allows any 8-bit set, and convert '/' to
> > > > > '!', see https://elixir.bootlin.com/linux/latest/source/lib/kobject.c#L299
> > > > > >
> > > > > > > 2 matching for 2 characters is faster than checking all the allowed
> > > > > > > symbols during session establishment.
> > > > > >
> > > > > > Extra CPU cycles won't make any difference here.
> > > > > As we can have hundreds of sessions, in the end, it matters.
> > > >
> > > > Your rtrs_clt_open() function is far from being optimized for
> > > > performance. It allocates memory, iterates over all paths, creates
> > > > sysfs and kobject.
> > > >
> > > > So no, it doesn't matter here.
> > > >
> > > Let me reiterate, why do we want to further slow it down, what do you
> > > anticipate if we only do the disallow approach
> > > as we do it now?
> >
> > It is common practice to sanitize user input and explicitly allow known
> > good input, instead of relying on deny of bad input. We don't know the
> > future and can't be sure that "deny" is actually closed all holes.
> 
> Thanks for the clarification, but still what kind of holes do you have
> in mind, the input string length is already checked and it's
> not duplicated with other sessname. and sysfs does allow all 8 bit set IIUC.

As an example, symbols like "/" and "\".

> 
> Thanks!
> 
> > Thanks
