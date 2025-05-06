Return-Path: <linux-rdma+bounces-10090-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A230AAC70D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 15:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7300F5003F6
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC15280300;
	Tue,  6 May 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZLpmtbJY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F52E27585E
	for <linux-rdma@vger.kernel.org>; Tue,  6 May 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539740; cv=none; b=PJtugzWzhu0oqdt42v5KBWxlkLmZWl82Q7iNsUomX9/6REgwKEO3WIjPLnszgGWTQv3sfp5ogGmnlq5R68+6QLN6muLc2jQVn+IPUmu1kX9+/cUlE+EL+GDgHTzPLa5gAqI7T0hkcvc4m6Ebs52257uoy9JSJtNsrGKaHegamh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539740; c=relaxed/simple;
	bh=4/8rtOQ84hrt7xaLNFp36c7CMUUjH22rS/1Tp7wpJMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBrIjyYDYVKs5RwK0YcFr/qmGnEmUpNuO8znvLhf4WsqRk1xYo23FwZcYS72IIA+FopXRBhiU1cCdDKSClq74ZUchm0Lx7mpX9LlS/vPMNguuwEwj3n1YwYCXvsiaKLXo6F0QhPjFDdo367DUYQnX/ZIP0AhVwQoifbR4H1dRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZLpmtbJY; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c96759d9dfso636696885a.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 May 2025 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746539737; x=1747144537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf4JjGxQCwpgS6sftKvl9+EOOyc5cLZ6tjRaCrnWGTM=;
        b=ZLpmtbJY82wGry2WwoJMYQsB/EYYGWlLey/bgeol9lfl0r+6RmhVouKtgLW0dGoQTe
         GWFbXs+IBrvg9yG/1Mpou6cTGTcdvD1ZqlWq/N4sGC8nr/EgdYuKQ/QDIVY7byPsw0lb
         kb/J+lZs6AidHv+b1wok6tQVLeaGjeuj2wHVVWSc+kHOa+5BAWf2CT8s+sVxjjfFRC+p
         2NRNXIxQFpMZw+xFdu/0OHX1g75UbulYuXU6Ul1iN3v6op7Zv0bJOGPhkW0fcmUYqT9G
         cgbqFG9yxQI++ReDHXETfwKYzQEghbz8lohBVJTAw5GVJ1VKEfYJDLrZWJ/aoxmiO150
         6kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539737; x=1747144537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rf4JjGxQCwpgS6sftKvl9+EOOyc5cLZ6tjRaCrnWGTM=;
        b=NlM9JzFnss3Uup9oFTHlffGYlM0dg7yKjSOSe6lazy6cKRjT3FclxNUKyC5VJSQNHs
         cCWSKHeVHaIQHgAF89AfCsRS7uvtKlhSGu4ehinSiVMLMtHpk52mDSKTHfFTIw3H+5oC
         qIj/XWr8D5m9Elxntdo86r7qvu336QHmFYa1cWRPE+JnNRsb3iS2eBHPszoruAC32Csm
         qey7OjQLCGkdcc/mMQR36DHfgJT4FW7w6t9ta/ivrgTi5epsCQuYb2WtEjZ6bB6hr/qF
         sdfX3Mmp/NjgihiHk7fDWUEcm/rRLDHx8YjsETbO6mANxDQ2wSlMdoXGHMVkF47GpmKM
         qCyg==
X-Forwarded-Encrypted: i=1; AJvYcCVi8cPbmKWSmu8vj/QsFGxmL+wLdfOM6qSEWBxRkrEMPZpXRx2I0OdGzh3Gen1C15UlzMpDVPS0s5o8@vger.kernel.org
X-Gm-Message-State: AOJu0YyaegzW+rGOV2wQJ6fTkYpen8mPgyMhaYSQhyTF937+rLHWGmIh
	Upx0251EwMKAbi4hJH70PLQEAg045a6zQtTzHKq0rD6ots9wrz9D0P3hKKkwdkk=
X-Gm-Gg: ASbGncvR7AExfRlAbIbhkKVNacdovUIRSfcXfvZ1lxjuBmSEeYkraZafuyfq/ga1J88
	/lhDbcZ4p5A0M1vyX8w+J8gRfkQQhdnz47K6VyEuI8r1jymbg/MWAE3er2WvmKN3kKamwMMZSkv
	9k2nr06D9O2u1vrRtSCJkF8RM9GgzC2AJGXttwLEeXhLOTwBGDxPJNuorBBmfttOJoHTHT3O8NP
	apHFYje9GQcF1kDvtIuLfYrlf5GhKPnxOiDkk6xMwJ7Dp3wGFJhzXn9bZuEjPme3Tl7czeOxaEQ
	a6ReSDX5t+edYnffThwil06qUUuOW0epvXz/AHkNMuhNRrSTtChAQ7SUtXRIz3UtqtfX2PikTM8
	vr/5+P2QZzk1XCo+1/6s=
X-Google-Smtp-Source: AGHT+IGaO8ljMXOeEkr4RUOojdJ5UwAMwDBVV7a9s0Z2nsjD98gxMNOlDK7kPEGavQ9nw4w+7DJ2mg==
X-Received: by 2002:a05:6214:c8a:b0:6e8:87bd:386e with SMTP id 6a1803df08f44-6f528ce8d39mr183708456d6.33.1746539737135;
        Tue, 06 May 2025 06:55:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f44f47dsm69906396d6.92.2025.05.06.06.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:55:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCIlk-0000000062H-0ro4;
	Tue, 06 May 2025 10:55:36 -0300
Date: Tue, 6 May 2025 10:55:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: cel@kernel.org, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
Message-ID: <20250506135536.GH2260621@ziepe.ca>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org>
 <aBoJ64qDSp7U3twh@infradead.org>
 <20250506131722.GG2260621@ziepe.ca>
 <aBoRSeERzax5lTvH@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBoRSeERzax5lTvH@infradead.org>

On Tue, May 06, 2025 at 06:40:25AM -0700, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 10:17:22AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 06, 2025 at 06:08:59AM -0700, Christoph Hellwig wrote:
> > > On Mon, Apr 28, 2025 at 03:36:49PM -0400, cel@kernel.org wrote:
> > > > qp_attr.cap.max_rdma_ctxs. The QP's actual Send Queue length is on
> > > > the order of the sum of qp_attr.cap.max_send_wr and a factor times
> > > > qp_attr.cap.max_rdma_ctxs. The factor can be up to three, depending
> > > > on whether MR operations are required before RDMA Reads.
> > > > 
> > > > This limit is not visible to RDMA consumers via dev->attrs. When the
> > > > limit is surpassed, QP creation fails with -ENOMEM. For example:
> > > 
> > > Can we find a way to expose this limit from the HCA drivers and the
> > > RDMA core?
> > 
> > Shouldn't it be max_qp_wr?
> 
> Does that allow for arbitrary combination of different WRs?  

I think it is supposed to be the maximum QP WR depth you can create..

A QP shouldn't behave differently depending on the WR operation, each
one takes one WR entry.

Chuck do you know differently?

Jason

