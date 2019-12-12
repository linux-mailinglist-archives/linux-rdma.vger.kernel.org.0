Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834E011CE97
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 14:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfLLNl4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 08:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbfLLNl4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 08:41:56 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A722077B;
        Thu, 12 Dec 2019 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576158115;
        bh=eKIpRDx+zfn9tjbkvPcwD44F+RZgeuddmRcdxODecF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDAQC728DMmhZg3qL4jAR538yfhDTJ0lm6Kf+9fpYSdnhWz7nT0DicXenTE+nLnrb
         i1+Eho4lCWrAClTzN+L7XkHJhwcfQEaR44cPTD94jsd6VNWM8bLU3/CT2cVXi3lhKj
         6+uVNGLXoeQK6BaGmxNf4SBFFt3MJgYTS0p68kJs=
Date:   Thu, 12 Dec 2019 15:41:52 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Max Hirsch <max.hirsch@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Myungho Jung <mhjungk@gmail.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Fix checkpatch error
Message-ID: <20191212134152.GB67461@unreal>
References: <20191211111628.2955-1-max.hirsch@gmail.com>
 <20191211162654.GD6622@ziepe.ca>
 <20191212084907.GU67461@unreal>
 <e5123cbb-9871-d9c3-62e9-5b3172d1adf8@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5123cbb-9871-d9c3-62e9-5b3172d1adf8@amazon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 02:10:12PM +0200, Gal Pressman wrote:
> On 12/12/2019 10:49, Leon Romanovsky wrote:
> > On Wed, Dec 11, 2019 at 12:26:54PM -0400, Jason Gunthorpe wrote:
> >> On Wed, Dec 11, 2019 at 11:16:26AM +0000, Max Hirsch wrote:
> >>> When running checkpatch on cma.c the following error was found:
> >>
> >> I think checkpatch will complain about your patch, did you run it?
> >
> > Jason, Doug
> >
> > I would like to ask to refrain from accepting checkpatch.pl patches
> > which are not part of other large submission. Such standalone cleanups
> > do more harm than actual benefit from them for old and more or less
> > stable code (e.g. RDMA-CM).
>
> Sounds like a great approach to prevent new developers from contributing code.
> You have to start somewhere and checkpatch patches are a good entry point for
> such developers, discouraging them will only hurt us in the long term.

We have staging tree where new developer can train their checkpatch patches.

What about fixing smatch and sparse errors? It doesn't require HW for
that and much better entry point for the new developers.

>
> Linus had an interesting post on the subject:
> https://lkml.org/lkml/2004/12/20/255

We are in 2019 and our opinions, Linus's back 15 years ago and mine can be different.

Thanks
