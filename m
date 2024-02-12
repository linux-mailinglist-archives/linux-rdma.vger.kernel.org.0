Return-Path: <linux-rdma+bounces-1007-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14C8519EA
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546D92881DD
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6C3D39F;
	Mon, 12 Feb 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dpcuib6L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2491EEE4
	for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756337; cv=none; b=c4o6y9SA/Ku4qTmzTq2LP8GFe/EXosnZRUX8gI1Ihq3WifYdJN12ykiEsSviet+0zdSztcp7uvX4uidkTUOCFF3fvnYbUy31YWwUU46t0p2Y9DcwznEnNIuoC8TFFGvf6nsrx/i6nbckocZ/FE1jtuLO0F/WKWx0R9TolOVBuMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756337; c=relaxed/simple;
	bh=1/tWpQlnP94bVyqQ6y1OAnzH0jY7bLY7oqcu61l5nnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLlnZWMFRwBF+Dl5+4TJ9XZQjqYpCjNIdP4XMgK+i/YXzisVga6vu3WwSl3lJ7teEc5X0oi45AH0vWIpFa2tU6E6Zqd5uukrFJlaPDigQ02kLkoCBNjFxBQPZX/MBB0hyXG8lWMXCck4CHbwmgX4sIh15iZdlCt18Er5ijq29Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dpcuib6L; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a8ecbadf7so1180141eaf.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 08:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707756334; x=1708361134; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lo9XbQ7dx9SzxGHR+20HUOSS1L4JFUQtrbdrUtrYBMA=;
        b=dpcuib6LlxM6JS1Q0+S5x99eZA53oLbgFL+uEoOKMtHJ6CMw9C1GCyshj7BrTC4RkZ
         DeFHebNiADiLco4reJJ2+i630ckCYjm4WX8ZIDj4nCgxj77T2omiTRvpbzu3v3BF8nti
         akT6iYrassHcF3jjnS9/L6qW12U1H0CDOcdZ3Yjhr2sri0vHx8uNH39wyNeFYgGlKML2
         npvLe9VNPTN7TTzA+z48b0eWw1DzDiqF40SXJDCV4XZK0mAXRyPI0hPCx7xxvMJ3jh4G
         yKXcSzBL0OtzoPBP19mt3NInbHOHqIR52HO8UXmUooRA+sf2HeviLBPhdhdEm83xj//f
         ZPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756334; x=1708361134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo9XbQ7dx9SzxGHR+20HUOSS1L4JFUQtrbdrUtrYBMA=;
        b=QAs7d00go7mA+Ptuu+jC9VKfgp24I16zpSQDNcvEFQsVG9fv2HKhR+zVsEdBHQMrb6
         iN5tLprfveaJzZkuZnzY9I/1e1hPwNYRLgVGhQlMODU8VNCG61qo6hrkBTJZNY8x4jSf
         C7zDoh5QijOZZ8kJ3VE7ix8RIHIfxikMz6Ig0wluHi1wjzQCppTUEbRXI5SnZzjfRXmF
         vdRAXlUwKudEyhj2LLfwHsGu9OXQkjhcmx+0SKPzQPqpOto2/ouL1qy5/eakgvAE17zN
         m9itIGaHgy0G2CzqPJ0OMIT+JB2tP9QuVPF7icmaXWd1j2DLLX01MUoUBcLXJrd6OZVy
         EMYA==
X-Forwarded-Encrypted: i=1; AJvYcCUL+811tWvK5PKVtSqv/kqdwGQHi4hKcrjfbBXxWr1sdc5v7aQ2qYXE+VusmxSVhF0kVmrJLT64D8Dj7QaLwcv3UXhEap9PhrI+Ug==
X-Gm-Message-State: AOJu0YxOwndbcoP1GYbmgs9FVfrRZ+V1fCpK2EiWvhJRHr174GwYjggD
	3J99wuSXqCawbsEv2hWApMHij4SDkDqy5/XdfqG8RGBfy71ksURoYCwPkeX76EY=
