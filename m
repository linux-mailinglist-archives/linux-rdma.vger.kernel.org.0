Return-Path: <linux-rdma+bounces-21404-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELzSBomJF2riIQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21404-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 02:17:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C30B5EB338
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 02:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEE08301D314
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 00:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C014B3438A1;
	Thu, 28 May 2026 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pVB+WAyR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44264
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927298; cv=none; b=N1+I7cpD29RQ/WMwNYZAlfi2tF22/xKy0UqEXy23Goz+yhsxAqWuyL7hW71OIlmOlM2GlYGzoxyT2HDlXV1OUtnsZdTYH0j9lhYZAl7I5xKKxt0Zqeeb4AtLGiCFly+HGbbROnAd43b9h1DH/HoYnXbFo1+AX5ws9gc3Bl9tRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927298; c=relaxed/simple;
	bh=fziVrkI884eZ+x51haHa0AQufT9/OVIoU1+h1hOfPdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz1uCvRDvW7dHoIedFze2o1run4hcOT7w7ypI5WpXCY4JXzgEYmzgE2BsMGlr9zPc7MImq5/Fdz6QNmg46vBpp5/FU7ANvo8amnXXDtnfoXCg5Tw/X5l7xVhYqcrvo8IO+FVuK2u0bsqLWHqr7mYjXmfjHxJecSgGqOl47Ls7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pVB+WAyR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso141097236d6.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779927295; x=1780532095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shiZhttA2ogKEMjFWhpk+1hz7hkkeXX9L7uvpDz/1oc=;
        b=pVB+WAyRkAxIoTn4MWgj66ACAVUAfL5apYs/T/9OngT1cQ22nOmX7w7Va5i/CVn3uZ
         CY+hoxo9BvQhWXna0Hv52bDgS+ZRiCssJA/EB0XNU1Gxo9U1DcSJsLXpHPLkTw2yqiej
         SnS7ueY9Yiz57QS3wCVoI80C+xkq/UaOOfdqlz9Hzp0QF3LwRewWeVM1wAhcL75+Y5gO
         YHHLtSwLQS4sgJMfbVX8Tz4tNKCC2Lj96gOh4cY1Mzwmgq4qdmCNN0mRV6sJf8AWFD3Q
         WWzlIiQbpIJjKiBubtOdQydg/GFERHFE7vxILfjEWSnZLKvdg7NyNdafzdWCPBofMqoj
         Su0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779927295; x=1780532095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shiZhttA2ogKEMjFWhpk+1hz7hkkeXX9L7uvpDz/1oc=;
        b=LyZ6jNAGn4Xuj3ybmtTmgjNRbdvJVWTYyvqmdAcdjjhgE4hVkNg81EciUTuo6tWCZq
         N0SuWp67wTkEfZqxD98R1QT94scuYMtEiOrbAMtbHIbsd6DGD9CjgbRlAwRb4+kxlcTQ
         23FAOC9vy1H75iVfCYrXuNP0HwkjSlgG0lfiPPnP1GyTxkEAAWbbXRf06m98b5qnWe41
         hnpu0wr10Yo4B88mDnN7j4fBJb/EK5/1/FE8O+RpdsWvEkvL1FgJsY29v1N0zxGPMu59
         r7U81gGWG4kt8Wj7gMyt24o4ZXrk5Ym6N8a4fA7hpQTdbfl/z19kJha4oxuO1vW95ANI
         Dqlg==
X-Gm-Message-State: AOJu0Yz465uZ6MMTW9BzCTOT0BmTEphA1c1R4XucscxpdMTV9V4cnLVP
	fRrGcTKWDokQpz2XCBqgBdtJsr5VQVCl+trBS1mejoMvt582fbHKCYHboTFgL0VUr10=
X-Gm-Gg: Acq92OEuX1H20xtsBi8ujqoBe0L5X9GcxzeLmFuPDgnO0LMl3rXzVWi8Xi3tbwmpgCL
	KzqIFJW77saci5X8giA9q8xPCnShXi5fXp3TXoFRgL0AqRXprA8r2LRViHpNw7qXu6BxA8oBq0M
	pkRl0onD85Fj8ht3418e4odIfPZd3lYCzZIYS/6vN3NGRoYlC1n9uYUB1x5oNy9XdeRMJN5cG20
	bPMsGM8kkT7MdwBL8+sesG9esKaD3EMqff6ihcY0ml+HH809uLzvajoMpVRZgn+TOpYnIVyounw
	pGIfbuy6whDUGSf67JLhfqAPabjGqHjnq5fM7tK5h+rzx5SXRgjvose3YGMpnxGRGhunNO2K8t7
	cbowWmeFj1C6i2smUAM39LZNAFJv6bxpZodn1705mO+gkwE+dIhNSzuqHjjs2CWTiBJIuWu33hm
	CJ8Qj348dZUduWc+zGZl2Py5UrXTG6O2/rsP8e38mnUgw1cEEvCYaL3TbVxjGj60VHASB51Shqu
	5d+6/sNOduuvYIK
X-Received: by 2002:a05:6214:3d0f:b0:8cc:58f2:339f with SMTP id 6a1803df08f44-8cc7b61c78dmr378385676d6.16.1779927295273;
        Wed, 27 May 2026 17:14:55 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80deae74sm183159456d6.11.2026.05.27.17.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 17:14:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSOOk-0000000FcwU-0VeL;
	Wed, 27 May 2026 21:14:54 -0300
