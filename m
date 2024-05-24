Return-Path: <linux-rdma+bounces-2605-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162828CE783
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 17:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C18281BE2
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2024 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E3712CDA8;
	Fri, 24 May 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZRQ4i/cn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7E48CCC
	for <linux-rdma@vger.kernel.org>; Fri, 24 May 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563152; cv=none; b=pcRx74oTc9RL0DQvMsZVQzYrys3OnovrlyGd3PHDZGevr87Bfyw6M9oVejNmuwLfo4V05+Urq/PEb2kw87NH6EZ+Q1eg+7x/FC4CZk5dAxYKLO8rB5HxIENetEo/zESC+TcZfiYeDZ4x/91UjTF3b4gU1+K8+Y7FHW3auCKt8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563152; c=relaxed/simple;
	bh=SIYOk2y/8TIaVyuxx/LRgu09CLWFlDhOpvUyz6gEbsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdrM9XE9L5nOqYA+N9jpjITsFN+EQsB7wUqWqBCyiRUPJ5E8HpGg3AvMYoZcp3FWcyw99f+Qw4OwHl7MuapADRn95Kzr3mDzpCY6PltsEuwWgJfKX+l/XebhxWZN2v83SIIfk/wfLvKrcbSunf8V5ojAoEE7NuBHztFfHfwjobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZRQ4i/cn; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-794ac6b5409so49667485a.2
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2024 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716563150; x=1717167950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrfQFVHeBLW4L81BBsrvy3ibWByQt9SNNBB8L2DMjSc=;
        b=ZRQ4i/cnOnJ/aa5nWBQFLvlxK7VwjgDdRIxvhYGXHbd1aKSXXZvhKsFdedZ9KkcKf6
         D3wrsfsNpn6Nm8FO9SJ6eF6VcJ6xxQ86BMXqVbPWW42nYhYCaGWTqQTphlruhw1D8YSS
         cTtQWGcEpBFv1BNyvaS++ZH5lzPTrCW+e4a4lJlu/GvI/mef7xYU75RVOJP4gJ32Ny6C
         tovCBnFtkZ3+apaiw3/iNlT4ts67G1YfTRBoVbNtXwfwfBGfH3uXnLTQXJHt3P3in7ZI
         NiSFMSyCfT4USvqyZamgmS0e0pkrQp/iMCzk6qYm/q3JgPpSxPxWihTwGQdA444AThIZ
         1D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563150; x=1717167950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrfQFVHeBLW4L81BBsrvy3ibWByQt9SNNBB8L2DMjSc=;
        b=EYtLPvR0tiiOH+wIlG6BVo2iC+ECSR6aB5ifb2gLDose70vheUefhM8eHz9epkfiNG
         hgXYcTTN4Ds1calpNP9zEt7Q9LqnJSG2r0YXNEc4lQv/pbXqYX9w2hNS/gZ9VHMnbjL4
         /Q+Xqvt26zV6WcobdO3BAhswTiUNy46gSwRE7xeBro9z+cpWE1lMxCs6RH/T2TfonBpA
         OBAGkRHPi2/KXDD+YNWGu4pY+88R6wOOFHVLO383lfeJkaN6N09DQ92ePgy6bU73zkAM
         F4Bw5S/Dl5a2a/JBoeleQ6t0qxQMNxeWUg4gVzboP3AiIjAtNBHcch9kAd5lW7idUTnG
         KXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwCaK1NmVsjUnZgntrmkfjMepxkm1PuK0YSnRi2k+YSoO11JfUP+ZxZC34rbRjezXTk4AKyLxHds7p5Dr1JmoS/1rDOMVSq0/58A==
X-Gm-Message-State: AOJu0YzGvXs92aM6Ixybf4GD6tzLVrx38A8aMGV8mXySOU57A4hm2chz
	LZsdO9+to4lGR6W+8xT+090j+quCb+HK8SuPnnCst+V3h7wLsdIREKZQINFh/0E=
X-Google-Smtp-Source: AGHT+IHUIGYxHhJJDbHOdbQA4yeYhL/+fJBNhDEfZga1QrFdb4Uq49wj4VhnkK+cLmSCLAtSXRP63Q==
X-Received: by 2002:a05:620a:37a9:b0:794:82de:c38e with SMTP id af79cd13be357-794ab1108a1mr218041685a.73.1716563149861;
        Fri, 24 May 2024 08:05:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd06397sm70529685a.96.2024.05.24.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:05:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAWUN-001QSS-W6;
	Fri, 24 May 2024 12:05:48 -0300
Date: Fri, 24 May 2024 12:05:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Honggang LI <honggangli@163.com>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix data copy for IB_SEND_INLINE
Message-ID: <20240524150547.GQ69273@ziepe.ca>
References: <20240516095052.542767-1-honggangli@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516095052.542767-1-honggangli@163.com>

On Thu, May 16, 2024 at 05:50:52PM +0800, Honggang LI wrote:
> For RDMA Send and Write with IB_SEND_INLINE, the memory buffers
> specified in sge list will be placed inline in the Send Request.
> 
> The data should be copied by CPU from the virtual addresses of
> corresponding sge list DMA addresses.
> 
> Fixes: 8d7c7c0eeb74 ("RDMA: Add ib_virt_dma_to_page()")
> Signed-off-by: Honggang LI <honggangli@163.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This seems like a serious bug

Cc: stable@kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

