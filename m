Return-Path: <linux-rdma+bounces-4210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429389489D9
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 09:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAF71F22D9A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 07:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4307166313;
	Tue,  6 Aug 2024 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Omfr31xh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E8B65C
	for <linux-rdma@vger.kernel.org>; Tue,  6 Aug 2024 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928466; cv=none; b=jjFobl4Z9Qb+h8FkUfl26bRzqaT9WVINrj6t9cUG4RGV69wzxM/3kDURVEbK7EUsbGmAjl3zLnQ3Pr+HWA8Eb43XlcbvfsLCQ78y8BDpaDAIhW9hWrZbesuHACQCqcen88dTWhPjn0Lgbx8LEW0OnSJLH3ekFGWAR0aTBtPYQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928466; c=relaxed/simple;
	bh=3E98Eu1FQ6+6jyk4/YZ+6HHm8hP2V0WB/HfY10KRV2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJsurMk/Uu5yjkdgkOMrj8iC+YnfEt9yQHpkSk0UKYofIiU2jG22MvRRcLw7OvukTGxOZCJ4v+PtoHXDOOFQOteyQmMfmsqqbSGy0qQXjNQ/PdDEmvLLLuadlXXjVN8TrmV7ATemoa1hQG7aEtOzZigye3XZyDJIYMa7m8Vm2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Omfr31xh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7ac9994b0dso2024866b.2
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2024 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722928463; x=1723533263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YoILIVGqnvyXue9wibe7yNdf+HXnnRRR2apk4zDrIOU=;
        b=Omfr31xhZ+9STHQfF8waRi781X/stfs6DNfAYfXoAxD2BEgaGKJ/yu/AnKJlJdwpkA
         VVag4UFJ+1UYd9x2vGHkG6GZlf3Vy1+zcp6KN5jGosGI8sFfZgLXvX2ReYZgeyxLzJGl
         MTd5qzW87aJ4a+hPqzbGA4mX+vODIeZ4tKtXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722928463; x=1723533263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoILIVGqnvyXue9wibe7yNdf+HXnnRRR2apk4zDrIOU=;
        b=TkAQTlSlywVI15d2XWs0EkPUzKHgfZMhv4wQIiC+VpqxN2PfoORJNI/HsJDePKoaXF
         DTQPWzCk4NUxP8ek8xPNHg3fGA/89s8s3umJqqYun7wm9b6ATnbx0pD7jKoGWopPRKWC
         AbS8jlIQEJsIYdZmyNXOucmjR9BtIu190001Gun3iemLyjpJHIV7aqAiPV58ycOy360K
         6jWhvA/giDEDknG6miKbh9ggG6N5tokuGQJOtent4a+grOnIeNduI738705VTxT6TwND
         0fSfzlVmwC54/PjRcx9OvkcHjr8L78F6UdXrXaBWoX4lfB/L7BFrHz0XqT+VxQY0cs3P
         gfLw==
X-Forwarded-Encrypted: i=1; AJvYcCVNpZcqmW/t5QVY8qBg58yzY5PrLiiiMtJW5ULK2bir/WgaG4crqP7UnwVGYy1NM7FVOC3oxPrShrrV@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWmgU25CjYbkPAF4kCammrnM2C32NkGwrGENdhoDu00/qsQBF
	h9Xd+neLGGhdBsGURxm+h7fOKvf9MLqPsh3WvuGbXJnntnWo5rt4X8Xg+UzQbM0=
X-Google-Smtp-Source: AGHT+IFt0UubU9tRXKmN+PsjgMssVL3mvxSBP75ERwo+mokToAjh3r5kkW9RxlPq16mZ3FsLBnNkIQ==
X-Received: by 2002:a17:906:bc0b:b0:a7a:9a78:4b5e with SMTP id a640c23a62f3a-a7dc50ff341mr496151166b.8.1722928463251;
        Tue, 06 Aug 2024 00:14:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80e5fsm519934866b.161.2024.08.06.00.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 00:14:22 -0700 (PDT)
Date: Tue, 6 Aug 2024 09:14:20 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	shiju.jose@huawei.com, Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <ZrHNTBJV5aybQrum@phenom.ffwll.local>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240729134512.0000487f@Huawei.com>
 <20240729154203.GF3371438@nvidia.com>
 <66a81996d4154_2142c29464@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZqiSfC5--4q2UFGk@phenom.ffwll.local>
 <20240801142223.GM3371438@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801142223.GM3371438@nvidia.com>
X-Operating-System: Linux phenom 6.9.10-amd64 

On Thu, Aug 01, 2024 at 11:22:23AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 30, 2024 at 09:13:00AM +0200, Daniel Vetter wrote:
> > I think a solid consensus on the topics above would be really useful for
> > gpu/accel too. We're still busy with more pressing community/ecosystem
> > building needs, but gpu fw has become rather complex and it's not
> > stopping. And there's random other devices attached too nowadays, so fwctl
> > makes a ton of sense.
> 
> Yeah, I'm pretty sure GPU is going to need fwctl too, the GPU's are
> going to have the same issues as NIC does. I see people are already
> struggling with topics like how to get debug traces out of the GPU FW.
> 
> > But for me the more important stuff would be some clear guidelines like
> > what should be in other more across-devices subsystems like edac (or other
> > ras features), what should be in functional subsystems like netdev, rdma,
> > gpu/accel, ... whatever else, and what should be exposed through some
> > special purpose subsystems like hwmon.
> 
> In my mind the most important part is that fwctl is not exclusive, the
> FW interface and things being manipulated must be sharable or blocked
> from fwctl. We should never get in a situation where a fwctl
> implementation becomes a reason we cannot have a functional subsystem
> interface.

Hm still not clear to me how you want to achive that, but I guess best
I'll jump over to the fwctl thread and ask about those details there.

> > We've got plenty of experience in enforcing such a community contract with
> > vendors, but the hard part is creating a clear and ideally concise
> > documentation page I can just point vendors at as the ground truth.
> 
> Well, I tried with the documentation in the fwctl patch series..
> 
> https://lore.kernel.org/linux-rdma/6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com/

I'll head over and drop some acks and comments.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

