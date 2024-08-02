Return-Path: <linux-rdma+bounces-4190-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EBE945FEA
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 17:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AD0284197
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB642139CD;
	Fri,  2 Aug 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wN8R0xH/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021B2101B7;
	Fri,  2 Aug 2024 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611297; cv=none; b=ip1VT1hwY/51U6iHueNQNrNr7Q0vkVi6hgSO8BAMxdM+VcsgseBKMaVHQq4KL0do4OyvM6A/7Mq2fH0aNXAjUZ9wjHI25cyPijs+uaYJqwOBN1l324Thatlh8ybVlMTer6PMH019tdik6ooSl2CL9XjlNJh9opQNW5BHG7y/jQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611297; c=relaxed/simple;
	bh=9YHLzEBPhAU5AwpROppk2stTQe7p9Sm7x8VdtUFvPA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7h/eLtuqMmL0SNbr1p6zWm4LrkIKJSNfA6XbkC9Yl5dn+pygS7DCekfNDwzrO3KAKWjNzw6Z34NQ+nRqx+4hu1/LEj62X+8n65G31910bTHsd+zMXwhOs9y57BlRByQ2xzYwHeB0ptb04UW7/1y16P+xPgWjzpTULTx+lnbfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wN8R0xH/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B3F24524;
	Fri,  2 Aug 2024 17:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722611244;
	bh=9YHLzEBPhAU5AwpROppk2stTQe7p9Sm7x8VdtUFvPA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wN8R0xH/4h5vT6keuaysM6cahOylGdms88O4eQlDOpVO/Gimy1l+Tq8Jf2VrH63Ve
	 njCPmetacH0fLMeQ3Q3D9W1I15bXqzK4HesZRs+lA+EgTpi0WzXoj2DGdiX2tL+7HF
	 CwIc3cLb04j7RGu8giXKun3HXgQB4en3xDz5lBQ0=
Date: Fri, 2 Aug 2024 18:07:53 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sakari Ailus <sakari.ailus@iki.fi>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240802150753.GC2725@pendragon.ideasonboard.com>
References: <20240722111834.GC13497@pendragon.ideasonboard.com>
 <CAPybu_1SiMmegv=4dys+1tzV6=PumKxfB5p12ST4zasCjwzS9g@mail.gmail.com>
 <20240725200142.GF14252@pendragon.ideasonboard.com>
 <CAPybu_1hZfAqp2uFttgYgRxm_tYzJJr-U3aoD1WKCWQsHThSLw@mail.gmail.com>
 <20240726105936.GC28621@pendragon.ideasonboard.com>
 <CAPybu_1y7K940ndLZmy+QdfkJ_D9=F9nTPpp=-j9HYpg4AuqqA@mail.gmail.com>
 <20240728171800.GJ30973@pendragon.ideasonboard.com>
 <CAPybu_3M9GYNrDiqH1pXEvgzz4Wz_a672MCkNGoiLy9+e67WQw@mail.gmail.com>
 <Zqol_N8qkMI--n-S@valkosipuli.retiisi.eu>
 <CAKMK7uGx=VjHCo90htuTE6Oi0b8rt_0NrPsfbZwFKA304m7BdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKMK7uGx=VjHCo90htuTE6Oi0b8rt_0NrPsfbZwFKA304m7BdA@mail.gmail.com>

On Wed, Jul 31, 2024 at 03:15:39PM +0200, Daniel Vetter wrote:
> On Wed, 31 Jul 2024 at 13:55, Sakari Ailus wrote:
> > This is also very different from GPUs or accel devices that are built to be
> > user-programmable. If I'd compare ISPs to different devices, then the
> > closest match would probably be video codecs -- which also use V4L2.
> 
> Really just aside, but I figured I should correct this. DRM supports
> plenty of video codecs. They're all tied to gpus, but the real reason
> really is that the hw has decent command submission support so that
> running the entire codec in userspace except the basic memory and
> batch execution and synchronization handling in the kernel is a
> feasible design. And actually good, because your kernel wont ever blow
> up trying to parse complex media formats because it just doesn't.

I don't think V4L2 codecs parse the bitstream in the kernel either, at
least not the recent ones.

-- 
Regards,

Laurent Pinchart

