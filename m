Return-Path: <linux-rdma+bounces-1500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7688870ED
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Mar 2024 17:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DDF2851C7
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Mar 2024 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F75D494;
	Fri, 22 Mar 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JuJ6oBjw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC615CDC9
	for <linux-rdma@vger.kernel.org>; Fri, 22 Mar 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125126; cv=none; b=rGGsytL+2TW4f2kok3c3eyVfFa+HCpIiM6J1BKJ6ysDDlo3tXTGzJBCmAacQozHuIUp5FSpM+GlDKZlN9SOsxe0kJoKo03Hty2OWXnRuC6GdVXXgCkFBvxs22vrOJwNrMQwcQCSs2cfXHLATNfD/uMX/X/aMp/JPpe/qWEtuIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125126; c=relaxed/simple;
	bh=BuQG63lMcTmgNNl4rqvlHS29xM6nE11JEuyaJ7K23dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYrB/Dm7gFMXIkABb+8Lw5ZVxrgHUWYteQQQbtGLRtdlVB3dPFgTagYqwYL+CRIY2cC+kTBTCukp79EWGnFDSTFSeio/bSFfhQykBKql8M5g74LZOpZX8OcrDfriE68wtIA7GkhCgzj5hAXPf3KmxhIfbqrZRL2K1SrqgUz85sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JuJ6oBjw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-789e4a4d3a5so159214685a.1
        for <linux-rdma@vger.kernel.org>; Fri, 22 Mar 2024 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711125123; x=1711729923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/jKRcxkxWVwJBSpRibUSdG75lkZ4ocJycd1Mr6Bw2Y=;
        b=JuJ6oBjw8H7yZWUC46RLCQoesbwU9Lk6T9WPH3kye2vyYNHfTd+KhOz1wwfnD1igB7
         1p3mIFFWcgt2sWdN6hRnJ2z4cW4j93IxiGT/Oyjuh5sSqqA9XvkQmumHJwmHhBm8x3O1
         pVBhfk4LLMCLM2XYpDiEH/NXcdlqr2XGuJXMo+MUiisQg5nErFEVsv1z6rPH2bddD/Tf
         akyFuTxkvmUVwPH41wi30mNRTJoJwAAUZwGEYyXudgKdI+5OGBKrrLClSpkJt6QEfkcP
         /WMYN8fHNWXXkeu5oo32YIoGoFmLXCPOx5uP4bP5Yd9yRktMIkPkw07IF8VuaaqBwlEs
         PhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711125123; x=1711729923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/jKRcxkxWVwJBSpRibUSdG75lkZ4ocJycd1Mr6Bw2Y=;
        b=ZN5/t3hfwmMYdp+weKZn9iS+8/2Rr7sp7Fvpxvh6hLGuWNMvQ5CL2GBYjjzb0rAuh2
         ePxlCc7mgw9rdaFMVi27TO3RzR1Lm5SsOeFPnDqigOPOmexW+QitGZt4hbvs3payETWs
         J/FR4B0tGIN2TcV6gd1DRz/2AfAfQDhJxR1i40abvComsU8hTq5rSX2KA0VwJYPGLAv/
         CE/zhpiqa93yZV4d5FnMBGB70q1F4j5h8B1wMM/DPrWuQyrmbu4LU29WEw6GT3K24FiH
         nAkhNj5BlZYvYNbq9HEAvfBN2+NhgoIQlZIC+sH/u2IzYCFGrqQTTJdvHQQVEZKbnc1p
         hAZA==
X-Forwarded-Encrypted: i=1; AJvYcCVz4d5sBasmZD8D0enrCf9lEKg+amMQjQBMJZ0FcRvNUcJpLtcBoF78ZSpMnFTm/GlvYcuCSeJuZgtGJKYw+o/hnROgunFB6/dwoQ==
X-Gm-Message-State: AOJu0YyKswWK3OOXDorS0EkE6ZVhbZRVH1zsP1FdcRyybJ9nM//FKvRE
	dhujGaEx0bsg+X4ShihhZKnorhbVWe5YkZr6BmsVzGV2VVuDVfqlpxHQ/6H8HAQ=
