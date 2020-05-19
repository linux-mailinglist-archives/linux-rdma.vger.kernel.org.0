Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD371D9B7F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgESPmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 11:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgESPmQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 11:42:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC70720657;
        Tue, 19 May 2020 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589902935;
        bh=SAUtnHbhRUvNQHA6UXyEPH+tMYYQxg6u5DOJzEquLKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYhLcLMwyQL8Olf6gN9Egx1f9rCvTAa3We8KZNbNicrG7ysAiKgk56HhizrOtc6SD
         HBHDxlAb7et8c9pTj0C+b+JXRNUZ9iFyFdG/Kdn6NhKUBs5W2kfo19l6BtILfuD7eU
         MvT7vBCzYLzY1AFuO27CyZGKCYgRWDyi0P2t8brg=
Date:   Tue, 19 May 2020 18:42:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/1] rnbd/rtrs: pass max segment size from blk user to
 the rdma library
Message-ID: <20200519154211.GS188135@unreal>
References: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
 <20200519080136.885628-1-danil.kipnis@cloud.ionos.com>
 <20200519080136.885628-2-danil.kipnis@cloud.ionos.com>
 <20200519084812.GP188135@unreal>
 <CAHg0Huw9HiNz1jYcypiirbB6encMcBOuGMLDE+9m0wGp0B6VfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHg0Huw9HiNz1jYcypiirbB6encMcBOuGMLDE+9m0wGp0B6VfA@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 11:14:26AM +0200, Danil Kipnis wrote:
> Hi Leon
>
> On Tue, May 19, 2020 at 10:48 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, May 19, 2020 at 10:01:36AM +0200, Danil Kipnis wrote:
> > > When Block Device Layer is disabled, BLK_MAX_SEGMENT_SIZE is undefined.
> > > The rtrs is a transport library and should compile independently of the
> > > block layer. The desired max segment size should be passed down by the
> > > user.
> > >
> > > Introduce max_segment_size parameter for the rtrs_clt_open() call.
> > >
> > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > ---
> >
> > Please, add fixes line.
> I'm new to this for-next fix up procedure. What tree the commit I
> should reference with the fixes line should come from? Should I split
> this commit so that I can reference the commits which add separate
> files in the original patchset here
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=for-next
> ? And also if I have to fix yet another issue - how do I then
> reference the commit this patch creates if applied?
> Thank you!

NP,

You need to configure your email client to properly honor replies,
e.g. add extra blank line between your reply and the email body.
It will make your replies more clear.

Regarding fixes:
1. There should not blank line between Fixes line and SOBs.
2. You can use one Fixes line (use latest).
3. Patches are usually divided for logical units.

Thanks

>
> >
> > Thanks
