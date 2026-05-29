Return-Path: <linux-rdma+bounces-21526-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA+hJHXvGWoX0AgAu9opvQ
	(envelope-from <linux-rdma+bounces-21526-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 21:56:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F86081F9
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 21:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADD98306782B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55B73ACF18;
	Fri, 29 May 2026 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XGx0zv55"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2B357739
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084389; cv=none; b=tYaQ7jey0cd/Hqwe/QvTa69Z2757YEoKZao7yluXH2UXMl0XDyWT6KMSdYx95GfzZw+tiTKMce9jQYerI1BVBvVucllRaFWIMzcTKIFuS9DC5ow9zJyQhR4rLb/fCcsZahHCYPjKKEFbo+T/2Dh2OScLMucfKbN31ftslL3Uwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084389; c=relaxed/simple;
	bh=Ilrlh6tgl/iKqJKXcBqdHv4bD4NTiyMvoXGNjk9NSrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZB+zTUCVrOrCdSPA/MgroHyfcqBi2/4rNj8m8Xn5JW5bXLM5RNCRqllp9qYfBZcGdqWK3LQLQkgq55RHwPAdHLg5czctUwX82oFN1a8zun+DWkAfYzQfPeZ67dFAr41tYkiS+K/1mjftn508HHYLqjpyN7bR/j3MQ825Kq5wVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XGx0zv55; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8be236ce888so137980536d6.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780084387; x=1780689187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=elcdWbZomJc058eb3bDFELTgP5cUh/jytbapcV7AOgc=;
        b=XGx0zv55frSzzwkF2cn8lQhHBB8HbEoPE1YLKdy2pU/HL3XwcOpDTJCavo/VZi6L5y
         IHl58hRasqS0RlxWiCHsDs3a0R3rz2vv0ZiHyW1P22kp5xPs5AbRvWgTadduknA8Affs
         HUt32WWzVfDfO3SipGVbST6Jo93+BX7FtGGxHtUJ8r2O8nFBZ0UOtrgfWeXdC9eXb+Ok
         GSLOF62VGMZG7+vm/drpyvHsvdM5EmHi0tyous3fvmMR6evDSaYAjxR7XjAf03fsiczC
         vfMHSumqi4l4YYydBtMy2W7DUxr7ouDApB6oeB6pbBfoWD0Ai45uF1ILJ3hQglybUPdp
         128A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084387; x=1780689187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elcdWbZomJc058eb3bDFELTgP5cUh/jytbapcV7AOgc=;
        b=pE3Kn9ZWPBCubkF6grddzONmhQAJ1j57Rt1aw3izf4ZwhzDA++PeAP3TLKQ1Fgv9d1
         sgrHgtuLwu079wcEi5ajA6OU9e1e5v/ayH3u4CwMmj+8GpdQTNaie6vcjaMQ3E0ojdTY
         mAiiQcLR7OgahidIBrAAfkCdu7jTK1hTsP4n1kmBYjtQmWx2hdo3+tTtULgP+e6GpYng
         UvfODFgvU9027m8agbuxZ1gTzXSRkPsB4Fcp5g3IlGC2pjzdgzuW14UwsZQQFIfVWB+r
         +wX9nJ/BzlvUcyQO7LXeT3ddGZHBaGkQjd9GABX6SysOEAnJLqrQsuaaWDQtCuqUrcdu
         uidA==
X-Gm-Message-State: AOJu0Ywi63pb7kiuu3gtGqTajo+fQCFhHUA+upC5OikrFkjL+zZdTXmB
	GzGIbr5W3V1J3R1psxoVSklwj+uhb7OnNNQW0ohtvxu4qPlaHs8gp5kg6+Kw0VWxU9A=
X-Gm-Gg: Acq92OFPeRWAgwl/Yu/7hSNT9GNmKaOgws6kSitRzvoB6byfkgAtkmgQ+JEBFBtWH44
	9gNtsIzqS22Mhx4pEwF3Yvr2HHUKgZhs/+U1Jf7E1DSY3/GHs3GRjrbXACla7hlVfrQSrPSlNRT
	MKnoIiQA2BxPGmoQ5w2exE76NwcnMiNlKEytCc+mPb6Nu0JQ5I9GuHjAywI1yXCLuSJNcXeocjZ
	GeCajCH74zsB5YtGWS7Lrvap9BFGGwxH7RanJcOSdWjBi1y6D1piQYBPPRSm8Ri2ZK797KnP+cc
	t5jC1N55/MlFOxpkebqneXZu4Glg+HkdukbOH4UNdSFclN4jyKoANxoBFiwQtGhYtp9IclPbnlr
	AJdndGmGg9bJ95NjG2KWIVoqosSHSMiLnFv7NdawYnyL3iyzJi6T23AmM3ucnpj84Y9HKtbEjQB
	Z9W5fq4zLos39BAdr2Ak/UIGrVOhW0q4MRpRMERsUfKj7CiJqN+LuAX6D5Y7jJohURPZAV8Yy/X
	6O1ONQRh7PD91Fy
X-Received: by 2002:a05:620a:8804:b0:914:d093:aba7 with SMTP id af79cd13be357-9153d936c3emr185244485a.7.1780084386856;
        Fri, 29 May 2026 12:53:06 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm334241385a.18.2026.05.29.12.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:53:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wT3GS-00000000piL-3dQQ;
	Fri, 29 May 2026 16:53:04 -0300
Date: Fri, 29 May 2026 16:53:04 -0300
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
Subject: Re: [PATCH rdma-next v9 03/16] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260529195304.GT2487554@ziepe.ca>
References: <20260529134312.2836341-1-jiri@resnulli.us>
 <20260529134312.2836341-4-jiri@resnulli.us>
 <ahnkoTRWKA3r1RJ2@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahnkoTRWKA3r1RJ2@FV6GYCPJ69>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21526-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 004F86081F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 09:14:50PM +0200, Jiri Pirko wrote:
> Fri, May 29, 2026 at 03:42:59PM +0200, jiri@resnulli.us wrote:
> 
> [..]
> 
> >+struct ib_umem *ib_umem_get_desc(struct ib_device *device,
> >+				 const struct ib_uverbs_buffer_desc *desc,
> >+				 int access)
> >+{
> >+	struct ib_umem_dmabuf *umem_dmabuf;
> >+
> >+	if (desc->flags & ~IB_UVERBS_BUFFER_DESC_FLAGS_KNOWN_MASK)
> >+		return ERR_PTR(-EINVAL);
> >+
> >+	if (overflows_type(desc->addr, unsigned long) ||
> >+	    overflows_type(desc->length, size_t))
> >+		return ERR_PTR(-EOVERFLOW);
> 
> Sashiko says:
> Does this validation evaluate potentially uninitialized garbage data?
> If a user passes an invalid, unsupported, or future buffer type, the
> addr and length fields might be uninitialized garbage. Evaluating them
> before validating desc->type might cause the kernel to return -EOVERFLOW
> instead of -EINVAL, which can break userspace feature probing based on
> error codes.

I guess it is right stylistically but I am not worried about it for
this series.

> Should this validation be moved inside the cases of the switch statement
> that actually use these fields?

It should be moved down into the actual get functions when they check
that addr+length doesn't overflow, it is free to do this check there
and all that is needed is to propogate the desc down the
callchain. That is why I showed it that way in my diff

So it can be touched later, maybe ideally after converting
ib_umem_dmabuf_get_pinned() to all use desc

Jason

