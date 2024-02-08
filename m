Return-Path: <linux-rdma+bounces-978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1F84E04E
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 13:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BED289AB6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2F6F535;
	Thu,  8 Feb 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibwt6ibR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC65427E
	for <linux-rdma@vger.kernel.org>; Thu,  8 Feb 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393828; cv=none; b=sPp+0Bm7QsIbtSLMMKYWYH31NiTULww+cMlWwpz7K6SBrqgXUJkbDw7SQBPk+InOAJ+jTyC7MUIzTnYSJRznwYmAzriJMQ7/zfNifI7RQGYhfkd/Dz3FpHlKz+1P425CkboudhVEW+2UI22j7B7SFBIWJuP3N5XNZDKHVvPphCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393828; c=relaxed/simple;
	bh=zQdmnsnBQtr1L044s4H83OWT6/kt/nD66IoNbbnJfjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLtDqxc9qtP9wHm4cWIITB3oDfg3rZIozFARi/0uQDGSLw0pTtKBSUQbWKVp6Rcatf0N8mplKF/fO186mifRM1aLDNWbZ4kxSkrP80vekHMtWDQ/TwNS4lmHDdbsgJcx+rFdosKnZM7G3/i5VmA3sqUV4pdWmo8BNkXlXwbVTDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibwt6ibR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99342C433C7;
	Thu,  8 Feb 2024 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707393828;
	bh=zQdmnsnBQtr1L044s4H83OWT6/kt/nD66IoNbbnJfjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibwt6ibRvSE3tx/soTzmAGQBu49niN+d6a47mSaqzqSmbABkG9RjSfSAkGZRHJXUB
	 3oLvEetAbCXvp93h3rcsg68GBEzaH6VVB42dG8zBt6ZBZx8HJ7nGV22FW+MnudXvvV
	 IOJwCpyQIVBvao42HurDEIaggsXGM5iG7ss09rODLqqIw0msyUL04qCmyV6PAGNY7U
	 YNMVvqEtHa++xJwu/7uFrWadPMakkIpat+5gCN5txDbPiRDauo3mREBVXhEPaq0W4W
	 EYHFZ0j8VJglS+c5VG4xQ8ve3Q08Yv/2nyTL4hZu54hpgqMc6meWRbAIKuOvwwOQAu
	 cQjTqr3zGvQ4w==
Date: Thu, 8 Feb 2024 14:03:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Subject: Re: Re: Re: [PATCH] RDMA/siw: Trim size of page array to max size
 needed
Message-ID: <20240208120343.GH56027@unreal>
References: <20240119130532.57146-1-bmt@zurich.ibm.com>
 <05415e8a-2878-04a7-efeb-4119b95b8fd2@linux.dev>
 <BY5PR15MB3602E55D5186E1A241489C8B997B2@BY5PR15MB3602.namprd15.prod.outlook.com>
 <a4496a1e-c7bb-eba3-1095-07b4472786dc@linux.dev>
 <BY5PR15MB36028A78D66BBEE55A54C67E997A2@BY5PR15MB3602.namprd15.prod.outlook.com>
 <20240126110534.GE9841@unreal>
 <BYAPR15MB320873D5B2D4CD9A3C38A3FF99442@BYAPR15MB3208.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR15MB320873D5B2D4CD9A3C38A3FF99442@BYAPR15MB3208.namprd15.prod.outlook.com>

