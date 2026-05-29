Return-Path: <linux-rdma+bounces-21524-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGkxLLnlGWoZzwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21524-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 21:15:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F421F607BE8
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 21:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F9A23010DA0
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC7409602;
	Fri, 29 May 2026 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ZZhhZimc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442524014BB
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082101; cv=none; b=BS1IXaXrVwh1ZaGr/6b6ApM33T/5Erp/c8HF9dQ8bIu2h88s2d7cL6EWqjgJtFh2rREylQMJU1ySWEmiw6JGzBUOELPb2TwMnMHwV0OPCbmSqN/KwgqrYRubx6apGlEWX9+50sfjhRQelFXyyDTx1dBkN9DOofpW+P71naFfjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082101; c=relaxed/simple;
	bh=I0oD+2cZ9HZkGJfBHohNH2T3X4hUuvLhFMMieKU5KJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DafsMxoTll9FKh4HX/rLpXnIG6Ema9SZsUJTdOSMGNg/ZKmV96uKKn/EfPyqJkdklq3Q74cSbieSX3lJiRFGu5afAjP9I1ykDEFaKs1+cm1ryGRk3IQbG64bOFRft+Cj0+AW/IMkwFbOwU083HRVeuYH3CEI/nkVH9fTrKoFB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ZZhhZimc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd85ebb368fso2123378466b.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780082096; x=1780686896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQii5vdeYwVCKypO8ITf6fSTLxR48S1Ly2XXBNJOx2c=;
        b=ZZhhZimcNvHNp/69+Arr1tHgX1RVgegIuSvMGzRxGyWKJYjAVjG+5+v2rYfbW/4jM9
         J4IX9sfuCOki0R/wzlfcZgS6WHklcCI3saAPrPSKmRDaOmd+UhMr2yfX2kDdAu2blBS9
         f6vjAEsjD1Vdl/R9DgfjVYAKTRnkRloz9LkvzfFHrbwrQBa8JlIZde4+V56EZ5L1bmZL
         bBK8vanuF1vLWO2RqLVtAU1lnRnlRlv/GsyYBU/13x1br/Bl2lch5KgVuuxVVlGpfbLd
         CgwjvcFaS35pgt3lZ5CaW80phsQfTvmzOn6126s6JMx0vG8N0uSxtCIFbho3N3dKTps+
         xSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780082096; x=1780686896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQii5vdeYwVCKypO8ITf6fSTLxR48S1Ly2XXBNJOx2c=;
        b=XjTv1Ul8M/5H+MgDga96hyZpT4TVS7qKaZv4JSL6qHOOH9exAPlnPLZ7HOSQuCDVDh
         Y/yxHez+oYlT+KzxhXR3c2I6yie4mKYUmPbDi5hsxW95BGQnhK/6nuWZI4T1r8GblBEr
         2E95oh+/T0ecyEHkgudGWjlqUgOsHnmQ+kLEeox1WCrYNKRFKJIivlMgFKGIF8zSs8Gh
         WPSqw7SwAXfIfsRqEbGgREXgCtQfwraVAUt4YpGD5ZZPe/igpzUe4Op4WMc2v24gvWbr
         PU67KbLomEc5nopVoQIsm66I9MUmjVBwrEEj7XThHD7HXu7uBq8NsfPZCuPGtDpPbqyp
         oHuA==
X-Gm-Message-State: AOJu0Yx4Z98NEgzGT1Q6CAnHHgbsYT+ourumZubFKmpQhv016cnWP1Da
	2val37tw1tOTqRA5TGpmenAIa/Xg1bgjXfFZzCdD1Zs6ZSaxqCPQVy4k/LnS6Uaf89RRr9VuuX6
	Wx6EHymLx4w==
X-Gm-Gg: Acq92OEC5kGdt/PrCGIhiRjU1DlWfn8HUVRJZhE24bZkpZh/W+b1DHkiZiZV68Xnoec
	bZFLB8dtA4bKTKV9HQ4XktwSJrQytxvYrdnhSJLRi4tcPil23a6+rKggj1zdKEVO8Oqz9MXHgAm
	JzcMc6qOl/xpump7G22+eotYDC2wSrU9nhBn6fmERSd7m/jW1Z1Nl66Wzp31GGWAt6dKFXIRLv+
	0/8LLHq3islWjJ1Lvqcv72I8KorF7WleHGdE4yhHAp1Cpfhv85+VT0+AY6VIjdxU1mjiQ6RYM+q
	wuoi64IILDrEN5bZnquF9fS1CVaSzR4/+2Z7d9CfS6J1DRTVBM+eugHlrz+ygjbNMoUiPx7xgAs
	oqoEi8Hvuv9bFVWw5elilcID+8/GIBy+OIHX83ZNASNuGCza5ZazJWMDEJ1jPlYAgBSTv1Njkp7
	kG1VN1yM2CH4ZJX1Mk4VtErMg656lDoAO0DkjDP/7TAKI=
X-Received: by 2002:a17:907:6d16:b0:bd3:66e:e4f6 with SMTP id a640c23a62f3a-beab3d3a75amr51444066b.20.1780082095934;
        Fri, 29 May 2026 12:14:55 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d27f2258sm92550566b.9.2026.05.29.12.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:14:55 -0700 (PDT)
Date: Fri, 29 May 2026 21:14:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v9 03/16] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <ahnkoTRWKA3r1RJ2@FV6GYCPJ69>
References: <20260529134312.2836341-1-jiri@resnulli.us>
 <20260529134312.2836341-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529134312.2836341-4-jiri@resnulli.us>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21524-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli.us:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: F421F607BE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fri, May 29, 2026 at 03:42:59PM +0200, jiri@resnulli.us wrote:

[..]

>+struct ib_umem *ib_umem_get_desc(struct ib_device *device,
>+				 const struct ib_uverbs_buffer_desc *desc,
>+				 int access)
>+{
>+	struct ib_umem_dmabuf *umem_dmabuf;
>+
>+	if (desc->flags & ~IB_UVERBS_BUFFER_DESC_FLAGS_KNOWN_MASK)
>+		return ERR_PTR(-EINVAL);
>+
>+	if (overflows_type(desc->addr, unsigned long) ||
>+	    overflows_type(desc->length, size_t))
>+		return ERR_PTR(-EOVERFLOW);

Sashiko says:
Does this validation evaluate potentially uninitialized garbage data?
If a user passes an invalid, unsupported, or future buffer type, the
addr and length fields might be uninitialized garbage. Evaluating them
before validating desc->type might cause the kernel to return -EOVERFLOW
instead of -EINVAL, which can break userspace feature probing based on
error codes.
Should this validation be moved inside the cases of the switch statement
that actually use these fields?


Probably this may be hit in case some other type does not use addr
and length (how likely is that?).

I would sanitize it as a follow-up if nobody is oppose that.

[..]

