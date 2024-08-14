Return-Path: <linux-rdma+bounces-4355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045DA9510DD
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 02:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371DB1C22523
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C1919F;
	Wed, 14 Aug 2024 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kCsbcFME"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00038DCF
	for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593768; cv=none; b=O1sB/MUCXHY3S9KyOlc3H+lWj701K1dEPKRkl6ZSTA0BI5lUI6Mb60ogKbqgTJ70yXWL1Gh8LWV1XF9pw+ne8gKA6vaR6PlvBnm+9Uvf0ULxTh+2TYpk22RHV5lKzyX2sRIG9HARnAP0iRUdTIin72UoNCMOfl6E/yH/5rdShco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593768; c=relaxed/simple;
	bh=h8VVQ9A8DPOTqaNpNou6lHBkfb8drBFwdY+oqRSKcK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E54q386dchmWyQnaz7Jo6hz79DQac4hwHlFJft7V0cASXJr8ANxfFmkbt/H+kasIqJTeBWu2oJKk4jX8SUHHZk4TtRg+wQYrWlVjrzBareDSC8EP+oL7IuSkZ1MVHtrmUeeyFXip7enUFP/sAt8FjqHH0CfB+5xys0nkyye1ePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kCsbcFME; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1dcba8142so31992585a.0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Aug 2024 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723593766; x=1724198566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTKySPg0C0mUlZw+lpD9nr3DuGcnFr36IobOnZTiUuc=;
        b=kCsbcFMEc34zg2l2eHNpaULkZqYUY6Rwc8xGpzFLSK3f/cuXdV5J/Zny2yL+orUzZM
         WXTzb0RqF5T5musgqTDLgcrhm9QiKhnMhZNYA70NcNAlJCsUIwWCzl1ceBnnQgk6WGRt
         VNa7c3Y9huU3/Nw9Ft65mHcDe+uCzEfhOQtNhyBECjwAmaSbpiU4z2R/iUKDpcrFa8r7
         /+BQr/axP/uUuGZ0i43ElsL5eK/li3P8OSLf1J0cJnyZKUznxYSXhi6jcwkP2ce4qpfO
         IEGaHV2ULwF2ToNblk14sW61pJPpdGIqogTS/W6Rn8h+UmsxEDRTRptsl/mZ/7Nuwcof
         eQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723593766; x=1724198566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTKySPg0C0mUlZw+lpD9nr3DuGcnFr36IobOnZTiUuc=;
        b=bUyvNvy6uKThWlt5Tchmr/FTFB1MVx5jLEr8FGpG6ERgX24xiNgQCGk792ZvYmQy87
         Wx7nCWzts/lf1OAOy5/tljDFUe5NehoZ7ej1vxW/MKuRaH70x9jPrFiwF9qUAatodI0y
         hbmCGvm40I0uqmlIKthon684MTtiW67YTAfY85PpXrwqdwV9FpSDHB/xo3TGOL4DyhD/
         DvZn6pu73lxf3Q5PjrEUAbHmYa1eMzM/zxeEZiuJYNg8nDSmz3hpQBfWUtIYYvtExzlM
         DJGPiUnLpEOHoszYBe+RX4kek05treWirxBu9DsCNCt3WqmtfTffxM3Q8oYPPdDBd3tY
         AvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj6VjVkh4gk5IRIfEeowbbMmI0Ih4nIY2b1KJJv+fcmb5wZHRagUkuqrC+DCeD5ZzzeqKpr0HMEHa8ktADHaxH+ORmv3G6oc8sVA==
X-Gm-Message-State: AOJu0Yw6prdL0NxkHzrtg1gMqLFSlvi+NdgMbmbWCKSlUV8AqRYsYjiO
	OynVETJRaAtclZCUfBnGQimMaPgnXHUDiyn79uyQaOq694yZsqR7Htw4DrIiZNk=
X-Google-Smtp-Source: AGHT+IELZQfx8+xdaOH9kPY1NkPGEscrDOIVC5ILmt/1CCzfZ7mr5luUHmGWXl7b2nhzl+Os2iGU7A==
X-Received: by 2002:a05:620a:4252:b0:7a1:da10:91a with SMTP id af79cd13be357-7a4e37a6f76mr735266185a.12.1723593766145;
        Tue, 13 Aug 2024 17:02:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e115c0sm375949685a.133.2024.08.13.17.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 17:02:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1se1TR-00AVMp-3t;
	Tue, 13 Aug 2024 21:02:45 -0300
Date: Tue, 13 Aug 2024 21:02:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v5 3/4] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Message-ID: <20240814000245.GV1985367@ziepe.ca>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-4-martin.oliveira@eideticom.com>
 <ZrmuGrDaJTZFrKrc@infradead.org>
 <20240812231249.GG1985367@ziepe.ca>
 <ZrryAFGBCG1cyfOA@infradead.org>
 <20240813160502.GH1985367@ziepe.ca>
 <66bb91fbcbe66_1c18294fe@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66bb91fbcbe66_1c18294fe@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Tue, Aug 13, 2024 at 10:03:55AM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Mon, Aug 12, 2024 at 10:41:20PM -0700, Christoph Hellwig wrote:
> > > On Mon, Aug 12, 2024 at 08:12:49PM -0300, Jason Gunthorpe wrote:
> > > > > This is unfortunately not really minor unless we have a well documented
> > > > > way to force this :(
> > > > 
> > > > It is not that different from blocking driver unbind while FDs are
> > > > open which a lot of places do in various ways?
> > > 
> > > Where do we block driver unbind with an open resource?  
> > 
> > I keep seeing it in different subsystems, safe driver unbind is really
> > hard. :\ eg I think VFIO has some waits in it
> > 
> > > The whole concept is that open resources will pin the in-memory
> > > object (and modulo for a modular driver), but never an unbind or
> > > hardware unplug, of which unbind really just is a simulation.
> > 
> > Yes, ideally, but not every part of the kernel hits that ideal in my
> > experience. It is alot of work and some places don't have any good
> > solutions, like here.
> 
> ...but there is a distinction between transient and permanent waits,
> right? The difficult aspect of FOLL_LONGTERM is the holder has no idea
> someone is trying to cleanup and may never drop its pin.

It is the quite similar to userspace holding a FD open while a driver
is trying to unbind. The FD holder has possibly no idea things are
waiting on it.

Nice subsystems allow the FD to keep existing while the driver is
unplugged, but still many have to wait for the FD to close as
disconnecting an active driver from it's FD requires some pretty
careful design.

Jason

