Return-Path: <linux-rdma+bounces-5045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D6397E813
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850301F21195
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E532919415E;
	Mon, 23 Sep 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC/7T2GP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087A18F2F6;
	Mon, 23 Sep 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082151; cv=none; b=gOnKeo6tardpNhKLKXKyFPKfmqn8bDrG0tuZYDlth3u8ACJGCg0g7FHQt/fQejTl87Axol4awOuqphfEupQI7obZBMq0djlLV62kSyqqukZmlaXZIl3FKh+dkT5sWjxZ1MrWzZ9HPw2kJlWDrYdxEZpUoYCmYjtzecj5du7jNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082151; c=relaxed/simple;
	bh=nYReNpQtNv6aYEQbY/B+irqqvulEmXF1JG6ZUNt6kIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiJ6zhlOadfe9+PIsxB/f4nBvJzmQzTCqoZ7DNjFSZyLQC5NWWIuroFNnXxRKgqnlPAz4rXUWvUMcd8c0LG+N2HX8rv6rwVemL9ibIRnfnvaGXbkktle1aKxmzuhAC/YJPjCe0SaF0YG7fFzmyM3hbpJuuxhoP+pP4WWll0mMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC/7T2GP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACF9C4CEC4;
	Mon, 23 Sep 2024 09:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727082151;
	bh=nYReNpQtNv6aYEQbY/B+irqqvulEmXF1JG6ZUNt6kIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oC/7T2GPTEvBksS19Owaae6jeUBOo/Hw78fXKX9kuca/dooUsfODdwq8nHO/pwq4V
	 XynAEO5icKlxUlNg/gD3AwAPjVFM5aAyS3XL4L2j9ksu7fDO8DWw+Yh4dcf1bydg+7
	 JFnAj/KrdNbtcupEnurYihkBuGxcbTo7A1H6pV/luixAozE12+sulfmcnrG+PnIKNM
	 6TS1XWQ7jB+xFoncPsoXDwD/TIe2C5TCkzSUgBoObj/DpMo6wEnysc5YvOFaP6i9Se
	 E7o1bxo9V53Mrt6Ha77gNI3KKiVXOibCwT/E+ab/34tpdBe1+3gWC39xteT+efVDO0
	 CkcXpkDisEvLg==
Date: Mon, 23 Sep 2024 12:02:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 for-next 2/2] RDMA/hns: Disassociate mmap pages for
 all uctx when HW is being reset
Message-ID: <20240923090226.GI11337@unreal>
References: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
 <20240913122955.1283597-3-huangjunxian6@hisilicon.com>
 <20240916091323.GM4026@unreal>
 <595ec9f3-c3cd-66b3-c523-452f88e079ac@hisilicon.com>
 <Zu1u/aiOAooVUeq2@ziepe.ca>
 <24e9ec1c-8b63-f3e0-a465-80030ea6002d@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24e9ec1c-8b63-f3e0-a465-80030ea6002d@hisilicon.com>

On Mon, Sep 23, 2024 at 02:17:40PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/9/20 20:47, Jason Gunthorpe wrote:
> > On Fri, Sep 20, 2024 at 05:18:14PM +0800, Junxian Huang wrote:
> > 
> >>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> >>>> index 4cb0af733587..49315f39361d 100644
> >>>> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> >>>> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> >>>> @@ -466,6 +466,11 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
> >>>>  	pgprot_t prot;
> >>>>  	int ret;
> >>>>  
> >>>> +	if (hr_dev->dis_db) {
> >>>
> >>> How do you clear dis_db after calling to hns_roce_hw_v2_reset_notify_down()? Does it have any locking protection?
> >>>
> >>
> >> Sorry for the late response, I just came back from vacation.
> >>
> >> After calling hns_roce_hw_v2_reset_notify_down(), we will call ib_unregister_device()
> >> and destory all HW resources eventually, so there is no need to clear dis_db.
> > 
> > Why can't you do the unregister device sooner then and avoid all this
> > special stuff?
> > 
> 
> It's a limitation of HW. Resources such as QP/CQ/MR will be destoryed
> during unregistering device. This is not allowed by HW until
> hns_roce_hw_v2_reset_notify_uninit(), or it may lead to some HW errors.

It is interested claim given the fact that you are changing original
code from 2016.

Thanks

> 
> > I assumed you'd bring the same device back after completing the reset??
> > 
> 
> Yes
> 
> > Jason
> 

