Return-Path: <linux-rdma+bounces-10162-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37CAAFA4E
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 14:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84CC3B060F
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E36A228C9D;
	Thu,  8 May 2025 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NbBA/Ij7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3FB227E87
	for <linux-rdma@vger.kernel.org>; Thu,  8 May 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708213; cv=none; b=joSjIL5Bi4+eKjU0zAQqv6SuLTqOcWaR0XQRtyUjcqxd60BuD+tJDbO0OwuBpQavP8ohHX0z99fGWwksmt36dXNedbLVorpIvBLy9vzD066x7AetkO4mUbk1Krj3qQY3vPcxqip9XqC3xp/KNcyGleg+62+gPizM4lPzenzBteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708213; c=relaxed/simple;
	bh=HWNHsRtf+5FSZ+GTPagDzDXppia9BSYKFD19Fh4swEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD9ZXbXqH8gqr0Al2a5k8RQnNFVpJQoRprGKIzephUuzVnuRWfgKGS2oY9R27/tgYD1DBp0O4oIeMoZ2PE9RlJGGDEEkkEWmrb/ghf5MNiENHjbxDN6dUy6n1EYzEEKBTph6GX6aCn2gWBqtsaVTgyXdc3usDbpC5pBU1atm1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NbBA/Ij7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f5365bdbaeso8750086d6.3
        for <linux-rdma@vger.kernel.org>; Thu, 08 May 2025 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746708210; x=1747313010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTWV7pQLtBIDnIccpvKkJE8DcYZkkis9h7adB60+MAY=;
        b=NbBA/Ij7LB15QhX7ojYis54PSRC6nnJjBAYu6XamAEsvePvr0xVgyJt3QvwOM3mLtv
         brjH92yxOR2ADYRtPtnqP4mbQXLkpBg7ET2zfjMW8+IejZJwZksOwJPbJiV/gdpP34k6
         0OzbEU4pcpyHMZ7jmsHHuKBWi2G2Eu2Nn/hRWWmuZ2TtF9BQwc8SIhU60xexwEv0dtsG
         rl3gr5NB4lKTh8xxeiklqsMTTAljyEFutLT/MASzlFcntE3TIs7ShH0/ociVwT+jinQc
         n11ZNGYEskoDMKHtwkjAMLe9+BHsS+4MBwdXH+0t5bP4XYjYK2JwK1RzCsYMJ90yXlD9
         YziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746708210; x=1747313010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTWV7pQLtBIDnIccpvKkJE8DcYZkkis9h7adB60+MAY=;
        b=lVAc9Bl1ZAwEraKK5b6eVSgpPmxdk0xGy63AAe59bOVIQZVt55qBvaSp2bRbpwa+Nw
         dmwZ82dwcjPKRDE1I/Vktp2xxj5bHBIAwDaU23IeqZ4h9hvz5xMTz7x0jszN7TWWfz79
         usKDiw4EoYY3744um3ow2QJe6bN1Y/gj3h3o1lYQ4fLyUxDiCpflQveBoy0GkXmMrHSc
         38KJP42CjO40kgS/Ej9g5mSuoDBrzY5OgcppK4JZLglOR3yXsy8JEHOuZNKuY2XxByeE
         4i8b8Sz0ScshDsI2iiOzyKsolq73VSIOhz/nZtOwRRnDiDjWy38yns/Kjdstr6I9kl/a
         NG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUK9m78ljeNp4zxV7LidnXUGlehYZo5z1ps9kQGJxrTQU38r276ENmvsCCDPDKUxMeIfnPTmKIsxtl3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rbf6ygsHeiRycvOQuOr1XmB3sTzP9kXCVXTzimD+j8l6Sba5
	Aw7NnXAGjCxPJFTG86KmgXWR1BDqWGQ8ichyLyHc5G+LC91OKgyVepYrYCw0ksM=
