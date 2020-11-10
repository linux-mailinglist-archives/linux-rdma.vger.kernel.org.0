Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730182ACE91
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Nov 2020 05:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgKJEgl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Nov 2020 23:36:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:29729 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKJEgl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Nov 2020 23:36:41 -0500
IronPort-SDR: 6elDkBGZCAa6P+8ExgnWoxJ9SH+i32tCTuJE6/l0MqTEq7p06UEqEIq7xSmq4kTI/rOskqYhYJ
 OHjX84Mq1suA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="170069400"
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="170069400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 20:36:40 -0800
IronPort-SDR: Zf7HpjrRWAJrXDBbWaCKXubRRNYU+7U9e4KOxwSp/NdN2OQOZzki/2myiNA6JHwWwZi9zZPfth
 722TzYklKUAw==
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="322700549"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 20:36:39 -0800
Date:   Mon, 9 Nov 2020 20:36:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH for-rc v1] IB/hfi1: Move cached value of mm into handler
Message-ID: <20201110043639.GK3976735@iweiny-DESK2.sc.intel.com>
References: <20201029012243.115730.93867.stgit@awfm-01.aw.intel.com>
 <20201105001245.GG1531489@iweiny-DESK2.sc.intel.com>
 <a9be20e5-f350-0e25-f757-4c9fee9d2df3@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9be20e5-f350-0e25-f757-4c9fee9d2df3@cornelisnetworks.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 12:13:23PM -0500, Dennis Dalessandro wrote:
> On 11/4/2020 7:12 PM, Ira Weiny wrote:
> > On Wed, Oct 28, 2020 at 09:22:43PM -0400, Dennis Dalessandro wrote:
> > > Two earlier bug fixes have created a security problem in the hfi1
> > > driver. One fix aimed to solve an issue where current->mm was not valid
> > > when closing the hfi1 cdev. It attempted to do this by saving a cached
> > > value of the current->mm pointer at file open time. This is a problem if
> > > another process with access to the FD calls in via write() or ioctl() to
> > > pin pages via the hfi driver. The other fix tried to solve a use after
> > > free by taking a reference on the mm. This was just wrong because its
> > > possible for a race condition between one process with an mm that opened
> > > the cdev if it was accessing via an IOCTL, and another process
> > > attempting to close the cdev with a different current->mm.
> > 
> > I'm not clear on the issue in this last sentence.  If process A is accessing
> > the FD via ioctl then process B closes the fd release should not be called
> > until process A calls close as well?
> 
> Is that the case. If proc A opened the FD then forked. Won't a call by B to
> close the fd end up doing the release?

Only if A closes the FD as well.  In which case A can't be in the middle of an
ioctl.

> 
> > I don't think it really matters much the code is wrong for other reasons.  I'm
> > just trying to understand what you are saying here.
> > 
> > > 
> > > To fix this correctly we move the cached value of the mm into the mmu
> > > handler struct for the driver. Now we can check in the insert, evict,
> > > etc. routines that current->mm matched what the handler was registered
> > > for. If not, then don't allow access. The register of the mmu notifier
> > > will save the mm pointer.
> > > 
> > > Note the check in the unregister is not needed in the event that
> > > current->mm is empty. This means the tear down is happening due to a
> > > SigKill or OOM Killer, something along those lines. If current->mm has a
> > > value then it must be checked and only the task that did the register
> > > can do the unregister.
> > 
> > I'm not seeing this bit of logic below...  Sorry.
> 
> Hmm. Maybe I goofed on a merge or something. Will fix up for a v2.
> 
> > > Since in do_exit() the exit_mm() is called before exit_files(), which
> > > would call our close routine a reference is needed on the mm. This is
> > > taken when the notifier is registered and dropped in the file close
> > > routine.
> > 
> > This should be moved below as a comment for why you need the mmget/put()
> 
> I can do that.
> 
> > > Also of note is we do not do any explicit work to protect the interval
> > > tree notifier. It doesn't seem that this is going to be needed since we
> > > aren't actually doing anything with current->mm. The interval tree
> > > notifier stuff still has a FIXME noted from a previous commit that will
> > > be addressed in a follow on patch.
> > > 
> > > Fixes: e0cf75deab81 ("IB/hfi1: Fix mm_struct use after free")
> > > Fixes: 3faa3d9a308e ("IB/hfi1: Make use of mm consistent")
> > > Reported-by: Jann Horn <jannh@google.com>
> > > Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > > Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> > > 
> > > ---
> > > 
> > > Will add a Cc for stable once the patch is finalized. I'd like to get
> > > some more feedback on this patch especially in the mmu_interval_notifier
> > > stuff. I expect to be able to get a Reviewed-by from Ira as well but
> > > I've made changes he hasn't yet seen so going with a Cc for this round.
> > > 
> > > This is sort of a v1 as the patch was sent to security folks at first
> > > which included a few others as well. This is the first public posting.
> > 
> > Is this really a security issue or a correctness issue?  Is there really any
> > way that a user can corrupt another users data?  Or is this just going to
> > scribble all over the wrong process or send the wrong data on the wire?
> 
> I guess it depends on your viewpoint. It's a security issue in the sense
> that we are currently letting one process operate while using a pointer to
> another's mm pointer. Could someone exploit it to do somethign bad, I don't
> know. I'd rather not take the chance. Due to the nature of the bug we
> thought it prudent to not take chances here.

I agree this should be fixed.  But I think it is low on the security issue.  I
have not really thought about what it might mean in an HPC sense of MPI jobs
but I still think it would be contained to a single users data.  So still seems
like a bug which would only affect a single user and I'm not sure how it would
be exploited to other users data.

That said we should get it fixed...

[snip]

> > > @@ -92,7 +80,7 @@ static unsigned long mmu_node_last(struct mmu_rb_node *node)
> > >   	return PAGE_ALIGN(node->addr + node->len) - 1;
> > >   }
> > > -int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
> > > +int hfi1_mmu_rb_register(void *ops_arg,
> > >   			 struct mmu_rb_ops *ops,
> > >   			 struct workqueue_struct *wq,
> > >   			 struct mmu_rb_handler **handler)
> > > @@ -110,18 +98,20 @@ int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
> > >   	INIT_HLIST_NODE(&handlr->mn.hlist);
> > >   	spin_lock_init(&handlr->lock);
> > >   	handlr->mn.ops = &mn_opts;
> > > -	handlr->mm = mm;
> > >   	INIT_WORK(&handlr->del_work, handle_remove);
> > >   	INIT_LIST_HEAD(&handlr->del_list);
> > >   	INIT_LIST_HEAD(&handlr->lru_list);
> > >   	handlr->wq = wq;
> > > -	ret = mmu_notifier_register(&handlr->mn, handlr->mm);
> > > +	ret = mmu_notifier_register(&handlr->mn, current->mm);
> > >   	if (ret) {
> > >   		kfree(handlr);
> > >   		return ret;
> > >   	}
> > > +	mmget(current->mm);
> > 
> > I flagged this initially but then reviewed the commit message for why you need
> > this reference.  I think it is worth a comment here as well as below.
> > Specifically mentioning the order of calls in do_exit().
> 
> Sure.

I'm somewhat with Jason on this regarding the mmget().  It does say it should not
be held for a long time.  This is why I flagged the code above initially.

But then you mentioned the whole do_exit() thing which I did not take the time
to really dig into.  So perhaps it should be revisited if you need to use the
mmget_not_zero() call to catch this do_exit() senario?

Ira

