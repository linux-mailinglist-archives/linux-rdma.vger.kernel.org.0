Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E226D999AC
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbfHVQ6n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 12:58:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:41204 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730411AbfHVQ6n (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 12:58:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 09:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="180441046"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2019 09:58:42 -0700
Date:   Thu, 22 Aug 2019 09:58:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        willy@infradead.org, michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, jgg@mellanox.com,
        linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
Message-ID: <20190822165841.GA17588@iweiny-DESK2.sc.intel.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
 <20190822084102.GA2898@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822084102.GA2898@lap1>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 11:41:03AM +0300, Yuval Shaia wrote:
> On Wed, Aug 21, 2019 at 04:37:37PM -0700, Ira Weiny wrote:
> > On Wed, Aug 21, 2019 at 05:21:01PM +0300, Yuval Shaia wrote:
> > > Following patch-set introduce the shared object feature.
> > > 
> > > A shared object feature allows one process to create HW objects (currently
> > > PD and MR) so that a second process can import.
> 
> Hi Ira,
> 
> > 
> > For something this fundamental I think the cover letter should be more
> > detailed than this.  Questions I have without digging into the code:
> > 
> > What is the use case?
> 
> I have only one use case but i didn't added it to commit log just not to
> limit the usage of this feature but you are right, cover letter is great
> for such things, will add it for v2.
> 
> Anyway, here is our use case: Consider a case of server with huge amount
> of memory and some hundreds or even thousands processes are using it to
> serves clients requests. In this case the HCA will have to manage hundreds
> or thousands MRs. A better design maybe would be that one process will
> create one (or several) MR(s) which will be shared with the other
> processes. This will reduce the number of address translation entries and
> cache miss dramatically.

I think Doug covered my concerns in this area.

> 
> > 
> > What is the "key" that allows a MR to be shared among 2 processes?  Do you
> > introduce some PD identifier?  And then some {PDID, lkey} tuple is used to ID
> > the MR?
> > 
> > I assume you have to share the PD first and then any MR in the shared PD can be
> > shared?  If so how does the MR get shared?
> 
> Sorry, i'm not following.
> I think the term 'share' is somehow mistake, it is actually a process
> 'imports' objects into it's context. And yes, the workflow is first to
> import the PD and then import the MR.

Ok fair enough but the title of the thread is "Sharing PD and MR" so I used the
term Share.  And I expect that any random process can't import objects to which
the owning process does not allow them to right?

I mean you can't just have any process grab a PD and MR and start using it.  So
I assume there is some "sharing" by the originating process.

> 
> > 
> > Again I'm concerned with how this will interact with the RDMA and file system
> > interaction we have been trying to fix.
> 
> I'm not aware of this file-system thing, can you point me to some
> discussion on that so i'll see how this patch-set affect it.


https://lkml.org/lkml/2019/6/6/1101
https://lkml.org/lkml/2019/8/9/1043
https://lwn.net/Articles/796000/

There are many more articles, patch sets, discussion threads...  This work has
been going on much longer than I have been working on it.

> 
> > 
> > Why is SCM_RIGHTS on the rdma context FD not sufficient to share the entire
> > context, PD, and all MR's?
> 
> Well, this SCM_RIGHTS is great, one can share the IB context with another.
> But it is not enough, because:
> - What API the second process can use to get his hands on one of the PDs or
>   MRs from this context?

MRs can be passed by {PD,key} through any number of mechanisms.  All you need
is an ID for them.  Maybe this is clear in the code.  If so sorry about that.

> - What mechanism takes care of the destruction of such objects (SCM_RIGHTS
>   takes care for the ref counting of the context but i'm referring to the
>   PDs and MRs objects)?

This is inherent in the lifetime of the uverbs file object to which cloned FDs
(one in each process) have a reference to.

Add to your list "how does destruction of a MR in 1 process get communicated to
the other?"  Does the 2nd process just get failed WR's?

> 
> The entire purpose of this patch set is to address these two questions.

Fair enough but the cover letter should spell out the above and how this series
fixes that problem.

I have some of the same concerns as Doug WRT memory sharing.  FWIW I'm not sure
that what SCM_RIGHTS is doing is safe or correct.

For that work I'm really starting to think SCM_RIGHTS transfers should be
blocked.  It just seems wrong that Process B gets references to Process A's
mm_struct and holds the memory Process A allocated.  This seems wrong for any
type of memory, file system or not.  That said I'm assuming that this is all
within a single user so admins can at least determine who is pinning down all
this memory.

Ira

