Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC072983E
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 14:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391342AbfEXMo6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 08:44:58 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36757 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389057AbfEXMo6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 08:44:58 -0400
Received: by mail-ua1-f65.google.com with SMTP id 94so3459676uam.3
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=86zgAQfw8EJJS+UNpjxjOFPf8eRhOu/zVe65BnxqX6k=;
        b=OwAdPYWwIIhzKIrP9zacmHWALt7WHScrXTSOiHZlMka+qhZn/6McmfKFyb+5mt72A8
         4yZy3bxx8SNsfV/ezDuz1DHppIcgD8780P3ujAMHW+4K+f5RPN2e/31pnlevfPC9Lp+c
         IN1fRiPPUJUb5X4snek7Tvn/JK+pQvE5V97Id1Jk2wzSHpDtKmilz9caWuJ8z3mWEy9q
         AOt6arDl+8e3Fikr/N4U9ap3kxtcaR49d3FGq/xJ5hMQ0ZX/MhCAK0F6obNBUpuZOBis
         qEUp9M8syRwmD9qj3C+L+koiFfG+W4r4XUmdJ49PyV4KvxBT7r7Hdnt9AYt3p/P2fLLt
         SrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=86zgAQfw8EJJS+UNpjxjOFPf8eRhOu/zVe65BnxqX6k=;
        b=DxLFXQDFEyyGJsFgfLOUMsWEK6jZpUaXLwmQ9JMubHTkygVO7WcXvmciz49gRyBbta
         ehkm94cgkdC9fR/xcPwHymSnxKz3fb8rvyQJGQ1G1diCows2xScby06SSFVuDvIpphGC
         nUfL1nXy7GEvZAFKexFrFgwJreN0LHlEkrPYvP8frHhGc1godKgWY6EjTmLzgS8dO5gI
         y1icJR8mmLoXZ3zhdVJdD8OZJIoaFpcQNls+xellzDLji+OQ74nQnDMxOI3m1To9CEhi
         qFMauGvuZPualiLWSjtZJevLa+oucxiH58sUUVHplz26P/pTuxQXgblXBs8EPFA/PdtX
         qjYg==
X-Gm-Message-State: APjAAAXmgGIKaSwpDgaeoLkrIYlShGyc+tcqlgSz4fQaRSGyGBIBXBbK
        3VAXpXCgOI8NDSHKvn2hH6x2D7zY0OI=
X-Google-Smtp-Source: APXvYqyEylmmdkAB6AaIhsy3vhee0zusZnFo+WYBZWM/18FEIODicL7EA9MIafCvZ0ZYEzrSfr1ouA==
X-Received: by 2002:ab0:23cd:: with SMTP id c13mr14715196uan.77.1558701896809;
        Fri, 24 May 2019 05:44:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id x19sm453316vsq.9.2019.05.24.05.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 05:44:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hU9Z9-0004qz-Fc; Fri, 24 May 2019 09:44:55 -0300
Date:   Fri, 24 May 2019 09:44:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        Dave Airlie <airlied@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Jerome Glisse <jglisse@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-mm@kvack.org, dri-devel <dri-devel@lists.freedesktop.org>
Subject: RFC: Run a dedicated hmm.git for 5.3
Message-ID: <20190524124455.GB16845@ziepe.ca>
References: <20190522235737.GD15389@ziepe.ca>
 <20190523150432.GA5104@redhat.com>
 <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca>
 <20190523182458.GA3571@redhat.com>
 <20190523191038.GG12159@ziepe.ca>
 <20190524064051.GA28855@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524064051.GA28855@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 11:40:51PM -0700, Christoph Hellwig wrote:
> On Thu, May 23, 2019 at 04:10:38PM -0300, Jason Gunthorpe wrote:
> > 
> > On Thu, May 23, 2019 at 02:24:58PM -0400, Jerome Glisse wrote:
> > > I can not take mmap_sem in range_register, the READ_ONCE is fine and
> > > they are no race as we do take a reference on the hmm struct thus
> > 
> > Of course there are use after free races with a READ_ONCE scheme, I
> > shouldn't have to explain this.
> > 
> > If you cannot take the read mmap sem (why not?), then please use my
> > version and push the update to the driver through -mm..
> 
> I think it would really help if we queue up these changes in a git tree
> that can be pulled into the driver trees.  Given that you've been
> doing so much work to actually make it usable I'd nominate rdma for the
> "lead" tree.

Sure, I'm willing to do that. RDMA has experience successfully running
shared git trees with netdev. It can work very well, but requires
discipline and understanding of the limitations.

I really want to see the complete HMM solution from Jerome (ie the
kconfig fixes, arm64, api fixes, etc) in one cohesive view, not
forced to be sprinkled across multiple kernel releases to work around
a submission process/coordination problem.

Now that -mm merged the basic hmm API skeleton I think running like
this would get us quickly to the place we all want: comprehensive in tree
users of hmm.

Andrew, would this be acceptable to you?

Dave, would you be willing to merge a clean HMM tree into DRM if it is
required for DRM driver work in 5.3?

I'm fine to merge a tree like this for RDMA, we already do this
pattern with netdev.

Background: The issue that is motivating this is we want to make
changes to some of the API's for hmm, which mean changes in existing
DRM, changes in to-be-accepted RDMA code, and to-be-accepted DRM
driver code. Coordintating the mm/hmm.c, RDMA and DRM changes is best
done with the proven shared git tree pattern. As CH explains I would
run a clean/minimal hmm tree that can be merged into driver trees as
required, and I will commit to sending a PR to Linus for this tree
very early in the merge window so that driver PR's are 'clean'.

The tree will only contain uncontroversial hmm related commits, bug
fixes, etc.

Obviouisly I will also commit to providing review for patches flowing
through this tree.

Regards,
Jason
(rdma subsystem co-maintainer, FWIW)
