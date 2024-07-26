Return-Path: <linux-rdma+bounces-4010-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08893D379
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 14:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7F31F2122E
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 12:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C1817B509;
	Fri, 26 Jul 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TSqKdGFZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB52B9DB;
	Fri, 26 Jul 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998212; cv=none; b=s0YOBlGClS4RCv28TWaRUJtFRr4iFQIJi8RaK1rCseKdsh6wyNfb9L0sdXhb26vmYL4cSJzRvGvrSH9gcL5CSESGeCm3arIjeBmxIEhSeXzliSw+iWil+w95UvpaxJsfaokOw0b8xmycxBsK7jHF7KtxPRPaRlAkvf2rS6lJEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998212; c=relaxed/simple;
	bh=ChIjTtvu9Dfrd1KDX61JojpZQTYzTK991GkprGnfzf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maVrs36ZDHg/FHEIAQqpwviwsaAG9TCxEstTTaiZH49xqTPS74AYL9LyT9w5+iVJiTy5mZW0/krvZevpRTUShnd5LNLS21mS3I4s12nDSDmQ89ttrkxI43VKjJ1/Iah+sVKeuwHXGb4ZnqXVWVUj+tQ5zQfWcNXeRfyxKNm9D1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TSqKdGFZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F04FD8CC;
	Fri, 26 Jul 2024 14:49:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721998165;
	bh=ChIjTtvu9Dfrd1KDX61JojpZQTYzTK991GkprGnfzf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSqKdGFZPQPATHVrSyQNFMYy69YZxq5Jmju027eOlKaZ09hvOUtxM0SD/YzhGjibY
	 lzAuNZG7jw0HAY9oDuyuTc5UN3yMuNAeboXyrwhY0Znr4g1gtF5ULx0txaoZrdDSmB
	 oqvZduN7SvEVAv+TUiFJQqudzJT0snTxhqQKvFDU=
Date: Fri, 26 Jul 2024 15:49:49 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240726124949.GI32300@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com>
 <20240725194314.GS3371438@nvidia.com>
 <20240725200703.GG14252@pendragon.ideasonboard.com>
 <CAPybu_0C44q+d33LN8yKGSyv6HKBMPNy0AG4LkCOqxc87w3WrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPybu_0C44q+d33LN8yKGSyv6HKBMPNy0AG4LkCOqxc87w3WrQ@mail.gmail.com>

On Fri, Jul 26, 2024 at 10:04:48AM +0200, Ricardo Ribalda Delgado wrote:
> On Thu, Jul 25, 2024 at 10:07 PM Laurent Pinchart wrote:
> > On Thu, Jul 25, 2024 at 04:43:14PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jul 25, 2024 at 10:31:25PM +0300, Laurent Pinchart wrote:
> > >
> > > > I don't think those are necessarily relevant examples, as far as device
> > > > pass-through goes. Vendors have many times reverted to proprietary ways,
> > > > and they still do, at least in the areas of the kernel I'm most active
> > > > in. I've seen first hand a large SoC vendor very close to opening a
> > > > significant part of their camera stack and changing their mind at the
> > > > last minute when they heard they could possibly merge their code through
> > > > a different subsystem with a pass-through blank cheque.
> > >
> > > If someone came with a fully open source framework for (say) some
> > > camera,
> >
> > We have such a framework, it's called libcamera :-) Multiple vendors are
> > already collaborating.
> >
> > > with a passthrough kernel driver design, would you reject it
> > > soley because it is passthrough based and you are scared that
> > > something else will use it to do something not open source?
> >
> > It depends what "passthrough kernel driver design" means. If it means
> > accessing the PCI registers directly from userspace, yes. That's what X
> > used to do before KMS, and I'm glad it's now a distant past.
> 
> Nobody has suggested giving PCI register access to userspace.

I know you didn't, but as I didn't expect Jason to be familiar with the
camera ISP discussions, I didn't want to make any specific assumption
regarding what he meant by passthrough kernel driver design.

> > If it means a kernel driver that takes the majority of its runtime
> > parameters from a buffer blob assembled by userspace, while controlling
> > clocks, power domains and performing basic validation in kernelspace,
> > then I've already acked multiple drivers with such a design, exactly
> > because they have open-source userspace that doesn't try to keep many
> > device features proprietary and usable by closed-source userspace only.
> 
> If that was an option we would not be having this discussion.
> 
> Vendors cannot have vendor access in v4l2.
> """
> It is not an option to upstream a driver that has support for
> undocumented closed features. Basically maintainers can't put their
> name on something that contains unverifiable (for them) and unusable
> (by all except the vendor) features.
> """
> https://linuxtv.org/news.php?entry=2022-11-14-1.hverkuil

What is not an option exactly in my description above ? We have multiple
V4L2 drivers for ISPs. They receive ISP parameters from userspace
through a data buffer. It's not allowed to be opaque, but it doesn't
prevent vendor closed-source userspace implementations with additional
*camera* features, as long as the *hardware* features are available to
everybody.

> > > I wouldn't agree with that position, I think denying users useful open
> > > source solutions out of fear is not what Linux should be doing.

-- 
Regards,

Laurent Pinchart

