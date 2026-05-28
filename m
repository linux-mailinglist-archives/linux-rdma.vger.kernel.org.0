Return-Path: <linux-rdma+bounces-21405-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EwLJ9uPF2oUJQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21405-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 02:44:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC5F5EB56B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 02:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6275330E06EF
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24C191F94;
	Thu, 28 May 2026 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lSwlVoDh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FF3438BD
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928863; cv=none; b=NKVatDYo+TnWaOaj7OkOXTigL/bIDC34MEdNWkwT/i1j1dzYYAr/TqatgWcL5/g4UoDo4rmpG/Ilt6ZeLATzyqPYNTrQxJFBPz95Xi0iOlmMm/45eY6bxjHdxUcWM2pdJRCzRkG6eYnkCrkoBLXgpPMXqagUjKYZPoUiRhhn1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928863; c=relaxed/simple;
	bh=py5nGrpSqggEafw75IyPQHUgctwvRblVTXiocZxDH+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II7/S1BxHfivU1HVqF8fus2uEDED4/1wrjnZZiSlkyidhNXcy1PW1syZIZTU55wS5FyN/hqhyzQddGp3LFGYHoNU7KT4deqPnGJkTO8Gic/JHg61/YZHQ5b8JmchfsEihvVDAoMP9XK+fMPqYTtgKMXsKaJt9NlpjE0CWxJzgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lSwlVoDh; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-914c1ced558so287759785a.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779928861; x=1780533661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZqJA5IRhzrmg+LObIx4zTSuB9andPd4wHFh6rtlki8=;
        b=lSwlVoDhcSMegrD285uyW8RYC4StNqSB3Issd7EMdIprfifkQhMU+YAFR77q8rUx/X
         ovaJSHvKdXWv7qvUR80k+rJCj+To7D+DtVDSZFVjv8YlxH+P1SqyOkpGlJAkH7tZSxpJ
         EmAmreWCrEvmcbk8DsEYqiOa5SM+/D2xz0bGqR/k2uwUCzCJ9qod9ZrKKigmsngL0WP2
         vXGjbkDDkmHazQE/Jt1kWjahIX7zJS6IrstDmTobE7abaJtD66DupTq1AVCRY+2HKxqh
         qKnQB5mYRGjCE0kc2pLWSzwifovYEmyno2KSWEIs1CmKjvs8H1qL+IlLawlCzE8eY6fj
         mGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779928861; x=1780533661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZqJA5IRhzrmg+LObIx4zTSuB9andPd4wHFh6rtlki8=;
        b=iRt1xZQfGk8klPnkExFtTpfai/rTyKmUNtjCF0uJcU7M6hNIIQqy0sn+y6OyGCxYQZ
         5OcaM6yfx7DfcMdhYC2VHTn5SVIR65fkQWK+b0zGbLHd8oELw6z7bUyVeSlA2LP+6013
         3p6mL4XaK0Miw7RjOp1IlcekzAt9vYfNQ4+wDkwkCR0f2n71VzLdbaV/dqYWEK14KH1K
         MOkCBPdb2qZ4Kap10FYM55gIlOjApXKJIrO7S+/SnYWaMP5eLlKavdujrSZSV1mvI9PV
         0NxvlJEkeJDITsGFZWdqnx35g4VDz4um1DNuXUrth/0HLXwrCS/J2LkkdQUIcoFzdhK2
         Lh6Q==
X-Gm-Message-State: AOJu0YyrCam14jW2hPAF/ADyhFQ0SyLBusGLREypbAvWqTL3dqUiXb64
	G62SUCl/eFnisuVPke7Pv3TDH6mjBZdO/GpjcBfS/43nHbn69FE3nGrSPvB5+H6Gv44=
X-Gm-Gg: Acq92OHmbN3MTjGh7GYslUK0N8rXALFwDzQ5Xf0qF1vFkx2D6Mn2bFWdUOi7m9mWTPD
	ZxumEKsuauKO4nNDuYBW0ZoZO8xrQ/UjjcNu9zlKcZ9kXNn4FWwE34iJNpYWxNJiYHsJtfOEvOr
	ojERJQ6WNWzmBk78IDzwnZ4Eh+cIyKFFMxEwNidSb/xplB+vkRR5rhZGLgoPUHtSgeL7aPLefep
	kFpJIP6B982IFQIGzTt6iR8hh0+qouUUTsOE15b8gjqUVcBPvplxFb3rFTjZ0x9udAW89vZ10fw
	DuucJ4lVSrxJwUKqriPCXFZ+pJhXorgJyGSX6w0FoguVHwQjc8rBmvvMeUsHfLT+yhq8OM7NrDL
	63nHyWeQ9X0x5i4V5vNKcZIuEmFSOzGSB8spucE39GiD/kQ3Hkt58ma8UH7zBrAJlnpprKaylry
	EBiFWO77ZvZw1HiEC5YfpU5v4zbeOxfdBTfPHqYpOpn8wd/PY37VjwI69YBBPZVcDn7qR4mgqFj
	CVMzuHq81g1gpKp
X-Received: by 2002:a05:620a:2413:20b0:911:f0ff:3d21 with SMTP id af79cd13be357-914b49a0a29mr2644113485a.37.1779928860836;
        Wed, 27 May 2026 17:41:00 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87d1a90sm693228785a.27.2026.05.27.17.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 17:40:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSOnz-0000000FeYm-1CAs;
	Wed, 27 May 2026 21:40:59 -0300
