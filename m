Return-Path: <linux-rdma+bounces-764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E483D8FB
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 12:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914A01F2365E
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF0134AD;
	Fri, 26 Jan 2024 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDWVumaN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB287134A3
	for <linux-rdma@vger.kernel.org>; Fri, 26 Jan 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706267139; cv=none; b=HSYAjwOOuv+I0e5OU7AyUPid+6ZIyyco8EJSpmCTLH1XUiYu/z2fMIn1Oy999ovVnTOeQ5ns6WcnhNFMS2HfDFsQ/vzvsLUZo0plXW7C8qBQkojrCX87MEPvxYVf8qnmhIk+WG/KxpjUpZVLFVBVSqbdQtYeFRh0oJvQWWI4M3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706267139; c=relaxed/simple;
	bh=WbXWuA2ENJ6lmkZS3QH6j1mNh5HJOqC5BB7qr/oRaqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4DsMVepRTJugagNHwr6tW9+AeB/TD/kXOx2ogMiomZx52TkyTjMKFi30s8eTXVuxK73iFVTOp+EMmtxVY8f4Csc59s9ynYbQlKBoAYdwMOSR3p7EsodbI3j+4CEN7cCTzkvUWakzEVMPLE/1AeHJx4OGOQB9BIbyaxRHNKFFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDWVumaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7ECC433C7;
	Fri, 26 Jan 2024 11:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706267139;
	bh=WbXWuA2ENJ6lmkZS3QH6j1mNh5HJOqC5BB7qr/oRaqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDWVumaNWuVATlCOjKE+hGxnwSSCdCwegK20ljUepq60+WFNVgUyDLLhhO+oI/kMO
	 twu1bjWkF84VlVsdUHqqu4vbdY2MCk1wOH4eBvCupMHCiTS3ceqYeo6SH9RlskwJwP
	 0aHGsTF4R9A/IjmN5X6N1UTm73Vs5xKSjQCEc/qt4IxLoV1ct/lM5QNmRkoZHGYHl9
	 G091I6ijG1aceEkSRv+hkXKh8p0HGe6qkb6/wvqwGuZ4wPWwx9U+wq2KcafSDIDCPC
	 zXZ+p1wNSiZEH73qFUAzjogL/tbqXZbQzrSdPhRnsZKnFBLc2I9PAYxKozqPQD0Mc+
	 a7fyxECNqz5Cw==
Date: Fri, 26 Jan 2024 13:05:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Subject: Re: Re: [PATCH] RDMA/siw: Trim size of page array to max size needed
Message-ID: <20240126110534.GE9841@unreal>
References: <20240119130532.57146-1-bmt@zurich.ibm.com>
 <05415e8a-2878-04a7-efeb-4119b95b8fd2@linux.dev>
 <BY5PR15MB3602E55D5186E1A241489C8B997B2@BY5PR15MB3602.namprd15.prod.outlook.com>
 <a4496a1e-c7bb-eba3-1095-07b4472786dc@linux.dev>
 <BY5PR15MB36028A78D66BBEE55A54C67E997A2@BY5PR15MB3602.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR15MB36028A78D66BBEE55A54C67E997A2@BY5PR15MB3602.namprd15.prod.outlook.com>

