Return-Path: <linux-rdma+bounces-7320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BF8A224A6
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 20:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE940165C9A
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 19:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5941E282D;
	Wed, 29 Jan 2025 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Tj8GLVoi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC09158A09
	for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738179828; cv=none; b=m7og2tGKq98YWS4c0OjJFmvGZIa0jnvHKMP2AgFlgq9yUfXlYQXFHVQCMBdneBReZ3vHukI7xF8gQOwGpjHD9bfeZf+vaQwoQU9nMIakz1IXX+IHwNrPVha/W0Z29jOsGifuHf/aUd3EnM0emGRp6j9Xu2y4kLyZOlFScgAlSiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738179828; c=relaxed/simple;
	bh=D2Kx2P+neXMFIw5ucuqV34P1DzELWI9lZRYaExHir/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzXGOPij0dh3CLwLRaAa5igFInP9v1KP+P7kN4+1xY+gHK000YLdzHzbZrpz6b61jhK1bJKMqSXacQnpvGvAMr2BSS85DbYMJgRGHyItT65YduIQh761vLDvSagYeCDIb4Jhz35Gji1BlnRx9crcZJWVQE2y0xxXh6CjDa8wazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Tj8GLVoi; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8fd060e27so391006d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738179825; x=1738784625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nSbrJF+0ambUjTCtJ80jRG3qCyBlWZS208KWFiT6W8k=;
        b=Tj8GLVoiZsOTrswFhHGP77GfLsoowQIELQYtveI4jjjohsTUVJr90rslbrec3rrSb+
         uspIDXlcp/CLBlKEp8VHv215Bf3zikezcqhWxc6jjuCJVvSUUAx0e3J07vkz6cRBLdbe
         TUON74UBOLhODuLk2s/6vS15geLiCgR7/hgtpmqcyA/QpP94e2e3WP2usQ2PstKJ5JIG
         QOH0Pna5xJwPTMwUu984n8IO1qVKEnfVGY539FinmEavTHXrJ8/DteoToJdVZpBVGPn0
         P5wcnB18dVT6xHvC45mFsvDF3DI94Ugwz/P6EWojTC3xdce4mi63N2F+SCH7RVLeC1E0
         zkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738179825; x=1738784625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSbrJF+0ambUjTCtJ80jRG3qCyBlWZS208KWFiT6W8k=;
        b=cm73n9YI+q9Hh4/q8yI1vpeVFn/RwZHWVJ2wUZiMuMdZ/HFZLuExGRKyghO9LVkc6A
         v5PFndnwxwm4Jua81eFUKGH9CWk//lwzcsVBxofUXvul82qfgBfAJk1RSZdXsUD5ZbQY
         llpYbUSeMd7ujPgpEq8W/pIR3nRob2A2JsD1dMam8JfZeqOQZwlAKvKd6QOtK3b+S9sx
         DZe6Fg2dLAPSU24gER92wcCbcpyGjQiFfLAHH1sAnz6qoF0DdIE+Nd8RdDqE9x6CkHe3
         K+qMlNvCoQvNTOHOhDAjuMM06nbh0T0QmY2dxAd4ToIZ2n0jkpwt64ZTvpwlJCJws2GM
         YodA==
X-Forwarded-Encrypted: i=1; AJvYcCWVc+3867VhBDddapr+EYaa/KH9JMoZBsgL5fvutgS1MPwFYxIzs+cUSmv9+8+Wjn2fHbQWpFT1PuHj@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVVOB3DJK54OUIiZtHzlQ9Xxfia30Sk3EU9+0qINUNsjvoogm
	6fxx8S8mC095YaUQBYFSbEctSBO51KgSMoYbepn5X4o5t3Ecekyq8P/uZiv2aoc=
