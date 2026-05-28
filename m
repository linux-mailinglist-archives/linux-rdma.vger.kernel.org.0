Return-Path: <linux-rdma+bounces-21406-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NXWIymTF2p1JwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21406-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 02:58:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9135EB719
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 02:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE45301E3E3
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 00:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180EC1E260C;
	Thu, 28 May 2026 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BfZyZt00"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DF1A704B
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929550; cv=none; b=ud9Cnq0mr+rcy6y/spR9bdjeLY6JwwFSdezsMd36P2Fmno1bMJY3cYSoJ9vzRbutQD0Lhill2HfmzYa+RgMmpxUUxpjytITzqDA80nNqDyqRxSShgKZhVACFdT9ZLmq73919dYr7wcNvIi8kX5nx/ijX7UyKvWH4pDC+bobjUmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929550; c=relaxed/simple;
	bh=eUTd65W7UxmkLcJa00BoV7kcaqzWWBSzYXFESgn3D+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpM+VOTmOC0zRz5msoHVgirAEwDG4Pj93WvM4wp/0DU2SMbdeaSnYucOPQw1fMRci+1Phk4LzXCquyvZfXhr/zeOEtCtn0voDlZOC6jTki//b1XepgFKSVBloSRLhg1j9Y/BhT/IXAwR3M/lJdq6W8FSeGi5bQOOfjEaPSJAhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BfZyZt00; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-911796e9885so1071164485a.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779929548; x=1780534348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEaGMiLLYefkg3Eh3YK7YtlQzdcQtVsvjvFzi+FHDds=;
        b=BfZyZt00RE2eHcRfAV19QzWhHfXtpjngRTsknSGM8c4VZKR+GrSa57y/3LSf7xFIjL
         IZ5ndLZEHkyZvilrtB3s6v0z7dwT9Zrxlf10DdP/0QJ+1itdPqJOuHHNPt3W5rMq+L2Q
         WwADqdSQKuCmEFs8Jvw3JWEXaYryuJMvvYOUI6fpSI4VDXs9P9ZwJtlfdy4kxSEXk9LE
         hTzsNewkK+OJmd35ugMuP4rYX9KGKrX/IJDMdzwbxPbn31pa61LoISoht2pGySz9BZF7
         fZRnSWK2fQslICCkEH1LwKjscDU2Pqcq7mlOkjGatAOLwLUIOHx8qzW/hIjnLXbDVHNX
         vqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929548; x=1780534348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEaGMiLLYefkg3Eh3YK7YtlQzdcQtVsvjvFzi+FHDds=;
        b=CKJofVkIRP3jqDyGoKdzmuz3Z4RA05ssJAj/Br+7zonQAS6XvywhGfRKtNG5P8ROHA
         GM8dRUt+FwyqszcdEsJKWIlQnR/Bb0Pt3xwk5Q9WQthI5gW4WMw6jk51N4LzXEkQZY6L
         b4gEe3SguKLpZ43Y5Stl0mgfiJY40wM5vQCkp688SzE7IzcZJCbzieOyb47NDSeqeSh0
         5wbI3zbvFqI1R52qhx7If/fq5rw45vu9y90FybAuWImUcvMDcT0elHHzNN6QMkc71KsL
         bZ/yovazZCBFzoanE91ZccseW+dmgXIYoy+mTq4Dp93kpoLvJzBFIypG/JDDMqiyiPJC
         DBvQ==
X-Gm-Message-State: AOJu0YyGCBwogp6BWy5MPw9N7pA+iOLEFn3NoI1axoOU5ilzoE0ERrpD
	inZIhw823x8QCD+6s0h1g3p2rm6KHwkXSS+sg+aqsIWe5+JCdH4QNNmTuv8qT6+TUqo=
X-Gm-Gg: Acq92OFimzdE2JIyunWzBqROVBgo3z+kMoQO5UnHxeuQ2XcrsKY8VfXK9lY5+FMbKpL
	UUAIqrgMPg7Ee3+tb02scFgdp25MyrGt57Uf3HK9eZfZ2PPgDr0DYAHKhHLdHPx8lZaU4BHUByQ
	HKJMQxAQI/dck9nq+Nsla8Yu7U95INmByF3LkXWj1etNvv6VbhGOAcmvul5uFAMbEnSPBCa0LTH
	XDGW6XjwP0pkYgblmO9rPC89oT4GX4sBrY64eguvKXKWsc5Pv1uMlWrsvhQbci5BuTLVMd3hztD
	tlRfTQSLw5LRJhWxhkYcNQNT5+Qc0cC6V38aWLa7LveYWLSjp0apQ+giVGoycJeyMT56cxMWklp
	t8MZXEaZHHrdveK58Zj9Ox8xSEy5WJMDgDdjAGNra+THmWZ0oqf1BcAfD6QfF4BvE33aFwKUwKw
	6eSHpMACwrrXrw6M+/Tpwd0M6gS00iK+5zMJRdmKUGXDsRP3eDkkPXqgI2Evlk72SbV5Csi+Zdw
	0A0VUtp1O2+s/PIFb9wZ0cPpbE=
X-Received: by 2002:a05:620a:47ae:b0:914:a824:6695 with SMTP id af79cd13be357-914a8246d0bmr2527504385a.37.1779929548164;
        Wed, 27 May 2026 17:52:28 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8820fb0sm635888085a.46.2026.05.27.17.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 17:52:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSOz5-0000000FgRT-0mgW;
	Wed, 27 May 2026 21:52:27 -0300
Date: Wed, 27 May 2026 21:52:27 -0300
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
Message-ID: <20260528005227.GF3528738@ziepe.ca>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21406-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: DD9135EB719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 07:09:36PM +0200, Jiri Pirko wrote:

> +/*
> + * ib_umem_get_desc_check - Pin a umem from @desc and verify it meets
> + *                          @min_size.
> + */
> +static struct ib_umem *
> +ib_umem_get_desc_check(struct ib_device *device,
> +		       const struct ib_uverbs_buffer_desc *desc,
> +		       size_t min_size, int access)
> +{
> +	struct ib_umem *umem;
> +
> +	umem = ib_umem_get_desc(device, desc, access);
> +	if (IS_ERR(umem))
> +		return umem;
> +	if (umem->length < min_size) {
> +		ib_umem_release(umem);

Sashiko was worried min_size can be unused udata memory here, but I
could not find a concrete example, nor could codex.

I suggest to leave an AI friendly kdoc in the _or_va versions strongly
stating that min_size must be valid even if addr will not be used.

In hope the future AI conversion of the drivers does not introduce
this mistake..

Jason

