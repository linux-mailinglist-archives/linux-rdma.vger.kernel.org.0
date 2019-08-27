Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2A9F1D2
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfH0Rqu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 13:46:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33346 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfH0Rqt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 13:46:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2fYF-0007sj-Uu; Tue, 27 Aug 2019 17:46:40 +0000
Date:   Tue, 27 Aug 2019 18:46:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
Message-ID: <20190827174639.GT1131@ZenIV.linux.org.uk>
References: <20190819100526.13788-1-geert@linux-m68k.org>
 <581e7d79ed75484beb227672b2695ff14e1f1e34.camel@perches.com>
 <CAMuHMdVh8dwd=77mHTqG80_D8DK+EtVGewRUJuaJzK1qRYrB+w@mail.gmail.com>
 <dbc03b4ac1ef4ba2a807409676cf8066@AcuMS.aculab.com>
 <CAMuHMdWHGTMwK+PO_BgsNZMpqRat1SHE-_CP0UqxEALA_OJeNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWHGTMwK+PO_BgsNZMpqRat1SHE-_CP0UqxEALA_OJeNg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 07:29:52PM +0200, Geert Uytterhoeven wrote:
> Hi David,
> 
> On Tue, Aug 27, 2019 at 4:17 PM David Laight <David.Laight@aculab.com> wrote:
> > From: Geert Uytterhoeven
> > > Sent: 19 August 2019 18:15
> > ...
> > > > I think a cast to unsigned long is rather more common.
> > > >
> > > > uintptr_t is used ~1300 times in the kernel.
> > > > I believe a cast to unsigned long is much more common.
> > >
> > > That is true, as uintptr_t was introduced in C99.
> > > Similarly, unsigned long was used before size_t became common.
> > >
> > > However, nowadays size_t and uintptr_t are preferred.
> >
> > Isn't uintptr_t defined by the same standard as uint32_t?
> 
> I believe so.

It sure as hell is not.  C99 7.18.1.4:

The following type designates an unsigned integer type with the property that any valid
pointer to void can be converted to this type, then converted back to pointer to void,
and the result will compare equal to the original pointer:
	uintptr_t

IOW, it's "large enough to represent pointers".
