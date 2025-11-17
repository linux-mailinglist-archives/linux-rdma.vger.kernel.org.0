Return-Path: <linux-rdma+bounces-14536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0265C6501C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 17:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD44E4D23
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787582BF019;
	Mon, 17 Nov 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O5EyoHLI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D587285056
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395235; cv=none; b=mFmMIH2OusZ1+o8PybCO2zlUAUGzo3BBe4LtodnrvyCZsYWRecwNLDAFrJWRftg9qVm0uPfEtQRdFOfj4EGvEcFoqZOBbGWNDdD7S1bqksI9UdQxmVzsY6YaTGAUXQ+5moN/O3jdUJ5GgaECitDah5c5HZy3jTbqLvAH90LJBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395235; c=relaxed/simple;
	bh=G7C4pAgpKtZexEHJcykCN6RuqFFJo5KbCaykefTP9os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLVhWyGD7ov8zjG50+jUBeDhlmAY33kUZes07ZpkJLzJuYfyObt1xJfD3POLIBphmxgRRYtoU/6xdKCojBkko2+U547Qqrxfl8lYpnPMxjrnYEl2qVDiUkk/IM6CQFkcgZ/uBYG45fV9nkVvT1yzBEiwNu7pANiLsJTTjtiUJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O5EyoHLI; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ee18a21886so7732521cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 08:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763395231; x=1764000031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFCLv8SrKLLdHd1BTr34c+OpWZv8CYrj5E911NYrygg=;
        b=O5EyoHLIhbrQuztPhtUFu74iYvDbavEgjlvI3ocBpCsWgvRTYhekXKOyBqMvrRZgS5
         XtNhz/v05SOPK6Bmy8b1MT4K+92OCcHdpXyynn27yKtp0kPfVa/IHLSeZewoV6QCLxbd
         MvN4HIIiMY0vWcBc0p8nzuyeCMkpvTtB1pQCEu5eKXqU9jRiAeDPJm44wE1iCbg7JoXw
         ZOlr7F/M3C0jBYGrBrZpLhT+2GLRIEaCRvM76q0dEv613B3JOSGmZpy1uj7v+Q0n5l9X
         th9gNsW8s8wDzeCjDu61LIPxThJSarYueYtavnLaOPFblcu9AWJvuNATHHb9AmOXfgo5
         olYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395231; x=1764000031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFCLv8SrKLLdHd1BTr34c+OpWZv8CYrj5E911NYrygg=;
        b=ZW3gYgUHiMELRlpJ9yJcgTOS3Scm/F6/gvbJ6vuAfsMh7/MMe1VMdSTqjlWPu2qVIT
         fz9rCc/t7TY9P27/apjS7xE8ccj0VQpUg9ZON867mmy8G5+luX23lsPN9OzSObpW3NA9
         Hsr8HjTDBA8J5Bno2AQrgUU5KhpzL8vKcZS2O4BR0UALAvH9kcXiTC87JuT1EXnLOfED
         kfwYF5WLJjWSU8xqKF37Qv9/+uJF/xqvvgaPNYTfEICpBlaLHebQSDVB+8yLc1uTYOYf
         Oz0pcb7FG1LeNxuyV4DmPECGdw7bEeMySJsWG9mDtjkFCL5sAzadIBWuYSP4uVClwsQV
         tNhw==
X-Forwarded-Encrypted: i=1; AJvYcCXhraqeSYE0E2gphkZaBjcrzB4jtAr+EwKQJJcYBZm62JA+H2uH1vPzppC0TQAVt2istWFuuSpFavCp@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOHACQSKjI5gwEdT7aL+FCYlOoWANdKyi5//ELyJnmWa+DSe8
	Yl0lS6CpPBdG8bMpHSc8nGnuOfjb4N37894pY9FVhkNasm9yMNLYm4VWwH2VFNoh5OjtumR4cTM
	0FrzAdttgQQ==