Date: Wed, 27 May 2026 21:40:59 -0300
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
Subject: Re: [PATCH rdma-next v8 03/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260528004059.GE3528738@ziepe.ca>
References: <20260527170948.2017439-1-jiri@resnulli.us>
 <20260527170948.2017439-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527170948.2017439-4-jiri@resnulli.us>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21405-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EFC5F5EB56B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 07:09:36PM +0200, Jiri Pirko wrote:

> +/**
> + * ib_umem_get_desc - Pin a umem from a buffer descriptor.
> + * @device: IB device.
> + * @desc:   buffer descriptor (VA or DMABUF).
> + * @access: IB access flags.
> + *
> + * Return: caller-owned umem on success, ERR_PTR(...) on error.
> + */
> +struct ib_umem *ib_umem_get_desc(struct ib_device *device,
> +				 const struct ib_uverbs_buffer_desc *desc,
> +				 int access)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +
> +	if (desc->flags & ~IB_UVERBS_BUFFER_DESC_FLAGS_KNOWN_MASK)
> +		return ERR_PTR(-EINVAL);
> +
> +	switch (desc->type) {
> +	case IB_UVERBS_BUFFER_TYPE_DMABUF:
> +		umem_dmabuf = ib_umem_dmabuf_get_pinned(device, desc->addr,
> +							desc->length, desc->fd,
> +							access);

Sashiko points out we are mangling types, and there is sort of a
systemic little (existing?) oops here.

The entire uapi is using u64 types, so all of these new functions
should stick to u64 types for all the uAPI data.

So this is good:

ib_umem_get_from_attrs_or_va(struct ib_device *device,
			     const struct uverbs_attr_bundle *attrs,
			     u16 attr_id,
			     ib_umem_buf_desc_filler_t legacy_filler,
			     u64 addr, size_t size, int access)
                             ^^^^^^^

And addr goes into desc as a u64.

But when we get the umem we implicitly cast away the u64 in both get paths:

		return __ib_umem_get_va(device, desc->addr, desc->length,
					access);

static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
					unsigned long addr, size_t size,
					int access)

Which is not ideal, it should fail if the uAPI has an unusable u64.

Something like this added to this patch will deal with it easily
enough. Someday we can push the desc down through the dmabuf callchain
too..

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 4ce7fbecf3bf30..dd994fc411642f 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -153,10 +153,13 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 }
 EXPORT_SYMBOL(ib_umem_find_best_pgsz);
 
-static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
-					unsigned long addr, size_t size,
-					int access)
+static struct ib_umem *
+__ib_umem_get_va(struct ib_device *device,
+		 const struct ib_uverbs_buffer_desc *desc, int access)
 {
+	unsigned long addr;
+	unsigned long addr_end;
+	size_t size;
 	struct ib_umem *umem;
 	struct page **page_list;
 	unsigned long lock_limit;
@@ -171,9 +174,12 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
 	 * If the combination of the addr and size requested for this memory
 	 * region causes an integer overflow, return error.
 	 */
-	if (((addr + size) < addr) ||
-	    PAGE_ALIGN(addr + size) < (addr + size))
-		return ERR_PTR(-EINVAL);
+	if (check_add_overflow(desc->addr, desc->length, &addr_end))
+		return ERR_PTR(-EOVERFLOW);
+	if (addr_end > ALIGN_DOWN(ULONG_MAX, PAGE_SIZE))
+		return ERR_PTR(-EOVERFLOW);
+	addr = desc->addr;
+	size = desc->length;
 
 	if (!can_do_mlock())
 		return ERR_PTR(-EPERM);
@@ -288,6 +294,10 @@ struct ib_umem *ib_umem_get_desc(struct ib_device *device,
 
 	switch (desc->type) {
 	case IB_UVERBS_BUFFER_TYPE_DMABUF:
+		if (overflows_type(desc->addr, unsigned long) ||
+		    overflows_type(desc->length, size_t))
+			return ERR_PTR(-EOVERFLOW);
+
 		umem_dmabuf = ib_umem_dmabuf_get_pinned(device, desc->addr,
 							desc->length, desc->fd,
 							access);
@@ -295,8 +305,7 @@ struct ib_umem *ib_umem_get_desc(struct ib_device *device,
 			return ERR_CAST(umem_dmabuf);
 		return &umem_dmabuf->umem;
 	case IB_UVERBS_BUFFER_TYPE_VA:
-		return __ib_umem_get_va(device, desc->addr, desc->length,
-					access);
+		return __ib_umem_get_va(device, desc, access);
 	default:
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index ad023c2d84d859..5da3922582f931 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -126,8 +126,10 @@ ib_umem_dmabuf_get_with_dma_device(struct ib_device *device,
 	unsigned long end;
 	struct ib_umem_dmabuf *ret = ERR_PTR(-EINVAL);
 
-	if (check_add_overflow(offset, (unsigned long)size, &end))
-		return ret;
+	if (check_add_overflow(offset, size, &end))
+		return ERR_PTR(-EOVERFLOW);
+	if (end > ALIGN_DOWN(ULONG_MAX, PAGE_SIZE))
+		return ERR_PTR(-EOVERFLOW);
 
 	dmabuf = dma_buf_get(fd);
 	if (IS_ERR(dmabuf))

Jason