On Thu, Feb 08, 2024 at 11:32:37AM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Friday, January 26, 2024 12:06 PM
> > To: Bernard Metzler <BMT@zurich.ibm.com>
> > Cc: Guoqing Jiang <guoqing.jiang@linux.dev>; linux-rdma@vger.kernel.org;
> > jgg@ziepe.ca; ionut_n2001@yahoo.com
> > Subject: [EXTERNAL] Re: Re: [PATCH] RDMA/siw: Trim size of page array to
> > max size needed
> > 
> > On Thu, Jan 25, 2024 at 05:27:52PM +0000, Bernard Metzler wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Guoqing Jiang <guoqing.jiang@linux.dev>
> > > > Sent: Thursday, January 25, 2024 1:15 AM
> > > > To: Bernard Metzler <BMT@zurich.ibm.com>; linux-rdma@vger.kernel.org
> > > > Cc: jgg@ziepe.ca; leon@kernel.org; ionut_n2001@yahoo.com
> > > > Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Trim size of page array to
> > max
> > > > size needed
> > > >
> > > > Hi Bernard,
> > > >
> > > > On 1/25/24 03:59, Bernard Metzler wrote:
> > > > >> -----Original Message-----
> > > > >> From: Guoqing Jiang <guoqing.jiang@linux.dev>
> > > > >> Sent: Tuesday, January 23, 2024 3:43 AM
> > > > >> To: Bernard Metzler <BMT@zurich.ibm.com>; linux-rdma@vger.kernel.org
> > > > >> Cc: jgg@ziepe.ca; leon@kernel.org; ionut_n2001@yahoo.com
> > > > >> Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Trim size of page array to
> > > > max
> > > > >> size needed
> > > > >>
> > > > >> Hi Bernard,
> > > > >>
> > > > >> On 1/19/24 21:05, Bernard Metzler wrote:
> > > > >>> siw tries sending all parts of an iWarp wire frame in one socket
> > > > >>> send operation. If user data can be send without copy, user data
> > > > >>> pages for one wire frame are referenced in an fixed size page
> > array.
> > > > >>> The size of this array can be made 2 elements smaller, since it
> > > > >>> does not reference iWarp header and trailer crc. Trimming
> > > > >>> the page array reduces the affected siw_tx_hdt() functions frame
> > > > >>> size, staying below 1024 bytes. This avoids the following
> > > > >>> compile-time warning:
> > > > >>>
> > > > >>>    drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt':
> > > > >>>    drivers/infiniband/sw/siw/siw_qp_tx.c:677:1: warning: the frame
> > > > >>>    size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-
> > > > than=]
> > > > >> I saw similar warning in my ubuntu 22.04 VM which has below gcc.
> > > > >>
> > > > >> root@buk:/home/gjiang/linux-mirror# make
> > M=drivers/infiniband/sw/siw/
> > > > >> -j16 W=1
> > > > >>     CC [M]  drivers/infiniband/sw/siw/siw_qp_tx.o
> > > > >> drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
> > > > >> drivers/infiniband/sw/siw/siw_qp_tx.c:665:1: warning: the frame size
> > > > of
> > > > >> 1440 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > > > >>     665 | }
> > > > >>         | ^
> > > > >>
> > > > > Whew.. that is quite substantially off the target!
> > > > > How come different compilers making so much of a difference.
> > > > > Guoqing, can you check if the macro computing the maximum number
> > > > > of fragments is broken, i.e., computes different values in
> > > > > the cases you refer?
> > > >
> > > > Sorry, I was wrong 😅.
> > > >
> > > > The warning is not relevant with compiler, and it also appears with
> > gcc-
> > > > 13.1
> > > > after enable KASAN which is used to find out-of-bounds bugs. Also,
> > there
> > > > are lots of -Wframe-larger-than warning from other places as well.
> > > >
> > > > > Thanks a lot!
> > > > > Bernard
> > > > >> # gcc --version
> > > > >> gcc (Ubuntu 12.3.0-1ubuntu1~22.04) 12.3.0
> > > > >>
> > > > >> And it still appears after apply this patch on top of 6.8-rc1.
> > > > >>
> > > > >> root@buk:/home/gjiang/linux-mirror# git am
> > > > >>
> > > > ./20240119_bmt_rdma_siw_trim_size_of_page_array_to_max_size_needed.mbx
> > > > >> Applying: RDMA/siw: Trim size of page array to max size needed
> > > > >> root@buk:/home/gjiang/linux-mirror# make
> > M=drivers/infiniband/sw/siw/
> > > > >> -j16 W=1
> > > > >>     CC [M]  drivers/infiniband/sw/siw/siw_qp_tx.o
> > > > >> drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_tx_hdt’:
> > > > >> drivers/infiniband/sw/siw/siw_qp_tx.c:668:1: warning: the frame size
> > > > of
> > > > >> 1408 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > > > >>     668 | }
> > > > >>         | ^
> > > >
> > > > The patch actually reduced the frame size from 1440 to 1408 though it
> > is
> > > > still larger than 1024.
> > > >
> > >
> > > So in your opinion, does this patch fix the issue of having a
> > > frame size larger than 1024 bytes for a typical build? I am sure
> > > we do not want to optimize the driver for building with KASAN
> > > debug options enabled.
> > 
> > But this is how we are running or supposed to run kernels. In any
> > sane regression run, KASAN is enabled.
> > 
> > I would speculate that most people who run SIW, use it to test their ULPs.
> > 
> > So I would like to see it fixed for them too.
> 
> Understood. I propose to take the patch as I sent for now as a fix
> of the problem under the conditions reported. I'll look into
> restructuring the transmit path to squeeze its size below 1024
> even for KASAN builds. It will require some time.
> 
> Kernel builds with KASAN enabled emit lots of similar compile
> time warnings reporting frame sizes above 1024 bytes. Our core/nldev.c
> alone spills 13 of those. Any action needed? ;)

Yes, report them to ML and someone will fix them :).

Thanks

> 
> Best,
> Bernard
> > 
> > Thanks
> > 
> > >
> > > The original bug report claimed a frame size of 1040 bytes for a
> > > build w/o KASAN, being larger than 1024 bytes by 16 bytes. I
> > > think this patch fixes the reported issue.
> > >
> > > Thanks a lot,
> > > Bernard.
> > >
> > >
> > > > Thanks,
> > > > Guoqing
> > >

