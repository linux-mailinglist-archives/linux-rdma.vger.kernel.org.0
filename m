Return-Path: <linux-rdma+bounces-1001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1478085157B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 14:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF82F285996
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB003A8CF;
	Mon, 12 Feb 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="omgxMKVN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9328485
	for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744788; cv=none; b=Ej/jlpMKIi0xzTBoP/nPJBiLGuCWpJ0+7vJH1RZVyLe6Ps63wv2Zw2E2kTio2vK0ZbItUgDaUPw9ASsU+ytFXryaJhfIzWB3vVBxjgedmJ3wOgNdfamFO8NGUkV3AfE408rqWuPbB24Z5TOga0jMTYZZXLbK2rPCWLxa71h0Xn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744788; c=relaxed/simple;
	bh=2nkgJqrMm6cheV8jZl1VcHp7Khu+3Fo9ys61eSAPCAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRz7RnX9wJAxXE5wEYg+/Sg3nUhNfUejEnMbByt9hBnCAKRXa3QFXeEg48KO+ZMaZbLNY0hCnmFIkylT7xTIo54ZwMSulgYG/nysfcpavx6ajQuwcYmOLXQcImAc9xamgvgoS5sRmDsvubm1notgE2MqZdYPuQvr1+pWKUzyw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=omgxMKVN; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-210c535a19bso1998554fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 05:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707744785; x=1708349585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqmzoVAOCPjPktZaceP/ZzYn3tgPcXj8AE2gRsFqtGs=;
        b=omgxMKVNhegK2CVPgHwHPNFr/e5pG6MXbf18yUJHjl0MYvmC8UCz1Vbk9iAHt9bXFD
         oOjLiLVM3YWFbKceFIT5eHpP8fz7sAvzHn0pN1V/dlF+CtGf0yrJDWBD1Bs1L9aoDwHg
         voUjgXmgcE1VnoUx9e/0KyycwBd+milaIQD4g7tcgRjBXRSXITV+iwf9hn5q5s4GRxOR
         5HEJ8Yc9LpDtfZtEdVU+aEE4/pq/fWRjTVXC9x5gVFwhezRw//WbJNVkV5GLeKtqIjaQ
         A7EYxLs/EWvsSS542AwCDf1Rkxp6aiN0m0IjKkT71ud+g0VdU8aJU42npH+WoWtiDjZm
         UCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744785; x=1708349585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqmzoVAOCPjPktZaceP/ZzYn3tgPcXj8AE2gRsFqtGs=;
        b=JHCHK81aqQHWhXwAUZ1KIeVfiXfGI7vhy6fQjAeXtQTioONlDM0nfai0VXdpd07klF
         R07qdVNf8x3XqO25GrnKSazjmJeIqw8niUKchToDa+aiLsGYBAijvKvYbZkgMLNX5cHA
         IAqKNtV6kJr6HQ3WZqWUddN5eltjiyfALRi+NSf1G3ExvrwjqtZf7fxdw8NOcqyf3faX
         X5LeUXwvO/d4juc3FD2fqp0bUwYpBdENPMy7rbN9R6mN5hokUP+1ho9dAsfxa0xRtH9Z
         YyGRAH9/T+D5SsuESCXrYFCdQRlQxMXQeqJwBZlwhlnl3cdwqK/lcJoBgY02j7LkG+Do
         cM6w==
X-Forwarded-Encrypted: i=1; AJvYcCW8+EmEtUzyFl2/u885zpSiLV8n74KfvBVujcnXoNwwtdrIz9Mqd8ZnljXEMtOYtaimw27WTbD1n8PSQOJvEB9JfPxk8hNDk6331g==
X-Gm-Message-State: AOJu0Yx1RIE/d8760llARgnlDmPTixmYkQJ7ZomRKGdrEipu393hNqY4
	zHMjVz/jg9glMuEnQKe76Ub2oUTGOshg8CzQ/F/nXapq5RNwxHVwKVOnVg4Nb3E=
