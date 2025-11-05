Return-Path: <linux-rdma+bounces-14263-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA9C35E98
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 14:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B98618C094D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3705324B3F;
	Wed,  5 Nov 2025 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N3pZ3d1Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679A3191C2
	for <linux-rdma@vger.kernel.org>; Wed,  5 Nov 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350423; cv=none; b=la42fB9RY5+lTSkBZ9XbuVOig3wZvuBFPeZ1BV9mrYeB8v3xTTcAcRNNUEUUMyOigK/QbFHuHeKdfPREvT1ieG7R80NekI/xG27UlHEFZu5vmmh52AH5bM/Wnmy3/VK04tcM7mqtIxXw9AjfroBDZQsZ4l8riozvu61oxPpOSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350423; c=relaxed/simple;
	bh=bvfb8EO/Jqx4CYfgIOHPa1nosqTQWDLTokUveNsd720=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6yAaEUm7dNbpd5+Pad5P8h7XknBxMiHEBcu5SHgd9otTVS3ZuSzCX1OYylgBeUaYiTymhVVCmBEyReaSF7iGJVj/bix1iSCHZM4D9wB7HNNiS+qFoQw9LvQwtaFLCaxzAnO7lG9QgmKx/TPwRbQJBSngHaGzP7TJFvBA0S9HYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N3pZ3d1Z; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4eba6e28d06so49490671cf.2
        for <linux-rdma@vger.kernel.org>; Wed, 05 Nov 2025 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762350421; x=1762955221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zp2fLrlqJdhZLczeGkjeF6Ah1WqCYQgeoq7QTO4hMM=;
        b=N3pZ3d1Z8mSqvUg0662RC8bZpvOpu1qb+bANagfhvp5hZFNgEHpxU2PahBcew+Pa/u
         utZnfv9zIa9G34AoF7vaFOZoZ1gJsjSWlt+X1VCQX8Smq+blDDOCQWHW6MDWg+ww/wy1
         VRwkhKVRJFydAxQNS/3lZw44TocdqEqYzKvXFK5VccnNTL+lznJkK3FZyzzvy4l/dVe7
         ZDaDoa6p0vAbN8GraudRxwJEm72c9ML32aeyhrj7sOGy1Gq2OHxwLoot7zIQ4Bwma3V5
         E9oI73lULX4bRzmH7Af+/3DcoDsTKaz7guepOdSAONKPqeWmfWvoCKuyKA56QhlMY1oK
         HquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350421; x=1762955221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zp2fLrlqJdhZLczeGkjeF6Ah1WqCYQgeoq7QTO4hMM=;
        b=q8vDtDk6tdpX3BDyQLAUplaGnvMYmmFDLn2N7+5JP97euVfJgQeJ7rGjZWBDD9mhUa
         YWybBI3y6/zq9vHQQQFCTkCPsU9+9PB3BpTJs7Nln6tgMvmnLuh7qSjLpj85iXScJSd6
         +syrjr1UuRE/OEkmRqVv3+EC2nJKaL5d+FSdNskEaxDoJLcQDIiWs4ZV9kq1BtTS+3vB
         8nc86GwaWNKWwbC+ooy8nMG1OouNEQEHUEMC/7AM4lRyX/4Yq42VdtwuXMLNdmg4Zo2v
         jzUsDRSIfadQl85XuypmAKoF2wEvX7HSSYcgINmBI+PqohI4wnDzDKICEOTy9+JZGWDp
         ThfA==
X-Forwarded-Encrypted: i=1; AJvYcCUgUnGUSMuFJD+fn+wlgzejcgNZrVuDAYa2P3MmHqjy+AoVfxUoNKzD/rrCes4/4MHGCYr6uoeBsIjh@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQMkxZq/jMVABq8g22go/rkIUZWudp8+xW+YcyBV9gYh5pM62
	XdCBZYZn47xbtp96/JO4qpEp6E0G6UEUTJmaXVhz3cre4L1RddNr48Bnt/Fotcq2PyU=
X-Gm-Gg: ASbGnct6nc9a08KofITnc97QVXcIR73iV3JRJcpGz/dPIPcI79SmJUe+KnaVWFVOJcj
	mMkK+oGZrawgDRc+cpFW1z0tEFXedqtVchjGWuHV95odxQ+KibpB09H2fG3s3kadZb2EBv98ynV
	SS5SIx0CH92zvqfh0qx3nw8B5kNbw7er3IEoqdY7PUmG+JLkAPcRMNrdLcjZUEC4HX/ahGTAVRK
	KtrpD53M5CMi/Y9kNs1MfMdkIAu5vMgu8TSwHBr5w4bTufrDwFCfLgMR4LHiaj5P+Q/K5xY4HKT
	xuOOHmv6eSeP9Vwj4HDxYUx3QCgtT2X+Ksn/g++igh1jXOz4QUHu3K3oO/h3v6++4yb4bumYZgl
	2T7lSK5QN9tFKLcFxyZzDFgE9+6w8kzZhZemqnZq0BRvv0yToRuOtjocLUtmddFhrKQnKy7O8Zp
	5ovMChi/UckX9SJoV98bR+XgzuVDC1W4zZhcRQ/Nqxu9X9+w==
X-Google-Smtp-Source: AGHT+IHiV3DU9pUwV6yRzvNAkLqpA9Q0anM5JtolaRsT/xrM1GR0vgEGuAlaC/LkLUMiyZ6hyzBu1w==
X-Received: by 2002:a05:622a:110b:b0:4ec:fafd:7607 with SMTP id d75a77b69052e-4ed72673eb5mr39574611cf.81.1762350420869;
        Wed, 05 Nov 2025 05:47:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5faf6038sm36924761cf.11.2025.11.05.05.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:47:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGdql-000000079Nw-3Qc1;
	Wed, 05 Nov 2025 09:46:59 -0400
Date: Wed, 5 Nov 2025 09:46:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Ma Ke <make24@iscas.ac.cn>, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: server: Fix error handling in
 get_or_create_srv
Message-ID: <20251105134659.GM1204670@ziepe.ca>
References: <20251104021900.11896-1-make24@iscas.ac.cn>
 <20251105125713.GC16832@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105125713.GC16832@unreal>

On Wed, Nov 05, 2025 at 02:57:13PM +0200, Leon Romanovsky wrote:
> On Tue, Nov 04, 2025 at 10:19:00AM +0800, Ma Ke wrote:
> > get_or_create_srv() fails to call put_device() after
> > device_initialize() when memory allocation fails. This could cause
> > reference count leaks during error handling, preventing proper device
> > cleanup and resulting in memory leaks.
> 
> Nothing from above is true. put_device is preferable way to release
> memory after call to device_initialize(), but direct call to kfree is
> also fine.

Once device_initialize() happens you must call put_device(), it is one
of Greg's rules.

Jason