On Thu, Jan 25, 2024 at 05:27:52PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Guoqing Jiang <guoqing.jiang@linux.dev>
> > Sent: Thursday, January 25, 2024 1:15 AM
> > To: Bernard Metzler <BMT@zurich.ibm.com>; linux-rdma@vger.kernel.org
> > Cc: jgg@ziepe.ca; leon@kernel.org; ionut_n2001@yahoo.com
> > Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Trim size of page array to max
> > size needed
> > 
> > Hi Bernard,
> > 
> > On 1/25/24 03:59, Bernard Metzler wrote:
> > >> -----Original Message-----
> > >> From: Guoqing Jiang <guoqing.jiang@linux.dev>
> > >> Sent: Tuesday, January 23, 2024 3:43 AM
> > >> To: Bernard Metzler <BMT@zurich.ibm.com>; linux-rdma@vger.kernel.org
> > >> Cc: jgg@ziepe.ca; leon@kernel.org; ionut_n2001@yahoo.com
> > >> Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Trim size of page array to
> > max
> > >> size needed
> > >>
> > >> Hi Bernard,
> > >>
> > >> On 1/19/24 21:05, Bernard Metzler wrote:
> > >>> siw tries sending all parts of an iWarp wire frame in one socket
> > >>> send operation. If user data can be send without copy, user data
> > >>> pages for one wire frame are referenced in an fixed size page array.
> > >>> The size of this array can be made 2 elements smaller, since it
> > >>> does not reference iWarp header and trailer crc. Trimming
> > >>> the page array reduces the affected siw_tx_hdt() functions frame
> > >>> size, staying below 1024 bytes. This avoids the following
> > >>> compile-time warning:
> > >>>
> > >>>    drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt':
> > >>>    drivers/infiniband/sw/siw/siw_qp_tx.c:677:1: warning: the frame
> > >>>    size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-
> > than=]
> > >> I saw similar warning in my ubuntu 22.04 VM which has below gcc.
> > >>
> > >> root@buk:/home/gjiang/linux-mirror# make M=drivers/infiniband/sw/siw/
> > >> -j16 W=1
> > >>     CC [M]  drivers/infiniband/sw/siw/siw_qp_tx.o
> > >> drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
> > >> drivers/infiniband/sw/siw/siw_qp_tx.c:665:1: warning: the frame size
> > of
> > >> 1440 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > >>     665 | }
> > >>         | ^
> > >>
> > > Whew.. that is quite substantially off the target!
> > > How come different compilers making so much of a difference.
> > > Guoqing, can you check if the macro computing the maximum number
> > > of fragments is broken, i.e., computes different values in
> > > the cases you refer?
> > 
> > Sorry, I was wrong 😅.
> > 
> > The warning is not relevant with compiler, and it also appears with gcc-
> > 13.1
> > after enable KASAN which is used to find out-of-bounds bugs. Also, there
> > are lots of -Wframe-larger-than warning from other places as well.
> > 
> > > Thanks a lot!
> > > Bernard
> > >> # gcc --version
> > >> gcc (Ubuntu 12.3.0-1ubuntu1~22.04) 12.3.0
> > >>
> > >> And it still appears after apply this patch on top of 6.8-rc1.
> > >>
> > >> root@buk:/home/gjiang/linux-mirror# git am
> > >>
> > ./20240119_bmt_rdma_siw_trim_size_of_page_array_to_max_size_needed.mbx
> > >> Applying: RDMA/siw: Trim size of page array to max size needed
> > >> root@buk:/home/gjiang/linux-mirror# make M=drivers/infiniband/sw/siw/
> > >> -j16 W=1
> > >>     CC [M]  drivers/infiniband/sw/siw/siw_qp_tx.o
> > >> drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
> > >> drivers/infiniband/sw/siw/siw_qp_tx.c:668:1: warning: the frame size
> > of
> > >> 1408 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > >>     668 | }
> > >>         | ^
> > 
> > The patch actually reduced the frame size from 1440 to 1408 though it is
> > still larger than 1024.
> > 
> 
> So in your opinion, does this patch fix the issue of having a
> frame size larger than 1024 bytes for a typical build? I am sure
> we do not want to optimize the driver for building with KASAN
> debug options enabled.

But this is how we are running or supposed to run kernels. In any
sane regression run, KASAN is enabled.

I would speculate that most people who run SIW, use it to test their ULPs.

So I would like to see it fixed for them too.

Thanks

> 
> The original bug report claimed a frame size of 1040 bytes for a
> build w/o KASAN, being larger than 1024 bytes by 16 bytes. I
> think this patch fixes the reported issue.
> 
> Thanks a lot,
> Bernard.
> 
> 
> > Thanks,
> > Guoqing
> 