X-Google-Smtp-Source: AGHT+IEz/OrygRuUacZFdjm+bCqwGssoBUn7XzqLxIw/0zkfnU4jU9YsjcnSUMtReHC32oezwAcY5g==
X-Received: by 2002:a05:6870:64a8:b0:219:3db5:b540 with SMTP id cz40-20020a05687064a800b002193db5b540mr6962808oab.41.1707744785297;
        Mon, 12 Feb 2024 05:33:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqdxSvCBQmxOwS+rFy2SUw3iffWpNqCvnd+P+nb2gMg4wUDvX1WVuTdPZwaxyFvhaAls3faC4hlANsCWHWxYcP5A/rik7qZXv8X/wF5XgUvBs8OaRyQTT/v8hee+Uvh4maZF3ZLSNJIfIsr/5rs6TgJ4PjLxr4lHBoZ759NOIEsXphAA==
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ny6-20020a056871750600b00219d2d04058sm1395997oac.55.2024.02.12.05.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:33:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZWQh-00GuMa-AV;
	Mon, 12 Feb 2024 09:33:03 -0400
Date: Mon, 12 Feb 2024 09:33:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kevan Rehm <kevanrehm@gmail.com>
Cc: Mark Zhang <markzhang@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>, kevan.rehm@hpe.com
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
Message-ID: <20240212133303.GA765010@ziepe.ca>
References: <3CAF66C4-32E1-4258-9656-D886843D7771@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3CAF66C4-32E1-4258-9656-D886843D7771@gmail.com>

On Sun, Feb 11, 2024 at 02:24:16PM -0500, Kevan Rehm wrote:
> 
> >> An application started by pytorch does a fork, then the child
> >> process attempts to use libfabric to open a new DAOS infiniband
> >> endpoint.  The original endpoint is owned and still in use by the
> >> parent process.
> >>
> >> When the parent process created the endpoint (fi_fabric,
> >> fi_domain, fi_endpoint calls), the mlx5 driver allocated memory
> >> pages for use in SRQ creation, and issued a madvise to say that
> >> the pages are DONTFORK.  These pages are associated with the
> >> domain’sibv_device which is cached in the driver.  After the fork
> >> when the child process calls fi_domain for its new endpoint, it
> >> gets the ibv_device that was cached at the time it was created by
> >> the parent.  The child process immediately segfaults when trying
> >> to create a SRQ, because the pages associated with that
> >> ibv_device are not in the child’s memory.  There doesn’t appear
> >> to be any way for a child process to create a fresh endpoint
> >> because of the caching being done for ibv_devices.
> 
> > For anyone who is interested in this issue, please follow the links below:
> > https://github.com/ofiwg/libfabric/issues/9792
> > https://daosio.atlassian.net/browse/DAOS-15117
> > 
> > Regarding the issue, I don't know if mlx5 actively used to run
> > libfabric, but the mentioned call to ibv_dontfork_range() existed from
> > prehistoric era.
> 
> Yes, libfabric has used mlx5 for a long time.
> 
> > Do you have any environment variables set related to rdma-core?
> > 
> IBV_FORK_SAFE is set to 1
> 
> > Is it reated to ibv_fork_init()? It must be called when fork() is called.
> 
> Calling ibv_fork_init() doesn’t help, because it immediately checks mm_root, sees it is non-zero (from the parent process’s prior call), and returns doing nothing.
> There is now a simplified test case, see https://github.com/ofiwg/libfabric/issues/9792 for ongoing analysis.

This was all fixed in the kernel, upgrade your kernel and forking
works much more reliably, but I'm not sure this case will work.

It is a libfabric problem if it is expecting memory to be registers
for RDMA and be used by both processes in a fork. That cannot work.

Don't do that, or make the memory MAP_SHARED so that the fork children
can access it.

The bugs seem a bit confused, there is no issue with ibv_device
sharing. Only with actually sharing underlying registered memory. Ie
sharing a SRQ memory pool between the child and parent.

"fork safe" does not magically make all scenarios work, it is
targetted at a specific use case where a rdma using process forks and
the fork does not continue to use rdma.

Jason

