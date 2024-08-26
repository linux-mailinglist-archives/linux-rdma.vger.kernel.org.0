Return-Path: <linux-rdma+bounces-4576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3695FDD9
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 01:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C181F20F28
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 23:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79719CD17;
	Mon, 26 Aug 2024 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HTM0zG1T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3BA13D291
	for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2024 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724715934; cv=none; b=REV3s3ODtlRWeipyBGag8AB5n8NftJKl1kAHyPXXuvgk36B4kciSNaQsAcUM2TgNxl198/H+DWChwX5PPEnJftMTZ0UtmkD/JO4VaFfxqdTBRBwUZTpTRYrp0yvmpMUmH1VuvYe3H6ONBb2XQ2CBW9Bdtj333GiJoPAW55J3a3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724715934; c=relaxed/simple;
	bh=vqZxLyIYwvOL7VofEWqLnPBg2kNsVlrEwKKqyU22uHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBwh3+w0nlxvbOdfH6jq3b7r5+qr+K2UwhMSco/ZujS8h2tS7DP2D9O7zThH+a3ImuRltMBJVfRKOxkowJyoaAh9Efwd7k141opmoOlLbhnTr67snjapyOB5K1hLuIaKNI8kKvjHMkHkB4qEj4NAGkktNH2zttiuRDbfTMBV3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HTM0zG1T; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a7d7ec7395so82056485a.3
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2024 16:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724715931; x=1725320731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lDuuNQ8/bu29BjzK9PteMZCVxgPOE2AxKbk9lTfYggQ=;
        b=HTM0zG1TAEakjLOil8Py3eNjoG5c6JNo9FFi5bHkUFS0Z0hApXFCTCuFEM5uv/MOZS
         BIaUfZZXw8AWpq+//8KMCnI1MDj7efhqimRoVjlO13+jaPZP+RonWK+jjvfsBHHqhWA5
         0XjztpiB6bZsNPqTB9WmB63Qt1YL51+LR0PD4rg81N9bLoDX+ZhJ92tMs16HxPbUjLmC
         csIUwLy3ApjmUQ0njAetuC24LGe95I8de8UagiBnRzohoB7uTmF7bVc4Ect+JoArz5gF
         U658thZh/AIXem3YOLb0PmPrTH2YfYrAYKx2LtuQ/dnoMhB9t6r/xE7pOHnICXIoTyEi
         sz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724715931; x=1725320731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDuuNQ8/bu29BjzK9PteMZCVxgPOE2AxKbk9lTfYggQ=;
        b=b12YuQZlTDNyWJ0nA7/4aq4g+uvqdiN/LBDT+dSAiGYWdjxveWVB2Ln0GBSc7OtpTB
         R5NszvhVreUv/87h298/k9UmSJz00xpfkFR8KRflV6rQ+4FLG0nCA5g8dck8Z1LrJ2dm
         ny7odFJw/De5B2cK8oVC96F5y0joK+8IcT9iCDjMph5YdBhvCiVhjsampQ44liswlfGw
         iLKRRyJ/ooQz2aHswEa5YlpJePOz0gL8jkNgGqMU1AN+siAcmIN1i8vRh+cpAMRft/nD
         eC5A+PhzLVNlk7N/GkWJdiIwxuYSeWwk7/6zBLEVs0rhWjFFH3bVRv37mHDvm+10+pAJ
         Aa4A==
X-Forwarded-Encrypted: i=1; AJvYcCVKIWQJs3s3WKPDTgya3/wqw4HuB7+RD4gwUho9qRCw5q9dIOQHsGTDdv9NxEklsP0c5gVPHaePCIT2@vger.kernel.org
X-Gm-Message-State: AOJu0YxG475Sp1ENOe7LHNi0jSp0pLGg/MSS7ulxMpdd3EH8CNb0626F
	bjOZ5EFC6WApBp97b2vZzGtJ3cIEvqe5/IES3Xl+dvVihawulyxS77I/8lXRp0Y=
X-Google-Smtp-Source: AGHT+IHzaXl2WmXOTOiigwMW4vAHbvohhbDK0cgaRu+I2GIwQhZXzz+hJUacz877ZzUojnA/oSOOuQ==
X-Received: by 2002:a05:6214:4381:b0:6c1:6a2e:afc6 with SMTP id 6a1803df08f44-6c16dc36d53mr143333916d6.15.1724715931544;
        Mon, 26 Aug 2024 16:45:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd5bfsm50953946d6.110.2024.08.26.16.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 16:45:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sijOs-00El7B-CY;
	Mon, 26 Aug 2024 20:45:30 -0300
Date: Mon, 26 Aug 2024 20:45:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Miller <doug.miller@cornelisnetworks.com>,
	linux-remoteproc@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Using RPMSG to communicate between host and guest drivers
Message-ID: <20240826234530.GK3468552@ziepe.ca>
References: <133c1301-dd19-4cce-82dc-3e8ee145c594@cornelisnetworks.com>
 <842aef7f-d6e1-490a-97b9-163287ddfe2d@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842aef7f-d6e1-490a-97b9-163287ddfe2d@cornelisnetworks.com>

On Mon, Aug 26, 2024 at 12:27:02PM -0400, Dennis Dalessandro wrote:
> On 7/31/24 4:02 PM, Doug Miller wrote:
> > I am working on SR-IOV support for a new adapter which has shared 
> > resources between the PF and VFs and requires an out-of-band (outside 
> > the adapter) communication mechanism to manage those resources. I have 
> > been looking at RPMSG as a mechanism to communicate between the driver 
> > on a guest (VM) and the driver on the host OS (which "owns" the 
> > resources). It appears to me that virtio is intended for communication 
> > between guests and host, and RPMSG over virtio is what I want to use.
> > 
> > Can anyone confirm that RPMSG is capable of doing what we need? If so, 
> > I'll need some help figuring out how to use that from kernel device 
> > drivers (I've not been able to find any examples of doing the 
> > service/device side). If not, is there some other facility that is 
> > better suited?
> 
> Hi Bjorn and Mathieu, any advice here for Doug? Adding linux-rdma folks as that
> is where this will eventually target.

Typically in cases like this you'd paravirtualize some of the VF
before sticking it in the VM so that there is a tidy channel between
the VF driver and the VMM to do whatever this coordination is. There
are many examples, but it is hard to see if you don't know the device
architectures in detail.

If you stick it in seperate virtio PCI device you'll have hard
problems co-ordinating the two drivers.

Jason

