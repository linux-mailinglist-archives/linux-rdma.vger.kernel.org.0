Return-Path: <linux-rdma+bounces-2323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B5F8BE93F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 18:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADD3290475
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A84916F901;
	Tue,  7 May 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hOO5Hih0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401FE16F8FC
	for <linux-rdma@vger.kernel.org>; Tue,  7 May 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099572; cv=none; b=g4U6sLrklfrCyshGMUmZjygrmkT+H+zxAoB7EfQjHCrPzKg8Zqr2zpuzrPzXyMV3Kfu2Yi98E/Ia79BO86toNNHsenCNtPrNDVY+c07NPk5ecujAyKcBMUEdFAcAeEV5EAyfzxuW3fEb0gS9b1NElh/web1jx0Ir3Z4nqs4fLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099572; c=relaxed/simple;
	bh=INO18z6SJx/Dr+S34QqbaN/w/rfUx+1L32KrTlJnvkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTMbz9wPRzPs1gMXGIHDC7Ppo1VBLTkuyrJq+nFcV0Nu1x+lNGDu6eHOrFYbx3LDqqd6vtwNDJ02HxcS46F+xo+YGQNzQOE36kfsQjPLZY4tJ4uSSB5MyxOZlCV7XYMl5pwNP3kCXZIonPG8ehJ7rG5rG24P8gZoBHDM0fGZZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hOO5Hih0; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43692353718so23925891cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2024 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715099570; x=1715704370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3usll03FDHPZWd9FujWnxwiyYaIOSwPotfuY0Jbl8qg=;
        b=hOO5Hih0+CJanjUSqCScPmU0AhqeYUIDRa4KUje0deekkQiaQ/O4EZmROCC8+9JIe2
         1OHgh5ohfGq4slP74+YFdUQYgDyt9AqGb9unAL3OIFpVu9P7ve0UzeN1dqeGZTHYuz/y
         UpNnfRm6vXtQoitldHzkSqiNWb8iPfNBOzXKkhQVwryteEmt/gpKTUWzOF/UzOpblHY4
         ntWR/nVw3oHhzHVJdCGGxCARCkRxYH9YHhf2FyC2y1zcL+YetPSh5KW2GV+V39TWRM18
         386Drvb9Qj+wDG5FD12w6G6o0TJMO5nFecarpR55zax4lbQ87Q5kLeXnxxCxEC49hEc7
         1pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099570; x=1715704370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3usll03FDHPZWd9FujWnxwiyYaIOSwPotfuY0Jbl8qg=;
        b=lZWtwZWQbr/VOL57XoO1pspy/UpNrDR9L8/tgzF/+/K+2yNqfb4/I2jsO5thsxbUPp
         Dv7vJKZVBMSjFEuSBvyaZPIJVrH6eI5bD+CpGYsWGvmUxkvFdTz3rregeoUrFYuo1axe
         tw4Gmlct5eIsvXZWBai55EZi0g+1GZxqz1sr/cZcQVVcumJ4qOpujC7PBBWk1wDat4ss
         7uxe+BnxF2K/ZJggRYLfJKOx8BBUf3glbj+OhlsHur/f8+uzroSUoYEtcq+1oT0EHGcy
         zcxqszoehOB+GjbbVph3+tpjIGlmfvdez7MGefYM/dxg3tjzKexN9WL8nYITbC+N690Y
         nqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9YCHoRql038HFG4YQnXqo/zUIJgKqIMrhEaBMMHQjDX0Ri4W4jBQFIWMug2NrWI+ZTh6W7UwkpR30985qrLGBLvFC6ZRLUdb28w==
X-Gm-Message-State: AOJu0Yzi+Jzcla/wHtL59Fh3yTS4zj/TaBW+HJp0PqHsjSC05ki9tk36
	rIRQNKekItOtVfG9st1yfDMX060m5XaxmngTq0LpT7m7dmDfiLhnEt4eJBBo5lo=
X-Google-Smtp-Source: AGHT+IEVdKMvS511ivAUPzsNDKcXaQL0tOLii6Z6QF8GZNpaDsJGDdSWqwDkZn25pxUr0kBFb7C/uA==
X-Received: by 2002:a05:622a:5808:b0:439:f88a:91c9 with SMTP id d75a77b69052e-43dbf515a55mr2474111cf.26.1715099570187;
        Tue, 07 May 2024 09:32:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ck12-20020a05622a230c00b0043aed0b8302sm6570768qtb.61.2024.05.07.09.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:32:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4NkG-0001UO-Mm;
	Tue, 07 May 2024 13:32:48 -0300