X-Gm-Gg: ASbGncvpZwTYsQxGdB6YK3IvUaCj2NwLbHTTZk42I+w+vz2GYF83F/7aGRD27vIUaL8
	uejaIxPPIf18obhzfp4vPdEd0SvJFrj+wJ7ppkqy14T06cbNS+z+i34QAubpqr7JwlagTAuUp6z
	p8/9hnADg8JEd4hxB0az++bVyui4ZtwLmEH7ngDKPDmIwWXO2gJRZj3iI6tslpUUd7lGe3EyWRl
	XIEPCWCvBOfThPpuHmC3UDbKldmIQyDlGFK9Xienn3LGG+MlySetjMorfTAiFWPwwOfLX6UFGqZ
	QMMv4ZQjpYDuoVyYUbcIublPDNzG1fzD9zV8+jtQ8OMAM1rXi5Z0YjU1DgPIo5UoY6iAwvgZwJ8
	b6QUVwc5yAro/6vukRlFwZmxVdBw1lPz543LXMerAsmKMlBGg81xT3gC2DDDUG7Yjp1hQov+vXg
	gehaUS1BaStPJfEDOT8abOSOGC96jVs4hSXVBSNIS8vTNAz1tjQ0Km6IKO
X-Google-Smtp-Source: AGHT+IHbSQImGkihOS5IZmENbT3R5EBp3J8G7fdTRwsSVJjLa5azC+CHu51Ebm1tLe+D3yglmQCuLw==
X-Received: by 2002:a05:622a:1453:b0:4ee:2e6e:a0f9 with SMTP id d75a77b69052e-4ee2e6ea38fmr9781441cf.35.1763395229938;
        Mon, 17 Nov 2025 08:00:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862d04e1sm94957706d6.7.2025.11.17.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:00:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vL1eW-000000004wY-27Uj;
	Mon, 17 Nov 2025 12:00:28 -0400
Date: Mon, 17 Nov 2025 12:00:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20251117160028.GA17968@ziepe.ca>
References: <20251113213712.776234-1-zhipingz@meta.com>
 <20251113213712.776234-3-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113213712.776234-3-zhipingz@meta.com>

On Thu, Nov 13, 2025 at 01:37:12PM -0800, Zhiping Zhang wrote:
> RDMA: Set steering-tag value directly in DMAH struct for DMABUF MR
> 
> This patch enables construction of a dma handler (DMAH) with the P2P memory type
> and a direct steering-tag value. It can be used to register a RDMA memory
> region with DMABUF for the RDMA NIC to access the other device's memory via P2P.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  .../infiniband/core/uverbs_std_types_dmah.c   | 28 +++++++++++++++++++
>  drivers/infiniband/core/uverbs_std_types_mr.c |  3 ++
>  drivers/infiniband/hw/mlx5/dmah.c             |  5 ++--
>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 12 +++++---
>  include/linux/mlx5/driver.h                   |  4 +--
>  include/rdma/ib_verbs.h                       |  2 ++
>  include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
>  7 files changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/drivers/infiniband/core/uverbs_std_types_dmah.c
> index 453ce656c6f2..1ef400f96965 100644
> --- a/drivers/infiniband/core/uverbs_std_types_dmah.c
> +++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
> @@ -61,6 +61,27 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
>  		dmah->valid_fields |= BIT(IB_DMAH_MEM_TYPE_EXISTS);
>  	}
>  
> +	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST_VAL)) {
> +		ret = uverbs_copy_from(&dmah->direct_st_val, attrs,
> +				       UVERBS_ATTR_ALLOC_DMAH_DIRECT_ST_VAL);
> +		if (ret)
> +			goto err;

This should not come from userspace, the dmabuf exporter should
provide any TPH hints as part of the attachment process.

We are trying not to allow userspace raw access to the TPH values, so
this is not a desirable UAPI here.

Jason

