Return-Path: <linux-rdma+bounces-988-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0AB84EE67
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 01:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18516B27F04
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 00:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE28632;
	Fri,  9 Feb 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H53aUxaz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F1376
	for <linux-rdma@vger.kernel.org>; Fri,  9 Feb 2024 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707438680; cv=none; b=F+LpvcgXzWkH2JkWa1c04H6VW5tqvYtLItRegirPI8kFBUuSr71JSzifp9D+R8FeQQi2lbU7+mde6l7b60UbROHmCwFJtbXrxWwcL5HTY/5seqyXdfleuheEoCoXXaeofnOsnYiI9d+7Q8QrgLJEQDoL2vKpmByBB6N21+NQOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707438680; c=relaxed/simple;
	bh=l916pRRCGHUnatFddLG54mO6hIm0GKfN0ogXG/hocdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiTj6PfhK7LkzM2A73JJh0IoWViKOtGQCxxErmqrOCGF5GtWIPtPBPfVdNWTazq9lbCO6heqCgk5iFhyqpU3F/SsPpjODEjuLybs5xUnNPRB/rQ7R8VgPc4/t0Z8hnPJhs32C9pTxN3RG2RrJvqU6iPUHDDB69sn0yQEAXQgf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H53aUxaz; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e117eec348so170372a34.2
        for <linux-rdma@vger.kernel.org>; Thu, 08 Feb 2024 16:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707438677; x=1708043477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czRkUXbU8Q5EjskKJu9/yfS0M+PFklv+rAmjxmsQpz0=;
        b=H53aUxazUfw22tqimqbhqoGvxUvk26gh24pyc5ccGHKiAJVTCVaCx3xj6PwHmgKYEG
         kxmMRtH4Dxgt0pn4rB7oME384MFO6vWMdWpApQ4uS7qjbhowLjdVF/T3aaZ/NJQvwNEO
         f97FWcfY4xiKJhjoednZ24AHkYnQjZ00c6HM/sovv1lmZdYRg22zwtitJVLPaeGEPEOZ
         4wAdXvzrulfTMw2mFDiiOkzcolg++6JgiTKxgd3OpFWjkPVdY7Jhff+h2OiID5J7Yelz
         J/PiYVT3/vMLrX84wjIUlmtbg+JbCvDIifmd+PIuGYMs98F7jW0Qh2zAPtd/K0jVVP30
         Y7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707438677; x=1708043477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czRkUXbU8Q5EjskKJu9/yfS0M+PFklv+rAmjxmsQpz0=;
        b=oxgV8m7d3el3bWF2obvuL1rYoQZW8DTaxr2ijIrCQNC8IDtuWWmn+YUcKTte13oj8X
         vvmkrKVkITFJNVQbpRfDdQdwUjHipnLwk/DF4gqz2u1frsvlL7g819ZzPvWPg3Ua8/z7
         AupCo+RkWfFfIf/DKABaLB33RIdNdjoiZ7ylICHfy+kQEyycAzUlbyTXl4IniNgE27ag
         bq3MCbLh7TLyhlJbTeKkhueEZO4bXtSAEnI9hntjBsSE8adZ7FayzqCZiu49WCzRsShQ
         NzorDoQvEaPXdeatT+AXQevWuI3xTXJh2EqJeglMsIbJw7xNuF244fYclvo3m/f1bMor
         RUqg==
X-Gm-Message-State: AOJu0Yx98MAena05KYNUI05jnmpTtJEoQCPeI3Z6RQell2X6GwTTm2Ij
	/QQbec1QZzk5HuqHJkVTJEQCbZjmUPegpCBgL5SSZU4XGqw49kYf3LmjaLaIgas=
X-Google-Smtp-Source: AGHT+IFdX0zRy/qTN3+hMuXAP66IPMPUi93cDkds2VFNeqs/e7FU3G9ogltteG3JtH94CgD7c6rdGg==
X-Received: by 2002:a9d:798a:0:b0:6e1:9db:f995 with SMTP id h10-20020a9d798a000000b006e109dbf995mr1124147otm.30.1707438677248;
        Thu, 08 Feb 2024 16:31:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaFdBIysYfONKSBNDv26g8cTf4/ZYZsu4PnMnZyHUPVde+bhaWUYgLkiTdHvkrx/7FKrimuMV0BpUIQQAM1Er6dk+tZeEKTwUzBnTRwR5dKr8LGIWQjOtecf3JNXUyBStgKde4xvDloonZDLCC2/UJNvXvtS1ma+8xuOeSQ/4GBKz/1NEjFYiNNDRvmulHXDSSVxKb+Ndo1Q==
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id a10-20020a9d470a000000b006e11970fb7esm98207otf.67.2024.02.08.16.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 16:31:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rYEnT-00H589-9F;
	Thu, 08 Feb 2024 20:31:15 -0400
Date: Thu, 8 Feb 2024 20:31:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of
 dma regions
Message-ID: <20240209003115.GA31743@ziepe.ca>
References: <1707318566-3141-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB326394A06EF49FF286D57B63CE442@PH7PR21MB3263.namprd21.prod.outlook.com>
 <PAXPR83MB0557C2779B1485277FD7E417B4442@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <20240208201638.GZ31743@ziepe.ca>
 <PAXPR83MB0557626F0EDEEE6D8E78C6D7B4442@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0557626F0EDEEE6D8E78C6D7B4442@PAXPR83MB0557.EURPRD83.prod.outlook.com>

> > > > > +
> > > > > + if (force_zero_offset) {
> > > > > +         while (ib_umem_dma_offset(umem, page_sz) && page_sz >
> > > > > PAGE_SIZE)
> > > > > +                 page_sz /= 2;
> > > > > +         if (ib_umem_dma_offset(umem, page_sz) != 0) {
> > > > > +                 ibdev_dbg(&dev->ib_dev, "failed to find page
> > > > > + size to
> > > > > force zero offset.\n");
> > > > > +                 return -ENOMEM;
> > > > > +         }
> > > > > + }
> > > > > +
> > 
> > Yes this doesn't look quite right..
> > 
> > It should flow from the HW capability, the helper you call should be tightly
> > linked to what the HW can do.
> > 
> > ib_umem_find_best_pgsz() is used for MRs that have the usual
> >   offset = IOVA % pgsz
> > 
> > We've always created other helpers for other restrictions.
> > 
> > So you should move your "force_zero_offset" into another helper and
> > describe exactly how the HW works to support the calculation
> > 
> > It is odd to have the offset loop and be using
> > ib_umem_find_best_pgsz() with some iova, usually you'd use
> > ib_umem_find_best_pgoff() in those cases, see the other callers.
> 
> Hi Jason,
> Thanks for the comments.
> 
> To be honest, I do not understand how I could employ ib_umem_find_best_pgoff
> for my purpose. As well as I do not see any mistake in the patch, and I think you neither.

It does exactly the same thing, it is just intended to be used by
things that are not doing the IOVA calculation. It is a matter of documentation.

> I can make a special helper, but I do not think that it will be useful to anyone. Plus,
> there is no better approach then halving the page size, so the helper will end up with that
> loop under the hood. As I see mlnx also uses a loop with halving page_sz, but for a different
> purpose, I do not see why our code cannot do the same without a special helper.

Are you sure you don't need the length check too? You have a granular
size but not a granular offset?

In that case yes, a helper does not seem necessary

However, you should still be calling ib_umem_find_best_pgoff() for
the initialize sizing as a matter of clarity since this is not a MR
and does not use IOVA addressing.

Jason

