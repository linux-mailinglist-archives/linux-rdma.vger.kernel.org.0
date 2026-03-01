Return-Path: <linux-rdma+bounces-17347-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPFtLQx+pGl5iQUAu9opvQ
	(envelope-from <linux-rdma+bounces-17347-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Mar 2026 18:57:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA091D1010
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Mar 2026 18:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5756B3018BE4
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2026 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C22337BB5;
	Sun,  1 Mar 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dIrerKPj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFA51C7012
	for <linux-rdma@vger.kernel.org>; Sun,  1 Mar 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387755; cv=none; b=I4TwKmGr/Y6ABTp34TN6TRNLP5nL5XCvA6JV8y2EouWvVSL41ALx+IvxpSuke6BaRgBrGB9koXBdQjIrPxURT2ScD2Jp0sGrwZr1ayTCj6QVc/8RRdffGkNoWj9LCQKvIDORsn4opx9p4scjKxJVRbTabK1az/Ff1K54JIu+hjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387755; c=relaxed/simple;
	bh=yhgi5eMSXsQDCYKm+CXjR4bsxzX9U+ECNX3EnREIBps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh8s2AbQM+yZLZKEVNgwAqWyJtgWQzusydPkrfMPDgeCXGxD4G5ikxvUn+iM0yIWN6vMpo+/0ARFXJovCD7HEyRuJ2Ko/0M0Qa2uvnV6sf2tTlJ4s6llOnqMyLW2HN+zpUX9f6jahOAccxXiwsFIfl+FJfla5h0rnbwFzodOXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dIrerKPj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb4136d865so494788785a.1
        for <linux-rdma@vger.kernel.org>; Sun, 01 Mar 2026 09:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772387753; x=1772992553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCd8bTN0yDfsSyi6ZA8FG9Faz13YGXHzhnf02MTH1b8=;
        b=dIrerKPjtw6iWP+dBwRH0Ci9RBi4QAE8rVnJeoI2Fg76E9IxhSGUNGqi7RaYvdv+BF
         cZ702ssNmV2/pOwLexFowpgH6EL4LUzOHaC2R6E8TzPUi9QeXSoD6n6qBMcuL9b5BtY/
         EqtmxRRyZgK7KcguiqjyPckkhPiR7qmPGHkDJY/PfLmhsdxIgoRE+5ESWp6Ub4opPveW
         CzSnh2rO8m8xGo4U1XzDl+YjYutgBUPTCKBDw61xlT2gVgnUYu9iSJXQj+7BpRya9cHB
         1nzkKljJH+32/UTRhGKxtMmAVXIhiIM5KGt7w5niHzF1uhkiZkN3rkRqdZDkkgbLQH4m
         ykgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772387753; x=1772992553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCd8bTN0yDfsSyi6ZA8FG9Faz13YGXHzhnf02MTH1b8=;
        b=LgY50KgvE/VLGDg6cHkd6d99hdrg55hIOUCHjIl/Rz5ozG3mwtZudHUopJhRc26Lor
         cXZNJKgEnbkE4BHmZRNxNj5zVLail6H30vHw9crGnTMaOMNbnP1iwaDtp48Pf7ohH8Hh
         dTgcS89AYZmrk9VxaEo+LhofqsOqpZ+30K9+e12YdUoa4j8pHZLba+Qhyazo8mGBNWGR
         6YiZQMvTrc7L8Z7wPrxSS1w6wLaBHwW6VQ6IPavnKqp/ByIhZHMwpy/UbSh05J/abE6o
         ZxNOkDeVs63L0LHGnf/ThH7ueiYtgNX3XRnIf0Hi2Ra5QlyVKR3okWA8NhOO53KgyY3+
         zobw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Bm/SCG7EWYPXSkWx1raHo28V7IX4+hU9l47P/RyY0YkYV29Fyto+TySYYCVWZlmYp84OwnqmNHAM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VFhxFd2p8LloQ96IbhgBOi3RwppUEEBbl7QXI6BLHDRvlirF
	OWbwt3gAscJzATHaOxZBcvlWySh+80+RPu9C+sX9KXcldUjJZrk0idn5OKyttBSrJLI=
X-Gm-Gg: ATEYQzwdHLlfm+gM+4bqyUbFg2iaXlWP4dhQkFVIJ9YMYtu7RNF4TgL2de2woB1RyZl
	PdSDyjUI+L1c4fNjtuuWj2pFfCHy6n8K70GJoGzCVOh7LyGgovTqA8ZLyLuo7scxTI/aAfSNT5H
	AJyyd5blxlcc+TReun/2rquOh8yfYvzqaPDsZ+HIiU0doXcBwuPUDuhVimgmaWN3QN7e4WhXprt
	vA14n/wAJy3wzC699AWn1kRaRV5uxOykSuSJ1ZN8ZeaXbMfa6S+BDUIu1h6DsUCRaee4nucLht3
	BQgSa4VPK9aDMa3xMcqAEGgz6ODQAHZlrG4qEi7VVbBoiu38jRFcCsDcjne0YBmkT8XRMvewL4K
	aeqTEc8Ms16BX7Sh6J9x8Vp/Lp6JyZwvhWvO39q/BomJ7hHw/jU0682jZl6VOpG6Rt6CNKmdA6d
	aNZwSVnyxWNH4vSyABARwqFh67/4EBI14+Ee5ll0mBynusdZ54hGevecZYDIqsTVZCaLR/aSKp3
	6aS1nHYbwaJxrjpuWg=
X-Received: by 2002:a05:620a:2802:b0:8c7:155a:6d04 with SMTP id af79cd13be357-8cbc8e6817cmr1277844485a.54.1772387752963;
        Sun, 01 Mar 2026 09:55:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f873dsm1033539385a.25.2026.03.01.09.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 09:55:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vwl1D-00000002dJu-0Hxd;
	Sun, 01 Mar 2026 13:55:51 -0400
Date: Sun, 1 Mar 2026 13:55:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC 2/2] RMDA MLX5: get tph for p2p access when registering
 dmabuf mr
