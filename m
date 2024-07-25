Return-Path: <linux-rdma+bounces-3996-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4612793C954
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 22:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07437281C50
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 20:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BEC77F11;
	Thu, 25 Jul 2024 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PJ8T1cIr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402074C14;
	Thu, 25 Jul 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938046; cv=none; b=AS9nrioezgsvaVqQ8Olca9OP5my8SV/hNHEWMCXhDrUl2maxdGvI0kVCpWRlmZTr33TFrvcBM8TCevi15cRQu9HFvlDXYqtJNlv/o4XnhV1Ej7EXPT6s/Bau92MM5OIns7cWrqBr8cf+DrRivSvZg3kNiKYBPNhNJmOmGEMB1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938046; c=relaxed/simple;
	bh=35dVAUVjA+Qv/ORD37Iu0sEtS6k6TBUJehX9nFWZ6/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smxsRA12d7SlsXU0ge2CIMLQI8ZDVM6s5fu1OGlioi/cFsABP2hy6LV0KASMzFhb/i3FYpzZjAmaqXyerzGTqPfZoHR9FtuZLYUfQbrLSAmU+EqFHBzK1X+SkYSn/EIWdodUQ+qZJUudL9DOE7If+/WUomc37a49iI+2Due55jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PJ8T1cIr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-73-91-nat.elisa-mobile.fi [85.76.73.91])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF211471;
	Thu, 25 Jul 2024 22:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721937999;
	bh=35dVAUVjA+Qv/ORD37Iu0sEtS6k6TBUJehX9nFWZ6/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJ8T1cIr8cfp4APgPK76+TxiIfJHAGV0ympS3DUmGOF76UcC4/MsoaWlyGPbycpQg
	 nnG/siG3qmmSMqstIQl74omn9gldYRgh8JjVKMr6yDl2lOixQyRBGBaLKmVlzqrtRO
	 6u7EWTlEfVL9YI9tR+pcs3k4fO4len0OORZg1p5Q=
Date: Thu, 25 Jul 2024 23:07:03 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240725200703.GG14252@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com>
 <20240725194314.GS3371438@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240725194314.GS3371438@nvidia.com>

Hi Jason,

On Thu, Jul 25, 2024 at 04:43:14PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 25, 2024 at 10:31:25PM +0300, Laurent Pinchart wrote:
> 
> > I don't think those are necessarily relevant examples, as far as device
> > pass-through goes. Vendors have many times reverted to proprietary ways,
> > and they still do, at least in the areas of the kernel I'm most active
> > in. I've seen first hand a large SoC vendor very close to opening a
> > significant part of their camera stack and changing their mind at the
> > last minute when they heard they could possibly merge their code through
> > a different subsystem with a pass-through blank cheque.
> 
> If someone came with a fully open source framework for (say) some
> camera,

We have such a framework, it's called libcamera :-) Multiple vendors are
already collaborating.

> with a passthrough kernel driver design, would you reject it
> soley because it is passthrough based and you are scared that
> something else will use it to do something not open source?

It depends what "passthrough kernel driver design" means. If it means
accessing the PCI registers directly from userspace, yes. That's what X
used to do before KMS, and I'm glad it's now a distant past.

If it means a kernel driver that takes the majority of its runtime
parameters from a buffer blob assembled by userspace, while controlling
clocks, power domains and performing basic validation in kernelspace,
then I've already acked multiple drivers with such a design, exactly
because they have open-source userspace that doesn't try to keep many
device features proprietary and usable by closed-source userspace only.

> I wouldn't agree with that position, I think denying users useful open
> source solutions out of fear is not what Linux should be doing.

-- 
Regards,

Laurent Pinchart

