Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5282BB1AE
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 18:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgKTRqe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 12:46:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:53942 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgKTRqe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Nov 2020 12:46:34 -0500
IronPort-SDR: mrZvhFRz6xTrk1wrInjOAC3zNtNnlNWlnLR421Il4lcvLXdAuAMwxDtXc57Yg1tbJWlJruFlr5
 FDD9MVEYoAlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168942533"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="168942533"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 09:46:32 -0800
IronPort-SDR: w9APTzgl3eZaJmvpwS8pmgr1+fYBNUbN42HsC3YvmFlK7mlm+Wi8vKfWM1sNFndxhj15P5keEG
 etF3nloQeyeA==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="477307350"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 09:46:30 -0800
Date:   Fri, 20 Nov 2020 09:46:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH for-rc v3] IB/hfi1: Move cached value of mm into handler
Message-ID: <20201120174630.GC1161629@iweiny-DESK2.sc.intel.com>
References: <20201117233213.10558.47108.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117233213.10558.47108.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 17, 2020 at 06:32:13PM -0500, Dennis Dalessandro wrote:
> Two earlier bug fixes have created a security problem in the hfi1
> driver. One fix aimed to solve an issue where current->mm was not valid
> when closing the hfi1 cdev. It attempted to do this by saving a cached
> value of the current->mm pointer at file open time. This is a problem if
> another process with access to the FD calls in via write() or ioctl() to
> pin pages via the hfi driver. The other fix tried to solve a use after
> free by taking a reference on the mm.
> 
> To fix this correctly we move the cached value of the mm into the mmu
> handler struct for the driver.

Is this true for this version of the patch?  It seems this version removes the
mm member from the mmu_rb_handler and relies on the mmu notifier mm...

> Now we can check in the insert, evict,
> etc. routines that current->mm matched what the handler was registered
> for. If not, then don't allow access. The register of the mmu notifier
> will save the mm pointer.
> 
> Note the check in the unregister is not needed in the event that
> current->mm is empty. This means the tear down is happening due to a
> SigKill or OOM Killer, something along those lines. If current->mm has a
> value then it must be checked and only the task that did the register
> can do the unregister.
> 
> Since in do_exit() the exit_mm() is called before exit_files(), which
> would call our close routine a reference is needed on the mm. We rely on
> the mmgrab done by the registration of the notifier, whereas before it
> was explicit.

Since you need to clean up the commit message above I think another good idea
would be to put this explanation in the code in hfi1_mmu_rb_unregister() so
that people understand right away why that check is special.

[snip]

> @@ -92,7 +81,7 @@ static unsigned long mmu_node_last(struct mmu_rb_node *node)
>  	return PAGE_ALIGN(node->addr + node->len) - 1;
>  }
>  
> -int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
> +int hfi1_mmu_rb_register(void *ops_arg,
>  			 struct mmu_rb_ops *ops,
>  			 struct workqueue_struct *wq,
>  			 struct mmu_rb_handler **handler)
> @@ -110,13 +99,12 @@ int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
>  	INIT_HLIST_NODE(&handlr->mn.hlist);
>  	spin_lock_init(&handlr->lock);
>  	handlr->mn.ops = &mn_opts;
> -	handlr->mm = mm;

NIT: I still think you should fix the spelling of handler...  ;-)

Otherwise I think the logic and code looks good...

With changes to the commit message and the comment...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Ira

