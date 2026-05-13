Return-Path: <linux-rdma+bounces-20608-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAG1EdLRBGr0PQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20608-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 21:32:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC004539FC9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 21:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFF843004628
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DD73B52FF;
	Wed, 13 May 2026 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="zBsaRZBh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD33B5851
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700738; cv=none; b=EkVpqRC8qQkDlduFWZrCwPeo1ROkfLA4n3SWbzWUY+5e1ZHPl98M6mdcoJIOkllwe8wXQbdO7e0AFOWtmdZXSFrDq+P4uzg4kGh5Y1P14RW09Ht7oIHK46JktNQcl6MOyP7MkTJMhI/ryZl7b6E4NlRUNr+uLbJcLyJGpwWoTt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700738; c=relaxed/simple;
	bh=FV1wvkEr1hkMBV98GzC1ZC3mndbL5OpEzZlXBYb/Lcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1VXurQOT7JbHbXGqPvhXFadXgletsLcBhzrTcL+i4OXSHkFh3fC1mCnLUTFWe0Q0xeQDh52lfxW9nnytOz8Bhus6it7IaIwrzIBE2I5/Hadm8tN3D5DMt57xhsTDGsklzH8UtbkC8D8H1EI2JF1UTISve++M0QQtkDmoWiSPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=zBsaRZBh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso77257895e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778700734; x=1779305534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dlm4i5NMrKNTEC4ZqjOVb+kRQ6vQi0cRtzbDPig6bpI=;
        b=zBsaRZBhNaxy4+gWNmRV26vuwcHLE56ZMdWW09R+dSKlO3DN/ymjDre81iTt/6JLCS
         UbDFdTU5CgnUIT4EilbV4UQYnZLiia2vE1gtekjPOMGkvKpymkGxfrQtv+KgpRtHVaG4
         ems2mIroKRC30yHdpqOZoRCVLG1gdlbV9jmU+OwiklvJPDJc3K50BsX5Nk2lMIOdgvZ5
         +wtjyktN/6FUpbrQ7aMMYkt8/2VdK5vE/qWfa8mdrvdXrUHK5cvdyNQ74qPbSqy4bLjb
         OArXUFRgJ0oXTb8PB/iDKBJhxZ+8uV6G6C2hlc7pf28mA0ny9RpdSJWmGYrVY8nxsYqe
         YGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700734; x=1779305534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlm4i5NMrKNTEC4ZqjOVb+kRQ6vQi0cRtzbDPig6bpI=;
        b=YOChncdtRoKDCtgL1vIwa6Vn4hq1WGOLKM5DJBYUNzIS97OEAJ6+PNyVRLJaLuORz7
         UyDfp3HsmwJvg0vmjlm6GUSIXHZ5wrC48vKxGSlpMET3x/TFRy5maf/EF9dOrVGR2rRE
         HWgb3o+3NJBBAvrpVbCBOFXoEqMlgaJR6YLnRq+W823mu+j4YQ8oT3t2hrO9bVs/WPno
         7qwGkM3z8NCol2INMQW1tYcY5OcthPEbhQc2WupQZdnt/dMLPMVI/DKMtW9N36zqIzPZ
         SIToc8vQHHx+7xBQgrTUi1J8zJ2OpjkUwXqc5fC4QxJNIG79pt/9BMbJ3y2h+x3j6X+O
         1u0g==
X-Gm-Message-State: AOJu0YyDzO7RSLZX/MXZBSUoy29ut6szO02Z6mADDEuQ9uO/gxDAHfeJ
	SVOMlQQ5t6PosZDhjofvWMaIOdXlZ3Jm7jwnkms5iHPDnCF2X6uGl/db0hUByz9C5nc=