X-Gm-Gg: ASbGncs9mGYVVulEJT0IdE3FL9tzsvDkF+3sbBef5o9PgcWIvmYuVXzeXLyIAoO7ne3
	1D0WW8BoXazQM1h3KLqZtrI5QOtqKDdLcq+LQp1YuYbDnHkpb6H6pORZFZ7rKW8EbZ3NMHHxi2V
	BrCjVNOXR/ScSAWQ1I/U0GBeUPCwOaRoQ8HrjazqBBuB/Fhd89TP6ro1HQzEF4SVhd3yqlLaeOV
	8/SMSeiX55dotPaKzYjPuQHMq3Z31A38bS9561KW/EBhhd3aTLHhrsF98Gfhy0bLcBFMhCwX2y0
	QD3TChyt2ZypI4JCy/dJVjngcsQkbjkZzFj1hKOGx1wKGMlDpldeXc+j+BRs7WwE
X-Google-Smtp-Source: AGHT+IHKhwF9xVpyoe5TNTrRCljlNEHVBKNqffPwSJMO26qOJXy1Tszicm+AOtcvz51i8IzoHdTOuw==
X-Received: by 2002:a0c:aa10:0:b0:6e2:4b52:ee21 with SMTP id 6a1803df08f44-6e24b52ef3amr24887696d6.9.1738179825298;
        Wed, 29 Jan 2025 11:43:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e205137058sm59033796d6.22.2025.01.29.11.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 11:43:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tdDyS-00000009RKn-11CL;
	Wed, 29 Jan 2025 15:43:44 -0400
Date: Wed, 29 Jan 2025 15:43:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] RDMA/rxe: handle ICRC correctly on big endian systems
Message-ID: <20250129194344.GD2120662@ziepe.ca>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-2-ebiggers@kernel.org>
 <ae41a37e-3ee4-484e-ba53-1cad9225df7a@linux.dev>
 <20250129183009.GC2120662@ziepe.ca>
 <20250129185115.GA2619178@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250129185115.GA2619178@google.com>

On Wed, Jan 29, 2025 at 06:51:15PM +0000, Eric Biggers wrote:
> Hi Jason,
> 
> On Wed, Jan 29, 2025 at 02:30:09PM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 29, 2025 at 10:44:39AM +0100, Zhu Yanjun wrote:
> > > 在 2025/1/27 23:38, Eric Biggers 写道:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > The usual big endian convention of InfiniBand does not apply to the
> > > > ICRC field, whose transmission is specified in terms of the CRC32
> > > > polynomial coefficients.  
> > 
> > This patch is on to something but this is not a good explanation.
> > 
> > The CRC32 in IB is stored as big endian and computed in big endian,
> > the spec says so explicitly:
> > 
> > 2) The CRC calculation is done in big endian byte order with the least
> >    significant bit of the most significant byte being the first
> >    bits in the CRC calculation.
> 
> (2) just specifies the order in which the bits are passed to the CRC.  It says
> nothing about how the CRC value is stored; that's in (4) instead.

It could be. The other parts of the spec are more definitive.
 
> The mention of "big endian" seems to refer to the bytes being passed
> from first to last, which is the nearly universal convention.

The LFSR Figure 57 shows how the numerical representation the spec
uses (ie the 0x9625B75A) maps to the LFSR, and it could be called big
endian.

Regardless, table 29 makes this crystal clear, it shows how the
numerical representation of 0x9625B75A is placed on the wire, it is
big endian as all IBTA values are - byte 52 is 0x96, byte 55 is 0x5A.

> (I would not have used the term "big endian" here, as it's
> confusing.) 

It could be read as going byte-by-byte, or it could be referring to
the layout of the numerical representation..

> > If you feed that to the CRC32 you should get 0x9625B75A in a CPU
> > register u32.
> > 
> > cpu_to_be32() will put it in the right order for on the wire.
> 
> I think cpu_to_be32() would put it in the wrong order.  Refer to the following:

It is fully explicit in table 29, 0x9625B75A is stored in big
endian format starting at byte 52.

It is easy to answer without guessing, Zhu should just run the sample
packet through the new crc library code and determine what the u32
value is. It is either 0x9625B75A or swab(0x9625B75A) and that will
tell what the code should be.

Jason

