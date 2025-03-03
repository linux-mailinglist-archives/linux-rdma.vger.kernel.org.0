Return-Path: <linux-rdma+bounces-8254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE0A4C39C
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 15:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839E9188AA96
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77D2144D3;
	Mon,  3 Mar 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="brJ9tgVk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B45214A6B
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012785; cv=none; b=JrSVV9HSP0p/n6+DWOq7xY6x2oVU+dpKa1Zet9hooKdw2IF/ANyZor3GdCgo0oVowS0KFEDqmHkkXe8Ilqyb8fPWPfdSsKA3N3wUluRuYNwDGabe1XQ3TG7bm0pgLi0cV7PyPty+pSTeglmocvVWknIhGDyPpAEjPdUzyhNWzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012785; c=relaxed/simple;
	bh=f/MmzAXL5OQHpffX6sGg4Xf3VuYmFv3FUS7egesUiFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxi7wnR7Cgt6DTqQl2WF/7G1VdHMTygdG5WeBGjHoEg/Xkoub8onXjw88M8n6QYHhqCi28WcD47mUbF5090ghCh7KR/XYhLRH0fD3caBnrfeB8LrxuEAdGhBXhrniOEp0ie6bG+smLU8k+ND8H0S6skUIPgFTNcZDQu8TvUo5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=brJ9tgVk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4721325e3b5so38266361cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Mar 2025 06:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1741012780; x=1741617580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7AsLn1sMs50UyzmZS5BkUzscifC9xG2WhaFTFTMT1s=;
        b=brJ9tgVkPvWjnCoaI4E5SsjSbz+n96HwUjYfe4g2fhSne9wZkdnh/TRNDfWyS7vvwO
         WfueyuMJAd4BXggwfq1lJSHZOUUyoI+oLHJGb2KFB74I1Db0xIsXhTOw86GBZVhcvGZ1
         /jWWKU9K0ya0UTIzFu0BtldgZhrHlt30x6fXmIkvojWnXiXQI7j5jvfS29igLw2q/H7z
         fRSjAEouFunNNyB3ghgA6BfdaepNl/j3kedLxskViY9yjZSQ5CXjJ5HgUF5ViUKVJU+Y
         nwNXOW9bGODlAdubpJg4P8KXOUZNRNuPUI3+M6FVRYdBawZLmrzLM0PbfzNLSbCpgdRs
         K2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012780; x=1741617580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7AsLn1sMs50UyzmZS5BkUzscifC9xG2WhaFTFTMT1s=;
        b=eKStmXhY4ugIKsQazyhDHdeTj9XNYFbG4XuVzYZ2DrdDkjtw382T11sDBQCcREPh23
         x9q/xGUMLhIdjZxEkrJUdSzis5YRDQDBZBztY9y96RH7lj7PEkXqxgUdw7KJq/75eYpQ
         BCoVbNqkH0zqVjpS+LUIzN/8Y+3QAHLNcIGkcClDRiYvYNzujfWGa0tW59w5O8tpglh6
         jvg4N1XDdYHFe9+u3nX0rBM58/B8cvIlsLavvtao6ymFiWfSAV9sgoN1AMbim7PW2DXS
         oQmb+ac+ksuyT3GjqnGiBjZ2dA7UY8lSXcDYVCohX3yuyVCBhW4osQRtEXFbzJiAlj2a
         AGhA==
X-Forwarded-Encrypted: i=1; AJvYcCUgFpH+Hmq0PeAcUWDCSK46x/YsfvMDDSmp9Xukl06EmISEX2g8/7CNKMQ7ECt/ovaQ8xU3JhzxPbnm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgd42FdlhqyxkWocx0mueSxDDXxu/6qp6eK9m+TVDkAQyXNDga
	nybp3APCO1ymTP65nrvSfEJc4B+aXXSnDmWNDsr6rUE1EkbvefwkfT8yB/Am+9D0q4IpceknHns
	7aA==
X-Gm-Gg: ASbGnct20SkxqfnQkMIaLDvBXAOdIwbHwdoiS2fPaZNxY/LP86n3Fg26tyPjEpgpTMM
	WC+bdDtPy96nsLQjqV3aVkf4JWIB81wxWppZSogNUHmC2C0L2lGw/q4tVofoNbwZ9G9wOe1Rbqu
	dKXYelFhhKpiaKGSOdFnRo9lpmrZgTraVEnH3Sbc6O4ntj9JLGoGZrn4sDAiUM7fuECRvGodSm2
	2eMOc+nNXNS7dG++Hy1wJMVO5iH8DPCjYuIOCz7+RgfhSoJRcEzuPG2unxWo54XqBJ/V3FA8rCN
	lcuG3miFM2dvaOYH7pJx54kaHYWr7Nw5z7QH2h5HCEnc8sLdWREGWnzWjMkFOXZ3mg==
X-Google-Smtp-Source: AGHT+IFQZWctUnPbfZ4JFiToDWuPse3P6E/7UY4w/4me8CrHgeGRMctdZBPOfHW7+lK6TZ19RHYQgg==
X-Received: by 2002:a05:622a:8d:b0:474:f991:b3b1 with SMTP id d75a77b69052e-474f991b60bmr12202431cf.43.1741012780563;
        Mon, 03 Mar 2025 06:39:40 -0800 (PST)
Received: from cs.cmu.edu (tempest.elijah.cs.cmu.edu. [128.2.210.10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e90b8853sm13021411cf.65.2025.03.03.06.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:39:40 -0800 (PST)
Date: Mon, 3 Mar 2025 09:39:37 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Joel Granados <joel.granados@kernel.org>
Cc: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 3/6] sysctl/coda: Fixes timeout bounds
Message-ID: <20250303143937.etzv7idjbenugsgw@cs.cmu.edu>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-4-nicolas.bouchinet@clip-os.org>
 <u7q5rpzw6mohtnnhpa2j3u4photckmgllsl3noafnyfttepbui@rzmndu533xcv>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u7q5rpzw6mohtnnhpa2j3u4photckmgllsl3noafnyfttepbui@rzmndu533xcv>

On Mon, Mar 03, 2025 at 09:16:10AM -0500, Joel Granados wrote:
> On Mon, Feb 24, 2025 at 10:58:18AM +0100, nicolas.bouchinet@clip-os.org wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > Bound coda timeout sysctl writings between SYSCTL_ZERO
> > and SYSCTL_INT_MAX.
> > 
> > The proc_handler has thus been updated to proc_dointvec_minmax.
> > 
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >  fs/coda/sysctl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
> > index 0df46f09b6cc5..d6f8206c51575 100644
> > --- a/fs/coda/sysctl.c
> > +++ b/fs/coda/sysctl.c
> > @@ -20,7 +20,9 @@ static const struct ctl_table coda_table[] = {
> >  		.data		= &coda_timeout,
> I noticed that coda_timeout is an unsigned long. With that in mind I
> would change it to unsigned int. It seems to be a value that can be
> ranged within [0,INT_MAX]

That seems fine by me.

It is a timeout in seconds and it is typically set to some value well
under a minute.

Jan

