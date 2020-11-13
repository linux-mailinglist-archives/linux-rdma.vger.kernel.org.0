Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992082B1365
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 01:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgKMAmX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 19:42:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:6160 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgKMAmW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 19:42:22 -0500
IronPort-SDR: NZp7FoAHXbzY1thwbhPz/xuYz2LuGLGP+OBYuuErsgBjO03R295rA1YXP7wlgdAAvpNi7yFyDX
 xxxQ42ro34hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="166897924"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="166897924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 16:42:21 -0800
IronPort-SDR: rsU/NrbilkyfFShHgrIPrigKB4wbPEpm3KVR7kB5TFbqJFukcWIHXPPPCUDOa9RfFmQPUTza1M
 Z1mxeWgTeHLA==
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="542464450"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 16:42:21 -0800
Date:   Thu, 12 Nov 2020 16:42:21 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        dledford@redhat.com, Jann Horn <jannh@google.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH for-rc v2] IB/hfi1: Move cached value of mm into handler
Message-ID: <20201113004221.GX3976735@iweiny-DESK2.sc.intel.com>
References: <20201112025837.24440.6767.stgit@awfm-01.aw.intel.com>
 <20201112171439.GT3976735@iweiny-DESK2.sc.intel.com>
 <b45c2303-a78e-a3b6-fcd2-371886caf788@cornelisnetworks.com>
 <20201113000136.GW244516@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113000136.GW244516@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 08:01:36PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 12, 2020 at 05:06:30PM -0500, Dennis Dalessandro wrote:
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
> > > Again I'm still not seeing the race here.  It is entirely possible that the fix
> > > I was trying to do way back was mistaken too...  ;-)  I would just delete the
> > > last 2 sentences...  and/or reference the commit of those fixes and help
> > > explain this more.
> > 
> > I was attempting to refer to [1], the email that started all of this.
> > 
> > > > 
> > > > To fix this correctly we move the cached value of the mm into the mmu
> > > > handler struct for the driver.
> > > 
> > > Looking at this closer I don't think you need the mm member of mmu_rb_handler
> > > any longer.  See below.
> > 
> > We went back and forth on this as well. We thought it better to rely on our
> > own pointer vs looking into the notifier to get the mm. Same reasoning for
> > doing our own referecne counting. Question is what is the preferred way
> > here. Functionally it makes no difference and I'm fine going either way.
> 
> Use the mm pointer in the notifier if you have a notifier registered,
> it is clearer as to the lifetime and matches what other places do

I agree.  IOW, if you are storing a pointer to something you should take a
reference to it.  Here you store 2 pointers but only take 1 reference and the
user has to 'know' the lifetime is the same...

> 
> > That's the question. It does make sense to do that if we are sticking iwth
> > the notifier's reference vs our own explicit one. I'm not 100% sold that we
> > should not be doing the ref counting and keeping our own pointer. To me we
> > shoudln't be looking inside the notifer struct and instead honestly there
> > should probably be an API/helper call to get the mm from it. I'm open to
> > either approach.
> 
> The notifier is there to support users of the notifier, and nearly all
> notifier users require the mm at various points.
> 
> Adding get accessors is a bit of a kernel anti-pattern, this isn't Java..

I'm not 100% on board that a helper call is an anti-pattern, it can help to ID
that users are 'reaching into' the notifier 'object'...  That said, in this
case I would not bother.  Also you defined other helper calls which reach into
the notifier...  so FWIW you were not consistent in this patch.  That flagged
my attention in the first place...   ;-)

Ira
