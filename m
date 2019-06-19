Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA24B1EF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 08:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfFSGHs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 02:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbfFSGHs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 02:07:48 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB6B20679;
        Wed, 19 Jun 2019 06:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560924467;
        bh=NkO49tgQdRCvMFENmhBhETbuwsvxmcQK4w1FtqSy4rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKDpvcXJS33/5nSaAFqUHmIeXeFv+zEEu4wTUkZS2vCbzAEU+Azv3MgHsMfBG2wdn
         siYgwZq2C3zjfNmRC7eIsE+Rckn7fRdfpRNIHqMOBR26dmdQHLH5msZr1pOliGlRCd
         QLziwra8wu0tplcCwHf3gjDnljAqilQE8ahzCxII=
Date:   Wed, 19 Jun 2019 09:07:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Message-ID: <20190619060744.GE11611@mtr-leonro.mtl.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-3-jgg@ziepe.ca>
 <20190618121709.GK4690@mtr-leonro.mtl.com>
 <20190618131019.GE6961@ziepe.ca>
 <97a95f7e5447b0ddf4dee15c536d72bd9fb65780.camel@redhat.com>
 <20190618165338.GO4690@mtr-leonro.mtl.com>
 <20190618184653.GM6961@ziepe.ca>
 <1ec72297f837bf95fadaf846b7fe39a7b24de23c.camel@redhat.com>
 <a936acff4501cd235735c1784bdbd7d2668fccfa.camel@redhat.com>
 <af804744ff8bac383888bf9a07c0f260b070533f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af804744ff8bac383888bf9a07c0f260b070533f.camel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 11:19:58PM -0400, Doug Ledford wrote:
> On Tue, 2019-06-18 at 22:45 -0400, Doug Ledford wrote:
> > On Tue, 2019-06-18 at 16:58 -0400, Doug Ledford wrote:
> > > On Tue, 2019-06-18 at 15:46 -0300, Jason Gunthorpe wrote:
> > > > On Tue, Jun 18, 2019 at 07:53:38PM +0300, Leon Romanovsky wrote:
> > > > > I have a very strong opinion about it.
> > > >
> > > > Then Doug should add the policies, here are the output values from
> > > > the
> > > > userspace:
> > > >
> > > >         [RDMA_NLDEV_ATTR_CHARDEV] = { .type = NLA_U64 },
> > > >         [RDMA_NLDEV_ATTR_CHARDEV_ABI] = { .type = NLA_U64 },
> > > >         [RDMA_NLDEV_ATTR_DEV_INDEX] = { .type = NLA_U32 },
> > > >         [RDMA_NLDEV_ATTR_DEV_NODE_TYPE] = { .type = NLA_U8 },
> > > >         [RDMA_NLDEV_ATTR_NODE_GUID] = { .type = NLA_U64 },
> > > >         [RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID] = { .type = NLA_U32 },
> > > >         [RDMA_NLDEV_ATTR_CHARDEV_NAME] = { .type = NLA_NUL_STRING
> > > > },
> > > >         [RDMA_NLDEV_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING },
> > > >         [RDMA_NLDEV_ATTR_DEV_PROTOCOL] = { .type = NLA_NUL_STRING
> > > > },
> > > >         [RDMA_NLDEV_ATTR_FW_VERSION] = { .type = NLA_NUL_STRING },
> > >
> > > Most of those were already in the policies.  Only the four that you
> > > added to enum rdma_nldev_attr needed added to the policies, and two
> > > of
> > > them your patch already added.  The only question I had is what the
> > > string length should be on ATTR_CHARDEV_NAME?  I throw in the
> > > default
> > > of
> > > .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN, but I wasn't sure if that was
> > > right
> > > for this entry?
> >
> > First of all, let me say that this is a PITA.  I'm thinking we need to
> > order all of the attributes in the policy array in alphabetical order
> > so
> > it's easier to tell what's there and what's missing.
> >
> > Also, I'm starting to not like adding items to the policy array before
> > they are actually acceptable as inputs.  Sure, there's the argument
> > that
> > they won't get missed.  But there's the counter argument that until
> > you
> > define them as an input in some netlink function that reads them, at
> > least for all of the string items, you can't actually set the real
> > string length limit.  By adding them to the policy now, you make it a
> > guarantee that you'll end up changing the API under userspace later
> > when
> > they become a legitimate input.  Not sure if that's actually
> > wise.  The
> > u32 and u64, sure, that's fine.  But the strings, that can cause
> > problems later.,
> >
>
> Maybe the best way to do string items if you add them ahead of time is
> to give them an input length of 1.  Theoretically that's just the null
> byte.  Then when you add a function to actually read the data, set the
> size to something real.

Like you said, it won't be needed till new input code is used, so from
API perspective, it doesn't matter what size will be. I liked your idea
to put it to be "1". It goes hand by hand to avoid possible addition
of input handlers without update of update nla_policy.

>
> Anyway, pushed to wip/dl-for-next, check it to make sure you're happy
> with the final results.

It looks good, thanks.

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


