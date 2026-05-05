Return-Path: <linux-rdma+bounces-20026-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOXON7QU+mlRJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20026-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 18:03:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB34D0D3C
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6DDF3011371
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48CE481FA4;
	Tue,  5 May 2026 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R7zAjNUp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3E3B0AF5
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996977; cv=none; b=YA8rjD9vI24IKj6vhWFH3iB/zC/ux71nqSv1y54z2K2rad6hj6snckFxyh9F5uhL6uYi4GxCFTTBYKu19lF88FDUea8WonEiP7ElK/co+pexLvE6SYERbcEQ/rYMKl+/imGurIBNKyCGkX4NKMjnAjXSNNGoGdquFjAOClVnqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996977; c=relaxed/simple;
	bh=lWBMQOnq/ItbkAe8+mq4QbvwMTZynQw+BrRmJGytxJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZabHJ2XVSj+HjYvgvZ9d9hPCvfqvCpVfbTop2WmmNWeYFHluN6uNnjtb+VLDCi2C8xdvMK+JtsV52dNnkFnmgbtaPibAjefGdon89dJr2MqtkUFm1Gabvpsn6iGyo23ykvs2xYGEbpo1tTFipCzkEgBj29b82yPocfY2+OyM3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R7zAjNUp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso57909045e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 09:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777996974; x=1778601774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQpNqZ9i/hPbAet6h8XkT4ALi6nM546tc0/VARKBD3Q=;
        b=R7zAjNUpfx4W13A/Az/jKNxJD+dAtVeYV29JRffTcc6y2B/ObOzWbK+MYky5LoS5nN
         WJZMcGgayO5W2TPNQ/6lU3HySNyikoE4PgIQfm9TdJxOlWXWx+rRuRZ53RHp9PjJQM4w
         YhI5pDtD6t3MzXWjuXO0BQyYMqL9S2OvQkQSfbWTtLUCJ/narpq4T7/qJRyLIKcPHbjk
         g6EcfW5f/Frpl9X9h+qXVkwFOv65BfVoBuz4PXi7n0gO8qhwTZs1HWd48tX67ejxgded
         Ofvnvob+XFUfOKy8z82ZF8uc0PImNDwkUwUTEQvxd/k0xMO8XUJRS76GNPx3Z7+WtaQv
         hyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996974; x=1778601774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQpNqZ9i/hPbAet6h8XkT4ALi6nM546tc0/VARKBD3Q=;
        b=bxZAkciNaC9vL/9M9TuvOEUkb3oAf8bKeE4268WAfrPUOhHVCADvsJk638wL/nAHok
         co11hMc/eTzcDCDrdlSiq7aLr7q1OB2y9oQ8kc4nWSA0zdjRslvRkJsBsgJ8ALPE/Hg5
         mkwzm0j6qKpOtzS6ZSTElDMPBfNiYHnbch63/ZqV/50DfvB6bHxzN1tZ6vpRDEJ/+kac
         qUYnt7RRvqTv+9cQZbOXnDviJdsva/sG4R1YdOf80+X9nc5zVIN2GzakqoC/bKIwTM+r
         iBiyl2fIL3/mRvV45g1MmUTiD1SXhI9PxZP98gKLcEChWJZq0+Xvn/mKGW/hAg1kl7sm
         h1lQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ReWTVEDqW8A9JKrxAhTOiqAYDt4WYjevyyZHphNEQ/oX6dXtF/60W11fdShhSFpkTs+RB8QmwNpVj@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3jN8uPEXvP8bS54vOVRLwkgBdOiVO3aaELII5XRFaKul/2JK
	gqsrOYzHRzyKXK4LqqpSXAzbAPwju02aKdKMyRNRmsnaUzP6uiJ3LJOkXTmzinZs40Y=
X-Gm-Gg: AeBDievBqULr/xBuWjW0OPljCsU+g45ArWrJQcFiiap1uVYrlnr/B087GuLPXqvhngl
	8zqKKn9b+G7GIuYt+IuTvGbLq3tRzSiRp2xJp/uMKRjvL1oPG6wZqMimdhG3bmypLSoVtHheSN6
	VHs3IzFwRqiusm1aF39f+yJ7Wejc6oee8P2/9ZQ69lAv8tBvImcXhVp+sTCtABJdBuYToJD60zH
	A2x8Pfue+st5Smf5CSz6aDairPq4Rb3Nw4e+NRXDf+iOmpLnWuMNQ2ewH80m8HLX4PRytDKtoOC
	BTPhYedeaEsOGnw0pQeGiJsFWCRfEvZiMWcHY5hbY9A3S+6dDlOpZjz7B1KtB1xPRTFxXgzuiVm
	4hjdHG6xIgerXDH9cdzG7AfHOEincNY58BM6FXz/+yv/eMjlCvbEDU9gJUjP+XdEw/tQbwvvw0F
	STbcUYUUYTAXQPo4EyhQ==
X-Received: by 2002:a05:600c:3513:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-48e51d6c8cfmr165315e9.27.1777996973374;
        Tue, 05 May 2026 09:02:53 -0700 (PDT)
Received: from ziepe.ca ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm483277125e9.11.2026.05.05.09.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:02:52 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wKIEU-000AHV-Qd;
	Tue, 05 May 2026 13:02:50 -0300
Date: Tue, 5 May 2026 13:02:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	leon@kernel.org, edwards@nvidia.com, kees@kernel.org,
	parav@nvidia.com, mbloch@nvidia.com, yishaih@nvidia.com,
	lirongqing@baidu.com, huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn
Subject: Re: [PATCH rdma-next 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <afoUqiDgZmhE4Kog@ziepe.ca>
References: <20260505061149.2361536-1-jiri@resnulli.us>
 <20260505061149.2361536-3-jiri@resnulli.us>
 <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com>
X-Rspamd-Queue-Id: B1EB34D0D3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20026-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]

On Tue, May 05, 2026 at 09:20:01AM -0400, Jacob Moroni wrote:
> Hi,
> 
> Out of curiosity, it seems like we set DMA_ATTR_REQUIRE_COHERENT, so
> would that have caused these registrations to fail anyway since it would
> be trying to use swiotlb if running in a CVM?

It is supposed to, at least that is the intention. I think that
new attribute overtook Jiri's patch here?

> I was hoping that the new cc_shared heap could be used without
> modifying the kernel driver by replacing the normal allocations in the provider
> with a dmabuf allocation+mmap and just passing the resulting pointer to reg_mr,
> but that won't work because it's a PFN mapping.

> The driver could be modified to accept the actual dmabuf instead for the QP/CQ
> rings, but I just wanted to see if that matches your vision here or if
> you had something
> else in mind. 

Jiri has been looking at both options, but kernel side irdma must be
upgraded to accept a dmabuf for every kind of userspace memory.

This is why we have been trying to centralize more of the umem logic
because every driver should be upgraded to accept dmabuf for
everything...

> Another idea was to just allocate them in the kernel using the DMA
> allocator and map them into userspace but it would be a larger change.

This isn't the pattern we are using in rdma..

Jason