Message-ID: <20260301175551.GT44359@ziepe.ca>
References: <20260210194014.2147481-1-zhipingz@meta.com>
 <20260210194014.2147481-3-zhipingz@meta.com>
 <aaDxmGoqpjnvmVs9@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaDxmGoqpjnvmVs9@kbusch-mbp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-17347-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 5DA091D1010
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:21:28PM -0700, Keith Busch wrote:
> On Tue, Feb 10, 2026 at 11:39:55AM -0800, Zhiping Zhang wrote:
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st_index,
> > +							  u8 *ph)
> > +{
> > +	int ret;
> > +	struct dma_buf *dmabuf;
> > +
> > +	dmabuf = dma_buf_get(fd);
> > +	if (IS_ERR(dmabuf))
> > +		return;
> > +
> > +	if (!dif there's any implication mabuf->ops->get_tph)
> > +		goto end_dbuf_put;
> > +
> > +	ret = dmabuf->ops->get_tph(dmabuf, st_index, ph);
> 
> You defined the "get_tph" function to take a pointer to a raw steering
> tag value, but you're passing in the steering index to it's table.

Yeah that's weird, there should be one TPH for a DMABUF, not many.

> But in general, since you're letting the user put whatever they want in
> the vfio private area, should there be some validation that it's in the
> valid range? I'm also not quite sure how user space comes to know what
> steering tag to use, or what harm might happen if the wrong one is used.

If the device is VFIO compatible then it needs to ensure that whatever
it does with its steering tags fit the security model of VFIO. You
can't harm the device - you can't reach outside the VFIO sandbox (eg
into another VF or something) and so on.

Under these conditions the kernel doesn't care what TPH is used, just
let userspace specify the raw bits on the wire.

Jason

