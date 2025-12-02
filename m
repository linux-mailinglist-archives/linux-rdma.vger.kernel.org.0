Return-Path: <linux-rdma+bounces-14865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E32C9CBD9
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 20:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7048B4E2F79
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Dec 2025 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B672D6400;
	Tue,  2 Dec 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VZQ79aRn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A91F09B3
	for <linux-rdma@vger.kernel.org>; Tue,  2 Dec 2025 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703076; cv=none; b=uYpy8gcSsHxVbLj/qeI7lEkBzyCghF7rOrfS0D7nqi5yGMRo+rhl6PWlnwHnnRGGTEW2QaXN6Qq9wyhdQ6xeEjeiRCVgS/GrZF0k8l50lVY1GIEyAZlIQ49KqndWy6Qg6oNgwn+TZDcsP6+j3ov82SnQKGOl8shk6aeZODc/ep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703076; c=relaxed/simple;
	bh=kcbFNjJuTm91U5cyytq0dKIVQhkZa+v5TZFLoItEAbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE2SOxnWhVdFIJMZELPIiw9cW7D/OAw7ahfak9nCvc7n8QBeGckXuEWKpWqVhXOmTdmKTMqJaVqLJOrh2pjii0TNPCUXWZ8poxNRKwfFgE/F2CcKx8esw2PRzl/a0/op3oF7Qoq59b0Sb1Khju79GLiYH9m/Bc1Lyvs3YaaewLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VZQ79aRn; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88245cc8c92so45362216d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 02 Dec 2025 11:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764703074; x=1765307874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JGxE+S/efhMYcIgbfTS8CoVT9v6By9hamlqYQ+GXc1o=;
        b=VZQ79aRnqoYXBPMKwCXiFoENrlr4zn6/nJ4O6Da0k7EBJlSKLm0dpJw/uWZbnbCI1r
         vKFpdFn8CvmAlDZYNxx9KqJLa+b/Vpd57fe7zmpmJhR4ttKLlFlOjBbjCJpzpdX/SVGl
         L0UPrGTLy1uX2WN+AV0530lBzGm1I+EBPyJDg4EbYZYonvWPVmcIr1exC8VI8FETIPYC
         Fw23+vUVIWQjZIMg5tdsCIDgxWDi6c1yQrz89nNCDUhK/XEz4J5We1qNcgpem/yYBBdE
         N5agSNJCuCdcZQOQodRKkom9tLY1KTurURwm2oVZV92g3J6mSKsPKunk0FDcZvleJJhL
         NnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764703074; x=1765307874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGxE+S/efhMYcIgbfTS8CoVT9v6By9hamlqYQ+GXc1o=;
        b=cAwAQjvTf0vL05wV1GDBk9jJ/mFoCbw8ZQ3wmGCdFSiPUBZUJVhlM2lSeGnv5wyA1S
         +b3X0+br+gkUzlZ2m6G1l2VtckX8nilSyUiw+Mxov57VIFNQ/+qrJ2TzXcursTG8Kzib
         CbZrGnXACLKXilx0T8sS30WXrymZM4lvs8B0xndk59yMT9iNGNDhybRTk7iYOQ4Wa8yn
         7yHVznkw0m3MjQLWaiK1JjI4jZiqPWniFUMc8CV9Bblpds35EUZ2daT8OxC7rW2TYbl0
         HunkBFvJOLI+tvY3TExR0uPvDlWcqEi+h8+VxBYsbwzhAbcTXqISzUq2DMYjqQoemvWq
         hZbg==
X-Forwarded-Encrypted: i=1; AJvYcCUZBM9QJ6Z8QVfrg+F1j1d5szGCZHAFcJjJlmGVffosdu/hv3rqwxqHQaAed4wYAV8Pecxp8vRLGu5q@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZbCAAFn5bHCjRmYuWuZ0VKrudPJQqJkM8VyhRihh8zE6bGUo
	E3Dddeq2DZ6MKEIJrDkuTnhErO1aKqdG7nGQaypBP8YBLEqBCwNKWtu+q0khN0ZCXx0=
