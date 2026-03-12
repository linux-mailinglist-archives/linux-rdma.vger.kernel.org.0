Return-Path: <linux-rdma+bounces-18053-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMR5Em0Ksml7IAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18053-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 01:35:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA55826BB62
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 01:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1128030E614E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 00:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA144342C88;
	Thu, 12 Mar 2026 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T6oJT5zW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5733507E
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275748; cv=none; b=nVEJVtz7OVHTOD+H0IUXqW9r8CLYRKPDCa7TK3gk1iZSrgYgqMmMTHV/0EyV1EoB3exNtniLxFNIwzRPy5Onxn4V1xgSVDjlx3HrOfFTH1I63Qbm1DmJp0sBU7o6IW0cIddfZ2gY/h1VDeAYAK1trFsC4iVxOXF0UxS7I8vHG4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275748; c=relaxed/simple;
	bh=bu9Oih6osFV7rtjEbKgQ3kyOQcVL4TprE4RKoYQKLtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzUSjm9jVFZ3uMKDhSYYnI/PvAjoIXORVogXlkcOQsbUiUvzVEZZoY7lEVWvTBVrRXl66oi1YaK4rD6+ajQJHG2xZrO3aBZ/R3PN8+4nexkBWbgE5HEvgLXtcTfKL0M+cGpgeRyL9r78vuoID2UmLSk3pNbdwmikAanoTeC+IYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T6oJT5zW; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd759f502dso39272785a.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773275746; x=1773880546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bu9Oih6osFV7rtjEbKgQ3kyOQcVL4TprE4RKoYQKLtQ=;
        b=T6oJT5zWuYFu//UQ44qIFvKBmmdQ907fAqU0B+SynFOCaH3CICCfLE0JIjo+TrRBCu
         OWMafBCtK5bj9+8WW19IgoMJauzYE3PxouS7PlZhkKO5SK72+SCn5P420BHbtOt0bTmC
         kuwmvPQZMYPvu/jJ3ucg4ED095KdqdtZEW9+LILVV5HHOmD4ibcRTe05tDLb8yag7tkD
         syQ+G3523JJsJZhXT3omA0rJ9+mlqaWOlAx4NEkOcM4eHniVed/UyP8zYqhuVU/3p94v
         qXvRZQSrkZLzBsLQceILOSorD+7MoYauHXw3sIbiclHi/HDiL9n36+GeHX5RM3minec6
         +tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773275746; x=1773880546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu9Oih6osFV7rtjEbKgQ3kyOQcVL4TprE4RKoYQKLtQ=;
        b=wkM3j4gZmG57JGkbIEtC1xYdzisfIJah3fOtwN/PF764j+avIFF8bWjp3u/+X9LZ3F
         smXSYR6NPPuj6alorpmo4si7Cotowl4aITyQPbOFfnJgy2hXSsddv5qrEhh9MzzLYR4A
         jKEiHYODY3c9Zr/wiEo/Razni0rAAnQr1wFQLdxvNYrn8WIwSXGUVFz5ZZG2iN4WfrW1
         PrxyltJtzsS90+5mEPxvlvrb+zjTO/H/AV2pIF4ihBfwmjVx2xn/20qo4aYdVxbjBs9W
         2hImogeBCq9dHUQlPQE705Av2SdKEyNyWgZxd0HvsPP3AoOZnUveK78D/xZbljYzmTIE
         OE4g==
X-Forwarded-Encrypted: i=1; AJvYcCUgAKEuLjkywnQfs0DQo/BZbqbMaFwc+X5TcENBuhm1bgeH44BaO05VxHKT8dIanXyLvP8IHCPUpmVy@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1AV6GQt17bYnJ5+p9p734DN3IQMjRtZ+4EGzfLfqEdS8+bOR
	1ZtoJSkJD2IKzl7PLcOPp4wXNSYq66i9s+n3nkeOoon/BAhVwrYrW7Pm2DljCzr53CE=
X-Gm-Gg: ATEYQzyvOlmW1YID3nkOdeqa4EPsS/aYR2S/guuRx8Z5Q5g77DCQyV5eBr9L5pZDC8f
	tZQpNZ2GilgFkGHXllf3cEM4tm3TR+LAqvGj3mDck7cnXefpLLapjyg3F9juxSmh54pgcWHlHZO
	192whDwChwKbG7bJuKyZAJHQj54kzDWXCb2loHGtFaK1LloKk+DGgfIDIlzqzFVXU4Hj+ZEQ130
	FjEqADXJw0Fc6VoC6bKFx5pXvszjBhWKE5Cr+Ubq4bPV9gBgFVEhCKI7tabDDpSyv8eIQcMw7YU
	wCl0f1Pns2Q2MeUNOWJz3sHQKkEwmaoIRtit20O9X6RY2TH79zdTzocNK+bSK5d0IhFFaKsVEaI
	0CWxAzNlDVEoQmrJf1J2kjndwGRNyFKuPgLrzDoKpMJJrzjf08+RZdX8S/Y4CXd0nu3LgE16tSZ
	qOv1cvM24I7Xi4uNOURbbhel5aOTbtZs488R7ZwdYOPyWTmtncciPHLx1wcR8rgMKlmlB0a8iN9
	cdz21dgNtfNBnhToU8=
X-Received: by 2002:a05:620a:711a:b0:8cb:5176:f00 with SMTP id af79cd13be357-8cda1a95cd3mr623140585a.45.1773275746517;
        Wed, 11 Mar 2026 17:35:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21100cfsm239690985a.24.2026.03.11.17.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 17:35:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0U1g-00000006a0E-4BUf;
	Wed, 11 Mar 2026 21:35:45 -0300
Date: Wed, 11 Mar 2026 21:35:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Praveen Kannoju <praveen.kannoju@oracle.com>
Cc: "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Anand Khoje <anand.a.khoje@oracle.com>
Subject: Re: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Message-ID: <20260312003544.GB1469476@ziepe.ca>
References: <20260304161704.910564-1-praveen.kannoju@oracle.com>
 <20260304201151.GI964116@ziepe.ca>
 <CH3PR10MB7704DD1E6B9A671796FC6B528C7DA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260306003217.GB1687929@ziepe.ca>
 <CH3PR10MB7704ABC8F3909C60FFDFB1188C7AA@CH3PR10MB7704.namprd10.prod.outlook.com>
 <20260306231024.GF1687929@ziepe.ca>
 <CH3PR10MB7704D1DF6471E59D47ECEB098C7BA@CH3PR10MB7704.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR10MB7704D1DF6471E59D47ECEB098C7BA@CH3PR10MB7704.namprd10.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18053-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA55826BB62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 07, 2026 at 05:43:56AM +0000, Praveen Kannoju wrote:

> It had been very challenging to arrive at the cause.
> we went thru many live debug sessions with Nvidia R&D team.
> but we couldn't root cause. This tells why we eventually.
> arrived at this mitigation as this issue is wide spread
> and has been hurting many and many customers in cloud.

It is almost certainly a qemu bug. If you cannot find it, then I
suggest you work around it by having qemu inject a spurious interrupt
around the migration situations.

But make sure you have the already known qemu and kernel bug fixes for
lost interrupts on MSI-X writes...

Jason

