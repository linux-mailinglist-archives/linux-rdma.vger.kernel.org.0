Return-Path: <linux-rdma+bounces-2004-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDF8AD356
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 19:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECB228344A
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E590153BF4;
	Mon, 22 Apr 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iM19m2Am"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383C146A6A
	for <linux-rdma@vger.kernel.org>; Mon, 22 Apr 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713807349; cv=none; b=LC1YFYQvC6UqHxMaYOg1Vg1A8o858A6kDlhGCNL2tU0m+aOLa1VOo/10HN+rVOVuKSZ6pQDATMbOHQw5TdNPR2iDs9Wk665oR19kRjH7LGl+7BDlcUbVhbtnpdyF90FV3eL6Ba3uOJHFb4Ozc4tPu67bJyU0q+lB2R6Cri7DkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713807349; c=relaxed/simple;
	bh=fQ+RSPrRbkVE7QdGSNojzW1XEfrlFEsqKgx2Vk5asHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1kIiA37CC1y3AQn7+SGYB9Zn2Ub8s08mfi3PaSZN4mFOsrFdohpHXfuCubhepd+AKBXKU/lZhvcZ2rw24CTQ0C+Nejl9joE4/HsHVqrv2YPOAc5OJnzoZRcG/epM5oN6LbMWsnaKlBeHnNw9//h2X/XRAJguftTuYWfGYIS45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iM19m2Am; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78efd0fcec4so306826185a.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Apr 2024 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713807345; x=1714412145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lFzQ5ZbTqQaKmQBwqezEp5FAm5/GgH6WPCnR+KjYok=;
        b=iM19m2AmEbc2vR5kk4Ug0MqhrufJfVHsICVtZPuDNEcJVbdU0BjXD0lgWawEsrpFlj
         SmyUDtwJ5GLif5LOBfZyos2dWjt9PDeEV/f6ObshzvX8QuNg3rpB6wA99GKjEgkYVNEX
         A1aDbjp/eKSMTLWQc4FozfZceB45TnlPNEUpX+sc7D3ng5rjtmP9jbiglXVp9MkzjSJB
         6GtujYYjkviK5gdGT5G3dAzRDc7pn3EkYiPqVZ9uGniEpfPEt9sJ1dYqYYpaGZ73ekNx
         yzYWqrIM0/MDPnOJoep+E37lpzKtWYe9y1urFMXjPVhFo4Myd68w7VFMXqDwLvKqBdtC
         6LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713807345; x=1714412145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lFzQ5ZbTqQaKmQBwqezEp5FAm5/GgH6WPCnR+KjYok=;
        b=eS6gYGasfYYQvHYlK/7zYJ63TN1SI653PBJ19pTihDoe6rADsRGavC4FWgZsuogR7T
         z+YviZ6SJbDlkV1bqd4mM7KoBlmHKv/thaNVK+7I7Pkkesvlpt/sxWK+HDhFWIOak2lJ
         MkP/V9+z9Tzrwf0Wqws9MhCXclGs5ES5ESgsPgkXMjP+enshRAAvbRN8U9nrQe4OYxg8
         bewrup5a/88PCTqIVfJLleKUErEjqLfrmIaq90JmwrEiKhXzvXeQ+KX6l4W3dRfdWgC9
         d4j2lSrThYs1seiSGwwxUKc4E1jRUIQXQuAUUbgWpiJ6kXabL37Ng4TSFPUYjbieB4ya
         qhiw==
X-Forwarded-Encrypted: i=1; AJvYcCWAMi+2+wCuJDN0I2ZAIBe9FxKj9NRHRiV7vGPNZ5nGskV6wa98g/iMSM/ntL34Cl3qnjNTg+tNDLpKKGf4DdHHxhE9OydI15O4ew==
X-Gm-Message-State: AOJu0YxVIjG+Loil551CVrFE25rLIzg8VuH1EzRxw/xEJ40JvXI/GTNn
	y+Bv9RygdrZ9WDFl3f7xcKXOUZyCc7CFRSzqjYgnMPbwgtlI+quy0/aRTmZgnjM=
X-Google-Smtp-Source: AGHT+IH8NRgbcS3cWgcCAHWxhNljYYcH0b05Tq7mhTOIL+dEV4fnMnt9hsZeLbNvl/xhsNXDhc/uGg==
X-Received: by 2002:a05:620a:1a0d:b0:790:5dab:f730 with SMTP id bk13-20020a05620a1a0d00b007905dabf730mr14122082qkb.55.1713807345218;
        Mon, 22 Apr 2024 10:35:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id w2-20020ae9e502000000b0078ec3aa9cc7sm4520464qkf.25.2024.04.22.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 10:35:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ryxZv-000yHl-Sl;
	Mon, 22 Apr 2024 14:35:43 -0300
Date: Mon, 22 Apr 2024 14:35:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
Message-ID: <20240422173543.GA231144@ziepe.ca>
References: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713363659-30156-3-git-send-email-kotaranov@linux.microsoft.com>
 <20240417145106.GV223006@ziepe.ca>
 <PAXPR83MB055789D898814B9F73B15C3BB40D2@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <20240419121357.GB223006@ziepe.ca>
 <PAXPR83MB0557B9C9FC7BE9DE4E893180B4122@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0557B9C9FC7BE9DE4E893180B4122@PAXPR83MB0557.EURPRD83.prod.outlook.com>

On Mon, Apr 22, 2024 at 09:12:46AM +0000, Konstantin Taranov wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > On Fri, Apr 19, 2024 at 09:14:14AM +0000, Konstantin Taranov wrote:
> > > > From: Jason Gunthorpe <jgg@ziepe.ca> On Wed, Apr 17, 2024 at
> > > > 07:20:59AM -0700, Konstantin Taranov wrote:
> > > > > From: Konstantin Taranov <kotaranov@microsoft.com>
> > > > >
> > > > > Implement allocation of DMA-mapped memory regions.
> > > > >
> > > > > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > > > > ---
> > > > >  drivers/infiniband/hw/mana/device.c |  1 +
> > > > >  drivers/infiniband/hw/mana/mr.c     | 36
> > > > +++++++++++++++++++++++++++++
> > > > >  include/net/mana/gdma.h             |  5 ++++
> > > > >  3 files changed, 42 insertions(+)
> > > >
> > > > What is the point of doing this without supporting enough verbs to
> > > > allow a kernel ULP?
> > > >
> > >
> > > True, the proposed code is useless at this state.
> > > Nevertheless, mana_ib team aims to send kernel ULP patches after we
> > > are done with uverbs pathes (i.e., udata is not null). As this change
> > > does not conflict with the current effort, I decided to send this
> > > patch now. I can extend the series to make it more useful.
> > >
> > > Jason, could  you suggest a minimal list of ib_device_ops methods,
> > > that includes get_dma_mr, which can be approved?
> > 
> > Is there any chance you can send a single series to support a ULP. NVMe or
> > something like?
> 
> Sure, I can. I will investigate the way to make get_dma_mr used with fewer changes. 
> 
> Generally, I am wondering what would be easier for reviewers.
> Should I try to send short patch series enabling one feature, or should I actually try
> to produce long patch series that enable a use-case consisting of several features?

Generally the guideline is to avoid adding dead code, some exceptions
may be possible, but that should be the gold standard to try for,
IMHO.

If you want to support kernel ULPs then say witch kernel ULP you want
and send a series to make it work.

If that series is way too big then split it into two halfs and post
both at the start.

Jason

