Return-Path: <linux-rdma+bounces-15783-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPGYERnjb2n8RwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15783-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 21:18:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED25B4B283
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 21:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAEB63EC87D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2AC466B63;
	Tue, 20 Jan 2026 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U/Pxz350"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF44657E2
	for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935514; cv=none; b=sNbcshYPIAAjysuA2xVwXn4L0NIiRrYBUlwLmKVVz6Xp0dIuEPafJujoWBgPfCkEuNYRkumNnfMyx7VMefIDeXLXKzG4FiqCuyjRWBdMgQV2UT7rKPxCwlF48CMbsfveN6nuJjGnPRK+iDq4Pjb79XBzF+J0zF8x0aYqUXkBbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935514; c=relaxed/simple;
	bh=QCWnmvZOMBqwCYoQiy1gsEGlEi/MVem164y6sFMk3qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5ZZrL5IiXfhXzRCV8Xt3aZ181FIMb988FGs9qtLmHI4XmkQilBy6x3//rKTb814EYnKz3K5wbuRpsS8Nhmo9Fxp9AQEYF3Xdq58AN/KS506HLNponnATSzJfC5LnpWLdExNMUOinrdSzQGWWY/writoPelP6e58UY2gSqSynlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U/Pxz350; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c6a50c17fdso468994885a.2
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768935511; x=1769540311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxU6F8ooeXzMpxSb6eZpYCuDOTZ3Sn4W0bgkLW7agKs=;
        b=U/Pxz350OZvfO6ABAx01vZYVx6GgSdArB06ibVoWmxK2Ay9NaW0p/Xn259ttz0iqFB
         1fUsQrA9DpAir9xjMubOmDcvDAwIAjC7XCok8CtqXgnyWT0IxZBVpbwzjNyKvUn/GvC6
         bev7XZHJePOeTagsrYjJqziO4qikdcLwWiJNjPIyI+eq4pECb4UAcE9MkNrY4wsyQASY
         T/YeqZvqSY10Of+WG2YfuFp7t1vuW13kDcH7GdvbLKMb6wgWJlMiaWuSwDYW6KhhDeUA
         OFyJ86g/TOUwEacBCV+hpfUiijrNvLPcXUIYZsMMHZx5OkxQ8pAvk+cJcMi5pCdKqD3p
         /bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768935511; x=1769540311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxU6F8ooeXzMpxSb6eZpYCuDOTZ3Sn4W0bgkLW7agKs=;
        b=f5PO8+mBiXB5nfydWf9T93/ndwDlUlwOBkus5HjKmUAx3FKX5nBfW/JXLiHtTq/5fy
         uWn3MqCc9sE5GMk+wUcp3Xmpz1WkZHW3awC71lHx5/1In4r2tsThx+XxnjOxKceBE5T/
         D6+yzD4qGuUh+6GwKeB3d7qj8pVtP7eNRX3qKo8rowyslwI9X9fNeFA5CUPNrlki3Y5+
         NYHoxasukVBvVx4DWJhhG1p3JeYzvSwfFZuLQRBNRcPNoUP0pkooE84NDjwuxks4uP6u
         Bf/3IMoPMgCdbyklU6LB/ZX6MkuRv32eWT1KtHOL+oc/ThKOwRGzlplbKr+CRVwX1xO/
         HYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVqQIbLVzckkA3HsGPGjcsQRLEnVjnJ0NjgPyVVhxJp/V950O+tIbPTM5ptGxYdp/wB2upkVDOoWPY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53zH3y4+bE6ojQ+5za27z8BIJM5snQ7Dz0qlTu7Dt2dOudXQl
	LStNeKHMmqUQqwGE3lhQ+99MMQk062hZfFuBR/JXXzbCequXfqrF2fkXAsZf0CUyEnk=
X-Gm-Gg: AY/fxX49MkIvQpRuYUPiMfBSWtNoHOy2mSXTNvq8wN8GkaDCk+fLeyVEJm8pXvAEo2x
	nQNuMWRZboyVJrfY8uhXHxplGqu//DN786qdXbhy6F+EAUWnU0Q9sZyc+Y/kKuqkhAdHZnCr9ML
	Uoodx1XO5NshBcal/1DS+qYkSYfxkF3+OiKshEvWtiMD5LXLxzF8IoyEkPNCAHQiEnCwS2G0mol
	flCPFzygoT07zKdZvrWfZqCekBDJAVkSOnMiCa1qlkFlVWQEQdU0JNs02hkpXr8XHqyCCfxBjgN
	OHE2DIll7MUVG9znNUx8QK0P5Vds4YtQxye2KpSZto5p0umVf5mDcZ7ocqrZOAJUmFa7Wso2nII
	Ss0l71wiwon2r6GQcE7qZYi7Z/rg3+o1erVyfUOFczkeb9HFd95PCnElAiCA0op2AmIWtNjQp4c
	yGhcAhBcQEONmL5BzDI9QChs+pLlLmrdURqbyFk+Y3uUS5DSHGrjbUVf5c3NJX74A5ntQ=
X-Received: by 2002:a05:620a:1729:b0:8b1:adfd:f850 with SMTP id af79cd13be357-8c6a68bb3d3mr2124448685a.18.1768935511372;
        Tue, 20 Jan 2026 10:58:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72985a8sm1077789885a.54.2026.01.20.10.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:58:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viGvu-00000005bIM-1ye4;
	Tue, 20 Jan 2026 14:58:30 -0400
Date: Tue, 20 Jan 2026 14:58:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: "Czurylo, Krzysztof" <krzysztof.czurylo@intel.com>,
	"Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/irdma: Convert QP table to xarray
Message-ID: <20260120185830.GV961572@ziepe.ca>
References: <20260118012500.681672-1-jmoroni@google.com>
 <DS0PR11MB7736349A3D51CDE681CFBD4BEB88A@DS0PR11MB7736.namprd11.prod.outlook.com>
 <CAHYDg1QRh5dGd6B5C0N96PNkXzKguTNggQzFcbaw6PtCAPVTQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1QRh5dGd6B5C0N96PNkXzKguTNggQzFcbaw6PtCAPVTQQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15783-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: ED25B4B283
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 10:56:26AM -0500, Jacob Moroni wrote:

> > Finally, the xarray was intended to replace radix tree. This is not
> > a vector-like (dynamically resized array) data structure.
> > Not sure if this is the right application for it.

xarray is an appropriate data structure for any kind of dynamic array
that has good clustering of values. Probably matches this well.
 
> It's just really easy to drop in place of the existing array for cases like this
> where the array is being used as an ID->pointer map and the IDs need
> to remain consistent for the object. It seems to be the go-to for many RDMA
> drivers.

I would certainly expect drivers to use xarray instead of allocating
their max possible ID tracking spaces.

That said someone from intel needs to ack this..

Jason

