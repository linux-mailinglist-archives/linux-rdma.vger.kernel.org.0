Return-Path: <linux-rdma+bounces-17384-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOPQJtOapWnxEgYAu9opvQ
	(envelope-from <linux-rdma+bounces-17384-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 15:12:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB41DA737
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 15:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A6473014906
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 14:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B6E3FD133;
	Mon,  2 Mar 2026 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P7Js+9Em"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DADA3FB066
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460295; cv=none; b=h5WylCkwQZ/slApAAod4Rj6NHh9DFhy37tZwhm5l86z0u/6bEyOlUocXQNZAZ2/vbhQXH71XUauCCAq0tfN7tOaV6an1rQfXEewKYIYb8ilxZ9/zCLutZi86yzPqKji3haK+sK2PN5i17X5lPKpIKtRB42EJGHNmN7DwEXFVlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460295; c=relaxed/simple;
	bh=8WaYxskhhRsHKhY63Ip0eu1QWZBza4VWUtV0RctbcDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcEXRgYzlS3alfdRm/LKUdJKJxwClGjGxpyK636Qj7JxwQ+kHyTgQB4QyHUqf+BXYd/nmqKdMoAo2xlB/zfzvXX21gBogJOK+b4mcyroQv3E/jYYFdyeqUFSSFfN2dTLRw5b9IgD90mJOM+KMtsfxBc3PDuVFoMlDr4ajVF4BEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P7Js+9Em; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899e85736e2so17445426d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772460293; x=1773065093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLrcIKGueBjnIWT3IFgt22YqquPVYuia+ThnGOOIiM8=;
        b=P7Js+9Em6FdZ7jMAbNY6UgXifGkMEsRdje45fjq6M6qjRgwlFy7h1D5ClhRc+BD6nz
         lD99gFKTzWa48hXLpWlE0g03bEf6B5Aa+GfkdNTfhAkv5zxTFwg63AvrFtsS61jds5hO
         0+lu/UHeHJBv3EYZKlx44Pu0m02zi8gbgABoMUwLtNHa94aiP3fpk/RvnN9KgZ4Zfylm
         NZ2g0MS85sk/l1eHakle94yAYN/hvgzduphRYmtMJnBJenCSuddH79ZCzfn/CdjANtxo
         /hhsa4WynJhYSEDJJHqtzrxRhknujk+XVj+FKHHd8VCqpKXG0M7SmB1uawZ03jJKc2IG
         P50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460293; x=1773065093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLrcIKGueBjnIWT3IFgt22YqquPVYuia+ThnGOOIiM8=;
        b=E3hfq62+dJfo7at5wY6g9DzRswaLD3YbXBJ0M9jET5bLkz5WVLbl3obGty+d1iiNAY
         hnlQRatq0O+76jiSEITRVxldL8Bclt5HlIZsXEjbmQk3agQ+Vy/urT+La/vatb9KXhXC
         ML4ar5yZcFkfdQzsJX2ajGUpqEjE3maXQIuavVPN3pSKaTibnW5R0u/b2C+yU5U2xF4u
         bGza1MsW2Zbl4fTKFoea2vUH7YOkoPUwWMEudSumy7i1Pq1Wr5bu4ch1NxGVef4Lk7Mp
         9xcTq6Ym6QL3ALrJoDqyFjnEAsHq9I/10JwZ6Z0chcWJ0hMO/oNqtr4tASbNX5byvjtc
         0qLg==
X-Forwarded-Encrypted: i=1; AJvYcCVF7uXlwBHNYzo8usCYKhaTqQhmw+iGcZ6vmoZ+QIe27mfm2Wu/1LrzpB4OnzBjhSD17UGno5jRm6Dm@vger.kernel.org
X-Gm-Message-State: AOJu0Yya2WVAjMk/LVk5RQNZDvpC2ZRYSIle45TceJOgqZgGIDQjs+xX
	fXpdBKKsZ32i8uptCTxbuwNa1KQ/EReveRken3L7B0jWp8i7UV+dy/lXTA7SAEizIQ8=
X-Gm-Gg: ATEYQzyMYCLepFbaNVB7Y4QOQBGIMKZLyHCZsvxjIQoar1+dDAyVfQ1xkpqXZCKuKPn
	GjXjElZM1tchBjfXGOXn0rRwjdL+nar1JA3RbEXzxnCYbYfTa5U+lk6AamDKDzDuWmEQWhDt6xO
	V/0xyL11z66j9tbEFylH6wu/hQ7vyGBV5/rjYJ6tYtykUb2vTQltZAzEspPNnL4kEFYFICbbs2y
	tUrQrMbwmAuVhrlSR40KtHFpiwlOEVULcfkj5uL7Fu4z4C7H+BrxdpCOKWG93kPJpH7q7aXJoqv
	+ABUe58g3LzTXWG7o1Q0J+bAJRaYM4uy/0rEZzYcxTbeBGnKAZAk43ASibKCY5Ok05DMXI3DAnI
	BCLExw2SkomtiSeCvmuuJWKQSzM6Y+0HzaqhAcpKbxHke4SwadRRtKymwl93DQal44OA4bZyqq1
	T/gc93zqy6LwBM/R48xtkDtrCJ+9VEz39ZIWRiXpLghWLjw/eXxJkEhYLNpQF3BNNm4jwliEBxK
	hbrv8vB
X-Received: by 2002:a05:6214:40c:b0:896:f4db:82c0 with SMTP id 6a1803df08f44-899c6766020mr242485226d6.1.1772460293275;
        Mon, 02 Mar 2026 06:04:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a017add76sm10957346d6.36.2026.03.02.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:04:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vx3tE-00000003fZH-0C57;
	Mon, 02 Mar 2026 10:04:52 -0400
Date: Mon, 2 Mar 2026 10:04:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next 0/6] Add support for TLP emulation
Message-ID: <20260302140452.GW44359@ziepe.ca>
References: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
 <aaIOgcfCbRIBlpUO@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaIOgcfCbRIBlpUO@kbusch-mbp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17384-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1BB41DA737
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 02:37:05PM -0700, Keith Busch wrote:
> On Wed, Feb 25, 2026 at 04:19:30PM +0200, Leon Romanovsky wrote:
> > This series adds support for Transaction Layer Packet (TLP) emulation
> > response gateway regions, enabling userspace device emulation software
> > to write TLP responses directly to lower layers without kernel driver
> > involvement.
> > 
> > Currently, the mlx5 driver exposes VirtIO emulation access regions via
> > the MLX5_IB_METHOD_VAR_OBJ_ALLOC ioctl. This series extends that
> > ioctl to also support allocating TLP response gateway channels for
> > PCI device emulation use cases.
> 
> Sorry if this is obvious to people in the know, but could you possibly
> give a quick high level description of the use case behind this feature?
> I'm just curious what emulation needs are enabled by having access to
> this packet level. Thanks!

These days the DPU world supports what I think of as "software defined
PCI functions". Meaning when the DPU receives a PCIe TLP on its PCI
interface it may invoke software generate a response packet for that
TLP.

At least the Mellanox DPU can route the TLPs to software in many
different places: various on-device processors, or on the ARM cores
running Linux..

So, for example, using this basic capability you can write some
software to have the DPU create a PCI function that conforms to the
virtio-net specification. Or NVMe. Or whatever else you dream up.

The peculiar thing is that this is all tightly coupled to RDMA. Eg if
you want your TLP to trigger a DMA from the PCI function then RDMA QPs
and MRs have to be used to execute the DMA.

Jason

