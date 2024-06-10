Return-Path: <linux-rdma+bounces-3030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD8902152
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 14:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892711F21889
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E23679B84;
	Mon, 10 Jun 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EDCSJR5K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9407FBA8
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021519; cv=none; b=cd01koh/I0a9L7ViIXi3JW8BJx4w4gN1TN5c9E1vfEyc44nMi/DTQbqZEVetk1d73vw+v6IAvRHmUICNerKSVlEdI/FufkLrw9+o5Iu9ppUQbzc2WlTPq7bPsZJ3eDADpFOirNuBdDB6BlPk5fQEpex3bQMIVX6ruIIz0qc5gvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021519; c=relaxed/simple;
	bh=caB1DgE6lNAzXW+g/NLwFuuEdV7bcFUoheISR77RlXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzTOYbttGGg68PaDSekGQrJlXo1E6bJXAK5UHsZ8vLeOwuYwjRAp26ttQ/FWpdJipXUM10UzqoOeqmktKAx1HsX1qDXPVemQm2ikvislFWKQNdxlLv8LFERQ3EnJUL7jgGHLMp3S+e/Jl5As23aB7C9JLK1CKlms32p58u0U6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EDCSJR5K; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2506fc3a6cfso2081617fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718021516; x=1718626316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3VfLy+0xn7yNaS/SyVEB4+sm+cKduyI1+wlQtfEH7Y=;
        b=EDCSJR5KdGemonIxsoQTseyTzM9BH8o/yMSGP/6PnbY8TGN+EguAGMUX22oxZZex9w
         u35HlIDUokYeQDPy9jwIjfn14cDRSBFPXNdD+Lxcpb2Whthx7urTa/onA6Q5YSdci0Cf
         NATW9ys5OZlcbpJ+PhaCWlAaVMPhi1gIu6Hxyj5i6J6iRYXbdijVHPGOOrlmci+SNTW8
         OJd20HLo9d9+SeLmm9inNpf0s0Q05QxtO3yFSOHzlUxsk0rVg+FiC8ytisLAeZqImfqy
         Qcu+/nH2/BCQsq0F7wpnO4n9iHltVJn4+6h/y0tKxrAUsDdGOUiAAsDZVVY7iAJ6dFxo
         +vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718021516; x=1718626316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3VfLy+0xn7yNaS/SyVEB4+sm+cKduyI1+wlQtfEH7Y=;
        b=t81UOXFqupjy+S7gfSAXbuK8TD7ivaezomFfLLbt4siXT8C2CzcqNmhdzxaYGApHAD
         zLmH10YZ65RZsKJhATrxrJXx0poEjT+4aYUJKNQ6a+JyqsPXXpIHGMplSMaUhXrtcOVm
         xyLWL/rgCnS5iaZrtkKA2w+cLcGFJM3bXFZ6y6wMvVJlzWbYibuKVCycpv2j39D7753N
         0qoIwV0/Gsc+6SBH1oXFN6rhdAk/HJosaFkx+FtefXlFsV2XbRfeRogGlZ5bZwEhTy2K
         OejkYPP47SxTKiW/tq2Bb0CR9VF3Jrj8PgOA2uzxDrLJsiUcLVgTZkoap+B7kCY8SR6J
         4xNQ==
X-Gm-Message-State: AOJu0YwhY3YCIXMBk/uzBvT5ba6ckgUazCmt0W616EhKTwYcu1zZ05ds
	CRrW+mH4aFlfXNDzlMV7QtkvvvDwQZrZLzI7WKIu9+ituZ4T0VUouDjx/7Wn+gg=
X-Google-Smtp-Source: AGHT+IHMlLqmreNq9NtSDVCvKZpZzp9aWfGxwYiAaNNsZlWsytpstVnNHWnxI5w1Z35ApPSZX6ZS9A==
X-Received: by 2002:a05:6870:d0c3:b0:254:b7d9:2dcb with SMTP id 586e51a60fabf-254b7d94b5fmr3834664fac.8.1718021516266;
        Mon, 10 Jun 2024 05:11:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954d46bb31sm268776685a.14.2024.06.10.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:11:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGdsQ-00DhCf-S1;
	Mon, 10 Jun 2024 09:11:54 -0300
Date: Mon, 10 Jun 2024 09:11:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Valentine Sinitsyn <valesini@yandex-team.ru>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 6/6] RDMA/umem: add support for P2P RDMA
Message-ID: <20240610121154.GH791043@ziepe.ca>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
 <20240605192934.742369-7-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605192934.742369-7-martin.oliveira@eideticom.com>

On Wed, Jun 05, 2024 at 01:29:34PM -0600, Martin Oliveira wrote:
> If the device supports P2PDMA, add the FOLL_PCI_P2PDMA flag
> 
> This allows ibv_reg_mr() and friends to use P2PDMA memory that has been
> mmaped into userspace for MRs in IB and RDMA transactions.
> 
> Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
> ---
>  drivers/infiniband/core/umem.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