X-Gm-Gg: ASbGnctqIK4Zs+2iEAz48eJQQkGaOjbBrZttrG/4xjxY4uMjYaclGItOanF7Jslg74y
	lZ/Ut9I6AL3OhnvvxWxS2mgwqdoOGn1Vj+PPmfS87R0cjtxv6N40tAS+vOQGumVtolMqQZCwG9K
	JwjvDqlqtN9nc4bzDdRg6Kw9cxffP3rLTCLWatwlbhmrRI7jbwh4IUHmbsdjGfbIPWyE/nI4QU/
	g7uPpxgr3nlZTRxpnNAlhOFvU/0uUNMMRp0C+vK8E7z/I2dpeCeWWmZUZIFBvVJNBVKHHSMkPJh
	fbDjn9M6zOP6LS8MVpVjE/Rkcz6kk79Nf6nhmIRIHwuyyJ1Cjb48TwNVi4clWiaY2db003anRt2
	7TGN6G6+ZcWQ8XRFEDwMwKYVj0YRcaMuuhTH2X1Y2rv7VbeJP02a9R5uC4nqDPtwajalDBIzbEN
	HsSGoaXyMRq0kMCXtjtbd+8DsrKo2w1q9JduzlUWNTJYpOEul9jN+4J7AT
X-Google-Smtp-Source: AGHT+IEkzzEi6bdPBdl2QhfgFxa14qu0tatBMNGdan8YKpAzDQBKXYs/8MQtD/NGQNGy669Z3ihRug==
X-Received: by 2002:a05:6214:5bc3:b0:880:477f:88eb with SMTP id 6a1803df08f44-8863b032494mr444154406d6.66.1764703073893;
        Tue, 02 Dec 2025 11:17:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b6cc1bsm108664796d6.46.2025.12.02.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 11:17:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vQVsm-00000004tDk-2NcE;
	Tue, 02 Dec 2025 15:17:52 -0400
Date: Tue, 2 Dec 2025 15:17:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH 0/5] replaced system_unbound_wq, added WQ_PERCPU to
 alloc_workqueue
Message-ID: <20251202191752.GJ812105@ziepe.ca>
References: <20251101163121.78400-1-marco.crivellari@suse.com>
 <CAAofZF7o+hA18Eiw=F9jbXBkeFqiw__eRx74Wb41EeTE1KP5PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAofZF7o+hA18Eiw=F9jbXBkeFqiw__eRx74Wb41EeTE1KP5PA@mail.gmail.com>

On Tue, Dec 02, 2025 at 02:22:55PM +0100, Marco Crivellari wrote:
> Hi,
> 
> On Sat, Nov 1, 2025 at 5:31 PM Marco Crivellari
> <marco.crivellari@suse.com> wrote:
> > Marco Crivellari (5):
> >   RDMA/core: RDMA/mlx5: replace use of system_unbound_wq with
> >     system_dfl_wq
> >   RDMA/core: WQ_PERCPU added to alloc_workqueue users
> >   hfi1: WQ_PERCPU added to alloc_workqueue users
> >   RDMA/mlx4: WQ_PERCPU added to alloc_workqueue users
> >   IB/rdmavt: WQ_PERCPU added to alloc_workqueue users
> >
> >  drivers/infiniband/core/cm.c      | 2 +-
> >  drivers/infiniband/core/device.c  | 4 ++--
> >  drivers/infiniband/core/ucma.c    | 2 +-
> >  drivers/infiniband/hw/hfi1/init.c | 4 ++--
> >  drivers/infiniband/hw/hfi1/opfn.c | 4 ++--
> >  drivers/infiniband/hw/mlx4/cm.c   | 2 +-
> >  drivers/infiniband/hw/mlx5/odp.c  | 4 ++--
> >  drivers/infiniband/sw/rdmavt/cq.c | 3 ++-
> >  8 files changed, 13 insertions(+), 12 deletions(-)
> 
> Gentle ping.

It looks like it was picked up, the thank you email must have become lost:

5c467151f6197d IB/isert: add WQ_PERCPU to alloc_workqueue users
65d21dee533755 IB/iser: add WQ_PERCPU to alloc_workqueue users
7196156b0ce3dc IB/rdmavt: WQ_PERCPU added to alloc_workqueue users
5267feda50680c RDMA/mlx4: WQ_PERCPU added to alloc_workqueue users
5f93287fa9d0db hfi1: WQ_PERCPU added to alloc_workqueue users
e60c5583b661da RDMA/core: WQ_PERCPU added to alloc_workqueue users
f673fb3449fcd8 RDMA/core: RDMA/mlx5: replace use of system_unbound_wq with system_dfl_wq

Jason

