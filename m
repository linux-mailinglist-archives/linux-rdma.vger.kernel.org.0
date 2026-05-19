Return-Path: <linux-rdma+bounces-21000-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPhvLt7pDGqapwUAu9opvQ
	(envelope-from <linux-rdma+bounces-21000-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 00:53:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C6B585D8F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 00:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D013300DE3A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8385B395D87;
	Tue, 19 May 2026 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o7ST77MH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3D31813A
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231183; cv=none; b=BFwDleJQt/+Rv4p5kUS5BG/ne+Z6H5+ITmAR89Xv9bqg4gbeGRzv0WEvP9UScWegt2k5j4Bf51+uJPBVf3qzsNCY4adILExKBt8idlXrEY+Nau8S3HtuvrbxdNN3M8BtGH0l33RjI6EGUhhsZZ6SYIRV+sBZ11ODvdV5JmfCT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231183; c=relaxed/simple;
	bh=R2ChHMZ9xPH65ExK9ZyvrpdtZ7y4rCkF/qmE5Tky2zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U29MiH334Oj6KueMbx6sj+l8MyZ3CwEL8Fp6v+8B4PnAd4HmbAPj3zO1OSJmIGbmJHuINlVWIV9zeccV/vDHgqrQsfg6R+4rAERISjMc1RpTNiwPNGe0Cn9McjKnR1JS/xrBRty3cpydjeysBCo50pv+bup8p/7OjCtxHB44krs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o7ST77MH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51306c9f2e1so52247721cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779231181; x=1779835981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nARFlekHGe+jGktqfgd00vuh00ND4LRreSq73uEZLk=;
        b=o7ST77MHFOu9fQ0/7CQgFGd24eFhYEOtGbSlcbrTIqjPT3SccrimA6z2hyrFazERco
         EhcfJXcNytIa9UrDTk6PDOP1rB+XtAKQctVefJpWjDVjkUPyXKBrlA49tdil8SbFXSCD
         kl2sTzd806xKlMPrDBu6HGsYob7o2XWBwBgS7euDOLiXheF4BmTlpqjoUZjKZxZFd/KN
         M4yElAeiW7/xDjNMv/hWGzYUjjkayVLs4ZkxbMBwxj9HH0EW11aXlT9of8LyS8lCCV2a
         dhgawRTd6ahHM2n0XfzuhjRBmhGWdSGxuob+lizNKxvbRuTo71p0qEKNqzQAKtKHeJ2m
         U8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779231181; x=1779835981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nARFlekHGe+jGktqfgd00vuh00ND4LRreSq73uEZLk=;
        b=SHNGJ1tlyH/nj788fVfPgahOJvXyYLEYg1XBI5+e1eElNu+AtpU00rgx5sfLXxo+Mb
         9VquwBCvg/6mivpFRqCtXkAqMcRnbuxkAYvIsjYRVW2wc/+b47sljvjIqzMhhwmI70Sb
         ulu5xJS9t9fAuhnmJN9/zS/W3YtQAfTDTAeaEWKIpbceLUGRLqNm+S6z+O1fNAC1xXBn
         K7Bk93DxSmNez1JH6jClALHwcizuKEnzi0/GcnG32lW2v+lz/CK6RunvNJSa43FTAOS2
         MOUHqGEQ5wfREBCQPeFNp6JWC9cw0HFZmVu/IFphpL5jb9GjuzuRgAuiMO7mEtkLl+PB
         bQFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SicABFa6eDu/rJTTv63lXqhOfBd3SqCJkFixNOu/1Q5uIjfKNowkp53fuhbeo93n4WZLCdYGPCVXS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yXb4j0qG87IUDotNkahXUxjdIvgAUtK7lxQEnAH4Jy6MmuDP
	qBQhopH47U82s9+e8LXhWm8iT5JhWkNd6YrHbCR3oheuHzsPTBjiLOyADZKjRlSw6sk=
X-Gm-Gg: Acq92OGg5lPxw/iBAJft+WpCFgVPCyn6iUQ7DVPH6Jd4T8QdPI+fPLawyKSrMUBFVYe
	qe6idyiFODuvSxu43ZGEBEBLbO+TxL7NkwYwj7MTBiUsmBRfB11PlaRZkg1EVNTcnqNPnFHWk93
	7Tro739Zkou2FKbLUJVOTVxodcw+uW/Vmqjr73pQDmVq2U0pCiFL+UcOcMQy6vqP7BM/N34p+zA
	LSqrthYHKOW7LIJSqQXqEPCftyPRUH5PNCgxxmfi3ek9KrbmDGh154RVUBu9KHJ2toD8aNRSKiD
	BS0WI567+l8ZcSI+zCo2u36lnGII4C1ZWR214MUS4a55n2m3k+M/DwDFRGwYB24cEaE7mGBPaTf
	v+rj3af2BLiqvQ8cOe7za+Fp/VDolz4ZSy9kL1E52xx5Dzb2vTFCdtSxW0qBb8RFEPnHICi7M6U
	juIBt7Z5vJ8typVP36myZmm7pNFgTKBxHTtfLxY10N3a7d3717GwFoTwApFMEEm69dQ/O993koN
	Q1XPEChUgnATA7O
X-Received: by 2002:ac8:7d53:0:b0:516:51da:ae52 with SMTP id d75a77b69052e-5165a1e8b62mr293191471cf.33.1779231181072;
        Tue, 19 May 2026 15:53:01 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164581aed3sm176686141cf.23.2026.05.19.15.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:53:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPTJ5-0000000Fym5-0QPM;
	Tue, 19 May 2026 19:52:59 -0300
Date: Tue, 19 May 2026 19:52:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: remove extraneous dummy helper functions
Message-ID: <20260519225259.GR7702@ziepe.ca>
References: <20260519203629.1341667-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519203629.1341667-1-arnd@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-21000-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 35C6B585D8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:36:22PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The _ib_copy_validate_udata_in() and _ib_respond_udata() functions
> are now defined unconditionally, but there is still a dummy helper
> definition for them when CONFIG_INFINIBAND_USER_ACCESS is disabled,
> leading to a build failure:

Thanks Arnd, Nathan beat you to it:

https://lore.kernel.org/all/20260519224911.GP7702@ziepe.ca/

Jason

