Return-Path: <linux-rdma+bounces-20508-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BTkArJtA2rF5gEAu9opvQ
	(envelope-from <linux-rdma+bounces-20508-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:13:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4627652709D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F16C83035106
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9ED349AF5;
	Tue, 12 May 2026 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R7jS4paX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00401343D9D
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609560; cv=none; b=TQOwiSJjCk4G5bsHAl08MHawkf5sx/fGFkrivRqbWXu8y8s8Xzc1LwvdTPPqwgudYAnKMvP8FYTRSEYWYTlLmVBSdSLJ3J8V80BLS+1FFRFU8jwE6U4rTTPHnUYPPKe+ZnrevjEShrh6JU3Mnmaf75dalDM7u2FXTDj2wdmEvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609560; c=relaxed/simple;
	bh=WEfLsbBNMLgYc1jmgvAe4SEz4JQn2zpnAAUrulEuGLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7WQeKHXgNH5+pMUgE9NelLDDNx8niGP6ioxmqv9vYfsn/RVrQGveKTgKVRFSo/H7sjbxpH9qLuNUbPDfFc2kwDvfg22A7q038+74SnWTsPUytsBfSYEIGn3cNikXlcRyLlGar8Ow/rjzg2AZiTqqPMiwXyvRzzOnr89zkIQcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R7jS4paX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8f231f3b130so455417885a.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778609558; x=1779214358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyrCLrLpEbZKQ5jJ2xapqvdsTLWfB0DbXAPHigkioQc=;
        b=R7jS4paXlNYKeIyjCKu1GIM2XRue9EhUMTeUBntAGpAGr9y8CIrnR0A728wbaW2Gql
         Hkujlw7F/iGr0pXq0SwBlwXuV6WgeLIMobgMpdqrZ/BB7Lwf+QAsPtYios6rMMLcobsz
         KFfpme78da/ejm5BtrdWw1l2iv026FnIQ/CVv0e42BCERzvzOU5x0GVI39OywQfO+oz7
         5YgXjmXRWbEuWgzSfnrA9LQ2Z5QyThaaEQsOhwMj46Kctpg5bbi2GUVQRjnzrpDCS598
         8UEbGQdziKkBWUOrS0KmMVi4girWZqnTnSzkNt0BStUcRTFD7XAS6r26aPmPEgyX14KU
         rSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609558; x=1779214358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyrCLrLpEbZKQ5jJ2xapqvdsTLWfB0DbXAPHigkioQc=;
        b=jkH/nwU3Tf6a3kevspwLUsM/D9aE68jsh1FHdUuLAPlxVZLMSXSboYZ7+v1ihwxniq
         RqH4GGvDycsxlndYdRsh7O4C/asT635SM3lPuUSyMA7I0l6wHW7P9hrYiORVDpIHT/vf
         1WXhL7DaxfGT8duRtfQMtMKd3gpNS41/dlg3NLg5c34pVDElXNaDYeMHFNTEPx0YgYHL
         KTGd4XDqO+s1gQ64xtZ8rz8XC8ffAKu3BJWvNPj/mrfmoiZecX+G8Q4zBs8NkFGro7y7
         M9KJbiy1z0Si4XrtvbUASG6TN6zrTvtMNRHY8ydrCnYDIe5Qd5Cx93j4Un/6Q7w0PAdU
         BrQw==
X-Gm-Message-State: AOJu0Yx3CA7iH5XPnB3pVJFjfx72VNjfO+TkDT6decd6TjHLa/EbhN24
	y+xKgaeP9stf8i/yomFJqzdTx8M1Ua//A1ucNF+iWNKXcB7iEgQexTfZR0qNLnK0syE=
X-Gm-Gg: Acq92OEBvccK8RmRIh9Y3SGKhHOJ0kf/0rppmdFlvpC+gH5q7l7o7u/D4rIcH0Ub0nP
	WrRZlvEYu+/1qcgwq1TrRFdtFpFr96Bx98Wd8FF+k6wF4WsTV6Jihw7Mmth0ykJHTIG3PofFsXj
	yCzMlutTWp9uTiZBxi+hIglyLiySU/frDMlUjAJhyn70+spN1MoE3IP3btnRfRAsxn+QHSqswhy
	6lexeMglMyPwFhH/CnEe1pU8zzEZikgRQ6gauAPR9OxP9vm5BgpJvwn5WhxluPb19VPbw/1PvMM
	RWkuFIQ5IAQeVNROM4UOSraaUk+qbr4C1WXQO8OlLXoty61c5VyWAktB6bIOqzGnmVcttbu5I0d
	HRRYIKGsZ2nVWz/VrSv8Kqlsp4VgOQ01QsZiTOGYwACrHKp/u2GWjb+KY6StxP9qCy7Zsyf1Vpi
	88xqV+01SSEw1XJhIyNsXq57G8bv/XDOLhXVrFDwQWt6CGsqLq7PvvsPJt0z6rnuN+v0XGNvO+i
	3GmZr4tEjScVNXO
X-Received: by 2002:a05:620a:468f:b0:8de:c429:552d with SMTP id af79cd13be357-90f88da1cafmr9124185a.20.1778609557771;
        Tue, 12 May 2026 11:12:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cdfbsm3533145285a.34.2026.05.12.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:12:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMrau-00000000jnj-0ciu;
	Tue, 12 May 2026 15:12:36 -0300
Date: Tue, 12 May 2026 15:12:36 -0300
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
Message-ID: <20260512181236.GA175362@ziepe.ca>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-4-jiri@resnulli.us>
 <aftENVgTr8AZVQnT@ziepe.ca>
 <aftL-2sJb4JfyDIs@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aftL-2sJb4JfyDIs@FV6GYCPJ69>
X-Rspamd-Queue-Id: 4627652709D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20508-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 04:14:34PM +0200, Jiri Pirko wrote:
> Wed, May 06, 2026 at 03:37:57PM +0200, jgg@ziepe.ca wrote:
> >On Mon, May 04, 2026 at 03:57:17PM +0200, Jiri Pirko wrote:
> >
> >> +/**
> >> + * ib_umem_get - Canonical on-demand umem getter.
> >> + * @device:        IB device.
> >> + * @udata:         uverbs udata bundle (may be NULL).
> >> + * @attr_id:       per-command UMEM attribute id; consulted if @udata is set.
> >> + * @legacy_filler: optional command-specific legacy attr filler.
> >> + *                 invoked if @udata is set.
> >> + * @va_fallback:   if true, build a VA-typed desc with @addr.
> >> + * @addr:          user VA, used if @va_fallback is true.
> >> + * @size:          driver-required minimum length.
> >> + * @access:        IB access flags forwarded to ib_umem_get_desc().
> >> + *
> >> + * Return: valid umem on success, ERR_PTR(...) on error, NULL
> >> + * if no source produced a buffer (only possible when @va_fallback is false).
> >> + */
> >> +struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
> >> +			    u16 attr_id,
> >> +			    ib_umem_buf_desc_filler_t legacy_filler,
> >> +			    bool va_fallback, u64 addr, size_t size, int access)
> >
> >I didn't try to look at what the drivers actually do, but I'm slightly
> >surprised not to see an addr_size here? Is it the case the drivers
> >don't have have a uhw->size to go along with their uhw->va?
> 
> "size_t size". What am I missing?

size is the minimum length, not the actual length passed into the
system call

> >> @@ -273,4 +273,27 @@ struct ib_uverbs_gid_entry {
> >>  	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
> >>  };
> >>  
> >> +enum ib_uverbs_buffer_type {
> >> +	IB_UVERBS_BUFFER_TYPE_DMABUF,
> >> +	IB_UVERBS_BUFFER_TYPE_VA,
> >> +};
> >
> >I've learned it helps backporters to add the =0, =1
> 
> Why do we care about backporters? I mean, the mainline code is what we
> care of, and for that, enum default values are well defined and enough.
> What am I missing?

Well, just something I've thought about before. The rest of the uverbs
is pretty agressively not doing this so leave it

Jason