Date: Tue, 7 May 2024 13:32:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chengchang Tang <tangchengchang@huawei.com>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>, leon@kernel.org,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support flexible WQE buffer page size
Message-ID: <20240507163248.GD4718@ziepe.ca>
References: <20240430092845.4058786-1-huangjunxian6@hisilicon.com>
 <20240430134113.GU231144@ziepe.ca>
 <fac4927b-16ed-d801-fb47-182f2aca355c@huawei.com>
 <20240506151112.GE901876@ziepe.ca>
 <90d51f0f-724f-fbba-9519-1c022c65c5e2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d51f0f-724f-fbba-9519-1c022c65c5e2@huawei.com>

On Tue, May 07, 2024 at 10:21:09PM +0800, Chengchang Tang wrote:
> 
> 
> On 2024/5/6 23:11, Jason Gunthorpe wrote:
> > On Mon, May 06, 2024 at 02:47:01PM +0800, Chengchang Tang wrote:
> >>
> >>
> >> On 2024/4/30 21:41, Jason Gunthorpe wrote:
> >>> On Tue, Apr 30, 2024 at 05:28:45PM +0800, Junxian Huang wrote:
> >>>> From: Chengchang Tang <tangchengchang@huawei.com>
> >>>>
> >>>> Currently, driver fixedly allocates 4K pages for userspace WQE buffer
> >>>> and results in HW reading WQE with a granularity of 4K even in a 64K
> >>>> system. HW has to switch pages every 4K, leading to a loss of performance.
> >>>
> >>>> In order to improve performance, add support for userspace to allocate
> >>>> flexible WQE buffer page size between 4K to system PAGESIZE.
> >>>> @@ -90,7 +90,8 @@ struct hns_roce_ib_create_qp {
> >>>>  	__u8    log_sq_bb_count;
> >>>>  	__u8    log_sq_stride;
> >>>>  	__u8    sq_no_prefetch;
> >>>> -	__u8    reserved[5];
> >>>> +	__u8    pageshift;
> >>>> +	__u8    reserved[4];
> >>>
> >>> It doesn't make any sense to pass in a pageshift from userspace.
> >>>
> >>> Kernel should detect whatever underlying physical contiguity userspace
> >>> has been able to create and configure the hardware optimally. The umem
> >>> already has all the tools to do this trivially.
> >>>
> >>> Why would you need to specify anything?
> >>>
> >>
> >> For hns roce, QPs requires three wqe buffers, namely SQ wqe buffer, RQ wqe
> >> buffer and EXT_SGE buffer.  Due to HW constraints, they need to be configured
> >> with the same page size. The memory of these three buffers is allocated by
> >> the user-mode driver now. The user-mode driver will calculate the size of
> >> each region and align them to the page size. Finally, the driver will merge
> >> the memories of these three regions together, apply for a memory with
> >> continuous virtual addresses, and send the address to the kernel-mode driver
> >> (during this process, the user-mode driver and the kernel-mode driver only
> >> exchange addresses, but not the the sizes of these three areas or other
> >> information).
> > 
> > So you get a umem and the driver is slicing it up. What is the
> > problem? The kernel has the umem and the kernel knows the uniform page
> > size of that umem.
> 
> Currently, because the user-mode driver and the kernel-mode driver only
> exchange addresses, from the perspective of the kernel-mode driver, if the
> page size is not negotiated, it cannot even calculate the size of each region,
> and thus cannot complete ib_umem_get().

That seems like what you should correct instead of sending in a page
shift.

> Of course, we can add some information to be passed to the kernel mode driver,
> such as size and offset of each region, but is there any essential difference
> between this and directly passing page shift?

Yes, userspace can reliably compute the start, length and any
offsets. It cannot reliably compute any sort of page size for DMA.

> >> Since the three regions share one umem, through umem's tools, such as
> >> ib_umem_find_best_pgsz(), they will eventually calculate the best page size
> >> of the entire umem, not each region. 
> > 
> > That is what you want, you said? Each region has to have the same page
> > size. So the global page size of the umem is the correct one?
> 
> No, the global page size may be bigger than the page size of each region.
> If we use the global page size, the hardware may have out-of-bounds
> access.

Because the page size may be the entire umem?

But this is simple to deal with, the API even has it built in. Just be
sure to limit the page size bit map to only include sizes you can
handle based on the smallest sub region and possibly region
alignment. It should be a couple of bit ops.

> > Even if it is difficult, this has to be done like this. You can't pass
> > a page size in from userspace, there is no good way for userspace to
> > do this correctly in all cases.
> 
> Userspace may indeed go wrong, but in the current scenario, the page size is
> only set within the allowed range [4k, 64k], and its errors only affects the
> current QP. Is this acceptable?

It is bad uAPI design to allow for such a failure mode.

Jason