X-Gm-Gg: ASbGncv7Ww6yBLpl00f+hT/JFtLvIUKVbWidsGmDIsbMNHs29CUyixY19edFr/AtN8j
	ByxrS1+N6FM0zcsIYkf40FnQAJU6TCR/rKM5l7SM6vyDnCl0uKOf0AOhk4LEggB1DQLgP+hy/fx
	9LaeRKPurhRnaQIRaxEsuS/qNpnO5ENQTu7b5a1mrPdLfNR0cQZkfc9GHvbZLs0es9WGxuCmeri
	94G70IHq66UeldFu3NE3s9tDBVUaHV5VELBWfol6CPbjkyhVBka8fdrAV6Hx1738755VPzyJodu
	DqqpnfJLrkU8ErKtrAGZk4/JmOQgxrXsczmWJqG841lvh4IfpAtmJqot5oKir75P1bb7R4yjIJA
	HjDWp/nyWsypPgqGXWUL635ql2OE=
X-Google-Smtp-Source: AGHT+IHVa+U5NKbbh3dgdKIjbb4/Pp34y7rEb7Z/PCeUn2AeS9DcR+RPDvVv8zS34Iwj9MQrXZxR4g==
X-Received: by 2002:a05:6214:19e9:b0:6ea:d393:962f with SMTP id 6a1803df08f44-6f542a1b31fmr81088476d6.16.1746708210089;
        Thu, 08 May 2025 05:43:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7caf753845csm348700085a.53.2025.05.08.05.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:43:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uD0b2-0000000026z-3sr6;
	Thu, 08 May 2025 09:43:28 -0300
Date: Thu, 8 May 2025 09:43:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Srouji <edwards@nvidia.com>
Cc: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
Message-ID: <20250508124328.GA6500@ziepe.ca>
References: <20250428193702.5186-2-cel@kernel.org>
 <aBoJ64qDSp7U3twh@infradead.org>
 <20250506131722.GG2260621@ziepe.ca>
 <aBoRSeERzax5lTvH@infradead.org>
 <20250506135536.GH2260621@ziepe.ca>
 <be740f28-8d68-400c-85bc-81cc4e48ccc6@kernel.org>
 <20250506141705.GI2260621@ziepe.ca>
 <d7115cd7-c34c-4212-b244-e5247ac68fcc@kernel.org>
 <20250506142202.GJ2260621@ziepe.ca>
 <1a1bcbd5-4b78-47ae-bede-36265586c7ff@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a1bcbd5-4b78-47ae-bede-36265586c7ff@nvidia.com>

On Thu, May 08, 2025 at 11:41:18AM +0300, Edward Srouji wrote:
> 
> On 5/6/2025 5:22 PM, Jason Gunthorpe wrote:
> > On Tue, May 06, 2025 at 10:19:06AM -0400, Chuck Lever wrote:
> > > > > In this patch I'm trying to include the reg/inv multiplier in the
> > > > > calculation, but that doesn't seem to be enough to make "accept"
> > > > > reliable, IMO due to this extra calculation in calc_sq_size().
> > > > Did ib_create_qp get called with more than max_qp_wr ?
> > > The request was for, like, 9300 SQEs. max_qp_wr is 32K on my systems.
> > Sounds like it is broken then..
> > 
> > 	props->max_qp_wr	   = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
> > 
> > So it is ignoring the wqe_size adustment.. It should adjust by the worst
> > case result of calc_send_wqe() for the device..
> How do you suggest adjusting to the worst case?
> How inline messages could be addressed and taken into account?

I think assume 0 size inline for computing max sizes

> Even if we ignore the inline size, worst case potentially could be less than
> 1/8th of the max HCA CAP, not sure we want to deliver this as a limitation
> to users.

The math is simply wrong - log_max_qp_sz is not the number of work
queue entries in the queue, it is the number of MLX5_SEND_WQE_BB's
units which is some internal value.

For a verbs API the result should be the max number of work queue
entries that can be requested for any of XRC/RC/UC/UD QP types using a
0 inline size, 1 SGL and no other special features.

Even for a simple RC QP sq_overhead() will return 132 which already
makes props->max_qp_wr uselessly wrong. 132 goes into here:

		return ALIGN(max_t(int, inl_size, size), MLX5_SEND_WQE_BB);

Comes out as 192 - so props->max_qp_wr is off by 3x even for a simple
no-feature RC QP.

Chuck is getting:

calc_sq_size:618:(pid 1514): send queue size (9326 * 256 / 64 -> 65536) exceeds limits(32768)

So I suppose that extra 64 bytes is coming from cap.max_send_sge >= 3?

Without a new API we can't make it fully discoverable, but the way it
is now is clearly wrong.

Jason

