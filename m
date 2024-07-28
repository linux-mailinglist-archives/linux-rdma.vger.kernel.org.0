Return-Path: <linux-rdma+bounces-4045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14E93E773
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65856283DA8
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742BA6E2BE;
	Sun, 28 Jul 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YU5VAwNX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B58537F5;
	Sun, 28 Jul 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182638; cv=none; b=GqJdn0ucsRioCcn1UlKrSt/L8L8jw4VRHhPUmzspA4y7s7i2rs6iW9x9JHgxTRdZRBpfC93V9JEewVQ0tJ/ka06BYR0ZSQJ7tFnA8oR1oBFgPxgiNt6oQ14439KhodbPTRpkNlWSzY6qpEql1fv0wKNsYRewvOpIPHmWyx1zJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182638; c=relaxed/simple;
	bh=WDJQlNgfGdna4CzkFsZF6kX6g9+Fgl0J7SogRdc7wfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fky8FF7xqO+THWzFa9CyYrF+nRu3G8E5o9BdYi+zKvexYxJAQaRSJ8EVD28f647GeVycjcmAbaA8yKpxTO9WjNnu8Px4B+rwklawZHyvABX/ATb61yAs05oKJwmg1q4C2jLg2qknl8sM5mT8RY1OXcsPmOk7a+q+yyAn+/k7rtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YU5VAwNX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6EEC86BE;
	Sun, 28 Jul 2024 18:03:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722182589;
	bh=WDJQlNgfGdna4CzkFsZF6kX6g9+Fgl0J7SogRdc7wfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YU5VAwNX5Kt8Sc3+hJ8YS8q8R6TE56J72L6fCH5eNINWRKOQQqWEsaim/LzSDVVEr
	 K273umqC/qi4WZyxXYenYMBwPCY+y7Ux/PdEOENH8RRS8crjZ2/IFj7FgPmnbU0nbS
	 9f8JXG+Hsas0gmFG0LsQefU/f7Wg5hKTEDkg1+SQ=
Date: Sun, 28 Jul 2024 19:03:36 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240728160336.GG30973@pendragon.ideasonboard.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240726142731.GG28621@pendragon.ideasonboard.com>
 <20240726113434.56200a0e@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726113434.56200a0e@rorschach.local.home>

On Fri, Jul 26, 2024 at 11:34:34AM -0400, Steven Rostedt wrote:
> On Fri, 26 Jul 2024 17:27:31 +0300 Laurent Pinchart wrote:
> 
> > I know this is a topic proposed for the maintainers summit, but given
> > the number of people who seem to have an opinion and be interested in
> > dicussing it, would a session at LPC be a better candidate ? I don't
> > expect the maintainer summit to invite all relevant experts from all
> > subsystems, that would likely overflow the room.
> > 
> > The downside of an LPC session is that it could easily turn into a
> > heated stage fight, and there are probably also quite a few arguments
> > that can't really be made in the open :-S
> 
> You can always submit a BoF. We have also had last minute BoFs made if
> there's rooms available.

We could also possibly expand the V4L2 vs. DRM discussion in the Complex
Camera MC to cover this, as there's an important overlap.

-- 
Regards,

Laurent Pinchart

