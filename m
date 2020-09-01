Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A895925857E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 04:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgIACBX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 22:01:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54902 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgIACBX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 Aug 2020 22:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598925681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DW3RpkFZ33SZha6jQXz5I3Q9hc0uu2ZyMo/pZQVTlEw=;
        b=bU4Co1EKbUoG9ZJ3SYR6a6nKXV1zGDbxwP+TGTBlk4vtFV6kjSOknOLLbryLSHGfxMPGi/
        6cF7VKWrZxmbSmeLXZBKY7G2jQTp83lezZ+3BgSbj5FHuDJWWQebyjC0YVlAkFoaD40j71
        90dAPkmBIdRzsYdggwh3k1ECuHqFxrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-ZKE8IOvnOh2XyfGbWBCIQQ-1; Mon, 31 Aug 2020 22:01:19 -0400
X-MC-Unique: ZKE8IOvnOh2XyfGbWBCIQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3523410054FF;
        Tue,  1 Sep 2020 02:01:18 +0000 (UTC)
Received: from T590 (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 688C91002393;
        Tue,  1 Sep 2020 02:01:12 +0000 (UTC)
Date:   Tue, 1 Sep 2020 10:01:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
Subject: Re: [PATCH] IB/isert: fix unaligned immediate-data handling
Message-ID: <20200901020108.GB289251@T590>
References: <20200830103209.378141-1-sagi@grimberg.me>
 <20200831121818.GZ24045@ziepe.ca>
 <8bc2755b-e7d6-5d9c-f5e0-e8036b28beb6@grimberg.me>
 <20200901010046.GA289251@T590>
 <03366642-e4e3-243a-4ced-df0303202763@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03366642-e4e3-243a-4ced-df0303202763@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 31, 2020 at 06:10:38PM -0700, Sagi Grimberg wrote:
> 
> > > > > Currently we allocate rx buffers in a single contiguous buffers
> > > > > for headers (iser and iscsi) and data trailer. This means
> > > > > that most likely the data starting offset is aligned to 76
> > > > > bytes (size of both headers).
> > > > > 
> > > > > This worked fine for years, but at some point this broke.
> > > > > To fix this, we should avoid passing unaligned buffers for
> > > > > I/O.
> > > > 
> > > > That is a bit vauge - what suddenly broke it?
> > > 
> > > Somewhere around the multipage bvec work that Ming did. The issue was
> > > that brd assumed a 512 aligned page vector. IIRC the discussion settled
> > > that the block layer expects a 512B aligned buffer(s).
> > 
> > I don't think the limit is from multipage bvec, and the limit is
> > actually from driver since block layer just sets up the vectors which
> > is passed to driver, see the following discussion:
> 
> Understood, fact is that this used to work (which is probably why this
> was overlooked) and now it doesn't. Assumed it was related to multipage
> bvec without a proof :)
> 
> I guess the basis was the original report:
> 
> > Hi,
> >
> > We recently began testing 5.4 in preparation for migration from 4.14. One
> > of our tests found reproducible data corruption in 5.x kernels. The test
> > consists of a few basic single-issue writes to an iSER attached ramdisk.
> > The writes are subsequently verified with single-issue reads. We tracked
> > the corruption down using git bisect. The issue appears to have started in
> > 5.1 with the following commit:
> >
> > 3d75ca0adef4280650c6690a0c4702a74a6f3c95 block: introduce multi-page bvec
> > helpers
> 
> Anyways, I think it's a reasonable requirement and hence this fix...

Agree, your fix is good, even though we can make brd working, however
there might be other drivers in which DMA alignment limit is broken by
the unaligned buffer from upper layer.


thanks,
Ming

