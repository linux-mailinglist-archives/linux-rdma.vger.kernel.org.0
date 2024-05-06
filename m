Return-Path: <linux-rdma+bounces-2298-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0488BD157
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 17:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC651C22D74
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D31A155A24;
	Mon,  6 May 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eWGGKiES"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158FF15575E
	for <linux-rdma@vger.kernel.org>; Mon,  6 May 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008277; cv=none; b=AFXsSQ3KwWrrwznP7W+fWuIDdPMBe6BhJ5HNbRTCb4HI+yIO+f1yOwgQZUJbLhddZ+i6e8jOxuBvu44ue2mWkqD/VhuCc/9Jfzij90IdiVjXM4OXY11pXJNzxfNsDXSDljHRLTMMySKR8du9rXRXt2GqW6xv+D24Rj43NbfXRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008277; c=relaxed/simple;
	bh=H8vt6scH7BoMUK/SlOWE4m46KlKCzDhGUHOMEm3175I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWV5uYTDXffW0rHz2kEVCVbseOcwmxyiY5O6rBGdSPZ0nvx1V6qsRYjMO7TOaW/Buicm19aURiL2BHfYdbPgqe5o0jo9PfbYgeh826JfJ64qtSWwokgjrSyyiNmsWo1QkpFqO9TIZsUQEz57TgQ0liNdbz1rPoL71Q8JtJueDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eWGGKiES; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9741777f0so195628b6e.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2024 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715008275; x=1715613075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBh6+cizIio2X4bEih+MrNlX8KtZG6Oq+pv2Gn+dV+M=;
        b=eWGGKiESrk19T+Ves+3x1o2gjEC9rEOaaeLe2D7bPP+/gicUlm58z8I7XF8MmyHoSf
         7fVRw4S7IQ6xiL7R1riB6+gfm56SQjawGZAoEinkNDRrIruh2aHanxMXgZZ//CJhTxd6
         hTV45sOCFQlHPOkkN4fkkWh8fx3K3pwGVScZbnHrLzIKrB1Wf1o+j/a1OFYjYjp+JY7X
         f5lQ11b/QBGqTX1I0STzEgXLYMvGlobA4rrYpCRMF4X92P1wJBv6r4ZhLKP6kGCHSjoP
         Ou0gHoBczXXrWNi5nXT8nlDG54r7PaCmz9fkpGkKy1bm7/h3dnJkCqm6X+0a3Yaw/oJO
         TdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715008275; x=1715613075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBh6+cizIio2X4bEih+MrNlX8KtZG6Oq+pv2Gn+dV+M=;
        b=Ru0bln9xpCYph9d11swYbRE7EJrDPoUNWgwKRgK8l4dZ3oyJypgmhVWLNTt2PLwb/J
         Z3cOGIC5XrS5Lyi1wzB8CzvBYZ1CUfwDjwpjPdZUVUD2NwTBVGq4ESxfD5yeYhyxdg7D
         ubvU/qDfqSTwpTysUrm2zIMuSe/HFgkm1vyDVGsDdLl+qvSMxDDQfS3vjbghrPsHhPbV
         bp537YwbavD/Hf6SB+saVNmWJcb9gEDjhIaxXQVJRepMvtpVJz2hJ/KCPx9GJx008LgA
         DY7Xnx+Nur9DGFlwbfqgLruqE20KvwCyFNoriqNOaoambUN5HZWQ52ivm4nMS33bEJ0V
         ehAg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1qgn8T92xAsh3xjc2WG8RuVW1FW9QUqYjahAM4HdnYkE6rcShZH8tZCVb5A1l2byY63ysNAmJafEKE7/FICSE0gtvG3SrLxDbA==
X-Gm-Message-State: AOJu0Ywd3isa8kiVO8oyXClMFxmytikVWqJnP+np4Ci6QCbUqSOGiNaL
	RlefqVQRNjbhlMf9o6ySqYVaqTuKHAYNA06cDvCP0U81dlDWu/7E8eShyl2JdE8=
