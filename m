Return-Path: <linux-rdma+bounces-18101-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOqgK7uvsmlGOwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18101-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 13:21:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C72719B2
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 13:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B47030451CD
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89F523ABA8;
	Thu, 12 Mar 2026 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lf57U9if"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792BD21FF21
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318062; cv=none; b=plKvPhAYyjsO3io87fTDOGaWYQg8wj3wIepuqp17VzpSoV1YXZra6MTZBIHNxf+kg+Z1jw6Ksq1f8jbRmFitylFWUxj+JAqDqt4VFAf5jRejPITrA4nUJosTMRpIAPL0wjlFtuIGvKXvAU775uMynTL9OqbxrMnoYdoGGkZLe+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318062; c=relaxed/simple;
	bh=ykZqC/Mt6PvknDhYlKuIL2nlRrianZMm9PtDxixDlPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLbBKj4V3OtzpfhxTqChaBnPq+45JeR/o11acDnAHqsif5B+y+U6/xzd3B8kWgiZazp2mztS+MYbU2LyYRcbcipFOfoFru3SlH1iaX27XcBMZKqMhoyFqW+dRgISd/AUHmJgnFFWWCuNjfXmnMkAvawIpLIaPH4INCCj/Yc/8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lf57U9if; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-509064418a8so11554471cf.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318060; x=1773922860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5rN+Dnt+nngZKc/HxpCY0GaFz9G0vHdC78c5bVshyI=;
        b=lf57U9ifEBLyWexzvIhO+XWU98aspeK4epPDkVo+bdUc3uTnRHFJOzAQFqtZnirpvL
         k8WeXlvvSI8u+12g+H+RomdTCxvAsh3kAn5N2BjPPi8vq94s6Oz20FKmexletPuH9CDd
         kY6PAL0+tgqYeVJyO+vItC60qEHK3ThnYf/UD0MFEEj1sd/5cHAqC+CRrRhfsPUeevgk
         NA9hIOWisR9ITVunmGpPNJjiTOXkD9H2lvwvenW8CHns6evMimwcZUGyabHMruJwxAaz
         pcI1HmQBIrJQjeuMNGr7o3dWdYRxf7UmUrzRdYCqQcdIWMOebcd7mYF5Bal6OCbsQR4Y
         5nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318060; x=1773922860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5rN+Dnt+nngZKc/HxpCY0GaFz9G0vHdC78c5bVshyI=;
        b=sRXJqOPh0aKkiff5WX5X7K7Hzq9LMtOdq17NYEwIhUqLpWZKFCOpJUyOyTKzyKtKHb
         B5D+ALUfP0vIdZ5qRSIjT7YnPx/P+Vte4YAg8UOTZLwFsA0v/4nDUnxbh1un246IVlab
         QLrBc/HZRAacS9xGETc4RYQkBc4BtJH3lZtYXP1KwFq1QaXBEH960U/Hh9ta/7+cCjTv
         W5aukWtpNpZ6xSoWfjR6MzCepKi4q2iOKPArnhWcEEgsLKLga5sKfv2I3yjyGc+HTeRu
         cl/RDaLQjEnWnNWi/b19DBokKTT1+so0uoceMm91Q0PHOsrHR6ktd0g+LBzlte2rZvlu
         H78Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuE+Xcm5RsLgdwLmofpn+JDYI8QduYQ+6H7GDGbTdq8lj62fGq6E2178HVi0gUV8DDQ9vBmKsXq6Su@vger.kernel.org
X-Gm-Message-State: AOJu0YxVcqzCczjFim0JRXlxRw8quAepZrAHK44ZQA/5RMCUKfeb8Doc
	1KlXdzHXJeTlRKs9NqwthlH/xC8bMJJ6KgAu9mxuxAcFySURxuLVpij8/Crl2u+A1SU=
X-Gm-Gg: ATEYQzxwZWKqNS8uPps5eIPigkl4mmeSodWZdfPX33ZIF45KmKuq7rTRxXiK6Hwz1yW
	SIpIhgwOASZaGvwcRinSqoF3KvoM0Q1gJbqLFwDUfEANk9Iqyp10afBlPjWgCCQ9unAkMTjESu3
	oRODXOijk7ilenirQQYGXnPlvPC8nJPF+TtLixMpDxkrhg6jDlZuhs6jtKxvrdwCCGPbXWZUZvw
	fC67jTPS+4WQoRMkQeqgBEz+kEW/wh33BbYom2ucavixRT1NA0iamdy3BgoqGvxc9Glq4MC2nTu
	zjYbZPaCr6LyTSEC+fnE5QFTS1rwZL1yoIrvid0SfViDS8ZXvHmVsj4SAFZGQmkyAhscCRKthij
	7MQo1QBO/bomeeALG7kXl1ecRKmsiSibGngmmc5KnFCPNXY0W+i2eXQRL1Wb43mNTBl03sKEls9
	dtSyHAliQ8HDqJmEK7rwXJ9L5M8bIYKTx3tHnhAd9tU/iQGUBzlg385kdT63NxMo+OEjcAD6b9r
	u+n4pTfF/EO5VPfBuQ=
X-Received: by 2002:a05:622a:11c1:b0:509:4410:4492 with SMTP id d75a77b69052e-50944104900mr62025551cf.22.1773318060513;
        Thu, 12 Mar 2026 05:21:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939ec5017sm30688511cf.8.2026.03.12.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:20:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f2A-00000006et5-427z;
	Thu, 12 Mar 2026 09:20:58 -0300
Date: Thu, 12 Mar 2026 09:20:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/8] dma-direct: prevent SWIOTLB path when
 DMA_ATTR_REQUIRE_COHERENT is set
Message-ID: <20260312122058.GE1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-5-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-5-e00bc2ca346d@nvidia.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18101-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 284C72719B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:08:48PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> DMA_ATTR_REQUIRE_COHERENT indicates that SWIOTLB must not be used.
> Ensure the SWIOTLB path is declined whenever the DMA direct path is
> selected.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  kernel/dma/direct.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e89f175e9c2d0..6184ff303f080 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -84,7 +84,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  	dma_addr_t dma_addr;
>  
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (attrs & DMA_ATTR_MMIO)
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>  			return DMA_MAPPING_ERROR;
>  
>  		return swiotlb_map(dev, phys, size, dir, attrs);

Oh here it is, still maybe it is better to put it in swiotlb_map() ?

Jason

