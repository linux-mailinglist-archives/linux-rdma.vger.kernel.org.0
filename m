Return-Path: <linux-rdma+bounces-985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB5384E982
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 21:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CADF28995E
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C980738DEC;
	Thu,  8 Feb 2024 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XjAIgW0Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCA36B0A
	for <linux-rdma@vger.kernel.org>; Thu,  8 Feb 2024 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423403; cv=none; b=WnbB8lchk2TxNSTPewLmOIhP2aCLqQ0BFLLXhKMVoXdqD/XtDSjub3VLrvVv+vA3B0M3R1mQqTM+0PGNboI2hTkMnLboPR0DDORmSkUg7VndWw9ivlw0Mq4ErCq38ysNRVckY12XgXKeMSTM6foDKpNeJBKzswPXzbC8rKDNv64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423403; c=relaxed/simple;
	bh=flHsUzAN1b+v0w8PvGBjhwVSZ3GxquBnNsjj8HFsyAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG6j8JW6PbgyY1Kge7HFIFvJ419FUhSjk0BOLZxIkeidmfdfNdcTXkqcP7bZTfevMMX2Cg+7zgn7xm1L/Iwhmz8djMmdwtxfaSEpjksR3jBxrK6Rff0/PgxC0mOSWG6Mq9u9SfWlJ580qL6K8MMYaMYaQcdy6NXPg66ZkcId/Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XjAIgW0Y; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3be3daeff38so71489b6e.2
        for <linux-rdma@vger.kernel.org>; Thu, 08 Feb 2024 12:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707423401; x=1708028201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8E10FDOpzIm5efl0mA2CAXdhkpGX2Vqi/2VCns5LkQ=;
        b=XjAIgW0YnUCBJ2RazjHePnx33WK/v2HoD5SM/bdyzw1NDZg12yX39qjcDbcJcTdMuF
         OwDytEtyDE5IMfkWRd+2f66dB08rSbWgYAefnAWcgRefj0UPG1zU78COjG2/vzz9sPZf
         /pHkvZOlvhtrgJ39zOhIKOBjwHlumZh///VPd2UZbM1fcXPHtB2aku4KfzY3QPeYXmFI
         yNxFbO6Ra9GAijhZMrjipHBX1ztrXvyzcMwAwCqEtGY747dO/hrZCGBpLwdDUtHEQ03z
         V8EljbluGjg9Vr/dKTpdJOGRVPfB5aFq+bu1JDoDHvU6FlPn86QpAFcVkNMu2eTlsFF0
         uixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707423401; x=1708028201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8E10FDOpzIm5efl0mA2CAXdhkpGX2Vqi/2VCns5LkQ=;
        b=qnam1FQTQY45T+T7QMrMkIur3CoyC7x9INC61QzhsxsFl6RCaulMLy4rXCeU2Igst+
         cFxJq88qesYVmGFlSMPN+wphU4TCc0/pSnZosHZIxSDw5Zwv2mluxotdC9NNnFJfLQqM
         2bgBNVa6XM/2c72OW98YJ/qkJGMug0C18YglbpCO9p4xJ8VjM0YRuJUDjf9XqF1FImbw
         cN1JqeFENOQua38U24/PevclRmpP4bhS2Uj0Hxc+4fD83nuZLquqgj7+K44JK+h/1Qyj
         2OIz3GYk4t7h8l0Kh6OK3cegGzchlwXgvCA6q3QeQJldEp9u9po9TqZbsdmbDofz0WlI
         kDMw==
X-Gm-Message-State: AOJu0Yx3kJrUgnFaLcqDNRltuxiLRNlr9ZIeQQNM5kpf1sTYLxGk1Qj6
	qymmrf5wkUBHtDkheWPMtVJAzrn0RP51VM3O/MCpwTTINSqs3+i2niJxoUuUX+Y=
