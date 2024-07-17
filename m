Return-Path: <linux-rdma+bounces-3892-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0AB933815
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 09:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0621C22757
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C40C1BF3A;
	Wed, 17 Jul 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2iTlWay"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565CD17BDC;
	Wed, 17 Jul 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201773; cv=none; b=ceMkwPGo7BBbPr0ATn2JGTtvkZyhMZS23OCSv1cEePLHZXLgk9+gocdnSgM0sKBG1CD8F1VWd7dlVD5V0ta9Y5G8ff8UbqvyATcFPon7tTvluXYLz+vK1gnKXfnVsPI2vJCYA8ALj+hrjRlY4OOz2YJMvBP72Y/0PsyrAF4I7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201773; c=relaxed/simple;
	bh=DDscfeFdgVitL5WGsurjRFhEaiQNw6wovwBI8OWQiyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZX9ahmKwtMPGAUeCxlQth+WzDAAl+D/199y4RGJhenTmqNO/WYJQSuM1xGgUoWPoQPAc4bOBcNV3e1oqXo6jq7Ms6CfmxkWwoCQ1Gz88ecu+lvG48Bs7mt8Cf/vw4m/9bgd5bgz7eJltfWhCoXin6q41TFRtwWFbzFmFaugAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2iTlWay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BD5C32782;
	Wed, 17 Jul 2024 07:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721201772;
	bh=DDscfeFdgVitL5WGsurjRFhEaiQNw6wovwBI8OWQiyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2iTlWayEv7uaa8ulrsaBTC3XdATDPEITl8I1CWhBPW3HqnYdwQB6h0UR1D/F6BxS
	 YEf37O6bwlCDaVlrXZRYqGlcVk7JeeIcwaT76HgDx1D/7mfuN1sVpDTOsv+C82Ng6g
	 AV9ZAvoXG6r0sEqCnwOYqotLoijzlmyWpH3nQLh4bEC4kEckLelc4XgHu3VJQfbaIO
	 FP36m4RZvdYfo2xBcuj+5qwl8d5GaPckOktQhi6Yo0iBB66T0xCXRlBoVtTzOLRuFz
	 8n03KzVjW3cwk2z1N8At5bdgec9JY7Ps20O/inY4M8Xi+l4rPXTmAmwb6gNWTcu2gM
	 EX9eL1imU7Wug==
Date: Wed, 17 Jul 2024 10:36:07 +0300
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
Message-ID: <20240717073607.GF5630@unreal>
References: <20240617190429.GB4025@unreal>
 <461bf44e-fd2f-4c8b-bc41-48d48e5a7fcb@habana.ai>
 <20240618125842.GG4025@unreal>
 <b4bda963-7026-4037-83e6-de74728569bd@habana.ai>
 <20240619105219.GO4025@unreal>
 <a5554266-55b7-4e96-b226-b686b8a6af89@habana.ai>
 <20240712130856.GB14050@ziepe.ca>
 <2c767517-e24c-416b-9083-d3a220ffc14c@habana.ai>
 <20240716134013.GF14050@ziepe.ca>
 <ca6c3901-c0c5-4f35-934b-2b4c9f1a61dc@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca6c3901-c0c5-4f35-934b-2b4c9f1a61dc@habana.ai>

On Wed, Jul 17, 2024 at 07:08:59AM +0000, Omer Shpigelman wrote:
> On 7/16/24 16:40, Jason Gunthorpe wrote:
> > On Sun, Jul 14, 2024 at 10:18:12AM +0000, Omer Shpigelman wrote:
> >> On 7/12/24 16:08, Jason Gunthorpe wrote:
> >>> [You don't often get email from jgg@ziepe.ca. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> On Fri, Jun 28, 2024 at 10:24:32AM +0000, Omer Shpigelman wrote:
> >>>
> >>>> We need the core driver to access the IB driver (and to the ETH driver as
> >>>> well). As you wrote, we can't use exported symbols from our IB driver nor
> >>>> rely on function pointers, but what about providing the core driver an ops
> >>>> structure? meaning exporting a register function from the core driver that
> >>>> should be called by the IB driver during auxiliary device probe.
> >>>> Something like:
> >>>>
> >>>> int hbl_cn_register_ib_aux_dev(struct auxiliary_device *adev,
> >>>>                              struct hbl_ib_ops *ops)
> >>>> {
> >>>> ...
> >>>> }
> >>>> EXPORT_SYMBOL(hbl_cn_register_ib_aux_dev);
> >>>
> >>> Definately do not do some kind of double-register like this.
> >>>
> >>> The auxiliary_device scheme can already be extended to provide ops for
> >>> each sub device.
> >>>
> >>> Like
> >>>
> >>> struct habana_driver {
> >>>    struct auxiliary_driver base;
> >>>    const struct habana_ops *ops;
> >>> };
> >>>
> >>> If the ops are justified or not is a different question.
> >>>
> >>
> >> Well, I suggested this double-register option because I got a comment that
> >> the design pattern of embedded ops structure shouldn't be used.
> >> So I'm confused now...
> > 
> > Yeah, don't stick ops in random places, but the device_driver is the
> > right place.
> > 
> 
> Sorry, let me explain again. My original code has an ops structure
> exactly like you are suggesting now (see struct hbl_aux_dev in the first
> patch of the series). But I was instructed not to use this ops structure
> and to rely on exported symbols for inter-driver communication.
> I'll be happy to use this ops structure like in your example rather than
> converting my code to use exported symbols.
> Leon - am I missing anything? what's the verdict here?

You are missing the main sentence from Jason's response:  "don't stick ops in random places".

It is fine to have ops in device driver, so the core driver can call them. However, in your
original code, you added ops everywhere. It caused to the need to implement module reference
counting and crazy stuff like calls to lock and unlock functions from the aux driver to the core.

Verdict is still the same. Core driver should provide EXPORT_SYMBOLs, so the aux driver can call
them directly and enjoy from proper module loading and unloading.

The aux driver can have ops in the device driver, so the core driver can call them to perform something
specific for that aux driver.

Calls between aux drivers should be done via the core driver.

Thanks