Date: Wed, 27 May 2026 21:14:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com, jmoroni@google.com
Subject: Re: [PATCH rdma-next v8 14/15] RDMA/mlx5: Use UMEM attribute for CQ
 doorbell record
Message-ID: <20260528001454.GD3528738@ziepe.ca>
References: <20260527170948.2017439-1-jiri@resnulli.us>
 <20260527170948.2017439-15-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527170948.2017439-15-jiri@resnulli.us>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-21404-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6C30B5EB338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 07:09:47PM +0200, Jiri Pirko wrote:
> -int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context, unsigned long virt,
> -			struct mlx5_db *db)
> +static int mlx5_ib_db_map_user_desc(struct mlx5_ib_ucontext *context,
> +				    const struct ib_uverbs_buffer_desc *desc,
> +				    struct mlx5_db *db)
>  {
>  	struct mlx5_ib_user_db_page *page;
> +	struct ib_umem *umem;
>  	int err = 0;
>  
> +	if (desc->length < sizeof(__be32) * 2)
> +		return -EINVAL;
> +
>  	mutex_lock(&context->db_page_mutex);
>  
> -	list_for_each_entry(page, &context->db_page_list, list)
> -		if ((current->mm == page->mm) &&
> -		    (page->user_virt == (virt & PAGE_MASK)))
> -			goto found;
> +	/*
> +	 * Only VA-typed descriptors are eligible to share a per-page
> +	 * doorbell umem; FD-typed descriptors are pinned individually.
> +	 */
> +	if (desc->type == IB_UVERBS_BUFFER_TYPE_VA) {
> +		list_for_each_entry(page, &context->db_page_list, list) {
> +			if (current->mm != page->mm)
> +				continue;
> +			if (page->desc.addr == (desc->addr & PAGE_MASK))
> +				goto found;
> +		}
> +	}
>  
> -	page = kmalloc_obj(*page);
> +	page = kzalloc_obj(*page);
>  	if (!page) {
>  		err = -ENOMEM;
>  		goto out;
>  	}
>  
> -	page->user_virt = (virt & PAGE_MASK);
> -	page->refcnt    = 0;
> -	page->umem = ib_umem_get_va(context->ibucontext.device,
> -				    virt & PAGE_MASK, PAGE_SIZE, 0);
> -	if (IS_ERR(page->umem)) {
> -		err = PTR_ERR(page->umem);
> +	page->desc = *desc;
> +
> +	/*
> +	 * Normalize VA descriptors to a page-aligned PAGE_SIZE region so
> +	 * multiple DBRs that fall in the same user page share one umem.
> +	 */
> +	if (page->desc.type == IB_UVERBS_BUFFER_TYPE_VA) {
> +		page->desc.addr &= PAGE_MASK;
> +		page->desc.length = PAGE_SIZE;
> +	}
> +
> +	umem = ib_umem_get_desc(context->ibucontext.device, &page->desc, 0);
> +	if (IS_ERR(umem)) {
> +		err = PTR_ERR(umem);
> +		kfree(page);
> +		goto out;
> +	}
> +
> +	/*
> +	 * The 8-byte DBR is programmed to the device as one DMA address,
> +	 * so it must live in a single contiguous DMA segment.
> +	 */
> +	if (!ib_umem_is_contiguous(umem)) {
> +		ib_umem_release(umem);
>  		kfree(page);
> +		err = -EINVAL;
>  		goto out;
>  	}
> -	mmgrab(current->mm);
> -	page->mm = current->mm;
>  
> +	page->umem = umem;
> +	if (page->desc.type == IB_UVERBS_BUFFER_TYPE_VA) {
> +		mmgrab(current->mm);
> +		page->mm = current->mm;
> +	}
>  	list_add(&page->list, &context->db_page_list);
>  
>  found:
>  	db->dma = sg_dma_address(page->umem->sgt_append.sgt.sgl) +
> -		  (virt & ~PAGE_MASK);
> +		  (desc->addr & ~PAGE_MASK);

Sashiko pointed out this doesn't quite work, if the desc->addr is
PAGE_SIZE-4 then it will compute a db->dma that goes past the single
mapped page.

Something like this:

+#define MLX5_IB_DBR_SIZE (sizeof(__be32) * 2)
+
 struct mlx5_ib_user_db_page {
        struct list_head        list;
        struct ib_umem         *umem;
@@ -53,7 +55,10 @@ static int mlx5_ib_db_map_user_desc(struct mlx5_ib_ucontext *context,
        struct ib_umem *umem;
        int err = 0;
 
-       if (desc->length < sizeof(__be32) * 2)
+       if (desc->length < MLX5_IB_DBR_SIZE)
+               return -EINVAL;
+       if (desc->type == IB_UVERBS_BUFFER_TYPE_VA &&
+           (desc->addr & ~PAGE_MASK) > PAGE_SIZE - MLX5_IB_DBR_SIZE)
                return -EINVAL;
 
        mutex_lock(&context->db_page_mutex);
@@ -132,7 +137,7 @@ int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
        struct ib_uverbs_buffer_desc desc = {
                .type = IB_UVERBS_BUFFER_TYPE_VA,
                .addr = virt,
-               .length = sizeof(__be32) * 2,
+               .length = MLX5_IB_DBR_SIZE,
        };
 
        if (attrs) {


Jason

