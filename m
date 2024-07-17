Return-Path: <linux-rdma+bounces-3895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF73933D05
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 14:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AA81F24437
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC417FACA;
	Wed, 17 Jul 2024 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8xRCewe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE417E8FA;
	Wed, 17 Jul 2024 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219623; cv=none; b=HdlSkBcuhsE4hUy7ksO6wWVut15GhDBVpyR0pyONN/438NXAzgoQ4pwDDz3wRWLv7Sk1OUTtxWtHGuVE3Wd9NhdDw4Vcv+IlO/hDJKhdKy5MwH0XhDAIBoi8W/itmp4PRmtskopCX8KtSV7t0z5dWsczYnA8kZEauE0YRuwA2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219623; c=relaxed/simple;
	bh=XPoHNvBvk5aWq4Z1/WJjxhDz8NnrxpWn5NC51h1FfQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKc3SzdG4pGAXaU2LeNjEzEZbHzEZjRNXfFBzix32pRFpaEc38jxKM7hXfWYXPQ2K0eTgnYDhotgWNFNlqYsD68jWP5LCRRC0oL0jj0VeAiv4SBV8SWy8IgjmSqGXt0+gT16q+LIBMlv1sFB9X3IhG7vaslTGR2GqeGvAjfOt6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8xRCewe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEBCC32782;
	Wed, 17 Jul 2024 12:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721219623;
	bh=XPoHNvBvk5aWq4Z1/WJjxhDz8NnrxpWn5NC51h1FfQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8xRCeweLHGmv6CKbjkpl4zryLkOT68tBbaInoO2BoWnkD6sbKpEuyoAyc8KHw70t
	 9khT7f05JdWaMoAuepBKqZ92egYEyal1O0M8jku1NCBVL+qbdyyAyt7fDXGts/ZYsN
	 I55CCz8UC2zaZzyEHwxzjSaKTqopdAh3EDN1rw/jqsvQ5eIcKbbiH5LV5RFool9D1Z
	 Dyh4p78JjS5Yzf7Q7lNO71AHUu0+PPCZyf+3gQ0DxL4r+RUznjEHLE3lSJoPGvQJRt
	 hClqYrMiaoA+e6xVvBEQqLNdVg3JwlL3w9pqz9V0x8pmE86WyQzF1u97/u499idoJ9
	 bRB5hNIoMLsow==
Date: Wed, 17 Jul 2024 15:33:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 11/15] RDMA/hbl: add habanalabs RDMA driver
Message-ID: <20240717123337.GI5630@unreal>
References: <20240618125842.GG4025@unreal>
 <b4bda963-7026-4037-83e6-de74728569bd@habana.ai>
 <20240619105219.GO4025@unreal>
 <a5554266-55b7-4e96-b226-b686b8a6af89@habana.ai>
 <20240712130856.GB14050@ziepe.ca>
 <2c767517-e24c-416b-9083-d3a220ffc14c@habana.ai>
 <20240716134013.GF14050@ziepe.ca>
 <ca6c3901-c0c5-4f35-934b-2b4c9f1a61dc@habana.ai>
 <20240717073607.GF5630@unreal>
 <2050e95c-4998-4b2e-88e7-5964429818b5@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2050e95c-4998-4b2e-88e7-5964429818b5@habana.ai>

On Wed, Jul 17, 2024 at 10:51:03AM +0000, Omer Shpigelman wrote:
> On 7/17/24 10:36, Leon Romanovsky wrote:
> > On Wed, Jul 17, 2024 at 07:08:59AM +0000, Omer Shpigelman wrote:
> >> On 7/16/24 16:40, Jason Gunthorpe wrote:
> >>> On Sun, Jul 14, 2024 at 10:18:12AM +0000, Omer Shpigelman wrote:
> >>>> On 7/12/24 16:08, Jason Gunthorpe wrote:
> >>>>> [You don't often get email from jgg@ziepe.ca. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>>>
> >>>>> On Fri, Jun 28, 2024 at 10:24:32AM +0000, Omer Shpigelman wrote:
> >>>>>
> >>>>>> We need the core driver to access the IB driver (and to the ETH driver as
> >>>>>> well). As you wrote, we can't use exported symbols from our IB driver nor
> >>>>>> rely on function pointers, but what about providing the core driver an ops
> >>>>>> structure? meaning exporting a register function from the core driver that
> >>>>>> should be called by the IB driver during auxiliary device probe.
> >>>>>> Something like:
> >>>>>>
> >>>>>> int hbl_cn_register_ib_aux_dev(struct auxiliary_device *adev,
> >>>>>>                              struct hbl_ib_ops *ops)
> >>>>>> {
> >>>>>> ...
> >>>>>> }
> >>>>>> EXPORT_SYMBOL(hbl_cn_register_ib_aux_dev);
> >>>>>
> >>>>> Definately do not do some kind of double-register like this.
> >>>>>
> >>>>> The auxiliary_device scheme can already be extended to provide ops for
> >>>>> each sub device.
> >>>>>
> >>>>> Like
> >>>>>
> >>>>> struct habana_driver {
> >>>>>    struct auxiliary_driver base;
> >>>>>    const struct habana_ops *ops;
> >>>>> };
> >>>>>
> >>>>> If the ops are justified or not is a different question.
> >>>>>
> >>>>
> >>>> Well, I suggested this double-register option because I got a comment that
> >>>> the design pattern of embedded ops structure shouldn't be used.
> >>>> So I'm confused now...
> >>>
> >>> Yeah, don't stick ops in random places, but the device_driver is the
> >>> right place.
> >>>
> >>
> >> Sorry, let me explain again. My original code has an ops structure
> >> exactly like you are suggesting now (see struct hbl_aux_dev in the first
> >> patch of the series). But I was instructed not to use this ops structure
> >> and to rely on exported symbols for inter-driver communication.
> >> I'll be happy to use this ops structure like in your example rather than
> >> converting my code to use exported symbols.
> >> Leon - am I missing anything? what's the verdict here?
> > 
> > You are missing the main sentence from Jason's response:  "don't stick ops in random places".
> > 
> > It is fine to have ops in device driver, so the core driver can call them. However, in your
> > original code, you added ops everywhere. It caused to the need to implement module reference
> > counting and crazy stuff like calls to lock and unlock functions from the aux driver to the core.
> > 
> > Verdict is still the same. Core driver should provide EXPORT_SYMBOLs, so the aux driver can call
> > them directly and enjoy from proper module loading and unloading.
> > 
> > The aux driver can have ops in the device driver, so the core driver can call them to perform something
> > specific for that aux driver.
> > 
> > Calls between aux drivers should be done via the core driver.
> > 
> > Thanks
> 
> The only place we have an ops structure is in the device driver,
> similarly to Jason's example. In our code it is struct hbl_aux_dev. What
> other random places did you see?

This is exactly random place.

I suggest you to take time, learn how existing drivers in netdev and
RDMA uses auxbus infrastructure and follow the same pattern. There are
many examples already in the kernel.

And no, if you do everything right, you won't need custom module
reference counting and other hacks. There is nothing special in your
device/driver which requires special treatment.

Thanks

