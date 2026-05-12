Return-Path: <linux-rdma+bounces-20493-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIizJphAA2ro2AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20493-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:00:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E6152325A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A666A330FC64
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 14:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3195E3ADBAC;
	Tue, 12 May 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T/nqzI1Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C33A7197
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594715; cv=none; b=YN1KmWck6zVzfcud8IQtj5z857aawJvN0J0K7lZzmaAEr2LtCauY4vo0dq/cYHSHVLFEOedcbMQbGvrxA7IXPYJS3Y3I8nwu+dSPG5RXbPo7Sc00FC2wa2kbPsvEWbY7MlDs7aYVtA32tWVTN9FUg59LQierSIEpk9OttFB6PSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594715; c=relaxed/simple;
	bh=QUHbFxg7G21SAZNBYEzheTcAbV/4ml6pqeRmeAwMIMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpIWyvBIun36+P3JOnlV770GpU1TK7Zv11HxN3NGuowdCyk9A0B1o1XoMxVMDY8OVLELm7dNldFulMtZGs9XHX+6rfqIAyBa4z01yN1EUgQdlI0dIm6EDfc2zXPVJQy707pY+5aWI8HAcQLonhHc1r+3R2qSjcImaFyNw6Kchsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T/nqzI1Z; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56a9076813bso2263739e0c.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778594712; x=1779199512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=waPsD7QYYDWgi2qjD+tBTPWPLKxm94jaU3hp3X5FZhM=;
        b=T/nqzI1ZxG8I0CWXAED2ixyJ7kyBhDvXUR8279fkXGXPRw9WyLYN4I06Di6YxEAWaX
         CiEfnwG1RtYm+wsPJ2ebtW3ADZeQXJSxS3lb8w3CkPFvpLtg7wrr1SaqQjbl/yoTvg8D
         TWhk97RMInP2RC2n1Hq6CfL1FIjh7tBfzQzybbdbi5rsNNneihx0+PaAF2qlvuAHSXF1
         kkYg9Uadb0jpNJYxrXXvCacgCK8huDCPyi65U2VTQTqUf6X9VEhUbkhHj4pbE1BHPamX
         ZyHOUfGIqSDxsseBEmQvidagsrVl1tc0nxwEQC53KqPrHYxikWLp032sbXFvBNl5p15B
         2qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594712; x=1779199512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waPsD7QYYDWgi2qjD+tBTPWPLKxm94jaU3hp3X5FZhM=;
        b=Mx/KUZFY5gnjWoD7MEp4tsEBJGoXMLGc9wV5cP87FCnhAvk8XI1CRfWkgYoR8oUZfR
         WQa03e/DveaJ5Y/jIqitCEh+2gPipXGSrKzF4VWF8NQxhYumfUu+Qu2JYXtWjzy0PmX/
         HL0Q6CA3YPqMCdmfvHXo2zyDjieT/6jMqqnpo9Hen2gMbe7zPjbQV6uwlW3m4So9UdCb
         WmDJzGqJbt6qd4owIzA/GKTA7ecmOKozoy2eWesdsi2VHbQtKxd+RQSHVRnTEG0fRxHq
         SzQfXmZLBltT/KU9ttF0bi/1Y1buGVgFWWSn8j5c3Aceb0vHYeboFalKOQ3QDLd46Q8b
         OxXA==
X-Forwarded-Encrypted: i=1; AFNElJ/TMBc5CI5W9pahTOMH+PuNu77RApBC07k3VBeV3NFSqYqwI2UpP8LgWjgemrsmfqsXR8gxl+MyYGc7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6NwzZeL5zs9t6JcD3YxEF2hsUXAzi9kjTqTGKoeFTp2KmM7Xx
	+9ugm9DruoH4Rq11mGhTpVcYuaKRSRKNcBgAQmdNJ3N2hEKcxnHBE0oJIIN72M9ooNw=
X-Gm-Gg: Acq92OFukVx4mCL2PwUA0UbxEkJjTyKQedEoNu40N1fUKTHJW8cXHxzYhAljs+Hz0Wh
	CTvyrzrXu3eH79RlpRVe14XtRTycL8upiGurMC/Mmiijyq3+Dk22mn/KrVM/VpUlytq3stc5ibM
	a7JHh6AI5eRyajWDp3g/OzHeV+gQh0rxwcANLVd49zrk9PvmyJmN9IuXGyw7+nZ06frU6VY2oeN
	6xDPJgXUqBgRdFa2/IvEU5BnhgSfIPVpVkQlOkhcaxq202prQ/saoXalBRIHHLEGVodfDytEFN8
	nizNcXng6K56UtzqZJmonYiVQTCih7sESFH6msIVF9EamBJ1qa9attYYsCejdiwUO1DyO1gl1JK
	vzrV8CwJRNqD0o4X1BvkqmQZYl23XfcNbmIj9UgJSzFHsuApJX6fEK1HbANEkFCS0+VD6VI7cOi
	MioSeFIOeAbmpv6gEaijF/HZq2wCEr+nihq+blJBr1xZjeFnSlOXVfN3KscxQlRhXMldXaDkxyD
	C9CEg==
X-Received: by 2002:a05:6122:2224:b0:56c:da22:6921 with SMTP id 71dfb90a1353d-575860558d1mr3468893e0c.5.1778594712459;
        Tue, 12 May 2026 07:05:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c37057734esm76678616d6.30.2026.05.12.07.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:05:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMnjS-000000003RM-3UvE;
	Tue, 12 May 2026 11:05:10 -0300
Date: Tue, 12 May 2026 11:05:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	edwards@nvidia.com, kees@kernel.org, parav@nvidia.com,
	mbloch@nvidia.com, yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 1/2] RDMA/uverbs: expose CoCo DMA bounce
 requirement to userspace
Message-ID: <20260512140510.GA7702@ziepe.ca>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-2-jiri@resnulli.us>
 <20260512130329.GU15586@unreal>
 <agMzG-ZX6TRoikrI@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agMzG-ZX6TRoikrI@FV6GYCPJ69>
X-Rspamd-Queue-Id: 04E6152325A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20493-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:03:07PM +0200, Jiri Pirko wrote:
> >> @@ -1419,6 +1421,10 @@ int ib_register_device(struct ib_device *device, const char *name,
> >>  	 */
> >>  	WARN_ON(dma_device && !dma_device->dma_parms);
> >>  	device->dma_device = dma_device;
> >> +	if (dma_device &&
> >> +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> >> +	    is_swiotlb_force_bounce(dma_device))
> >
> >It is the wrong place. When I worked on my DMA series, I tried something
> >similar (a call into SWIOTLB) to notify users that RDMA would not work.
> >
> >The general feedback was that this is a layering violation, and that any
> >knowledge of SWIOTLB (and its API) should not leak out of the DMA API.
> >
> >You shouldn't call to is_swiotlb_force_bounce() here.
> 
> What do you suggest as alternative? We need to somehow tell the user
> what is the situation.

For now CC_ATTR_GUEST_MEM_ENCRYPT is likely sufficient.

Later we should be able to detect if the device is in T=1 mode
directly.

Jason

