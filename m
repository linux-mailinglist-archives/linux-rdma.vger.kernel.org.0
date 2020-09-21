Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6BD272557
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 15:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIUN0N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 09:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgIUN0N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Sep 2020 09:26:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4818120708;
        Mon, 21 Sep 2020 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600694773;
        bh=tTWlCLjvuo1tJvYphh7kj/Nq4AvZMFZvnyz0oLuf/j8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xjmubhzU5xJnmDIB15vYqI+Q/KIwbET6YFMDxXEBcBn7irb3hplACALO32oevYLoC
         toWXE/ib2N3ZoepvP0X+w05sqW/Y6g8beQTBPOXrTLDJY0hTSpwwK6ACj9G5TjyzlE
         lgCwdz2b9RhuqxfhTmyncCaTSuiDhhQ7o4hingTo=
Date:   Mon, 21 Sep 2020 16:26:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/mlx5: fix type warning of sizeof in
 __mlx5_ib_alloc_counters()
Message-ID: <20200921132608.GD1223944@unreal>
References: <20200917082926.GA869610@unreal>
 <20200917091008.2309158-1-liushixin2@huawei.com>
 <20200917090810.GB869610@unreal>
 <20200917123806.GA114613@nvidia.com>
 <20200917170511.GI869610@unreal>
 <20200917172451.GK8409@ziepe.ca>
 <20200917173346.GK869610@unreal>
 <59dfb43f-04a7-b02a-1619-81d92ca69278@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59dfb43f-04a7-b02a-1619-81d92ca69278@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 11:23:18AM +0800, Liu Shixin wrote:
> On 2020/9/18 1:33, Leon Romanovsky wrote:
> > On Thu, Sep 17, 2020 at 02:24:51PM -0300, Jason Gunthorpe wrote:
> >> On Thu, Sep 17, 2020 at 08:05:11PM +0300, Leon Romanovsky wrote:
> >>> On Thu, Sep 17, 2020 at 09:38:06AM -0300, Jason Gunthorpe wrote:
> >>>> On Thu, Sep 17, 2020 at 12:08:10PM +0300, Leon Romanovsky wrote:
> >>>>> On Thu, Sep 17, 2020 at 05:10:08PM +0800, Liu Shixin wrote:
> >>>>>> sizeof() when applied to a pointer typed expression should give the
> >>>>>> size of the pointed data, even if the data is a pointer.
> >>>>>>
> >>>>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >>>> Needs a fixes line
> >>>>
> >>>>>>  	if (!cnts->names)
> >>>>>>  		return -ENOMEM;
> >>>>>>
> >>>>>>  	cnts->offsets = kcalloc(num_counters,
> >>>>>> -				sizeof(cnts->offsets), GFP_KERNEL);
> >>>>>> +				sizeof(*cnts->offsets), GFP_KERNEL);
> >>>>> This is not.
> >>>> Why not?
> >>> cnts->offsets is array of pointers that we will set later.
> >>> The "sizeof(*cnts->offsets)" will return the size of size_t, while we
> >>> need to get "size_t *".
> >> Then why isn't a pointer to size **?
> >>
> >> Something is rotten here
> > No problem, I'll check.
> I think cnts->offsets is an array pointer whose element is size_t rathen than pointer,
> so the patch description does not correspond.
> And I think it should be modified to sizeof(*cnts->offsets) with other description.

Sorry for me being wrong, you are right.

Thanks

> >
> >> Jason
> > .
> >
>
