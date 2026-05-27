Return-Path: <linux-rdma+bounces-21347-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePxOI7LiFmpIvAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21347-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 14:25:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F12D55E4227
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 14:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 493A7305EAA7
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD83D47D2;
	Wed, 27 May 2026 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eextby6a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07A396573
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884082; cv=none; b=hCVvO8m1Sv/BQ0qYWdzZdoizclCVj1Kc2o3Xxg0u6tJWLGAVBgm6VmxaJYoXutyzuMIWCIhlXt4NT1HtYpq8jmY/VvrqS8fggwz7d36oPDiaiWBdMfbcNin9abR7r6iOmd0I6iSDFjlsA/xR9zFC+53E/XBjEbUWG8opylvzcgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884082; c=relaxed/simple;
	bh=r4H4etJpbxgvnWsKcOTGgVwJdweQQvXvLKk8S0w3cbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMjZ5a5S7dXFKI5gMJog0NTdiYb2Bn1dheTxIFuT9vWs5QDekxK6AjL/CQ7GZBEVlsSDKEmVGW4zzgygYizurkjbfIfnV60xE3cLYqB2TR8zSdm3WWJXoCNufyoxLJmBPYHwJcXgUrwfi0Mah63cAouUG4SGlLNkqp9PL0pNH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eextby6a; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5165195c8b0so127289611cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779884080; x=1780488880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zjybRMBUQubASldC260OK8MJUJyjzZlOHF/HoeFPi84=;
        b=eextby6ajjRyi73ugcPsaBcUGRyCiEHcrXw76GIcT6DqzMhVcYWiRuYzmmZymJL5kt
         1+DVEbLNgptJKvePXRcfFXDqxThs0EKdBV41MXXGetuT7WYVSf45tsGExGzxd4+PNyeS
         s8CySgQpiGAy0BBvKWE/+8RwhL9Z1kUH5hiNlwkf6FlLfSuzb5uITtJ1ePhC9r2icohc
         gQsQUs2pPEES+kZcFIQfejPDIqTq8H88nH7TpLJXKZz2RHRjxIt+0BsubVGcN5Uc7vzo
         Kk5EjfwzrO+iar6IR8Czp78sN4qOO6nQW0KvinjW+4mtCSbvarN4nojzvZtvidIWxt5w
         KlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779884080; x=1780488880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjybRMBUQubASldC260OK8MJUJyjzZlOHF/HoeFPi84=;
        b=ZLqoyH/UFN8dQ2bMNRXVexxntIIwJwz9VwM7tQvTSCZxm0GfLAG02WAe2Pn+IE1mnv
         DV3lbgd1o7sOASO2KuEjs0NhvjgUtrLMX97utNL2ywz9TjREhPUzO9g2D8CyQfiIgFCO
         1/52ReycLYt+dJtckPEFFZYL5d4Ddj8gLkl/Z/rZfauQf2hHQDiNYR6FzTaF7y7BeFxz
         v0zRiYJjbp8BgrYfagQUpOAly+uR3R9vYH7klOSQumE1R1pYjlX7ZmtMCKHjovMd+IGt
         37lr7rk4cW2pDQz5agFNQ22yXePah0kOqHZaff//P5F2jGVs4nyzL7zzFHMmyh1YGcHv
         NIEA==
X-Forwarded-Encrypted: i=1; AFNElJ8XJRNC+TFHZSpquq04oZOB6+teFF41Q8/AU82xJm04OMozs5q8r2mBHrvFNF13VENg+DWn57q4mJ6B@vger.kernel.org
X-Gm-Message-State: AOJu0YxVg0lehdlxU36JYvCwSMqqfkKLHcUh1kDKwrKZhG2dsz8l6sMY
	Uq2WonEnzd2cEDATlPmaeVDfPhlBqEtLr8fApRHd97GuuFSxkeUph9ZlvqwnqH7bhgs=
X-Gm-Gg: Acq92OFHeHZKROvZ34cgpNLgFfPKz9zmONC03ss6jHfSXrfPFP6pEsCthJuu2JMiJOj
	KRkYxVVjPL4I8P1y7OkA5j1pj6Njd2aYsM0+wEbWx5s63sypNnWD0vtX5eG9bTiduIYuVDVLAaJ
	PJB6qLNEbjz0hb82Hwn5FX9vADCngdnprQGNz07LPYWGHDntanCsZbio/w6Jee/MhQsyu25N5uo
	Vr3+niCqGHqteqMK6vfidHb2X1wFOK+vlBdaemq6X/aQKhz0/14flmY69hKjcSpxetWRXrgOA3o
	dxPg0YgnUUgCEbEvZleZtqKB3KtP/GXZ6Tq0NzN86nLiTe99rbUiSOlnvHwUYXF/fzVL6meM7bl
	KCkA8pofWjKHXzy6EieyGuPb1aOVT3bqUUNhl4h2D5yZa5714oI0gc7HVXnYLfqLqSdavCXgEHL
	f3n2MHrdgY11CdsgDwogRbij/l8Rx+mJasxOMh2bNr99YBbhhxe+NSoJn4v5taiiC/QwLRu/Ugr
	TmGUlz3zGxCFrsx
X-Received: by 2002:ac8:58d4:0:b0:516:d2cc:5160 with SMTP id d75a77b69052e-516d459212fmr302395201cf.32.1779884079723;
        Wed, 27 May 2026 05:14:39 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706adc446sm39991901cf.15.2026.05.27.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:14:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSD9i-0000000ENnz-0tj0;
	Wed, 27 May 2026 09:14:38 -0300
Date: Wed, 27 May 2026 09:14:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260527121438.GJ2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21347-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F12D55E4227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 08:55:49AM +0200, Christian König wrote:
> On 5/26/26 16:43, Zhiping Zhang wrote:
> > This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
> > export path, allowing importing drivers (e.g. mlx5) to use the
> > exporter's steering tag when performing peer-to-peer DMA into a
> > VFIO-owned device.
> 
> I'm not an expert for TPH, but that sounds very strange to me.
> 
> As far as I know the TLP Processing Hints allow devices to give a
> steering tag to the root complex together with memory accesses to
> give fine grained control about cache usage. In other words it is an
> extension to the classic snoop bit.

TPHS includes an bit of data on every TLP and the data transits to the
eventual completer.

It does not have to be a root port.
 
> For P2P that is obviously nonsense because we don't have P2P support
> for cached accesses.

For P2P the TPH data on the TLP will transit to the P2P completer
unchanged.

It is up to the completer do define what it does with the TPH data.

Typically root ports in CPUs will use TPH data for cache placement
instructions. But who knows what a P2P device will use it for.

In Linux the driver that owns the completing address space gets to
specify how the TPH data works based on its own device specific
knowledge.

Jason

