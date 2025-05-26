Return-Path: <linux-rdma+bounces-10736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F440AC442C
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 21:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8751899171
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 19:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B091623ED68;
	Mon, 26 May 2025 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jZ+DXS1p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FC1C8639
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748289441; cv=none; b=gJwPV8dNkBeGXt/Qg1tUnaD4mmTnk8Fun8D6Fge0ewFVgxNhmIlkeebshET1L2efgRbd83SNUBMKXEKtwHfUrQjLU3JHfRkipMrpmTpuun9xIoS8rT8JBCnSrJEqYtxDfN7uLaAym24PjTMgHJK8pLiCEqxRO1k8KBM1YTGD+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748289441; c=relaxed/simple;
	bh=JjAbM7bwUENza5M+9Ys+LTpnMeBhw+VDL+sZEhskg8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFIrL+HIkMpoCgd4UiJy3GibATAxH09pS79fowVYUGphC9TiKG/4pFl187E4IFlUNe1o9XbPA6GR9I1eOP7Y0NHCADMcjEAQwB3gZR3/Jc8F3WqS2m16OgD9fFdIwJJmSCmf+X+k6UNVmpqakIg3oj4ElD9MFcBQ4oF3ngN42E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jZ+DXS1p; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso21243916d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 12:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748289439; x=1748894239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=52+nhUj+fXQPtnoww4dOPn+bKeui7Kmj06MnKB1tkio=;
        b=jZ+DXS1p39MIdM+QtX+2ZF1iLDJdidx33EM0yeC5VzUre39wRNz5DSGYzK5mbw2RnC
         Vd5VK/oYpjxdooMNPSmna0mjnAQQGlIDWrHigAzngXtj/Wcyvw4o7EyZtY7BZGhIosuY
         ZQd4Cicm/aBcnRM9a7S+F+nFi5fsdIwQvcrM34fZktCjbvOVv1VB3Z8m4VTBRyXIl8hJ
         hhTfcQiCOJ+Pyj3hDmsHHImFqPZ/xr/zdzQl+Esb2u8Q/awl0v/Dr+9xoBbtyzYfmetB
         9XUdhr8OAXSRF+pWf8GbSZS40LxXJuzy8K7S+N+nU6NewG939FQhncf8l6Pkpwhr9R65
         l7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748289439; x=1748894239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52+nhUj+fXQPtnoww4dOPn+bKeui7Kmj06MnKB1tkio=;
        b=nNyZCMnPysJ2Orm3nIgs3yEt4Mv9zOMLcB3Axfx2iXyEf0r9k3gq4Va8Sl9LbqlBUL
         0gZswgcS/je6B4UIeZweedwL/tHiAMCa2e3YmbMguAg+rdVUvsYmI78voVK5fFdNtHqp
         smHsQRAyQJ4sNWdmMxitRjEIW+xf/5vP4oqprYvGUDgK5eZ8W1NRxeetljLF+c1I4S0f
         bkcbKUslprjHH6TFTafkfmEDmjypR0vAnXrwirrHkQ2oQWNJ2nZyvANge+P5Z4M2KsXx
         QSlBluWfbhNJuzsf2eA2TDl3Fmwgx6kv2heCxKJEkWbBSqj2VrqSzZgtiFPozdE5Pi5m
         vc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4IoJ62/LoslaW5A9UG9yyGOO57/rN2nEscY5PHJmT1sbZAsJeoVL08T3KSaGU4DjEyrL6Xe5E/T7w@vger.kernel.org
X-Gm-Message-State: AOJu0Yytgn+Xj6+89M4yhX0hmRvDqMMwlBMpgZ65qpdERVeVNGglU2VT
	lp0725ClKhnzRfJmumX9OjJHh2fgu49i1NSiz2yFLKrfLBhZCBbmCxiZZ4/MlDyL7+E=
X-Gm-Gg: ASbGncuBiy4pUvBuFAx192aGX0cMf9TqbzROsMwVNyif3RBp+u5tkqqkcGeFjox4dkE
	LZWnqXDEuaOeTha8Rrb4jggZhDbNGOHw9y2cPTx6y/oAlszKL5Yt8PlekqYNIjYadkmUxvDso2O
	D0u61053nT8RbfYMndPDWiA8sr1PsO0Hsf4q/8DY+s1WLpIZKEd7uOR8Z9wa1V5X3ai3yjlVwr/
	+NUC2TAB/b5GsfMxPOLdaVBJIFIJH4TJU8YierdwuNSfLh9eHlvw8i/FWsRa+9NW06RvPX3TGCC
	uBy+Ak6E2t+2DahHivxx+ivaOgCrEZBHbEvnylZD9dcRqPuN1Cvt1g0wPOnemKL9/6rcz5sP7uP
	wczUkWFrHOD2tUDc4AERlFs4j1UQ=
X-Google-Smtp-Source: AGHT+IFylJzlr+Hf21yAJjGNjVN0dUWZdqK9Jw5gc+JL3yLgiy4iZKIjMcJvpGVnbPd2NANnBq9o+w==
X-Received: by 2002:a05:6214:21a3:b0:6f5:421b:623c with SMTP id 6a1803df08f44-6fa9d173b40mr195321546d6.25.1748289438786;
        Mon, 26 May 2025 12:57:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6faa050c0b8sm33866496d6.74.2025.05.26.12.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 12:57:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uJdwj-00000000Ude-3Scs;
	Mon, 26 May 2025 16:57:17 -0300
Date: Mon, 26 May 2025 16:57:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
	Daisuke Matsuda <dskmtsd@gmail.com>
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
Message-ID: <20250526195717.GH12328@ziepe.ca>
References: <20250524144328.4361-1-dskmtsd@gmail.com>
 <174815946854.1055673.18158398913709776499.b4-ty@kernel.org>
 <aDQQyjJv9YKK_ZoV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDQQyjJv9YKK_ZoV@infradead.org>

On Sun, May 25, 2025 at 11:57:14PM -0700, Christoph Hellwig wrote:
> On Sun, May 25, 2025 at 03:51:08AM -0400, Leon Romanovsky wrote:
> > 
> > On Sat, 24 May 2025 14:43:28 +0000, Daisuke Matsuda wrote:
> > > Drivers such as rxe, which use virtual DMA, must not call into the DMA
> > > mapping core since they lack physical DMA capabilities. Otherwise, a NULL
> > > pointer dereference is observed as shown below. This patch ensures the RDMA
> > > core handles virtual and physical DMA paths appropriately.
> > > 
> > > This fixes the following kernel oops:
> > > 
> > > [...]
> > 
> > Applied, thanks!
> 
> So while this version look correct, the idea of open coding the
> virtual device version of hmm_dma_map directly in the ODP code
> is a nasty leaky abstraction.  Please pull it into a proper ib_dma_*
> wrapper.

IMHO the ib_dma_* family was intended to be a ULP facing API so that
verbs using drivers can pass the right information through the WQE
APIs. Inside a driver it should not be calling these functions.

I think the bigger issue is that the virt drivers all expect to be
working in terms of struct page. It doesn't make any sense that rxe
would be using struct hmm_dma_map *at all*.

Indeed maybe it shouldn't even be using ib_umem_odp at all, since
basically everything it needs to do is different.

The nasty bit here is trying to make umem_odp overload struct
hmm_dma_map to also handle a struct page * array for the virtual
drivers.

Jason

