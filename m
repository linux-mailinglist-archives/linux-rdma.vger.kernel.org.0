Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6C115AF
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 10:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfEBIqF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 04:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfEBIqF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 04:46:05 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0752075E;
        Thu,  2 May 2019 08:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556786764;
        bh=fMuQlZH+b6Ev5/ZMpjHsXbisyubSUEkPIXvpahminxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fiJ4SOMdlPBb79AMrYr2qEf8SULezX/Y9y3D3chJVvA0rN0EseINPucaEw3DnYswR
         IIgx9QPqgM2doCqAwWlwkYmUTH+w196ERxbUNX14uBuYTKChav6H2iUjMxLU7OqTHY
         iEwWZsYz8RtcFqQ8mTneLUnW2huUEsmJgVNSZqtw=
Date:   Thu, 2 May 2019 11:46:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Message-ID: <20190502084600.GQ7676@mtr-leonro.mtl.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190501164020.GA18128@mellanox.com>
 <75f5ded6-ba85-bd67-1a2f-92525f7a6e28@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f5ded6-ba85-bd67-1a2f-92525f7a6e28@amazon.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 02, 2019 at 11:28:40AM +0300, Gal Pressman wrote:
> On 01-May-19 19:40, Jason Gunthorpe wrote:
> > On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> >
> >> +int efa_mmap(struct ib_ucontext *ibucontext,
> >> +	     struct vm_area_struct *vma)
> >> +{
> >> +	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
> >> +	struct efa_dev *dev = to_edev(ibucontext->device);
> >> +	u64 length = vma->vm_end - vma->vm_start;
> >> +	u64 key = vma->vm_pgoff << PAGE_SHIFT;
> >> +	struct efa_mmap_entry *entry;
> >> +
> >> +	ibdev_dbg(&dev->ibdev,
> >> +		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
> >> +		  vma->vm_start, vma->vm_end, length, key);
> >> +
> >> +	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
> >> +		ibdev_dbg(&dev->ibdev,
> >> +			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
> >> +			  length, PAGE_SIZE, vma->vm_flags);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (vma->vm_flags & VM_EXEC) {
> >> +		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitted\n");
> >> +		return -EPERM;
> >> +	}
> >> +	vma->vm_flags &= ~VM_MAYEXEC;
> >
> > Also we dropped the MAYEXEC stuff
>
> Latest commit that had any MAYEXEC changes is 4eb6ab13b991 ("RDMA: Remove
> rdma_user_mmap_page"), where MAYEXEC is added not removed.
> Am I missing a followup patch?

I'm not aware of any.

Thanks
