Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8567A60B1B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfGERfx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 13:35:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37571 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfGERfx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Jul 2019 13:35:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so9697963qtk.4
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jul 2019 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bdqbyUW8SWFbHhiep1IcQc/wN+3YDPUFIGeb4cHdiew=;
        b=IwPF9H2whbchEYaGOQverh5ti5qF4YnlWR6cQvAlyRu01v3DfaDyFPLwSX75eFrKvQ
         5BvhC5lmfen7hktx2NbE3tO8d15GSK9NI1mCbGwa/9Z2tMmDerNHC0lxW4g41Oo0KH5x
         Kqh3hE0Idc6njGO0kAs6DQ7/5xYHZUGDDh8JEd1Bbvk4ftbirB83577f38Z8kNtSLBUg
         Mxgh6HhYLSR56/c/fYjNMTFg1apyzh/44QGIMXDuWvDwzeNH338C9Cpc2hSFTSBsipsl
         0GS8W2RunRmarbF4jGmZeL8b1JVvQlp+yWmRawQFF+a942qvUnO4RXltfCCuCMQ2ce4I
         kQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bdqbyUW8SWFbHhiep1IcQc/wN+3YDPUFIGeb4cHdiew=;
        b=YOZioCAzpFSF+j1k5ixhWp5vNV+94Wj7yXuliLMn3wOWrEoZqW3Udv6Cco9NSCfCxY
         h5eCHl1PSGSVEdbE+m+nFUHLQnH4LSeJICMk0DrLSCyabUe2amT665ns8MJLJryVGa9m
         ZaxXlq2IQL2HnvuhZapmsUSHUyIfMV6nAlV/51DSAPZvcn4k7Aj06SdMWLxGiDpRukFT
         SvsNsjipBh0kqyC2ZuPhId0ggXTEaY9wkYJ4fQPzVOMuVF8zn+1VB8RCEJ6qmpgeunTG
         vWQr7qfKN+aywTyswnP81RQ5YU9hkLQHsVuakNjFwvlT3WIS1bCDJ+kJutDt4m7M0wcK
         ofDw==
X-Gm-Message-State: APjAAAVVdeGMTYzvA6bWKtpJhBgCVHkuejg4twb00Hr6oy5NPpGQzmgo
        wOEjaz3FOXUYWtv+DJF1PgSJ5w==
X-Google-Smtp-Source: APXvYqwyL/+kItjIchs4ild/GunlE6XKM/A+eUKAHLq/BQwijyyGYy2iBebOTqICZmYZnlvoYWAUKw==
X-Received: by 2002:a0c:aed0:: with SMTP id n16mr4396280qvd.101.1562348152600;
        Fri, 05 Jul 2019 10:35:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g54sm4546464qtc.61.2019.07.05.10.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2019 10:35:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hjS7j-0001zk-PB; Fri, 05 Jul 2019 14:35:51 -0300
Date:   Fri, 5 Jul 2019 14:35:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Message-ID: <20190705173551.GC31543@ziepe.ca>
References: <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190702223126.GA11860@ziepe.ca>
 <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
 <20190704123511.GA3447@ziepe.ca>
 <MN2PR18MB318240185BE80841F1265D2FA1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190705153248.GB31543@ziepe.ca>
 <MN2PR18MB3182F4496DA01CA2B113DF04A1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182F4496DA01CA2B113DF04A1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 05, 2019 at 05:24:18PM +0000, Michal Kalderon wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Friday, July 5, 2019 6:33 PM
> > 
> > On Fri, Jul 05, 2019 at 03:29:03PM +0000, Michal Kalderon wrote:
> > > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Sent: Thursday, July 4, 2019 3:35 PM
> > > >
> > > > External Email
> > > >
> > > > On Wed, Jul 03, 2019 at 11:19:34AM +0300, Gal Pressman wrote:
> > > > > On 03/07/2019 1:31, Jason Gunthorpe wrote:
> > > > > >> Seems except Mellanox + hns the mmap flags aren't ABI.
> > > > > >> Also, current Mellanox code seems like it won't benefit from
> > > > > >> mmap cookie helper functions in any case as the mmap function
> > > > > >> is very specific and the flags used indicate the address and
> > > > > >> not just how to map
> > > > it.
> > > > > >
> > > > > > IMHO, mlx5 has a goofy implementaiton here as it codes all of
> > > > > > the object type, handle and cachability flags in one thing.
> > > > >
> > > > > Do we need object type flags as well in the generic mmap code?
> > > >
> > > > At the end of the day the driver needs to know what page to map
> > > > during the mmap syscall.
> > > >
> > > > mlx5 does this by encoding the page type in the address, and then
> > > > many types have seperate lookups based onthe offset for the actual
> > page.
> > > >
> > > > IMHO the single lookup and opaque offset is generally better..
> > > >
> > > > Since the mlx5 scheme is ABI it can't be changed unfortunately.
> > > >
> > > > If you want to do user controlled cachability flags, or not, is a
> > > > fair question, but they still become ABI..
> > > >
> > > > I'm wondering if it really makes sense to do that during the mmap,
> > > > or if the cachability should be set as part of creating the cookie?
> > > >
> > > > > Another issue is that these flags aren't exposed in an ABI file,
> > > > > so a userspace library can't really make use of it in current state.
> > > >
> > > > Woops.
> > > >
> > > > Ah, this is all ABI so you need to dig out of this hole ASAP :)
> > > >
> > > Jason, I didn't follow - what is all ABI?
> > > currently EFA implementation encodes the cachability inside the key,
> > > It's not exposed in ABI file and is opaque to user-space. The kernel
> > > decides on the cachability And get's it back in the key when mmap is
> > > called. It seems good enough for the current cases.
> > 
> > Then the key 'offset' should not include cachability information at all.
> > 
> Fair enough, so as you stated above the cachabiliy can be set in the cookie. 
> Would we still like to leave some bits for future ABI enhancements, requests, from user ? 
> Similar to a page type that mlx has ? 

Doesn't make sense to mix and match, the page_type was just some way
to avoid tracking cookies in some cases. If we are always having a
cookie then the cookie should indicate the type based on how it was
created. Totally opaque

Jason
