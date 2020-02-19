Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2E163CF7
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 07:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgBSGTz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 01:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgBSGTy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 01:19:54 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55753208E4;
        Wed, 19 Feb 2020 06:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582093194;
        bh=Tgni9eYzm21ACiqSs0VgFNoTEdm7KmNqvw7TBLe51MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFSBdDyHy0nO5ZETJuVYVohdSXiDO1A47cuf/R9Z/chm9x704DP+tudUVijqJVCPv
         mOh7peWu0fnE31SMqNRczjFBH49TKYxHqkBhzMZuLhqJwB7pX+pEgAstS+zIl6KnGb
         Ieey+LMkuIRcZZ/QRaTZMx70m7FoxWRG17b17miE=
Date:   Wed, 19 Feb 2020 08:19:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Jinpu Wang <jinpuwang@gmail.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
Message-ID: <20200219061949.GB15239@unreal>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
 <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
 <20200131165421.GB29820@ziepe.ca>
 <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
 <CAD9gYJLVMVPjQcCj0aqbAW3CD86JQoFNvzJwGziRXT8B2UT0VQ@mail.gmail.com>
 <a1aaa047-3a44-11a7-19a1-e150a9df4616@kernel.dk>
 <CAMGffEkLkwkd73Q+m46VeOw0UnzZ0EkZQF-QcSZjyqNcqigZPw@mail.gmail.com>
 <20200219002449.GA11943@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200219002449.GA11943@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 08:24:49PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 06, 2020 at 04:12:22PM +0100, Jinpu Wang wrote:
> > On Fri, Jan 31, 2020 at 6:49 PM Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > > On 1/31/20 10:28 AM, Jinpu Wang wrote:
> > > > Jens Axboe <axboe@kernel.dk> 于2020年1月31日周五 下午6:04写道：
> > > >>
> > > >> On 1/31/20 9:54 AM, Jason Gunthorpe wrote:
> > > >>> On Fri, Jan 31, 2020 at 05:50:44PM +0100, Danil Kipnis wrote:
> > > >>>> Hi Doug, Hi Jason, Hi Jens, Hi All,
> > > >>>>
> > > >>>> since we didn't get any new comments for the V8 prepared by Jack a
> > > >>>> week ago do you think rnbd/rtrs could be merged in the current merge
> > > >>>> window?
> > > >>>
> > > >>> No, the cut off for something large like this would be rc4ish
> > > >>
> > > >> Since it's been around for a while, I would have taken it in a bit
> > > >> later than that. But not now, definitely too late. If folks are
> > > >> happy with it, we can get it queued for 5.7.
> > > >>
> > > >
> > > > Thanks Jason, thanks Jens, then we will prepare later another round for 5.7
> > >
> > > It would also be really nice to see official sign-offs (reviews) from non
> > > ionos people...
> >
> > Totally agree.
> > Hi Bart, hi Leon,
> >
> > Both of you spent quite some time to review the code, could you give a
> > Reviewed-by for some of the patches you've reviewed?
>
> Anyone? I don't want to move ahead with a block driver without someone
> from the block community saying it is OK

I wanted to ask for a resend based on latest -rc2, if it is possible.

Thanks

>
> Jason
