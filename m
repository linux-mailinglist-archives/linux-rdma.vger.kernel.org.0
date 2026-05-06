Return-Path: <linux-rdma+bounces-20077-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHAQEUBE+2lPYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20077-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:38:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6A64DB139
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A294430120C2
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EBE3E315C;
	Wed,  6 May 2026 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oPYkpnNl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49330F927
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074683; cv=none; b=P/+g3pARBGZo2n/6gOCwM27t2+do+mPNVs9OzqXEES1Ln1Y1VSp+amJenNOXd5p4cnHXz/J1jUtRobzqQF8vyCPA/1PYhqEaZJ4IbKPZ/RJ4Iow1njtobRmm5phxq/UrPOV97Sy+uw3/BtmxqR5cfFAxJaVKX/4ad4o5GkK6AdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074683; c=relaxed/simple;
	bh=7NyC7GghsqNszReMbM4tx0mskYB6DChOVU/NXjBP3+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DehG+x67pOT8WrVqJQxlgF33iUzh4l4OoKbII6NODYnQEt6zTNWxASxoHCmwM2cYLgr5k0yRpSDHRawW8bDcuCGw++BCrBsChHTQ49eGnRjRGXTw1gGjrxpeUSzqEslCirXkFU0bRtFZcGj5iZQFquJnLkowXFCdtDQWjlKhxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oPYkpnNl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44a5174670eso2893624f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778074681; x=1778679481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wK7a8C7hQPt9J1YdU3i7zNUg9dNIb6YZUlOb3LcMNAk=;
        b=oPYkpnNl07DnKqJ5COPVNDXcl6s8ysb1ywsy3Yre8uxjC91zGOHtj0ijAekS/4l3NK
         hP6brOvqhTIKpiNsV1x00xXjbUa+nGR1cn6i0Wb+jxj9gapFddKxednYtwvhXbn0Vbhk
         6hdxziTsQ68n2v59zattNqTYOrTBwRNk6QAXYfYQSGrT1F+5m7JTErGnDK0E3/AP39eU
         /gGbHRccVCLe4Sd59nwVJKr5Ro2iOdGwEhbMKvy4ocjOzle6AkR9j/83znOL/2kiyHuw
         7UfwhTYggHn5N5ePKw7ftyeIvT+lLeC0mZjAQtseRcDU52Zh5LczmJ3fTkc6W7j7S3t9
         e5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074681; x=1778679481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK7a8C7hQPt9J1YdU3i7zNUg9dNIb6YZUlOb3LcMNAk=;
        b=aup2Fiqe/7zMkcKlhTF/l3xqWIUlnBe7Yj74mn3u5nbnSkzm2GOqhoDUpzMehm6fJy
         LSL3jb9QCF+nbelyQBOakfh3NH8rwNeWqe7uy7LFhYl5stzvCrMPUtdhZKKhaas6SOac
         SXEOj3H/UkmZXUjxIA0P1Ax3iP5ISq1fnkUxHXf6lGlqDyZWrzxL8RYmAskYUZ5AmC2S
         1TX0t7G+N+mfpuqzYNESQ9U+wnbtIsJ9NW65GJsVRNrYzWHAKtpC0iTQb2biGQaXW/Pk
         /mfPmwbEb1F+oCUd1r9g469533gEA3P2e0i88Q7I/oH8giAT4bgqDTg9npf7M8UoH+jC
         N0Yw==
X-Gm-Message-State: AOJu0YyraFGvLelX+hP6ixYsiihSOa+uqCGDixnIZvl4cqWCtehD/s7+
	RfT8H88u3fC0rVDzy4t57jObwnFH2f4gXm+8Cmv4CDOtgWwPEkeWkBO//5FmRXMkqZk=
X-Gm-Gg: AeBDieuyOmmGGEEMlJ0phFKl1K742VIDnsFYooj9QOOTQ5lemb8VGHgH/40c/wOV4FQ
	/yN0Sa0f0VrbuAcMG1NHsjlSwufcsCSZjt9YYXf8oL6DGgWuzEihj61l0byIS0Chv2aZQ+sO+pX
	uEukPQaoasacl0P4LAif/tsIFIKbJ2ESM+T9y7XxAwO1PUSMsjc00DaLrr9uPsi6NeEFBx22YU1
	ug4mU6nEQ7erSEhvcYcSh0EDz259/8EuNhoeohSSjXFmWRaFMtgfqL3sfJbUwUzh9bjUZ5Vn0mJ
	2E3d6yB6ZV2LaLOavJ+Hat7gVAECh7Qe7l7GW0Pv3x3PXBwH18Ep6LbLXTa+oxht+88G0TSQVXT
	jZQzWLPo3o/9iZvABYmm2x8pyxB3ya5a84V0rGRqzC+qPzVFl44cCOTpDXDMfcCYBPwyOpQmh2R
	I08JRhnEE=
X-Received: by 2002:a05:6000:288e:b0:449:af52:6167 with SMTP id ffacd0b85a97d-4515b056e09mr6138161f8f.8.1778074680483;
        Wed, 06 May 2026 06:38:00 -0700 (PDT)
Received: from ziepe.ca ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505558e213sm13482571f8f.25.2026.05.06.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:37:59 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wKcRp-0001jF-V7;
	Wed, 06 May 2026 10:37:57 -0300
Date: Wed, 6 May 2026 10:37:57 -0300
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
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 03/17] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <aftENVgTr8AZVQnT@ziepe.ca>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504135731.2345383-4-jiri@resnulli.us>
X-Rspamd-Queue-Id: AB6A64DB139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20077-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 03:57:17PM +0200, Jiri Pirko wrote:

> +/**
> + * ib_umem_get - Canonical on-demand umem getter.
> + * @device:        IB device.
> + * @udata:         uverbs udata bundle (may be NULL).
> + * @attr_id:       per-command UMEM attribute id; consulted if @udata is set.
> + * @legacy_filler: optional command-specific legacy attr filler.
> + *                 invoked if @udata is set.
> + * @va_fallback:   if true, build a VA-typed desc with @addr.
> + * @addr:          user VA, used if @va_fallback is true.
> + * @size:          driver-required minimum length.
> + * @access:        IB access flags forwarded to ib_umem_get_desc().
> + *
> + * Return: valid umem on success, ERR_PTR(...) on error, NULL
> + * if no source produced a buffer (only possible when @va_fallback is false).
> + */
> +struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
> +			    u16 attr_id,
> +			    ib_umem_buf_desc_filler_t legacy_filler,
> +			    bool va_fallback, u64 addr, size_t size, int access)

I didn't try to look at what the drivers actually do, but I'm slightly
surprised not to see an addr_size here? Is it the case the drivers
don't have have a uhw->size to go along with their uhw->va?

I guess mrs always use mr->len and the cq/qps are doing something like
uhw->ncqes*SIZE_CQE?

Did you find any counter example?

> +		ret = legacy_filler(attrs, &legacy_desc);
> +		if (!ret) {
> +			if (have_desc) {
> +				ibdev_err(device,
> +					  "UMEM attr (id=%u) and legacy attrs are mutually exclusive\n",
> +					  attr_id);
> +				return ERR_PTR(-EINVAL);

We must never print on system calls, it just gives a way for unpriv
userspace to fill the dmesg.

> --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> @@ -273,4 +273,27 @@ struct ib_uverbs_gid_entry {
>  	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
>  };
>  
> +enum ib_uverbs_buffer_type {
> +	IB_UVERBS_BUFFER_TYPE_DMABUF,
> +	IB_UVERBS_BUFFER_TYPE_VA,
> +};

I've learned it helps backporters to add the =0, =1

Jason