X-Google-Smtp-Source: AGHT+IEmjNO3iVQtJ5/6Fyo+e6vZeQz1BIgmUNoeNHyvqSHC03UiQxcsrMArTCXiiRa/okEHUAyW2g==
X-Received: by 2002:a05:620a:57c3:b0:78a:1e39:2674 with SMTP id wl3-20020a05620a57c300b0078a1e392674mr2949227qkn.39.1711125123483;
        Fri, 22 Mar 2024 09:32:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r30-20020a05620a03de00b0078a07fc259csm899307qkm.40.2024.03.22.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:32:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rnhoI-00CMyb-0E;
	Fri, 22 Mar 2024 13:32:02 -0300
Date: Fri, 22 Mar 2024 13:32:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support congestion control algorithm
 parameter configuration
Message-ID: <20240322163201.GF66976@ziepe.ca>
References: <20240308105443.1130283-1-huangjunxian6@hisilicon.com>
 <20240310100027.GC12921@unreal>
 <c16e3cc2-1a70-a9ec-e533-e508cfbab18e@hisilicon.com>
 <20240311071119.GH12921@unreal>
 <f8354762-703c-16e2-fa8e-bc8519fdcd06@hisilicon.com>
 <20240312080522.GO12921@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312080522.GO12921@unreal>

On Tue, Mar 12, 2024 at 10:05:22AM +0200, Leon Romanovsky wrote:
> On Mon, Mar 11, 2024 at 10:00:27PM +0800, Junxian Huang wrote:
> > 
> > 
> > On 2024/3/11 15:11, Leon Romanovsky wrote:
> > > On Mon, Mar 11, 2024 at 10:00:51AM +0800, Junxian Huang wrote:
> > >>
> > >>
> > >> On 2024/3/10 18:00, Leon Romanovsky wrote:
> > >>> On Fri, Mar 08, 2024 at 06:54:43PM +0800, Junxian Huang wrote:
> > >>>> From: Chengchang Tang <tangchengchang@huawei.com>
> > >>>>
> > >>>> hns RoCE supports 4 congestion control algorithms. Each algorihm
> > >>>> involves multiple parameters. Add port sysfs directory for each
> > >>>> algorithm to allow modifying their parameters.
> > >>>
> > >>> Unless Jason changed his position after this rewrite [1], we don't allow
> > >>> any custom driver sysfs code.
> > >>>
> > >>> [1] https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> > >>>
> > >>
> > >> I didn't quite get the reason from [1], could you please explain it?
> > > 
> > > Before [1], we didn't allow custom sysfs. After [1], the sysfs code
> > > started to be more sane and usable for the drivers. However, it is
> > > unlikely that the policy is changed to allow driver sysfs code.
> > > 
> > >>
> > >> And it would be helpful if you could give us a hint about any other
> > >> proper ways to do the algorithm parameter configuration.
> > > 
> > > Like any other FW internals.
> > > 
> > 
> > If we add the capability of custom driver parameter configuration to
> > rdmatool (similar to [2]), would it be acceptable?
> 
> Moshe's patch is for devlink. We are working on a generic solution for
> other vendors to control/debug their devices.
> https://lwn.net/Articles/955001/
> https://lore.kernel.org/all/20240304160237.GA2909161@nvidia.com/
> 
> Feel free to join the discussion and reply that you are interested in
> this proposal as well and emphasize that your device is not netdev at
> all.

Yeah, I'm kind of expecting that all RDMA devices are going to need
something like fwctl for exactly reasons like this. Adding a special
driver sysfs is, IMHO, worse than just exposing a driver specific
sysfs. hns looks like it would fit nicely into that scheme as it has a
clean fw RPC interface - indeed this is just welding the FW RPC to
sysfs..

Congestion control does seem like it could have some sensible
commonality, but there are so many different takes on it and many
people are not doing per-port stuff but per-device or per-qp
variations, so I'm not really sure.

I wish there was more industry standards here..

Anyhow, feel free to respond in that thread that hns is also
interested, thanks

Jason

