Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6599E145B3
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 10:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEFIEm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 04:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFIEm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 04:04:42 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CA3220830;
        Mon,  6 May 2019 08:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557129881;
        bh=hsloVYxcq60qbRtHc9scXXcAMlVTSKnLa/8/HnYtc+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wC3Z7T8qsccmQP6+YDtskcyCOl3QciHZi8CNirvmO+LlDpJ7AbcyKupauw0j9X1o8
         R2xxqy25FDR5hz5y8KQGcK6+JPxsDUsJhMH2zzrv1x/H5dQPZwMMSe3+g7Q4zIgK2I
         sAgwYMVWBIVlekCIPEEjfRMK+tG3aJxjeFLQf2Kg=
Date:   Mon, 6 May 2019 10:37:45 +0300
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
Message-ID: <20190506073745.GK6938@mtr-leonro.mtl.com>
References: <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190501164020.GA18128@mellanox.com>
 <75f5ded6-ba85-bd67-1a2f-92525f7a6e28@amazon.com>
 <20190502084600.GQ7676@mtr-leonro.mtl.com>
 <20190502174722.GD27871@mellanox.com>
 <f77f2b44-27d7-f8e2-311e-57b5a89d3ed2@amazon.com>
 <20190503122114.GD13315@mellanox.com>
 <b803ae84-669f-62e5-f230-d671becdac85@amazon.com>
 <20190505123721.GC30659@mellanox.com>
 <5b90e589-ade0-367a-0919-484ffd9b5d33@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b90e589-ade0-367a-0919-484ffd9b5d33@amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 09:25:05AM +0300, Gal Pressman wrote:
> On 05-May-19 15:37, Jason Gunthorpe wrote:
> > On Sun, May 05, 2019 at 10:36:36AM +0300, Gal Pressman wrote:
> >> On 03-May-19 15:21, Jason Gunthorpe wrote:
> >>> On Fri, May 03, 2019 at 12:32:58PM +0300, Gal Pressman wrote:
> >>>> On 02-May-19 20:47, Jason Gunthorpe wrote:
> >>>>> On Thu, May 02, 2019 at 11:46:00AM +0300, Leon Romanovsky wrote:
> >>>>>> On Thu, May 02, 2019 at 11:28:40AM +0300, Gal Pressman wrote:
> >>>>>>> On 01-May-19 19:40, Jason Gunthorpe wrote:
> >>>>>>>> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> >>>>>>>>
> >>>>>>>>> +int efa_mmap(struct ib_ucontext *ibucontext,
> >>>>>>>>> +	     struct vm_area_struct *vma)
> >>>>>>>>> +{
> >>>>>>>>> +	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
> >>>>>>>>> +	struct efa_dev *dev = to_edev(ibucontext->device);
> >>>>>>>>> +	u64 length = vma->vm_end - vma->vm_start;
> >>>>>>>>> +	u64 key = vma->vm_pgoff << PAGE_SHIFT;
> >>>>>>>>> +	struct efa_mmap_entry *entry;
> >>>>>>>>> +
> >>>>>>>>> +	ibdev_dbg(&dev->ibdev,
> >>>>>>>>> +		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
> >>>>>>>>> +		  vma->vm_start, vma->vm_end, length, key);
> >>>>>>>>> +
> >>>>>>>>> +	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
> >>>>>>>>> +		ibdev_dbg(&dev->ibdev,
> >>>>>>>>> +			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
> >>>>>>>>> +			  length, PAGE_SIZE, vma->vm_flags);
> >>>>>>>>> +		return -EINVAL;
> >>>>>>>>> +	}
> >>>>>>>>> +
> >>>>>>>>> +	if (vma->vm_flags & VM_EXEC) {
> >>>>>>>>> +		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitted\n");
> >>>>>>>>> +		return -EPERM;
> >>>>>>>>> +	}
> >>>>>>>>> +	vma->vm_flags &= ~VM_MAYEXEC;
> >>>>>>>>
> >>>>>>>> Also we dropped the MAYEXEC stuff
> >>>>>>>
> >>>>>>> Latest commit that had any MAYEXEC changes is 4eb6ab13b991 ("RDMA: Remove
> >>>>>>> rdma_user_mmap_page"), where MAYEXEC is added not removed.
> >>>>>>> Am I missing a followup patch?
> >>>>>>
> >>>>>> I'm not aware of any.
> >>>>>
> >>>>> It was a mistake it wasn't removed from that commit too.
> >>>>
> >>>> Can you explain please?
> >>>
> >>> We dropped all the MAYEXEC stuff and that case got missed - it should
> >>> have been dropped too
> >>
> >> Why is MAYEXEC not needed?
> >
> > There was a big thread about it.. It currently breaks userspace that
> > uses GNU_STACK=RWX
>
> Thanks, I can send a fix to mlx5 and efa but I need more information for a
> proper commit message. Do you have a link to this thread?

I'll handle mlx5 part.

Thanks