X-Gm-Gg: Acq92OFFRs7r3+XJE++t1EQbjB0FKe8gYU8l8QLUU2sMOIx5zPh7gueDfS+nE0Gku+o
	rHppPpFsIIXW9bcVB1SUaHQ6nqVKJ83vovctyJXwpWkWCWSO0PA3U7GcRHebNNE8rFiL3VUo/r2
	rcmpsZ9m0pXbX89oXUFj4w1z2zR/x1VXYlt/A+/MCfJ4OAz5iPMfWzFoLoKmHPUs4/SHzvNno03
	gGbrs04anhsL2/5idWliCtbdMahduyNiLs1AmtZP/PNje0ebPg6UoKKScKMsXPhOTHPaLlS4V/z
	DA+hB3WDYDLz99OgLpimkgH7WNeLBtEgdi1n9wykrh8r92TLOzXG5sqmrPXmqY7aI3tfupcqEdj
	SL5LipHHlH465ACBfJV9WVc7bmRHHvp8l+nSAzk4yVQ4dw9c4rKfHwz2/ocp7B+ZQ2jHhn4i0NZ
	L2uzOuglpjgbQYM9tim463y7zfen0p+CDllYLj2xvwjlkJwCVMif/XLlDU
X-Received: by 2002:a05:600c:8b75:b0:48f:d612:3c40 with SMTP id 5b1f17b1804b1-48fd6123dc6mr19964385e9.7.1778700734392;
        Wed, 13 May 2026 12:32:14 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd62b2f24sm6044845e9.1.2026.05.13.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:32:13 -0700 (PDT)
Date: Wed, 13 May 2026 21:32:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 15/16] RDMA/mlx5: Use UMEM attribute for CQ
 doorbell record
Message-ID: <agTRkNEZY0_u8rnL@FV6GYCPJ69>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-16-jiri@resnulli.us>
 <20260512192134.GK7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512192134.GK7702@ziepe.ca>
X-Rspamd-Queue-Id: EC004539FC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20608-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 09:21:34PM +0200, jgg@ziepe.ca wrote:
>On Thu, May 07, 2026 at 02:52:30PM +0200, Jiri Pirko wrote:
>> +int mlx5_ib_db_map_user(struct mlx5_ib_ucontext *context,
>> +			struct ib_udata *udata, u16 attr_id,
>> +			unsigned long virt, struct mlx5_db *db)
>>  {
>> -	struct mlx5_ib_user_db_page *page;
>> +	struct mlx5_ib_user_db_page *page = NULL;
>> +	unsigned long dma_offset;
>>  	int err = 0;
>>  
>> +	if (udata) {
>> +		struct ib_umem *umem;
>> +
>> +		umem = ib_umem_get_attr(context->ibucontext.device, udata,
>> +					attr_id, sizeof(__be32) * 2, 0);
>> +		if (IS_ERR(umem))
>> +			return PTR_ERR(umem);
>> +		if (umem) {
>
>More IS_ERR_OR_NULL stuff..
>
>> +			/*
>> +			 * The 8-byte DBR is programmed to the device as one
>> +			 * DMA address, so it must stay within a single page.
>> +			 * An 8-byte range that crosses a page boundary may
>> +			 * be split across two non-contiguous DMA mappings.
>> +			 */
>> +			if (ib_umem_offset(umem) >
>> +			    PAGE_SIZE - sizeof(__be32) * 2) {
>> +				ib_umem_release(umem);
>> +				return -EINVAL;
>> +			}
>
>I think this can just be ib_umem_is_contiguous()

Right.

>
>> +			page = kzalloc_obj(*page);
>> +			if (!page) {
>> +				ib_umem_release(umem);
>> +				return -ENOMEM;
>> +			}
>> +			page->umem = umem;
>> +			dma_offset = ib_umem_offset(umem);
>> +		}
>> +	}
>> +
>>  	mutex_lock(&context->db_page_mutex);
>>  
>> +	if (page)
>> +		goto add_page;
>> +
>> +	dma_offset = virt & ~PAGE_MASK;
>> +
>>  	list_for_each_entry(page, &context->db_page_list, list)
>>  		if ((current->mm == page->mm) &&
>>  		    (page->user_virt == (virt & PAGE_MASK)))
>>  			goto found;
>
>Ah, this is why..
>
>I think this function should take in a ib_uverbs_buffer_desc and that
>should be stored inside the page instead of using virt. Then the
>functions flow doesn't really change, it searchs the page_list for a
>matching desc, otherwise it converts the desc to a umem and creates a
>new page. Refuse to match FD based descs
>
>That sort of suggests you want to split up the earlier patch so there
>is a seperate re-usable get desc function instead of bundling into
>ib_umem_get..

Okay, done that. Thanks!


>
>
>Jason