X-Google-Smtp-Source: AGHT+IFEuLQHZc5btsZ/uqjXHRIUkAW7oW5rYUvJEBiWUqNUOi2rC577wNrZPjlPjqutpn/yuOwDlg==
X-Received: by 2002:a05:6808:2e8c:b0:3bd:36fc:1c1e with SMTP id gt12-20020a0568082e8c00b003bd36fc1c1emr673830oib.44.1707423400843;
        Thu, 08 Feb 2024 12:16:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIrODRyJcaN5pdqZBtOjmf2iFFQUJa2vBW2Jn+j9PQuQBTyzXAHfDo6M+CJICY6m0fWttc9YwoH+40lDg/E3ibTXAbeZZXkTmm8HMcgdAfSkf6GapjHtBcVEHKtNOuPOj/VIqKK6C6+Qo1YOiyntjobxxy8QqGXUVd6mM+2f6Lr3gsBUw1oDd9ULOddvUtjOoGT1E9YVjdn7zJbAVl/m4rpcx73WSnOqE/XWPtO6JaM8dl
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id dz2-20020a056808438200b003bff074dd43sm14449oib.58.2024.02.08.12.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:16:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rYAp5-00FyMn-0D;
	Thu, 08 Feb 2024 16:16:39 -0400
Date: Thu, 8 Feb 2024 16:16:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of
 dma regions
Message-ID: <20240208201638.GZ31743@ziepe.ca>
References: <1707318566-3141-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB326394A06EF49FF286D57B63CE442@PH7PR21MB3263.namprd21.prod.outlook.com>
 <PAXPR83MB0557C2779B1485277FD7E417B4442@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0557C2779B1485277FD7E417B4442@PAXPR83MB0557.EURPRD83.prod.outlook.com>

On Thu, Feb 08, 2024 at 06:53:05PM +0000, Konstantin Taranov wrote:
> > From: Long Li <longli@microsoft.com>
> > Sent: Thursday, 8 February 2024 19:43
> > To: Konstantin Taranov <kotaranov@linux.microsoft.com>; Konstantin
> > Taranov <kotaranov@microsoft.com>; sharmaajay@microsoft.com;
> > jgg@ziepe.ca; leon@kernel.org
> > Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of
> > dma regions
> > 
> > >
> > >  	/* Hardware requires dma region to align to chosen page size */
> > > -	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, 0);
> > > +	page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, virt);
> > >  	if (!page_sz) {
> > >  		ibdev_dbg(&dev->ib_dev, "failed to find page size.\n");
> > >  		return -ENOMEM;
> > >  	}
> > 
> > How about doing:
> > page_sz = ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, force_zero_offset
> > ? 0 : virt);
> > 
> > Will this work? This can get rid of the following while loop.
> > 
> 
> I do not think so. I mentioned once, that it was failing for me with existing code
> with the 4K-aligned addresses and 8K pages. In this case, we miscalculate the 
> number of pages. So, we think that it is one 8K page, but it is in fact two.

That is a confusing statement.. What is "we" here?

ib_umem_dma_offset() is not always guaranteed to be zero, with a 0
iova. With higher order pages the offset can be within the page, it
generates

  offset = IOVA % pgsz

There are a couple places that do want the offset to be fixed to zero
and have the loop, at this point it would be good to consolidate them
into some common ib_umem_find_best_pgsz_zero_offset() or something.

> > > +
> > > +	if (force_zero_offset) {
> > > +		while (ib_umem_dma_offset(umem, page_sz) && page_sz >
> > > PAGE_SIZE)
> > > +			page_sz /= 2;
> > > +		if (ib_umem_dma_offset(umem, page_sz) != 0) {
> > > +			ibdev_dbg(&dev->ib_dev, "failed to find page size to
> > > force zero offset.\n");
> > > +			return -ENOMEM;
> > > +		}
> > > +	}
> > > +

Yes this doesn't look quite right..

It should flow from the HW capability, the helper you call should be
tightly linked to what the HW can do.

ib_umem_find_best_pgsz() is used for MRs that have the usual
  offset = IOVA % pgsz

We've always created other helpers for other restrictions.

So you should move your "force_zero_offset" into another helper and
describe exactly how the HW works to support the calculation

It is odd to have the offset loop and be using
ib_umem_find_best_pgsz() with some iova, usually you'd use
ib_umem_find_best_pgoff() in those cases, see the other callers.

Jason