X-Google-Smtp-Source: AGHT+IF2LbvwaU5y88dHwYscHEuYchWgDVmV0xbfELqaYKAESrr8PYDSMpMOJ+2S23S4T1yDVGxuNQ==
X-Received: by 2002:a4a:bd89:0:b0:59d:70b3:2944 with SMTP id k9-20020a4abd89000000b0059d70b32944mr453091oop.6.1707756334693;
        Mon, 12 Feb 2024 08:45:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWEsl2/uPEAKggzSsRmh5CvVJP7tc6C2fPmKM2R/qDmHn6YJAG3SCL1P7wiMGcFc4Y257N8ZIKvNl0paP3fY8mTPiS1KorciouL6V8ZbLAgec0bofY7NOoUyvdHZIUy2JQfEa6q60XklA0tPfvsfU9GzsYIUbwSHS6UbFjXx4VBL1wg/pTgXMgpvkRwGkQ659TcxRhQ505GdKLQBW1
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id c5-20020a4ab185000000b0059d6e21b605sm104456ooo.0.2024.02.12.08.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:45:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZZQz-00HaGe-EI;
	Mon, 12 Feb 2024 12:45:33 -0400
Date: Mon, 12 Feb 2024 12:45:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kevan Rehm <kevanrehm@gmail.com>
Cc: Mark Zhang <markzhang@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>, kevan.rehm@hpe.com,
	chien.tin.tung@intel.com
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
Message-ID: <20240212164533.GG765010@ziepe.ca>
References: <3CAF66C4-32E1-4258-9656-D886843D7771@gmail.com>
 <20240212133303.GA765010@ziepe.ca>
 <8BB93F6F-14EC-4B43-B1F0-5FE185A64073@gmail.com>
 <20240212144013.GD765010@ziepe.ca>
 <53992378-7BB2-4E8C-BD3F-8A2B1FC837BD@gmail.com>
 <20240212161238.GF765010@ziepe.ca>
 <0BC5DF9E-53A2-4224-8EDE-87B4F2407D56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0BC5DF9E-53A2-4224-8EDE-87B4F2407D56@gmail.com>

On Mon, Feb 12, 2024 at 11:37:39AM -0500, Kevan Rehm wrote:
> 
> 
> > On Feb 12, 2024, at 11:12 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Mon, Feb 12, 2024 at 11:04:36AM -0500, Kevan Rehm wrote:
> > 
> >> Those routines call ibv_dontfork_range on the page after it’s been
> >> allocated via posix_memalign().  _add_page() then adds the new page
> >> to the mlx5_context field dbr_available_pages.
> > 
> > Oh, if this is your trouble then upgrade your kernel. This part is
> > fixed on kernels that have working fork support.
> 
> That’s the bit that confuses me; all this is happening in user
> space, what is different in the kernel that would prevent this
> problem from occurring in user space?  Any guess as to how much
> newer a kernel must be?

Newer kernels are detected and disable the DONT_FORK calls in verbs.

rdma-core support is present since:

commit 67b00c3835a3480a035a9e1bcf5695f5c0e8568e
Author: Gal Pressman <galpress@amazon.com>
Date:   Sun Apr 4 17:24:54 2021 +0300

    verbs: Report when ibv_fork_init() is not needed
    
    Identify kernels which do not require ibv_fork_init() to be called and
    report it through the ibv_is_fork_initialized() verb.
    
    The feature detection is done through a new read-only attribute in the
    get sys netlink command. If the attribute is not reported, assume old
    kernel without COF support. If the attribute is reported, use the
    returned value.
    
    This allows ibv_is_fork_initialized() to return the previously unused
    IBV_FORK_UNNEEDED value, which takes precedence over the
    DISABLED/ENABLED values. Meaning that if the kernel does not require a
    call to ibv_fork_init(), IBV_FORK_UNNEEDED will be returned regardless
    of whether ibv_fork_init() was called or not.
    
    Signed-off-by: Gal Pressman <galpress@amazon.com>

The kernel support was in v5.13-rc1~78^2~1

And backported in a few cases.

Jason

