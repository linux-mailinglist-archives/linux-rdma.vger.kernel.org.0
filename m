Return-Path: <linux-rdma+bounces-3571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7E491D1CB
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2024 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36473281FD9
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2024 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EE013E022;
	Sun, 30 Jun 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbFOIQfd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A71E49F;
	Sun, 30 Jun 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719754156; cv=none; b=Tu6IWNhiAk6j4NHooLT38sLctJHKMeMh9E3Jy+VZvCr6p9CLv/pduGSSInsPXxDLpZ0aujncVhAEWyFV5VDiX/gnUkKg+iUHa/V2RSFS/mvKCNyxOFTQLB0gUXJU+06dXP0Zn1kH9fbBxsIEGMgt4U4JSPOsi2HCiHDvtv78/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719754156; c=relaxed/simple;
	bh=lIzbh1ZHThwD7UWEVr5MpAgM+TIV3ozHD9CvdT9jSzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoPRNkPf/MKPq8ahykAlowFmN+o5EITly7h98yLqQr3LLXebwD2FJdWy36tLc2GXRMcmooQvKoiQl58pgBcgImw9gD7vnW9D0qYTgK10i1sowloAbWsMMelpbOOWlwFiUpUZ0V7owx/BvMvbjVHlqk6T6L9h6vmHDiQLxSI/lgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbFOIQfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6349C2BD10;
	Sun, 30 Jun 2024 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719754156;
	bh=lIzbh1ZHThwD7UWEVr5MpAgM+TIV3ozHD9CvdT9jSzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbFOIQfdIWI4aU3SAc6UWs5lsOSM6tdhrQsUSxd0XgYqvwSFCS2JHcSczgSEdpUa8
	 Shw635BaWX4HQLhpiqX0+vBHJQGw/lNveW8lXdSuFrqj0uLs66G0OUMXNeMz078G27
	 MPXnEU3+DB+j0nOcd0Vc3KYI/FamslmH8ZP73+8tnh2YmSfBukNH8G7p5N1NadHQPp
	 VdH6HpVL4tFgeR0Wa53IoX+bx0Yfew4uTS8rX4/m3ZjT8VVb0brFPdqWXoj15uzzIB
	 C+IXbe2HJaVTkuFVjud/30D9KfoopC7cf2EYCcXfM+HwSZ1ez1DfOwRAKFwmqul+w9
	 nRU7sb1iko7kA==
Date: Sun, 30 Jun 2024 16:29:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 11/15] RDMA/hbl: add habanalabs RDMA driver
Message-ID: <20240630132911.GB176465@unreal>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-12-oshpigelman@habana.ai>
 <20240613191828.GJ4966@unreal>
 <fbb34afa-8a38-4124-9384-9b858ce2c4e5@habana.ai>
 <20240617190429.GB4025@unreal>
 <461bf44e-fd2f-4c8b-bc41-48d48e5a7fcb@habana.ai>
 <20240618125842.GG4025@unreal>
 <b4bda963-7026-4037-83e6-de74728569bd@habana.ai>
 <20240619105219.GO4025@unreal>
 <a5554266-55b7-4e96-b226-b686b8a6af89@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5554266-55b7-4e96-b226-b686b8a6af89@habana.ai>

On Fri, Jun 28, 2024 at 10:24:32AM +0000, Omer Shpigelman wrote:
> On 6/19/24 13:52, Leon Romanovsky wrote:
> > On Wed, Jun 19, 2024 at 09:27:54AM +0000, Omer Shpigelman wrote:
> >> On 6/18/24 15:58, Leon Romanovsky wrote:
> >>> On Tue, Jun 18, 2024 at 11:08:34AM +0000, Omer Shpigelman wrote:
> >>>> On 6/17/24 22:04, Leon Romanovsky wrote:
> >>>>> [Some people who received this message don't often get email from leon@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>>>
> >>>>> On Mon, Jun 17, 2024 at 05:43:49PM +0000, Omer Shpigelman wrote:
> >>>>>> On 6/13/24 22:18, Leon Romanovsky wrote:
> >>>>>>> [Some people who received this message don't often get email from leon@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>>>>>
> >>>>>>> On Thu, Jun 13, 2024 at 11:22:04AM +0300, Omer Shpigelman wrote:
> >>>>>>>> Add an RDMA driver of Gaudi ASICs family for AI scaling.
> >>>>>>>> The driver itself is agnostic to the ASIC in action, it operates according
> >>>>>>>> to the capabilities that were passed on device initialization.
> >>>>>>>> The device is initialized by the hbl_cn driver via auxiliary bus.
> >>>>>>>> The driver also supports QP resource tracking and port/device HW counters.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> >>>>>>>> Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
> >>>>>>>> Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
> >>>>>>>> Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
> >>>>>>>> Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
> >>>>>>>> Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
> >>>>>>>> Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
> >>>>>>>> Co-developed-by: David Meriin <dmeriin@habana.ai>
> >>>>>>>> Signed-off-by: David Meriin <dmeriin@habana.ai>
> >>>>>>>> Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
> >>>>>>>> Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
> >>>>>>>> Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
> >>>>>>>> Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
> >>>>>>>
> 
> <...>
> 
> >> mlx5 IB driver doesn't export any symbol that is used by the core driver,
> >> that's why the core driver can be loaded without the IB driver (althought
> >> you'll get circular dependency if you would export).
> > 
> > Yes, IB and ETH drivers are "users" of core driver. As RDMA maintainer,
> > I'm reluctant to accept code that exports symbols from IB drivers to
> > other subsystems. We have drivers/infiniband/core/ for that.
> > 
> 
> We need the core driver to access the IB driver (and to the ETH driver as
> well). As you wrote, we can't use exported symbols from our IB driver nor
> rely on function pointers, but what about providing the core driver an ops
> structure? meaning exporting a register function from the core driver that
> should be called by the IB driver during auxiliary device probe.
> Something like:
> 
> int hbl_cn_register_ib_aux_dev(struct auxiliary_device *adev,
> 			       struct hbl_ib_ops *ops)
> {
> ...
> }
> EXPORT_SYMBOL(hbl_cn_register_ib_aux_dev);
> 
> That's how only the parent driver exports symbols to the son driver so the
> IB driver is a "user" of the core driver and so we count on the internal
> module reference counter. But we also get the ability to access the IB
> driver from the core driver (to report a HW error for example).

Before you are talking about solutions, please explain in technical
terms why you absolutely need to access IB from core driver and any
other possible way is not possible.

Thanks