X-Google-Smtp-Source: AGHT+IEVepJmR8F9MxalDoDb4b2ghxl9gZ1j9Wv3ingZbviU6bGlG8g1H0c1OFxGShUhmkGpG4Qskg==
X-Received: by 2002:a05:6808:b24:b0:3c9:6fad:25cd with SMTP id t4-20020a0568080b2400b003c96fad25cdmr2492419oij.22.1715008274880;
        Mon, 06 May 2024 08:11:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id k12-20020a54440c000000b003c7443c0efasm1450390oiw.1.2024.05.06.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:11:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s3zzk-002y7a-R6;
	Mon, 06 May 2024 12:11:12 -0300
Date: Mon, 6 May 2024 12:11:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chengchang Tang <tangchengchang@huawei.com>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>, leon@kernel.org,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support flexible WQE buffer page size
Message-ID: <20240506151112.GE901876@ziepe.ca>
References: <20240430092845.4058786-1-huangjunxian6@hisilicon.com>
 <20240430134113.GU231144@ziepe.ca>
 <fac4927b-16ed-d801-fb47-182f2aca355c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fac4927b-16ed-d801-fb47-182f2aca355c@huawei.com>

On Mon, May 06, 2024 at 02:47:01PM +0800, Chengchang Tang wrote:
> 
> 
> On 2024/4/30 21:41, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 05:28:45PM +0800, Junxian Huang wrote:
> >> From: Chengchang Tang <tangchengchang@huawei.com>
> >>
> >> Currently, driver fixedly allocates 4K pages for userspace WQE buffer
> >> and results in HW reading WQE with a granularity of 4K even in a 64K
> >> system. HW has to switch pages every 4K, leading to a loss of performance.
> > 
> >> In order to improve performance, add support for userspace to allocate
> >> flexible WQE buffer page size between 4K to system PAGESIZE.
> >> @@ -90,7 +90,8 @@ struct hns_roce_ib_create_qp {
> >>  	__u8    log_sq_bb_count;
> >>  	__u8    log_sq_stride;
> >>  	__u8    sq_no_prefetch;
> >> -	__u8    reserved[5];
> >> +	__u8    pageshift;
> >> +	__u8    reserved[4];
> > 
> > It doesn't make any sense to pass in a pageshift from userspace.
> > 
> > Kernel should detect whatever underlying physical contiguity userspace
> > has been able to create and configure the hardware optimally. The umem
> > already has all the tools to do this trivially.
> > 
> > Why would you need to specify anything?
> > 
> 
> For hns roce, QPs requires three wqe buffers, namely SQ wqe buffer, RQ wqe
> buffer and EXT_SGE buffer.  Due to HW constraints, they need to be configured
> with the same page size. The memory of these three buffers is allocated by
> the user-mode driver now. The user-mode driver will calculate the size of
> each region and align them to the page size. Finally, the driver will merge
> the memories of these three regions together, apply for a memory with
> continuous virtual addresses, and send the address to the kernel-mode driver
> (during this process, the user-mode driver and the kernel-mode driver only
> exchange addresses, but not the the sizes of these three areas or other
> information).

So you get a umem and the driver is slicing it up. What is the
problem? The kernel has the umem and the kernel knows the uniform page
size of that umem.


> Since the three regions share one umem, through umem's tools, such as
> ib_umem_find_best_pgsz(), they will eventually calculate the best page size
> of the entire umem, not each region. 

That is what you want, you said? Each region has to have the same page
size. So the global page size of the umem is the correct one?

> For this reason, coupled with the fact
> that currently only the address is passed when the kernel mode driver interacts
> with the user mode driver, and no other information is passed, it makes it more
> difficult to calculate the page size used by the user mode driver from the
> kernel mode driver. 

Even if it is difficult, this has to be done like this. You can't pass
a page size in from userspace, there is no good way for userspace to
do this correctly in all cases.

It sounds like you have it right, just get the page size from the
shared umem.

Jason

