Return-Path: <linux-rdma+bounces-16200-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JDhBsRee2kdEQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16200-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 14:21:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 777FCB0558
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 14:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CBC3300440C
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A81FAC34;
	Thu, 29 Jan 2026 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P91dyL7G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A211DE3DB
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692862; cv=none; b=Zkl9NU215Jx0j2Z5nJqEehi+tfFClIS7yqQsW0zn1pxpFj9XDaHKnwu+qoKGhEMQTpJ2VYIS1/K87HvQHPN5vQeZEkJQgxl8vZCpdBFQnYDw8yzUAFZRuBMBHA78YxYJgflWURvs0NfiDTeHMd2eDKRt3RMZ+EZG56yzpDVWZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692862; c=relaxed/simple;
	bh=vh7VpdWClqvupBRtUyQ4oaehf0QJg+QlY6j9lsmTLm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGbyMEwnqFcmWK9ZMRpjqbG3IhAXwd075Df8LkRiSwxcvGrazjLnXhvQHCmg/0DDaIBYiR/CQHx0S5FpB9DpqAWEvgAkKpwGPR4n6/0yGEDdpokSyqduTJs0e9H0lBgZun8gVuIOdOKnAdAQHfu4OrFqmqrqJh6DLZ9Cx3yE8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P91dyL7G; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c07bc2ad13so77289785a.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 05:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769692860; x=1770297660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vh7VpdWClqvupBRtUyQ4oaehf0QJg+QlY6j9lsmTLm0=;
        b=P91dyL7GH3Q3LC1VWC0ggnpPNgv2Ft+cnx2Jr0aJlCZFs9gQAU9NwkQiHHUhx+lXBj
         /zDrpCaRR/VC4OEg21KoY57JaR3Lt/ArETPe9W+zwQxZATbLOzUq/GZ4H1e12lo6tYYp
         Je9ouB5/T1ePvvGCr91wVQGBHGInWtK9m/Kh1WdC8qvd663Vw9OobOtqjbCejw82R3jj
         a+oqHZkjTK27Qs9WslKpOG/HZH6gWVC1y6gKf/i66lflCwYxfKEdka6ZUp76liThwQG2
         QH3Ikpom6eUTKGcDL4FyUWc/rm5/C/Pk0XSCmsXTKgaDRv6n0u0Dp8jOlc2P0Pbeck5e
         /I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769692860; x=1770297660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vh7VpdWClqvupBRtUyQ4oaehf0QJg+QlY6j9lsmTLm0=;
        b=ZF5NK+HIFnzGmsMvrcDuKbK7zUa/1JUP7MD0joYQKuhw2CWSH8cZYeFAznJrrESyHQ
         Ngjt/yps/jilzcpHOwFwLK/O7oEJ4CiScet2ylUZGNOoq1IndKkyXvCC29FYu8XxjwYf
         O+SDuJ0iT61mCBaVTHAd0KF+53EN7XruMIdpnMDJEuvZG3R59hobrlKrQvqyRsgjmn2P
         5JRCizcrPPsoBVww+707B9zYdt4KgZ0OAp/t4XAUscd+B5t4BccHhE/u+ttraHOKFJYk
         irc3hjWJCquKG9L4Ok9jc+P+uPZv4oCYGwKwNBt2vmtB1M3ZYvy1fteWI1bJWemQ+ijo
         BRmg==
X-Forwarded-Encrypted: i=1; AJvYcCUWxkK706e5OOmHGnHjaS2rGjI5slDZnr4nrvCUHAEQBQGWAEUSyU87H0q7Kz9q8Kc20yJ8+CPWP/On@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vm1JzflLN6NrdXVKRGAfcoXudwObUmDW8MD9N0WMXmFA4YVL
	pW1PlDQphxO7e+M5VhSxm4+erk2GZr8ZCjyEog3IkZa3ZYL9H0NhE8vc2HnwDfhLKgQ=
X-Gm-Gg: AZuq6aJ0C5XovjrKhiSnaIFJexezdSwgooOAWPIdNYlZRGn1yieRuTbITv+5I+Km0vT
	SatnJ2fORh72a+mXzESt+716Umhx63hWrGhzV+8FhoFcd9IqMelrqmpG9s5lzyrvOJoDoA9e8P3
	+IDe31cQ+6iEW7d1OfRjlPFtpQUl4Jky9779S56Z71D4GdriDBoHOFjSPu6Uci/YklIleUVvWve
	/tVF6ZKWvUH0SW+Jw6NFlQvByViarNkAaqvp4qp4nuO+eMgq3gTJulctoLa/nQgfhPG69pL9gxP
	hLWYC7tDA82/wJBf37K/p47x8iZZ+o7X4nPguZz3yhZy7ERZSxzyY3+UyWFeSPmJzE7K4WwKXkH
	OLbzDdie8pMGvjlYB/ijpYYnOAz1IEBCYSlulXaaE/BpWhVmoNt4l02ULfRK7tKj9vJqA9PMU5W
	she2PN6WinIGNZjFSJHonaOSZUkII6GSyHxEs338w2CW2qSaMFhobcptzFutJyHS2l9aY=
X-Received: by 2002:a05:620a:444d:b0:8c7:177f:cc17 with SMTP id af79cd13be357-8c7177fcf62mr589344485a.46.1769692859712;
        Thu, 29 Jan 2026 05:20:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36a5fb1sm37087576d6.9.2026.01.29.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 05:20:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlRxC-00000009joR-3Dw2;
	Thu, 29 Jan 2026 09:20:58 -0400
Date: Thu, 29 Jan 2026 09:20:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Leon Romanovsky <leon@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <20260129132058.GC2307128@ziepe.ca>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
 <20260128180629.GT1641016@ziepe.ca>
 <20260129113609.GA37734@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129113609.GA37734@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16200-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 777FCB0558
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:36:09PM +0800, D. Wythe wrote:

> > From there you can check the resulting scatterlist and compute the
> > page_size to pass to ib_map_mr_sg().

I should clarify this is done after DMA mapping the scatterlist. dma
mapping can improve the page size.

And maybe the core code should be helping compute the MR's target page
size for a scatterlist.. We already have code to do this in umem, and
it is a pretty bit tricky considering the IOVA related rules.

Jason

