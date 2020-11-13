Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3182B1347
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 01:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKMAd7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 19:33:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:47707 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgKMAd7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 19:33:59 -0500
IronPort-SDR: qS3qQNM6vpsPzx9gRDLyWHmejzR+tT80VnKH0cY7ZX/nEKjXedQqgYM4Eb85dx9KOyUQQway3p
 3iFf9s2g2D7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="169621739"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="169621739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 16:33:58 -0800
IronPort-SDR: oorlKCcdMPi5FiuEQSWO3toS2B0mmzscwtxZjs8e2Fd24nSlC6WeYHIqBcrVpHQRqoh4vIPpb1
 Mw/eztIzJUHg==
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="357310119"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 16:33:58 -0800
Date:   Thu, 12 Nov 2020 16:33:57 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH for-rc v2] IB/hfi1: Move cached value of mm into handler
Message-ID: <20201113003357.GW3976735@iweiny-DESK2.sc.intel.com>
References: <20201112025837.24440.6767.stgit@awfm-01.aw.intel.com>
 <20201112171439.GT3976735@iweiny-DESK2.sc.intel.com>
 <b45c2303-a78e-a3b6-fcd2-371886caf788@cornelisnetworks.com>
 <ba7df075-ab50-3344-aacb-656ae10b517a@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba7df075-ab50-3344-aacb-656ae10b517a@cornelisnetworks.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 05:08:22PM -0500, Dennis Dalessandro wrote:
> On 11/12/2020 5:06 PM, Dennis Dalessandro wrote:
> > On 11/12/2020 12:14 PM, Ira Weiny wrote:
> > > On Wed, Nov 11, 2020 at 09:58:37PM -0500, Dennis Dalessandro wrote:
> > > > Two earlier bug fixes have created a security problem in the hfi1
> > > > driver. One fix aimed to solve an issue where current->mm was not valid
> > > > when closing the hfi1 cdev. It attempted to do this by saving a cached
> > > > value of the current->mm pointer at file open time. This is a problem if
> > > > another process with access to the FD calls in via write() or ioctl() to
> > > > pin pages via the hfi driver. The other fix tried to solve a use after
> > > > free by taking a reference on the mm. This was just wrong because its
> > > > possible for a race condition between one process with an mm that opened
> > > > the cdev if it was accessing via an IOCTL, and another process
> > > > attempting to close the cdev with a different current->mm.
> > > 
> > > Again I'm still not seeing the race here.  It is entirely possible
> > > that the fix
> > > I was trying to do way back was mistaken too...  ;-)  I would just
> > > delete the
> > > last 2 sentences...  and/or reference the commit of those fixes and help
> > > explain this more.
> > 
> > I was attempting to refer to [1], the email that started all of this.
> 
> That link should be:
> [1] https://marc.info/?l=linux-rdma&m=159891753806720&w=2

Ah...  ok  That does not have anything to do with a close.  He is worried about
the mm structure going away because the other process exited.  That can't
happen, even with the old code, because the release will not be called until
the child process calls close.

But even if the mm is still around the get_user_pages_fast() in the child is
_going_ to use current->mm if it falls back to the locked version.  Thus it is
going to go off in the weeds when trying to pin user addresses in the child.

Basically there is no 'race', the code is just broken and going to do the wrong
thing regardless of timing!  :-(

The new code is keeping the mm_grab() reference in the mmu_notifier rather than
in the fd structure, an improvement for sure, but for many applications likely
to have almost the same lifetime as before, in the parent process.

Also Jann is 100% correct that the driver should not be operating on the wrong
mm and you are using his methodology #3.[1]

So I think the final point is the key to fixing the bug.  Keeping any
current->mm which is not the one we opened the file with...  (or more
specifically the one which first registered memory).  In some ways this may be
worse than before because technically the parent could open the fd and hand it
to the child and have the child register with it's mm.  But that is ok
really...  May just be odd behavior for some users depending on what operations
they do and in what order.

Ira

[1] Also, you probably should credit Jann for the idea with a suggested by tag.

> 
> -Denny
> 
