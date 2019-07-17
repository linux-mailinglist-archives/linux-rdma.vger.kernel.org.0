Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1EF6C3A8
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2019 01:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfGQXva (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 19:51:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:54562 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfGQXva (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jul 2019 19:51:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 16:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,276,1559545200"; 
   d="scan'208";a="187663757"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2019 16:51:29 -0700
Date:   Wed, 17 Jul 2019 16:51:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Shamir Rabinovitch <srabinov7@gmail.com>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, linux-rdma@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used
 anymore
Message-ID: <20190717235128.GA4936@iweiny-DESK2.sc.intel.com>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-9-srabinov7@gmail.com>
 <20190717115354.GC12119@ziepe.ca>
 <20190717192525.GA2515@shamir-ThinkPad-X240>
 <20190717193313.GN12119@ziepe.ca>
 <20190717203112.GA7307@lap1>
 <20190717204505.GD32320@bombadil.infradead.org>
 <20190717213636.GA2797@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717213636.GA2797@lap1>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 18, 2019 at 12:36:37AM +0300, Yuval Shaia wrote:
> On Wed, Jul 17, 2019 at 01:45:05PM -0700, Matthew Wilcox wrote:
> > On Wed, Jul 17, 2019 at 11:31:12PM +0300, Yuval Shaia wrote:
> > > On Wed, Jul 17, 2019 at 04:33:13PM -0300, Jason Gunthorpe wrote:
> > > > Like I said, drivers that require the creating ucontext as part of the
> > > > PD and MR cannot support sharing.
> > > 
> > > Even if we can make sure the process that creates the MR stays alive until
> > > all reference to this MR completes?
> > 
> > The kernel can't rely on userspace to do that.
> 
> ok, how about this: we know that for MR to be shared the memory behinds it
> should also be shared.
> 
> In this case, i know it sounds horrifying but do we care that the process
> that originally created this MR exits? i.e. how about just before the
> process leaves this world we will find some other ucontext to hold these
> memory mappings that driver holds?

Could you create a better cover letter for this.

What is the use case for all this?
What protections are in place for accesses between processes?
Why is it not sufficient to share the entire IB context with another process
using SCM_RIGHTS?


I've been trying to create a reliable method for an admin to identify processes
which may have pinned file backed pages (specifically with FS DAX).  The best
idea I have involves using the struct file of the ucontext to track the file
pins through procfs.  Jason and I discussed it here:

https://lkml.org/lkml/2019/6/7/548

Therefore, sharing to another ucontext _might_ work.  But only if the file pin
information is properly duplicated to the new ucontext.  This complicates (at a
minimum) having the generic GUP code handle the tracking of this information...

Generically, this whole thread scares me because now we are proposing something
even more obscure than just the sharing of a file descriptor to other processes
which point to the same IB context.  (Or at least that is what I infer from
reading the very short cover letter.)  But if there is a good use case ...  we
need to starting thinking about something generic to track these "memory maps"
which are not mmaps.

Ira

