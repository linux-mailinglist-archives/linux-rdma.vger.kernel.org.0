Return-Path: <linux-rdma+bounces-16872-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEWwAPw7j2mtNgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16872-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 15:58:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C81375A1
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E77303D73E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EC235FF5D;
	Fri, 13 Feb 2026 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TFgh6W37"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A361361DB0
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994471; cv=none; b=T6bSEuZfe+sKGPm+EvzLisGZRxppD5kWRN3tZmolOrwig2mO3mRIUznzN3gLrtrQAV7YVyDk7xePZuAE+jhobl7BhhyvcT3FJUhzUWocvSlr6/kO6R9C9ZMh+7zBz0S6b+vvByHMMenz/PpoVaOIp44tLlwPE7o03kNwDbqO/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994471; c=relaxed/simple;
	bh=81hocsRpSKmvZUDwuGJp21LS6aFwf3AXhhQAkwVY61g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DclvTvdIY5pSurfIf5iX6Yn78gwJwiAPHI8lUVdUqMuW9f1d+iMFGI1sWcrnmrXipwluz9VpfQ28GZt/8LUcaYsf40JbKuWzj7dKFBjK/ct1TWsH6RQdd2je3TWaopUoZk7/TniSlnC356vfw5ocOf1wyh3W4+XiMY6X0tDNs6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TFgh6W37; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-503bf474fdfso9840951cf.1
        for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770994468; x=1771599268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lxDeayeExOyNf/mHCnv46X6osc1EIG2LJgyE26QqfR8=;
        b=TFgh6W37DCWdZgExXZe4lGTKvoKsKAQu2WhgVj4ssAWlR4dhf1zrM7QdMd3ynotP2r
         g4PB/PJMJxjO3jUiJmHhP/5jhbbA9KsIGkzCMwN7NdzXab/Qpb8RorP1HYaxxV7YBnZl
         shh0zWuXAfYlBPTAZd4R6CtT23ELScAvn48rXlfIsfxk4GA+Ph+Xt9DY17my1NJW+DrE
         NWtUJgTmjizEp9OmZAtulaEmykQpBgmSAygwAfeW+qcbFwdzWJQ+eomi+f1COm1O9Tmd
         hbuQhdKpKxODmTaq2mQRrhEfRIcSk/1TCpaKvy84sqKtJ06K/c7VCV/a7L+RBXXDOaXS
         4EYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770994468; x=1771599268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxDeayeExOyNf/mHCnv46X6osc1EIG2LJgyE26QqfR8=;
        b=E77OI4ySeFqQqW1twwqUFly2YgD3NOhAOnEIY/6iWAk5uS2jqkla8D2RmFPhN5D+WS
         /L1Tslja/Sker+7qD8KHH2TWNQUT1E1Y3ucJhbz6Jd5Kcp8xTtGEBl07Q9UBbReZzgWR
         1aiXUy2JHWoYeAIV3JCn75Vz/FqFcwWHnV9EWoksHUJnQUOtf5t96JQNisxf0Nlti2rE
         K+lzushDuVyAZGaclkqcL+5WDJ9J7OIBqvSZ7pEZCGYT6wGA40+75/BFzpKHv8NMCWjJ
         Ay0M8PBU8REPtM/2kUwwyLqcTEqk1fKEbIbBS2on9x2dtN9ZQ2rtL45raXJirKuNEs3G
         3KCA==
X-Forwarded-Encrypted: i=1; AJvYcCWIcNpPMLOkoDXPRcGO4VP1ZWxpWq0ewZyPywp/Me98ODalWB6VOJPprJ0lnNijf0Uin5bpmCK3AegN@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRyV4kOgf0o6gtDElpIVTi7VpMioanYfx1jwmEvxyBTnUWIKx
	uk8H2umOHmAR0a+7tz6qDeFGSASddyZa3+Bjgew14PxYfKKFSq1qmJRcRCnrcRV49ic=
X-Gm-Gg: AZuq6aJXmCN7ounnKOUAd3dUlIusPaAuHNd/0YeoxVL1sCSnQG32gWM+q2jt3BYuwDK
	LSCcuNmH9eKHROPW4wKGDF41XGXJoUFfOh0q5Ia0IK1N82bYs00JVGyfnX1D31glHxQm0SzzBnR
	2dNX9Ncua6c3i8VARUCmqkAmQKzPvOhoTJgtSyGZwAOHRE79QpGO7e04z7iBPx14wXI5dEDYHvl
	VS/+sv8dIO/nYiPYo2qQpvvzr7UuaVM90u9ddGsLJ80N8qqnHw0do3rL8YFIEHF++7z9GQAc4x5
	LA9UR3Qp5AmAAClrJIno9rbfD1He3BstODiC17E0LZhPdXKQ/6GaBF4mpk4zgrdTxldDEnfKBko
	3kYXdqHPhJn8koGDS4IgvzG01JnkKi7TCfdSJSSMG8qjXyFn77ROlZ5XzWRTJ7CFTNlCLUGcRnx
	rE2duuQVEP1n9aSEblG+lN12B2zjUss4s9ZX3qdCTgGmSGIshWWCYC//zHUftKfSogzX6pFm8hm
	2wpK+k=
X-Received: by 2002:a05:622a:3cb:b0:505:ec73:822d with SMTP id d75a77b69052e-506a6aef92bmr30710151cf.38.1770994467493;
        Fri, 13 Feb 2026 06:54:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847d6f55sm72070921cf.5.2026.02.13.06.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 06:54:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vquYr-00000008tzF-2a0h;
	Fri, 13 Feb 2026 10:54:25 -0400
Date: Fri, 13 Feb 2026 10:54:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v12 5/6] RDMA/bnxt_re: Support dmabuf for CQ
 rings
Message-ID: <20260213145425.GN750753@ziepe.ca>
References: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
 <20260211124927.57617-6-sriharsha.basavapatna@broadcom.com>
 <20260213111256.GO12887@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213111256.GO12887@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16872-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C7C81375A1
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 01:12:56PM +0200, Leon Romanovsky wrote:
> > +int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> > +		      struct uverbs_attr_bundle *attrs)
> > +{
> > +	return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
> > +}
> 
> Please don't mix create_cq and create_cq_umem.
> https://lore.kernel.org/linux-rdma/20260213-refactor-umem-v1-15-f3be85847922@nvidia.com/T/#u

Either we drop this one patch and put those 50 ahead of it, or we just
take this one and rebase the above.. The above has the advantage that
it enables all drivers to support cq dmabuf in one giant shot.

However, frankly I'm getting tired of looking at this bnxt_re stuff so
I'd like to just see it done.

Jason

